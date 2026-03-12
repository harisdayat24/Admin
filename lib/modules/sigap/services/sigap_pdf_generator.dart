import 'package:flutter/material.dart' show Color;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/unit_blud.dart';
import '../models/sigap_constants.dart';

class SigapPdfGenerator {
  SigapPdfGenerator._();

  static PdfColor _pc(Color c) =>
      PdfColor(c.red / 255, c.green / 255, c.blue / 255);

  static final _blue = PdfColor.fromHex('#1d4ed8');
  static final _grey = PdfColor.fromHex('#64748b');
  static final _greyLight = PdfColor.fromHex('#94a3b8');
  static final _border = PdfColor.fromHex('#e2e8f0');
  static final _bgLight = PdfColor.fromHex('#f8fafc');
  static final _dark = PdfColor.fromHex('#0f172a');
  static final _body = PdfColor.fromHex('#374151');
  static final _green = PdfColor.fromHex('#059669');
  static final _red = PdfColor.fromHex('#dc2626');

  static final _dimColors = {
    'p3d': PdfColor.fromHex('#2563eb'),
    'spm': PdfColor.fromHex('#d97706'),
    'aset': PdfColor.fromHex('#f97316'),
    'rev': PdfColor.fromHex('#059669'),
    'unit': PdfColor.fromHex('#06b6d4'),
    'siswa': PdfColor.fromHex('#8b5cf6'),
    'sdm': PdfColor.fromHex('#ec4899'),
  };

  static String _rp(dynamic v) {
    final n = (v is num) ? v.toInt() : 0;
    if (n <= 0) return 'Nihil';
    if (n >= 1000000000) {
      return 'Rp${(n / 1000000000).toStringAsFixed(2)} Miliar';
    }
    if (n >= 1000000) return 'Rp${(n / 1000000).toStringAsFixed(1)} Juta';
    return 'Rp$n';
  }

  static String _num(dynamic v) {
    final n = (v is num) ? v.toInt() : 0;
    // Simple thousand separator
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  /// Generate + preview/download PDF profil untuk 1 sekolah
  static Future<void> generateAndPreview({
    required UnitBlud unit,
    required List<SkorDimensi> dimensi,
    required Map<String, dynamic>? survey,
  }) async {
    final pdf = _buildProfil(unit: unit, dimensi: dimensi, survey: survey);

    await Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
      name: 'SIGAP_Profil_${unit.nama.replaceAll(' ', '_')}.pdf',
    );
  }

