import 'package:get/get.dart';
import '../models/unit_blud.dart';
import '../models/sigap_enums.dart';
import '../services/sigap_service.dart';

class SigapController extends GetxController {
  final _service = SigapService();

  // ═══════════════════════════════════════════
  // DATA
  // ═══════════════════════════════════════════

  final allUnits = <UnitBlud>[].obs;
  final statsGlobal = Rxn<SigapStatsGlobal>();
  final statsPerSektor = <SigapStatsSektor>[].obs;
  final kabList = <String>[].obs;

  // ═══════════════════════════════════════════
  // UI STATE
  // ═══════════════════════════════════════════

  final isLoading = true.obs;
  final errorMessage = ''.obs;

  // Selected unit + detail
  final selectedUnit = Rxn<UnitBlud>();
  final selectedSkorDimensi = <SkorDimensi>[].obs;
  final surveyDetail = Rxn<Map<String, dynamic>>();
  final isLoadingDetail = false.obs;

  // ═══════════════════════════════════════════
  // FILTERS
  // ═══════════════════════════════════════════

  final searchQuery = ''.obs;
  final selectedKab = ''.obs;
  final sortBy = 'score'.obs;

  /// Sektor filter: null = semua
  final selectedSektor = Rxn<Sektor>();

  /// Status filter
  final showBlud = true.obs;
  final showCalon = true.obs;

  /// Tier filter (untuk calon BLUD yang punya skor)
  final activeTiers = <int>{1, 2, 3, 4}.obs;

  // ═══════════════════════════════════════════
  // LIFECYCLE
  // ═══════════════════════════════════════════

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final results = await Future.wait([
        _service.fetchAllUnits(),
        _service.fetchStatsGlobal(),
        _service.fetchStatsPerSektor(),
        _service.fetchKabList(),
      ]);

      allUnits.value = (results[0] as List<Map<String, dynamic>>)
          .map((m) => UnitBlud.fromMap(m))
          .toList();

      statsGlobal.value =
          SigapStatsGlobal.fromMap(results[1] as Map<String, dynamic>);

      // Hitung sudahDinilai dari data aktual
      statsGlobal.value?.sudahDinilai =
          allUnits.where((u) => u.hasScore).length;

      statsPerSektor.value = (results[2] as List<Map<String, dynamic>>)
          .map((m) => SigapStatsSektor.fromMap(m))
          .toList();

      kabList.value = results[3] as List<String>;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Gagal memuat data SIGAP: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ═══════════════════════════════════════════
  // FILTERED DATA
  // ═══════════════════════════════════════════

  /// List unit yang sudah difilter + sort
  List<UnitBlud> get filteredUnits {
    return allUnits.where((u) {
      // Sektor
      if (selectedSektor.value != null && u.sektor != selectedSektor.value) {
        return false;
      }

      // Status BLUD
      if (u.isBludAktif && !showBlud.value) return false;
      if (!u.isBludAktif && !showCalon.value) return false;

      // Tier (hanya berlaku untuk yang punya skor)
      if (!u.isBludAktif && u.tier > 0 && !activeTiers.contains(u.tier)) {
        return false;
      }

      // Search
      final q = searchQuery.value.toLowerCase();
      if (q.isNotEmpty) {
        final matchNama = u.nama.toLowerCase().contains(q);
        final matchKab = u.kabKota.toLowerCase().contains(q);
        final matchSub = (u.subSektor ?? '').toLowerCase().contains(q);
        if (!matchNama && !matchKab && !matchSub) return false;
      }

      // Kabupaten
      if (selectedKab.value.isNotEmpty && u.kabKota != selectedKab.value) {
        return false;
      }

      return true;
    }).toList()
      ..sort((a, b) => switch (sortBy.value) {
            'kab' => a.kabKota.compareTo(b.kabKota),
            'sektor' => a.sektor.name.compareTo(b.sektor.name),
            'nama' => a.nama.compareTo(b.nama),
            _ => b.skorTotal.compareTo(a.skorTotal), // default: score desc
          });
  }

  /// Hanya BLUD aktif yang visible
  List<UnitBlud> get visibleBludUnits =>
      filteredUnits.where((u) => u.isBludAktif).toList();

  /// Hanya calon dengan skor
  List<UnitBlud> get visibleCalonUnits =>
      filteredUnits.where((u) => !u.isBludAktif && u.hasScore).toList();

  /// Calon tanpa skor (belum survey)
  List<UnitBlud> get visibleBelumDataUnits =>
      filteredUnits.where((u) => !u.isBludAktif && !u.hasScore).toList();

  // ═══════════════════════════════════════════
  // TIER COUNTS (dari filtered data)
  // ═══════════════════════════════════════════

  Map<int, int> get tierCounts {
    final counts = <int, int>{1: 0, 2: 0, 3: 0, 4: 0};
    for (final u in allUnits.where((u) => !u.isBludAktif && u.hasScore)) {
      counts[u.tier] = (counts[u.tier] ?? 0) + 1;
    }
    return counts;
  }

  // ═══════════════════════════════════════════
  // ACTIONS
  // ═══════════════════════════════════════════

  void toggleTier(int tier) {
    if (activeTiers.contains(tier)) {
      activeTiers.remove(tier);
    } else {
      activeTiers.add(tier);
    }
  }

  void setSektor(Sektor? sektor) {
    selectedSektor.value = sektor;
  }

  void setSearch(String query) {
    searchQuery.value = query;
  }

  void setKab(String kab) {
    selectedKab.value = kab;
  }

  void setSort(String sort) {
    sortBy.value = sort;
  }

  /// Select unit + load skor dimensi + survey detail
  Future<void> selectUnit(UnitBlud? unit) async {
    selectedUnit.value = unit;
    selectedSkorDimensi.clear();
    surveyDetail.value = null;

    if (unit != null) {
      isLoadingDetail.value = true;
      try {
        // Fetch skor dimensi + survey detail in parallel
        final results = await Future.wait([
          unit.hasScore
              ? _service.fetchSkorDimensi(unit.kodeUnit)
              : Future.value(<Map<String, dynamic>>[]),
          _service.fetchSurveyDetail(unit.kodeUnit),
        ]);

        final dims = results[0] as List<Map<String, dynamic>>;
        selectedSkorDimensi.value =
            dims.map((m) => SkorDimensi.fromMap(m)).toList();
        unit.skorDimensi = selectedSkorDimensi.toList();

        surveyDetail.value = results[1] as Map<String, dynamic>?;
      } catch (_) {
        // Gagal load detail — tidak fatal
      } finally {
        isLoadingDetail.value = false;
      }
    }
  }

  void clearSelection() {
    selectedUnit.value = null;
    selectedSkorDimensi.clear();
    surveyDetail.value = null;
  }
}
