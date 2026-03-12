import 'sigap_enums.dart';

/// Data class untuk satu unit BLUD (SMKN, RSUD, UPT, dll)
/// Sumber: view v_unit_skor_total
class UnitBlud {
  final int id;
  final String kodeUnit;
  final String? npsn;
  final String nama;
  final String kabKota;
  final Sektor sektor;
  final String? subSektor;
  final StatusBlud statusBlud;
  final int? tahunBlud;
  final double lat;
  final double lng;

  // Skor agregat
  final int skorTotal;
  final int skorMax;
  final int skorPersen;
  final int tier;

  // Detail skor per dimensi (lazy-loaded dari v_unit_skor_dimensi)
  List<SkorDimensi> skorDimensi;

  UnitBlud({
    required this.id,
    required this.kodeUnit,
    this.npsn,
    required this.nama,
    required this.kabKota,
    required this.sektor,
    this.subSektor,
    required this.statusBlud,
    this.tahunBlud,
    this.lat = -7.5,
    this.lng = 112.2,
    this.skorTotal = 0,
    this.skorMax = 100,
    this.skorPersen = 0,
    this.tier = 0,
    this.skorDimensi = const [],
  });

  factory UnitBlud.fromMap(Map<String, dynamic> m) {
    return UnitBlud(
      id: m['id'] ?? 0,
      kodeUnit: m['kode_unit'] ?? '',
      npsn: m['npsn'],
      nama: m['nama'] ?? '',
      kabKota: m['kab_kota'] ?? '',
      sektor: Sektor.fromString(m['sektor'] ?? ''),
      subSektor: m['sub_sektor'],
      statusBlud: StatusBlud.fromString(m['status_blud'] ?? ''),
      tahunBlud: m['tahun_blud'],
      lat: (m['lat'] as num?)?.toDouble() ?? -7.5,
      lng: (m['lng'] as num?)?.toDouble() ?? 112.2,
      skorTotal: m['skor_total'] ?? 0,
      skorMax: m['skor_max'] ?? 100,
      skorPersen: m['skor_persen'] ?? 0,
      tier: m['tier'] ?? 0,
    );
  }

  bool get isBludAktif => statusBlud == StatusBlud.blud;
  bool get hasScore => skorTotal > 0;
  bool get isFastTrack {
    if (skorDimensi.isEmpty) return false;
    final p3d = skorDimensi.where((d) => d.kodeDimensi == 'p3d').firstOrNull;
    final rev = skorDimensi.where((d) => d.kodeDimensi == 'rev').firstOrNull;
    return (p3d?.skor ?? 0) == 25 && (rev?.skor ?? 0) >= 10;
  }

  /// Label ringkas untuk list item
  String get badgeText {
    if (isBludAktif) return 'BLUD';
    if (tier > 0) return 'T$tier';
    return '—';
  }
}

/// Skor per dimensi (dari v_unit_skor_dimensi)
class SkorDimensi {
  final String kodeDimensi;
  final String label;
  final int bobotMax;
  final int skor;
  final int urutan;
  final String? catatan;

  SkorDimensi({
    required this.kodeDimensi,
    required this.label,
    required this.bobotMax,
    required this.skor,
    this.urutan = 0,
    this.catatan,
  });

  factory SkorDimensi.fromMap(Map<String, dynamic> m) {
    return SkorDimensi(
      kodeDimensi: m['kode_dimensi'] ?? '',
      label: m['label'] ?? '',
      bobotMax: m['bobot_max'] ?? 0,
      skor: m['skor'] ?? 0,
      urutan: m['urutan'] ?? 0,
      catatan: m['catatan'],
    );
  }

  double get persen => bobotMax > 0 ? skor / bobotMax : 0;
}

/// Statistik global SIGAP (dari v_sigap_stats_global)
class SigapStatsGlobal {
  final int totalUnit;
  final int totalBlud;
  final int totalCalon;
  final int unitPendidikan;
  final int unitKesehatan;
  final int unitUpt;
  final int bludPendidikan;
  final int bludKesehatan;
  final int bludUpt;

  SigapStatsGlobal({
    this.totalUnit = 0,
    this.totalBlud = 0,
    this.totalCalon = 0,
    this.unitPendidikan = 0,
    this.unitKesehatan = 0,
    this.unitUpt = 0,
    this.bludPendidikan = 0,
    this.bludKesehatan = 0,
    this.bludUpt = 0,
  });

  factory SigapStatsGlobal.fromMap(Map<String, dynamic> m) {
    return SigapStatsGlobal(
      totalUnit: m['total_unit'] ?? 0,
      totalBlud: m['total_blud'] ?? 0,
      totalCalon: m['total_calon'] ?? 0,
      unitPendidikan: m['unit_pendidikan'] ?? 0,
      unitKesehatan: m['unit_kesehatan'] ?? 0,
      unitUpt: m['unit_upt'] ?? 0,
      bludPendidikan: m['blud_pendidikan'] ?? 0,
      bludKesehatan: m['blud_kesehatan'] ?? 0,
      bludUpt: m['blud_upt'] ?? 0,
    );
  }

  int get belumData => totalCalon - sudahDinilai;

  /// Perlu dihitung dari data — placeholder
  int sudahDinilai = 0;
}

/// Statistik per sektor (dari v_sigap_stats_per_sektor)
class SigapStatsSektor {
  final Sektor sektor;
  final int totalUnit;
  final int sudahBlud;
  final int calonBlud;
  final int sudahDinilai;
  final int belumDinilai;

  SigapStatsSektor({
    required this.sektor,
    this.totalUnit = 0,
    this.sudahBlud = 0,
    this.calonBlud = 0,
    this.sudahDinilai = 0,
    this.belumDinilai = 0,
  });

  factory SigapStatsSektor.fromMap(Map<String, dynamic> m) {
    return SigapStatsSektor(
      sektor: Sektor.fromString(m['sektor'] ?? ''),
      totalUnit: m['total_unit'] ?? 0,
      sudahBlud: m['sudah_blud'] ?? 0,
      calonBlud: m['calon_blud'] ?? 0,
      sudahDinilai: m['sudah_dinilai'] ?? 0,
      belumDinilai: m['belum_dinilai'] ?? 0,
    );
  }
}