  static pw.Document _buildProfil({
    required UnitBlud unit,
    required List<SkorDimensi> dimensi,
    required Map<String, dynamic>? survey,
  }) {
    final pdf = pw.Document();
    final tgl = _formatTgl(DateTime.now());
    final tierColor = _pc(SigapConstants.tierColor(unit.tier));
    final tierLabel = SigapConstants.tierLabel(unit.tier);
    final sv = survey ?? {};

    // ═══ Computed values ═══
    final sdmPns = ((sv['sdm_pns'] ?? 0) as num).toInt();
    final sdmPppk = ((sv['sdm_pppk'] ?? 0) as num).toInt();
    final sdmNonAsn = ((sv['sdm_non_asn'] ?? 0) as num).toInt();
    final sdmGtt = ((sv['sdm_gtt'] ?? 0) as num).toInt();
    final sdmTotal = ((sv['sdm_total'] ?? 0) as num).toInt();
    final sdmAsn = sdmPns + sdmPppk;
    final siswa = ((sv['jumlah_siswa'] ?? 0) as num).toInt();
    final tefa = ((sv['tefa'] ?? 0) as num).toInt();
    final upj = ((sv['upj'] ?? 0) as num).toInt();
    final luasTanah = ((sv['luas_tanah'] ?? 0) as num).toInt();
    final luasBangunan = ((sv['luas_bangunan'] ?? 0) as num).toInt();
    final bidangUsaha = sv['bidang_usaha']?.toString() ?? '';
    final harapan = sv['harapan']?.toString() ?? '';
    final statusP3d = sv['status_p3d']?.toString() ?? '-';
    final statusSpm = sv['status_spm']?.toString() ?? '-';
    final buktiAset = sv['bukti_aset']?.toString() ?? '-';
    final atasNama = sv['atas_nama']?.toString() ?? '-';

    // Issues
    final issues = <String>[];
    if (statusP3d.contains('Parsial')) issues.add('P3D Parsial');
    if (statusP3d.contains('Pinjam')) issues.add('Aset Pinjam Pakai');
    if (statusP3d.contains('Sengketa') || statusP3d == '-') {
      issues.add('P3D Sengketa');
    }
    if (statusSpm.contains('Draft')) issues.add('SPM Draft');
    if (!statusSpm.contains('Disahkan') &&
        !statusSpm.contains('Draft') &&
        statusSpm != '-') {
      issues.add('SPM Belum');
    }
    if (!buktiAset.contains('Tersimpan') &&
        !buktiAset.contains('BPN') &&
        buktiAset != '-') {
      issues.add('Dok Aset Hilang');
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (ctx) => _header(tgl),
        footer: (ctx) => _footer(tgl),
        build: (ctx) => [
          // ═══ NAMA SEKOLAH ═══
          pw.Text(unit.nama,
              style: pw.TextStyle(
                  fontSize: 20, fontWeight: pw.FontWeight.bold, color: _dark)),
          pw.SizedBox(height: 2),
          pw.Text(unit.kabKota,
              style: pw.TextStyle(fontSize: 12, color: _grey)),
          pw.SizedBox(height: 12),

          // ═══ SKOR BOX ═══
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: _bgLight,
              border: pw.Border.all(color: tierColor, width: 2),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Row(
              children: [
                pw.Text('${unit.skorTotal}',
                    style: pw.TextStyle(
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                        color: tierColor)),
                pw.SizedBox(width: 12),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('dari 100 poin',
                        style: pw.TextStyle(fontSize: 11, color: _grey)),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color: tierColor,
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Text(tierLabel,
                          style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 16),

          // ═══ SKOR PER DIMENSI ═══
          _sectionTitle('SKOR KESIAPAN PER DIMENSI'),
          ...dimensi.map((d) => _dimBar(d)),
          pw.SizedBox(height: 16),

          // ═══ DATA POKOK SEKOLAH ═══
          _sectionTitle('DATA POKOK SEKOLAH'),
          pw.Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _dataCard(_num(siswa), 'Jumlah Siswa Aktif'),
              _dataCard('$sdmTotal orang', 'Jumlah SDM Pengelola'),
              _dataCard('ASN: $sdmAsn', 'PNS: $sdmPns · PPPK: $sdmPppk'),
              _dataCard('${tefa + upj} unit', 'TEFA + UPJ'),
              _dataCard(luasTanah > 0 ? '${_num(luasTanah)} m\u00B2' : '-',
                  'Luas Tanah'),
              _dataCard(
                  luasBangunan > 0 ? '${_num(luasBangunan)} m\u00B2' : '-',
                  'Luas Bangunan'),
            ],
          ),
          if (bidangUsaha.isNotEmpty && bidangUsaha != '-') ...[
            pw.SizedBox(height: 8),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: _bgLight,
                border: pw.Border.all(color: _border),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(bidangUsaha,
                      style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: _dark)),
                  pw.Text('Bidang Usaha Unggulan (TEFA/UPJ)',
                      style: pw.TextStyle(fontSize: 9, color: _grey)),
                ],
              ),
            ),
          ],
          pw.SizedBox(height: 16),

          // ═══ DATA PENDAPATAN ═══
          _sectionTitle('DATA PENDAPATAN'),
          pw.Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _dataCard(_rp(sv['rev_eksisting']), 'Realisasi T-1 (2025)',
                  width: 80),
              _dataCard(_rp(sv['rev_25']), 'Estimasi 2025',
                  width: 80, valColor: _blue),
              _dataCard(_rp(sv['rev_26']), 'Estimasi 2026',
                  width: 80, valColor: _green),
              _dataCard(_rp(sv['rev_27']), 'Estimasi 2027',
                  width: 80, valColor: _green),
              _dataCard(_rp(sv['rev_28']), 'Estimasi 2028',
                  width: 80, valColor: _green),
              _dataCard(_rp(sv['rev_29']), 'Estimasi 2029',
                  width: 80, valColor: _green),
            ],
          ),
          pw.SizedBox(height: 16),

          // ═══ STATUS ADMINISTRATIF ═══
          _sectionTitle('STATUS ADMINISTRATIF'),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(child: _statusCard(statusP3d, 'Status P3D')),
              pw.SizedBox(width: 8),
              pw.Expanded(child: _statusCard(statusSpm, 'Status SPM')),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(child: _statusCard(buktiAset, 'Bukti Fisik Aset')),
              pw.SizedBox(width: 8),
              pw.Expanded(child: _statusCard(atasNama, 'Aset Tercatat a.n')),
            ],
          ),
          pw.SizedBox(height: 16),

          // ═══ ISU KRITIS ═══
          _sectionTitle('ISU KRITIS'),
          if (issues.isEmpty)
            _issueTag('Tidak ada isu kritis', isOk: true)
          else
            pw.Wrap(
              spacing: 4,
              runSpacing: 4,
              children: issues.map((i) => _issueTag(i)).toList(),
            ),
          pw.SizedBox(height: 16),

          // ═══ HARAPAN SEKOLAH ═══
          if (harapan.isNotEmpty && harapan != '-') ...[
            _sectionTitle('HARAPAN SEKOLAH'),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: _bgLight,
                border: pw.Border.all(color: _border),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(harapan,
                  style:
                      pw.TextStyle(fontSize: 11, color: _body, lineSpacing: 5)),
            ),
          ],
        ],
      ),
    );

    return pdf;
  }

  // ═══════════════════════════════════════════════════════════
  // BUILDING BLOCKS
  // ═══════════════════════════════════════════════════════════

  static pw.Widget _header(String tgl) {
    return pw.Column(children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('SIGAP BLUD',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: _blue)),
              pw.Text('Sistem Informasi Geospasial dan Analitik Peta BLUD',
                  style: pw.TextStyle(fontSize: 10, color: _grey)),
              pw.Text('Biro Perekonomian \u00B7 Pemprov Jawa Timur',
                  style: pw.TextStyle(fontSize: 10, color: _grey)),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text('Profil Kesiapan BLUD',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 11,
                      color: _dark)),
              pw.Text('Dicetak: $tgl',
                  style: pw.TextStyle(fontSize: 10, color: _grey)),
              pw.Text('Sub-Substansi BLUD',
                  style: pw.TextStyle(fontSize: 10, color: _grey)),
            ],
          ),
        ],
      ),
      pw.SizedBox(height: 8),
      pw.Container(height: 3, color: _blue),
      pw.SizedBox(height: 16),
    ]);
  }

  static pw.Widget _footer(String tgl) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
              'SIGAP BLUD \u00B7 Biro Perekonomian Pemprov Jawa Timur \u00B7 Sub-Substansi BLUD',
              style: pw.TextStyle(fontSize: 9, color: _greyLight)),
          pw.Text('Dokumen ini digenerate otomatis \u2014 $tgl',
              style: pw.TextStyle(fontSize: 9, color: _greyLight)),
        ],
      ),
    );
  }

  static pw.Widget _sectionTitle(String text) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Text(text,
          style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: _grey,
              letterSpacing: 0.8)),
    );
  }

  static pw.Widget _dimBar(SkorDimensi d) {
    final color = _dimColors[d.kodeDimensi] ?? _grey;
    final pct = d.bobotMax > 0 ? d.skor / d.bobotMax : 0.0;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 100,
            child: pw.Text(d.label,
                style: pw.TextStyle(fontSize: 10, color: _grey)),
          ),
          pw.Expanded(
            child: pw.Stack(
              children: [
                pw.Container(
                  height: 6,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#e2e8f0'),
                    borderRadius: pw.BorderRadius.circular(3),
                  ),
                ),
                pw.Container(
                  height: 6,
                  width: pct * 200, // approximate width
                  decoration: pw.BoxDecoration(
                    color: color,
                    borderRadius: pw.BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 8),
          pw.SizedBox(
            width: 36,
            child: pw.Text('${d.skor}/${d.bobotMax}',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: color)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _dataCard(String val, String label,
      {double? width, PdfColor? valColor}) {
    return pw.Container(
      width: width,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _bgLight,
        border: pw.Border.all(color: _border),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(val,
              style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: valColor ?? _dark)),
          pw.SizedBox(height: 2),
          pw.Text(label, style: pw.TextStyle(fontSize: 9, color: _grey)),
        ],
      ),
    );
  }

  static pw.Widget _statusCard(String val, String label) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _bgLight,
        border: pw.Border.all(color: _border),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(val,
              style: pw.TextStyle(fontSize: 11, color: _dark), maxLines: 3),
          pw.SizedBox(height: 2),
          pw.Text(label, style: pw.TextStyle(fontSize: 9, color: _grey)),
        ],
      ),
    );
  }

  static pw.Widget _issueTag(String text, {bool isOk = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: pw.BoxDecoration(
        color: isOk ? PdfColor.fromHex('#d1fae5') : PdfColor.fromHex('#fee2e2'),
        border: pw.Border.all(
            color: isOk
                ? PdfColor.fromHex('#6ee7b7')
                : PdfColor.fromHex('#fca5a5')),
        borderRadius: pw.BorderRadius.circular(5),
      ),
      child: pw.Text(
        isOk ? '\u2713 $text' : '\u26A0 $text',
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
          color: isOk ? _green : _red,
        ),
      ),
    );
  }

  static String _formatTgl(DateTime d) {
    const bulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${d.day} ${bulan[d.month]} ${d.year}';
  }
}
