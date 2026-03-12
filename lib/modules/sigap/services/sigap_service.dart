import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sigap_enums.dart';

/// Service layer untuk semua query Supabase SIGAP BLUD
class SigapService {
  final _sb = Supabase.instance.client;

  // ═══════════════════════════════════════════
  // UNITS + SKOR
  // ═══════════════════════════════════════════

  /// Semua unit dengan skor total (untuk peta + list)
  /// Bisa filter per sektor
  Future<List<Map<String, dynamic>>> fetchAllUnits({Sektor? sektor}) async {
    var query = _sb.from('v_unit_skor_total').select();
    if (sektor != null) {
      query = query.eq('sektor', sektor.dbKey);
    }
    final res = await query.order('skor_total', ascending: false);
    return List<Map<String, dynamic>>.from(res);
  }

  /// Skor per dimensi untuk 1 unit (detail card)
  Future<List<Map<String, dynamic>>> fetchSkorDimensi(String kodeUnit) async {
    final res = await _sb
        .from('v_unit_skor_dimensi')
        .select()
        .eq('kode_unit', kodeUnit)
        .order('urutan');
    return List<Map<String, dynamic>>.from(res);
  }

  /// Detail survey response (data mentah — siswa, SDM, rev, dll)
  Future<Map<String, dynamic>?> fetchSurveyDetail(String kodeUnit) async {
    try {
      final res = await _sb
          .from('survey_responses')
          .select()
          .eq('kode_unit', kodeUnit)
          .maybeSingle();
      return res;
    } catch (_) {
      return null;
    }
  }

  // ═══════════════════════════════════════════
  // STATISTIK
  // ═══════════════════════════════════════════

  /// Statistik global (header KPI)
  Future<Map<String, dynamic>> fetchStatsGlobal() async {
    final res = await _sb.from('v_sigap_stats_global').select().single();
    return res;
  }

  /// Statistik per sektor
  Future<List<Map<String, dynamic>>> fetchStatsPerSektor() async {
    final res = await _sb.from('v_sigap_stats_per_sektor').select();
    return List<Map<String, dynamic>>.from(res);
  }

  // ═══════════════════════════════════════════
  // FILTER HELPERS
  // ═══════════════════════════════════════════

  /// Daftar kabupaten unik
  Future<List<String>> fetchKabList() async {
    final res =
        await _sb.from('unit_blud').select('kab_kota').order('kab_kota');
    final set = <String>{};
    for (final row in res) {
      final kab = row['kab_kota'];
      if (kab != null) set.add(kab as String);
    }
    return set.toList();
  }

  // ═══════════════════════════════════════════
  // DOWNLOAD DATA
  // ═══════════════════════════════════════════

  /// Belum respon survey (untuk Excel download)
  Future<List<Map<String, dynamic>>> fetchBelumRespon({Sektor? sektor}) async {
    var query = _sb.from('v_sigap_belum_respon').select();
    if (sektor != null) {
      query = query.eq('sektor', sektor.dbKey);
    }
    final res = await query.order('kab_kota');
    return List<Map<String, dynamic>>.from(res);
  }

  /// Scoring dimensions config per sektor (untuk UI dinamis)
  Future<List<Map<String, dynamic>>> fetchScoringDimensions(
      Sektor sektor) async {
    final res = await _sb
        .from('scoring_dimensions')
        .select()
        .eq('sektor', sektor.dbKey)
        .eq('aktif', true)
        .order('urutan');
    return List<Map<String, dynamic>>.from(res);
  }
}
