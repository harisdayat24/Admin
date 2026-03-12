import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sigap_controller.dart';
import '../models/sigap_constants.dart';
import '../models/unit_blud.dart';
import '../services/sigap_pdf_generator.dart';

class SigapKpiPanel extends StatelessWidget {
  final SigapController controller;
  const SigapKpiPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() {
        final st = controller.statsGlobal.value;
        final selected = controller.selectedUnit.value;

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            // ═══ PROGRESS TRACKER ═══
            if (st != null) _ProgressSection(stats: st, controller: controller),

            // ═══ DISTRIBUSI TIER (DONUT) ═══
            _DonutSection(controller: controller),

            // ═══ SEKTOR BREAKDOWN ═══
            _SektorBreakdown(controller: controller),

            // ═══ DETAIL UNIT ═══
            _DetailSection(controller: controller),
          ],
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SECTION WRAPPER
// ═══════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  final String title;
  final String icon;
  final Widget child;

  const _Section({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$icon $title',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PROGRESS TRACKER
// ═══════════════════════════════════════════════════════════════

class _ProgressSection extends StatelessWidget {
  final SigapStatsGlobal stats;
  final SigapController controller;

  const _ProgressSection({required this.stats, required this.controller});

  @override
  Widget build(BuildContext context) {
    final total = stats.totalUnit;
    final bars = [
      (
        'Sudah BLUD',
        stats.totalBlud,
        SigapConstants.bludColor,
        const Color(0xFFD1FAE5)
      ),
      (
        'Terpetakan (Skor)',
        stats.sudahDinilai,
        const Color(0xFF2563EB),
        const Color(0xFFDBEAFE)
      ),
      (
        'Belum ada Data',
        stats.totalCalon - stats.sudahDinilai,
        const Color(0xFF94A3B8),
        const Color(0xFFF1F5F9)
      ),
    ];

    return _Section(
      title: 'PROGRES BLUD JATIM',
      icon: '📊',
      child: Column(
        children: bars.map((b) {
          final pct = total > 0 ? (b.$2 / total * 100).round() : 0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(b.$1,
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600)),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                              text: '${b.$2}', style: TextStyle(color: b.$3)),
                          TextSpan(
                            text: ' / $total ($pct%)',
                            style: const TextStyle(color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: total > 0 ? b.$2 / total : 0,
                    backgroundColor: b.$4,
                    color: b.$3,
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DONUT CHART
// ═══════════════════════════════════════════════════════════════

class _DonutSection extends StatelessWidget {
  final SigapController controller;
  const _DonutSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tc = controller.tierCounts;
      final total = tc.values.fold(0, (a, b) => a + b);

      return _Section(
        title: 'DISTRIBUSI KESIAPAN',
        icon: '🏷️',
        child: SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 48,
                  sections: [
                    for (int t = 1; t <= 4; t++)
                      PieChartSectionData(
                        value: (tc[t] ?? 0).toDouble(),
                        color: SigapConstants.tierColor(t),
                        title: '${tc[t] ?? 0}',
                        titleStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        radius: 32,
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$total',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const Text(
                    'sekolah',
                    style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════
// SEKTOR BREAKDOWN
// ═══════════════════════════════════════════════════════════════

class _SektorBreakdown extends StatelessWidget {
  final SigapController controller;
  const _SektorBreakdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sektors = controller.statsPerSektor;
      if (sektors.isEmpty) return const SizedBox.shrink();

      return _Section(
        title: 'PER SEKTOR',
        icon: '🏛️',
        child: Column(
          children: sektors.map((s) {
            final color = SigapConstants.sektorColor(s.sektor);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SigapConstants.sektorBg(s.sektor),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Text(s.sektor.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.sektor.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                        Text(
                          '${s.sudahBlud} BLUD · ${s.calonBlud} Calon',
                          style: const TextStyle(
                              fontSize: 10, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${s.totalUnit}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════
// DETAIL CARD (with survey data)
// ═══════════════════════════════════════════════════════════════

class _DetailSection extends StatelessWidget {
  final SigapController controller;
  const _DetailSection({required this.controller});

  String _rp(dynamic v) {
    final n = (v is num) ? v.toInt() : 0;
    if (n <= 0) return 'Nihil';
    if (n >= 1000000000) return 'Rp${(n / 1000000000).toStringAsFixed(1)}M';
    if (n >= 1000000) return 'Rp${(n / 1000000).toStringAsFixed(0)}jt';
    return 'Rp${n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unit = controller.selectedUnit.value;

      if (unit == null) {
        return _Section(
          title: 'DETAIL SEKOLAH',
          icon: '🏫',
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text('👆',
                      style: TextStyle(fontSize: 28, color: Color(0xFFC0C0C0))),
                  SizedBox(height: 8),
                  Text(
                    'Klik marker di peta atau\nnama di daftar untuk detail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFF94A3B8), height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      final color = unit.isBludAktif
          ? SigapConstants.bludColor
          : SigapConstants.tierColor(unit.tier);
      final dims = controller.selectedSkorDimensi;
      final sv = controller.surveyDetail.value;

      return _Section(
        title: 'DETAIL SEKOLAH',
        icon: '🏫',
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══ NAMA + KAB ═══
              Row(children: [
                Text(unit.sektor.icon, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(unit.nama,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            height: 1.3))),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  '${unit.kabKota}${unit.subSektor != null ? ' · ${unit.subSektor}' : ''}',
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ),
              const SizedBox(height: 12),

              // ═══ SKOR + TIER ═══
              Row(children: [
                if (unit.hasScore) ...[
                  Text('${unit.skorTotal}',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                          color: color)),
                  const SizedBox(width: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('dari ${unit.skorMax} poin',
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF64748B))),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: SigapConstants.tierBg(unit.tier),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(SigapConstants.tierLabel(unit.tier),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: color)),
                        ),
                      ]),
                ] else ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: unit.isBludAktif
                            ? SigapConstants.bludBg
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                        unit.isBludAktif
                            ? '✅ Sudah BLUD'
                            : 'Belum ada data skor',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: color)),
                  ),
                ],
              ]),

              // ═══ DIMENSI BARS ═══
              if (dims.isNotEmpty) ...[
                const SizedBox(height: 14),
                ...dims.map((d) => _DimensiBar(dimensi: d)),
              ],

              // ═══ ISSUES ═══
              if (sv != null) ...[
                const SizedBox(height: 10),
                _buildIssues(sv),
              ],

              // ═══ DATA ABSOLUT ═══
              if (sv != null) ...[
                _sectionLabel('DATA ABSOLUT'),
                _buildAbsolutGrid(sv),
                _sectionLabel('PENDAPATAN'),
                _buildRevenueGrid(sv),
                _sectionLabel(
                    'SDM — TOTAL ${sv['sdm_total'] ?? 0} ORANG (ASN: ${((sv['sdm_pns'] ?? 0) as num).toInt() + ((sv['sdm_pppk'] ?? 0) as num).toInt()})'),
                _buildSdmBar(sv),
                if (sv['harapan'] != null &&
                    sv['harapan'].toString().isNotEmpty) ...[
                  _sectionLabel('💬 HARAPAN SEKOLAH'),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: Text(sv['harapan'].toString(),
                        style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF374151),
                            height: 1.6)),
                  ),
                ],
              ],

              // ═══ EXPORT PDF BUTTON ═══
              if (sv != null) ...[
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => SigapPdfGenerator.generateAndPreview(
                      unit: unit,
                      dimensi: dims.toList(),
                      survey: sv,
                    ),
                    icon: const Icon(Icons.picture_as_pdf, size: 16),
                    label: const Text('Export PDF — Profil Kesiapan BLUD'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],

              // Loading
              if (controller.isLoadingDetail.value)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
              letterSpacing: 0.5)),
    );
  }

  Widget _buildIssues(Map<String, dynamic> sv) {
    final issues = <String>[];
    final p3d = sv['status_p3d']?.toString() ?? '';
    final spm = sv['status_spm']?.toString() ?? '';
    final aset = sv['bukti_aset']?.toString() ?? '';

    if (p3d.contains('Parsial')) issues.add('P3D Parsial');
    if (p3d.contains('Pinjam')) issues.add('Aset Pinjam Pakai');
    if (p3d.contains('Sengketa') || p3d.isEmpty) issues.add('P3D Sengketa');
    if (spm.contains('Draft')) issues.add('SPM Draft');
    if (!spm.contains('Disahkan') && !spm.contains('Draft')) {
      issues.add('SPM Belum');
    }
    if (!aset.contains('Tersimpan') && !aset.contains('BPN')) {
      issues.add('Dok Aset Hilang');
    }

    if (issues.isEmpty) {
      return Wrap(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFF6EE7B7))),
          child: const Text('✓ Tidak ada isu kritis',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF059669))),
        ),
      ]);
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: issues
          .map((i) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFFCA5A5))),
                child: Text('⚠ $i',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFDC2626))),
              ))
          .toList(),
    );
  }

  Widget _buildAbsolutGrid(Map<String, dynamic> sv) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2.2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _absCard(
            '${((sv['jumlah_siswa'] ?? 0) as num).toInt()}', 'Siswa Aktif'),
        _absCard(
            '${((sv['tefa'] ?? 0) as num).toInt() + ((sv['upj'] ?? 0) as num).toInt()} unit',
            'TEFA + UPJ'),
        _absCard(
            '${((sv['luas_tanah'] ?? 0) as num).toInt()} m²', 'Luas Tanah'),
        _absCard('${((sv['luas_bangunan'] ?? 0) as num).toInt()} m²',
            'Luas Bangunan'),
      ],
    );
  }

  Widget _absCard(String val, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(val,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace')),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 9, color: Color(0xFF64748B))),
          ]),
    );
  }

  Widget _buildRevenueGrid(Map<String, dynamic> sv) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2.2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _absCard(_rp(sv['rev_eksisting']), 'Pendapatan 2025'),
        _absCard(
            _rp(((sv['rev_26'] ?? 0) as num).toInt() +
                ((sv['rev_27'] ?? 0) as num).toInt() +
                ((sv['rev_28'] ?? 0) as num).toInt() +
                ((sv['rev_29'] ?? 0) as num).toInt()),
            'Proyeksi 2026–2029'),
      ],
    );
  }

  Widget _buildSdmBar(Map<String, dynamic> sv) {
    final pns = ((sv['sdm_pns'] ?? 0) as num).toInt();
    final pppk = ((sv['sdm_pppk'] ?? 0) as num).toInt();
    final nonAsn = ((sv['sdm_non_asn'] ?? 0) as num).toInt();
    final gtt = ((sv['sdm_gtt'] ?? 0) as num).toInt();
    final total = pns + pppk + nonAsn + gtt;
    if (total == 0) return const SizedBox.shrink();
    final t = total.toDouble();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Row(children: [
          _sdmSeg(pns / t, const Color(0xFF2563EB)),
          _sdmSeg(pppk / t, const Color(0xFF06B6D4)),
          _sdmSeg(nonAsn / t, const Color(0xFFF59E0B)),
          _sdmSeg(gtt / t, const Color(0xFF94A3B8)),
        ]),
      ),
      const SizedBox(height: 6),
      Wrap(spacing: 10, runSpacing: 4, children: [
        _sdmLegend(const Color(0xFF2563EB), 'PNS: $pns'),
        _sdmLegend(const Color(0xFF06B6D4), 'PPPK: $pppk'),
        _sdmLegend(const Color(0xFFF59E0B), 'Non-ASN: $nonAsn'),
        _sdmLegend(const Color(0xFF94A3B8), 'GTT: $gtt'),
      ]),
    ]);
  }

  Widget _sdmSeg(double frac, Color color) {
    return Expanded(
      flex: (frac * 100).round().clamp(1, 100),
      child: Container(height: 8, color: color),
    );
  }

  Widget _sdmLegend(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(fontSize: 9, color: Color(0xFF64748B))),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════
// DIMENSI BAR
// ═══════════════════════════════════════════════════════════════

class _DimensiBar extends StatelessWidget {
  final SkorDimensi dimensi;
  const _DimensiBar({required this.dimensi});

  @override
  Widget build(BuildContext context) {
    final color = SigapConstants.dimensiColor(dimensi.kodeDimensi);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        SizedBox(
            width: 100,
            child: Text(dimensi.label,
                style:
                    const TextStyle(fontSize: 10, color: Color(0xFF64748B)))),
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                    value: dimensi.persen,
                    backgroundColor: const Color(0xFFE2E8F0),
                    color: color,
                    minHeight: 5))),
        const SizedBox(width: 8),
        SizedBox(
            width: 36,
            child: Text('${dimensi.skor}/${dimensi.bobotMax}',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    color: color))),
      ]),
    );
  }
}
