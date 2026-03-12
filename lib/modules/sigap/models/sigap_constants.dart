import 'package:flutter/material.dart';
import 'sigap_enums.dart';

class SigapConstants {
  SigapConstants._();

  // ═══════════════════════════════════════════
  // TIER
  // ═══════════════════════════════════════════

  static Color tierColor(int tier) => switch (tier) {
        1 => const Color(0xFF10B981),
        2 => const Color(0xFF3B82F6),
        3 => const Color(0xFFF59E0B),
        4 => const Color(0xFFEF4444),
        _ => const Color(0xFF94A3B8),
      };

  static Color tierBg(int tier) => switch (tier) {
        1 => const Color(0xFFD1FAE5),
        2 => const Color(0xFFDBEAFE),
        3 => const Color(0xFFFEF3C7),
        4 => const Color(0xFFFEE2E2),
        _ => const Color(0xFFF1F5F9),
      };

  static String tierLabel(int tier) => switch (tier) {
        1 => 'Tier 1 — Siap',
        2 => 'Tier 2 — Hampir',
        3 => 'Tier 3 — Pembinaan',
        4 => 'Tier 4 — Belum',
        _ => 'Belum Dinilai',
      };

  static String tierLabelFull(int tier) => switch (tier) {
        1 => 'Tier 1 — Siap Penuh (≥75)',
        2 => 'Tier 2 — Hampir Siap (50–74)',
        3 => 'Tier 3 — Perlu Pembinaan (30–49)',
        4 => 'Tier 4 — Belum Siap (<30)',
        _ => 'Belum Dinilai',
      };

  // ═══════════════════════════════════════════
  // SEKTOR
  // ═══════════════════════════════════════════

  static Color sektorColor(Sektor s) => switch (s) {
        Sektor.pendidikan => const Color(0xFF2563EB),
        Sektor.kesehatan => const Color(0xFFDC2626),
        Sektor.uptLainnya => const Color(0xFF7C3AED),
      };

  static Color sektorBg(Sektor s) => switch (s) {
        Sektor.pendidikan => const Color(0xFFDBEAFE),
        Sektor.kesehatan => const Color(0xFFFEE2E2),
        Sektor.uptLainnya => const Color(0xFFEDE9FE),
      };

  // ═══════════════════════════════════════════
  // STATUS BLUD
  // ═══════════════════════════════════════════

  static const Color bludColor = Color(0xFF059669);
  static const Color bludBg = Color(0xFFD1FAE5);
  static const Color calonColor = Color(0xFF3B82F6);
  static const Color belumColor = Color(0xFF94A3B8);

  // ═══════════════════════════════════════════
  // DIMENSI SCORING
  // ═══════════════════════════════════════════

  static Color dimensiColor(String kode) => switch (kode) {
        'p3d' => const Color(0xFF2563EB),
        'spm' => const Color(0xFFD97706),
        'aset' => const Color(0xFFF97316),
        'rev' => const Color(0xFF059669),
        'unit' => const Color(0xFF06B6D4),
        'siswa' => const Color(0xFF8B5CF6),
        'sdm' => const Color(0xFFEC4899),
        'akreditasi' => const Color(0xFFDC2626),
        _ => const Color(0xFF64748B),
      };

  // ═══════════════════════════════════════════
  // MAP
  // ═══════════════════════════════════════════

  /// Center Jawa Timur
  static const double jatimLat = -7.65;
  static const double jatimLng = 112.9;
  static const double jatimZoom = 8.0;

  /// Batas validasi koordinat Jatim
  static bool isValidJatimCoord(double? lat, double? lng) {
    if (lat == null || lng == null) return false;
    return lat > -9.0 && lat < -5.5 && lng > 110.5 && lng < 116.0;
  }
}
