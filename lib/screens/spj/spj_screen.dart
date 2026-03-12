// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:minia_web_project/widgets/upload_dokumen_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/widgets/breadcrumb_widget.dart';

class SPJScreen extends StatefulWidget {
  const SPJScreen({super.key});

  @override
  State<SPJScreen> createState() => _SPJScreenState();
}

class _SPJScreenState extends State<SPJScreen> {
  final _supabase = Supabase.instance.client;

  bool _loading = true;
  String _error = '';
  List<Map<String, dynamic>> _cacheSPJ = [];
  List<Map<String, dynamic>> _filtered = [];
  List<Map<String, dynamic>> _kegiatanButuhSPJ = [];

  // Paginasi Riwayat SPJ
  int _halamanAktif = 1;
  final int _itemPerHalaman = 5;

  List<Map<String, dynamic>> get _halamanData {
    int start = (_halamanAktif - 1) * _itemPerHalaman;
    int end = (start + _itemPerHalaman).clamp(0, _filtered.length);
    return _filtered.sublist(start, end);
  }

  int get _totalHalaman => (_filtered.length / _itemPerHalaman).ceil();

  // Paginasi Kegiatan Perlu SPJ
  int _halamanKegiatan = 1;

  List<Map<String, dynamic>> get _halamanKegiatan_data {
    int start = (_halamanKegiatan - 1) * _itemPerHalaman;
    int end = (start + _itemPerHalaman).clamp(0, _kegiatanButuhSPJ.length);
    return _kegiatanButuhSPJ.sublist(start, end);
  }

  int get _totalHalamanKegiatan =>
      (_kegiatanButuhSPJ.length / _itemPerHalaman).ceil();

  // Expand row personel
  String? _expandedSpjId;
  final Map<String, List<Map<String, dynamic>>> _personelCache = {};
  final Map<String, bool> _loadingPersonel = {};

  String _filterStatus = 'SEMUA';
  String _cariKeyword = '';
  final _cariCtrl = TextEditingController();

  int _totalDraft = 0;
  int _totalDisetujui = 0;
  int _totalDitolak = 0;
  int _nominalPending = 0;
  int _totalPerluBukti = 0;

  // ── Konstanta lebar kolom tabel (satu sumber kebenaran) ────
  // Total kolom: 20+110+330+280+140+230+140+310 = 1560 + 40 padding = 1600
  static const double _colExpand = 20;
  static const double _colTanggal = 110;
  static const double _colKegiatan = 330;
  static const double _colRekening = 280;
  static const double _colNominal = 140;
  static const double _colPIC = 230;
  static const double _colStatus = 140;
  static const double _colAksi = 310;
  static const double _tableMinWidth = 1600;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _cariCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = '';
    });
    try {
      await _loadSPJ();
      await _loadKegiatanButuhSPJ();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadSPJ() async {
    final data = await _supabase.from('data_spj').select('''
      id_spj, nominal, status_verif, keterangan, link_bukti,
      tgl_pengajuan, tgl_verifikasi,
      kegiatan:ref_id_kegiatan (
        nama_kegiatan, kode_sub_kegiatan,
        pic:pic_kegiatan_id ( nama )
      ),
      rekening:ref_id_dpa (
        kode_rekening, uraian_belanja, pagu_dpa
      ),
      verifikator:verifikator_id ( nama )
    ''').order('tgl_pengajuan', ascending: false).limit(200);

    _cacheSPJ = data
        .map<Map<String, dynamic>>((s) => {
              'id': s['id_spj'],
              'nominal': (s['nominal'] as num?)?.toInt() ?? 0,
              'status': s['status_verif'] ?? 'Draft',
              'keterangan': s['keterangan'] ?? '',
              'tgl_ajuan': _formatTgl(s['tgl_pengajuan']),
              'tgl_verif': _formatTgl(s['tgl_verifikasi']),
              'nama_keg': s['kegiatan']?['nama_kegiatan'] ?? '-',
              'kode_sub': s['kegiatan']?['kode_sub_kegiatan'] ?? '-',
              'pic': s['kegiatan']?['pic']?['nama'] ?? '-',
              'kode_rek': s['rekening']?['kode_rekening'] ?? '-',
              'uraian': s['rekening']?['uraian_belanja'] ?? '-',
              'pagu': (s['rekening']?['pagu_dpa'] as num?)?.toInt() ?? 0,
              'verifikator': s['verifikator']?['nama'] ?? '-',
              'link_bukti': s['link_bukti'] ?? '',
            })
        .toList();

    _totalDraft = _cacheSPJ.where((s) => s['status'] == 'Draft').length;
    _totalDisetujui = _cacheSPJ.where((s) => s['status'] == 'Disetujui').length;
    _totalDitolak = _cacheSPJ.where((s) => s['status'] == 'Ditolak').length;
    _totalPerluBukti = _cacheSPJ
        .where((s) =>
            s['status'] == 'Disetujui' && (s['link_bukti'] as String).isEmpty)
        .length;
    _nominalPending = _cacheSPJ
        .where((s) => s['status'] == 'Draft')
        .fold(0, (sum, s) => sum + (s['nominal'] as int));

    _applyFilter();
  }

  Future<void> _loadKegiatanButuhSPJ() async {
    final spjIds =
        _cacheSPJ.map((s) => s['ref_id_kegiatan']).whereType<String>().toSet();

    final data = await _supabase
        .from('data_kegiatan')
        .select('''
          id_kegiatan, nama_kegiatan, tgl_pelaksanaan,
          kode_sub_kegiatan, butuh_anggaran,
          pic:pic_kegiatan_id ( nama )
        ''')
        .eq('butuh_anggaran', true)
        .order('tgl_pelaksanaan', ascending: false);

    setState(() {
      _halamanKegiatan = 1; // reset saat data baru
      _kegiatanButuhSPJ = data
          .map<Map<String, dynamic>>((k) => {
                'id': k['id_kegiatan'],
                'nama': k['nama_kegiatan'] ?? '-',
                'tgl': _formatTgl(k['tgl_pelaksanaan']),
                'kode_sub': k['kode_sub_kegiatan'] ?? '-',
                'pic': k['pic']?['nama'] ?? '-',
                'sudah_spj': spjIds.contains(k['id_kegiatan']),
              })
          .toList();
    });
  }

  void _applyFilter() {
    setState(() {
      _halamanAktif = 1;
      _filtered = _cacheSPJ.where((s) {
        bool cocokStatus =
            _filterStatus == 'SEMUA' || s['status'] == _filterStatus;
        bool cocokCari = _cariKeyword.isEmpty ||
            s['nama_keg'].toLowerCase().contains(_cariKeyword) ||
            s['kode_rek'].toLowerCase().contains(_cariKeyword) ||
            s['pic'].toLowerCase().contains(_cariKeyword);
        return cocokStatus && cocokCari;
      }).toList();
    });
  }

  Future<void> _updateStatus(String idSPJ, String status,
      {String keterangan = ''}) async {
    Map<String, dynamic> update = {
      'status_verif': status,
      'keterangan': keterangan
    };
    if (status == 'Disetujui' || status == 'Ditolak') {
      update['tgl_verifikasi'] = DateTime.now().toIso8601String();
    }
    await _supabase.from('data_spj').update(update).eq('id_spj', idSPJ);
    await _loadSPJ();
  }

  Future<void> _loadPersonel(String idSpj) async {
    if (_personelCache.containsKey(idSpj)) return;
    setState(() => _loadingPersonel[idSpj] = true);
    try {
      final data = await _supabase
          .from('spj_personel')
          .select(
              'id_personel, nominal, link_kwitansi, pegawai:ref_id_pegawai(nama)')
          .eq('ref_id_spj', idSpj)
          .order('created_at');
      setState(() {
        _personelCache[idSpj] = (data as List)
            .map<Map<String, dynamic>>((p) => {
                  'id_personel': p['id_personel'],
                  'nama': p['pegawai']?['nama'] ?? '-',
                  'nominal': (p['nominal'] as num?)?.toInt() ?? 0,
                  'link_kwitansi': p['link_kwitansi'] ?? '',
                })
            .toList();
      });
    } finally {
      setState(() => _loadingPersonel[idSpj] = false);
    }
  }

  void _uploadKwitansi(BuildContext context, String idPersonel, String idSpj) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Icon(Icons.receipt_outlined, color: Color(0xFF0D6EFD)),
          SizedBox(width: 8),
          Text('Upload Kwitansi', style: TextStyle(fontSize: 16)),
        ]),
        content: UploadDokumenWidget(
          folder: 'kwitansi',
          label: 'Upload Scan Kwitansi (PDF/Gambar)',
          onUploaded: (url) async {
            await _supabase
                .from('spj_personel')
                .update({'link_kwitansi': url}).eq('id_personel', idPersonel);
            // Hapus cache agar reload fresh
            _personelCache.remove(idSpj);
            Navigator.pop(context);
            await _loadPersonel(idSpj);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Kwitansi berhasil diupload'),
                  backgroundColor: Colors.green));
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Tutup'))
        ],
      ),
    );
  }

  Future<void> _exportPDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: pw.EdgeInsets.all(24),
      build: (ctx) => [
        pw.Text('Rekapitulasi SPJ',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Sub BLUD — Biro Perekonomian Setda Prov. Jatim',
            style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
        pw.Text('Tahun Anggaran 2026',
            style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
        pw.SizedBox(height: 16),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: pw.FixedColumnWidth(25),
            1: pw.FlexColumnWidth(3),
            2: pw.FixedColumnWidth(90),
            3: pw.FixedColumnWidth(90),
            4: pw.FixedColumnWidth(60),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.blue50),
              children: [
                _pdfCell('No', bold: true),
                _pdfCell('Kegiatan', bold: true),
                _pdfCell('Nominal', bold: true),
                _pdfCell('Kode Rekening', bold: true),
                _pdfCell('Status', bold: true),
              ],
            ),
            ..._filtered.asMap().entries.map((entry) {
              int i = entry.key + 1;
              var s = entry.value;
              return pw.TableRow(
                decoration: pw.BoxDecoration(
                    color: i % 2 == 0 ? PdfColors.grey50 : PdfColors.white),
                children: [
                  _pdfCell('$i'),
                  _pdfCell(s['nama_keg'] ?? '-'),
                  _pdfCell('Rp ${_formatRupiah(s['nominal'] as int)}'),
                  _pdfCell(s['kode_rek'] ?? '-'),
                  _pdfCell(s['status'] ?? '-'),
                ],
              );
            }),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Text('Total: ${_filtered.length} SPJ',
            style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
      ],
    ));
    await Printing.layoutPdf(
        onLayout: (format) async => pdf.save(),
        name: 'Rekapitulasi_SPJ_2026.pdf');
  }

  pw.Widget _pdfCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: pw.Text(text,
          style: pw.TextStyle(
              fontSize: 9,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
    );
  }

  void _buatSPJDariKegiatan(Map<String, dynamic> kegiatan) {
    showDialog(
      context: context,
      builder: (_) => _FormSPJDialog(
        refIdKegiatan: kegiatan['id'],
        namaKegiatan: kegiatan['nama'],
        onSaved: () => _loadData(),
      ),
    );
  }

  void _konfirmasiAksi(
    BuildContext context, {
    required String id,
    required String status,
    required Color warna,
    required IconData icon,
    required String judul,
    required String pesan,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Icon(icon, color: warna, size: 22),
          SizedBox(width: 8),
          Text(judul,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ]),
        content: Text(pesan),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _updateStatus(id, status);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Status diperbarui: $status'),
                    backgroundColor: warna));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: warna, foregroundColor: Colors.white),
            child: Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  void _bukaDialogTolak(
      BuildContext context, String id, Map<String, dynamic> spj) {
    final ketCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Icon(Icons.cancel_outlined, color: Colors.red, size: 22),
          SizedBox(width: 8),
          Text('Tolak SPJ', style: TextStyle(fontSize: 16)),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'SPJ: ${spj['nama_keg']}\nNominal: Rp ${_formatRupiah(spj['nominal'] as int)}',
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            SizedBox(height: 14),
            Text('Alasan Penolakan:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            SizedBox(height: 6),
            TextField(
              controller: ketCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Isi alasan penolakan...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton.icon(
            onPressed: () async {
              Navigator.pop(context);
              await _updateStatus(id, 'Ditolak', keterangan: ketCtrl.text);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('SPJ telah ditolak'),
                    backgroundColor: Colors.red));
              }
            },
            icon: Icon(Icons.cancel_outlined, size: 16),
            label: Text('Tolak SPJ'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }

  void _uploadBuktiSPJ(BuildContext context, String idSpj) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Icon(Icons.attach_file, color: Color(0xFF0D6EFD)),
          SizedBox(width: 8),
          Text('Upload Bukti SPJ'),
        ]),
        content: UploadDokumenWidget(
          folder: 'spj',
          label: 'Upload Bukti Pembayaran',
          onUploaded: (url) async {
            await _supabase
                .from('data_spj')
                .update({'link_bukti': url}).eq('id_spj', idSpj);
            Navigator.pop(context);
            await _loadSPJ();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Bukti SPJ berhasil diupload'),
                  backgroundColor: Colors.green));
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Tutup'))
        ],
      ),
    );
  }

  // ── PAGINASI (satu fungsi, dipakai oleh dua tabel) ───────────
  Widget _buildPaginasi({
    required int halamanAktif,
    required int totalHalaman,
    required int totalData,
    required int itemPerHalaman,
    required void Function(int) onHalamanChanged,
  }) {
    if (totalHalaman <= 1) return const SizedBox();

    List<int?> buildPageNumbers() {
      if (totalHalaman <= 7) {
        return List.generate(totalHalaman, (i) => i + 1);
      }
      final pages = <int?>[1];
      if (halamanAktif > 3) pages.add(null);
      for (int i = halamanAktif - 1; i <= halamanAktif + 1; i++) {
        if (i > 1 && i < totalHalaman) pages.add(i);
      }
      if (halamanAktif < totalHalaman - 2) pages.add(null);
      pages.add(totalHalaman);
      return pages;
    }

    final awal = ((halamanAktif - 1) * itemPerHalaman) + 1;
    final akhir = (halamanAktif * itemPerHalaman).clamp(0, totalData);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Menampilkan $awal–$akhir dari $totalData data',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: halamanAktif > 1
                ? () => onHalamanChanged(halamanAktif - 1)
                : null,
            icon: const Icon(Icons.chevron_left),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          ...buildPageNumbers().map((h) {
            if (h == null) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('...', style: TextStyle(color: Colors.grey)),
              );
            }
            final aktif = h == halamanAktif;
            return GestureDetector(
              onTap: () => onHalamanChanged(h),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: aktif ? const Color(0xFF0D6EFD) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color:
                        aktif ? const Color(0xFF0D6EFD) : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$h',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: aktif ? FontWeight.w700 : FontWeight.normal,
                      color: aktif ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 4),
          IconButton(
            onPressed: halamanAktif < totalHalaman
                ? () => onHalamanChanged(halamanAktif + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        _buildKartuRingkasan(),
        SizedBox(height: 16),
        if (_kegiatanButuhSPJ.isNotEmpty) ...[
          _buildSectionKegiatanPerluSPJ(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(children: [
              Container(width: 2, height: 20, color: Colors.grey.shade200),
              SizedBox(width: 20),
              Icon(Icons.arrow_downward, size: 13, color: Colors.grey.shade400),
              SizedBox(width: 6),
              Text('Riwayat SPJ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500)),
            ]),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
            ],
          ),
          child: Column(children: [
            _buildToolbar(),
            _loading
                ? Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()))
                : _error.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('Error: $_error',
                            style: TextStyle(color: Colors.red)))
                    : _buildTabel(),
            if (!_loading && _error.isEmpty)
              _buildPaginasi(
                halamanAktif: _halamanAktif,
                totalHalaman: _totalHalaman,
                totalData: _filtered.length,
                itemPerHalaman: _itemPerHalaman,
                onHalamanChanged: (p) => setState(() => _halamanAktif = p),
              ),
          ]),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreadcrumbWidget(items: [
                BreadcrumbItem(
                    label: 'Manajemen Operasional',
                    onTap: () => Get.find<SideBarController>().index.value = 0),
                BreadcrumbItem(label: 'Manajemen SPJ'),
              ]),
              SizedBox(height: 8),
              Text('Manajemen SPJ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              Text('Verifikasi dan monitoring Surat Pertanggungjawaban.',
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _exportPDF(context),
          icon: Icon(Icons.picture_as_pdf_outlined, size: 16),
          label: Text('Export PDF'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: BorderSide(color: Colors.red),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
            onPressed: _loadData,
            icon: Icon(Icons.refresh, color: Color(0xFF0D6EFD)),
            tooltip: 'Refresh'),
      ],
    );
  }

  Widget _buildSectionKegiatanPerluSPJ() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF0D6EFD).withOpacity(.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Color(0xFF0D6EFD).withOpacity(.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.assignment_late_outlined,
                    size: 16, color: Color(0xFF0D6EFD)),
              ),
              SizedBox(width: 10),
              Text('Kegiatan Perlu SPJ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Color(0xFF0D6EFD).withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text('${_kegiatanButuhSPJ.length}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0D6EFD),
                        fontWeight: FontWeight.w600)),
              ),
              Spacer(),
              Text('Kegiatan di bawah telah ditandai butuh SPJ.',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
          ),
          Divider(height: 1),
          // Rows — hanya tampilkan slice halaman aktif
          ..._halamanKegiatan_data.map((k) => Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100))),
                child: Row(children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: k['sudah_spj'] ? Colors.green : Colors.orange,
                      )),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(k['nama'],
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis),
                          Row(children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 11, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(k['tgl'],
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                            SizedBox(width: 12),
                            Icon(Icons.person_outline,
                                size: 11, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(k['pic'],
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ]),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: k['sudah_spj']
                          ? Colors.green.withOpacity(.1)
                          : Colors.orange.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      k['sudah_spj'] ? 'SPJ Dibuat' : 'Belum Ada SPJ',
                      style: TextStyle(
                          fontSize: 11,
                          color: k['sudah_spj'] ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: 12),
                  if (!k['sudah_spj'])
                    ElevatedButton.icon(
                      onPressed: () => _buatSPJDariKegiatan(k),
                      icon: Icon(Icons.add, size: 14),
                      label: Text('Buat SPJ', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0D6EFD),
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                ]),
              )),
          // ── Paginasi Kegiatan ──
          _buildPaginasi(
            halamanAktif: _halamanKegiatan,
            totalHalaman: _totalHalamanKegiatan,
            totalData: _kegiatanButuhSPJ.length,
            itemPerHalaman: _itemPerHalaman,
            onHalamanChanged: (p) => setState(() => _halamanKegiatan = p),
          ),
        ],
      ),
    );
  }

  Widget _kartu(
      String label, String nilai, String sub, IconData icon, Color warna) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: warna, width: 3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 6)
        ],
      ),
      child: Row(children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: warna.withOpacity(.1),
              borderRadius: BorderRadius.circular(7)),
          child: Icon(icon, color: warna, size: 15),
        ),
        SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
          SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(nilai,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: warna)),
              if (sub.isNotEmpty) ...[
                SizedBox(width: 6),
                Flexible(
                  child: Text(sub,
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey.shade400),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ],
          ),
        ])),
      ]),
    );
  }

  Widget _buildKartuRingkasan() {
    return Row(children: [
      Expanded(
          child: _kartu(
              'Menunggu Verifikasi',
              '$_totalDraft',
              'Rp ${_formatRupiah(_nominalPending)}',
              Icons.pending_outlined,
              Colors.orange)),
      SizedBox(width: 10),
      Expanded(
          child: _kartu('Disetujui', '$_totalDisetujui', '',
              Icons.check_circle_outline, Colors.green)),
      SizedBox(width: 10),
      Expanded(
          child: _kartu('Ditolak', '$_totalDitolak', '', Icons.cancel_outlined,
              Colors.red)),
      SizedBox(width: 10),
      Expanded(
          child: _kartu(
              'Perlu Bukti',
              '$_totalPerluBukti',
              'disetujui tanpa bukti',
              Icons.warning_amber_outlined,
              Colors.amber)),
    ]);
  }

  Widget _buildToolbar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 260,
          child: TextField(
            controller: _cariCtrl,
            onChanged: (v) {
              _cariKeyword = v.toLowerCase();
              _applyFilter();
            },
            decoration: InputDecoration(
              hintText: 'Cari nama kegiatan / rekening...',
              prefixIcon: Icon(Icons.search, size: 18),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 12),
        _filterBtn('Semua', 'SEMUA'),
        SizedBox(width: 6),
        _filterBtn('Draft', 'Draft'),
        SizedBox(width: 6),
        _filterBtn('Disetujui', 'Disetujui'),
        SizedBox(width: 6),
        _filterBtn('Ditolak', 'Ditolak'),
      ]),
    );
  }

  Widget _filterBtn(String label, String value) {
    bool active = _filterStatus == value;
    Color warna = value == 'Draft'
        ? Colors.orange
        : value == 'Disetujui'
            ? Colors.green
            : value == 'Ditolak'
                ? Colors.red
                : Color(0xFF0D6EFD);
    return InkWell(
      onTap: () {
        setState(() => _filterStatus = value);
        _applyFilter();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active ? warna : Colors.grey.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : Colors.grey.shade700)),
      ),
    );
  }

  Widget _buildTabel() {
    if (_filtered.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(40),
        child: Center(
            child: Column(children: [
          Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('Belum ada data SPJ.', style: TextStyle(color: Colors.grey)),
        ])),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: _tableMinWidth),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header row — pakai konstanta kolom
          Container(
            color: Colors.grey.shade50,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(children: [
              SizedBox(width: _colExpand),
              SizedBox(
                  width: _colTanggal, child: Text('Tanggal', style: _thStyle)),
              SizedBox(
                  width: _colKegiatan,
                  child: Text('Kegiatan', style: _thStyle)),
              SizedBox(
                  width: _colRekening,
                  child: Text('Rekening', style: _thStyle)),
              SizedBox(
                  width: _colNominal, child: Text('Nominal', style: _thStyle)),
              SizedBox(
                  width: _colPIC,
                  child: Center(child: Text('PIC', style: _thStyle))),
              SizedBox(
                  width: _colStatus,
                  child: Center(child: Text('Status', style: _thStyle))),
              SizedBox(
                  width: _colAksi,
                  child: Center(child: Text('Aksi', style: _thStyle))),
            ]),
          ),
          Divider(height: 1, color: Colors.grey.shade200),

          // Data rows
          ..._halamanData.map((s) {
            final id = s['id'] as String;
            final isExpanded = _expandedSpjId == id;
            final personelList = _personelCache[id] ?? [];
            final isLoadingP = _loadingPersonel[id] ?? false;
            Color statusColor = s['status'] == 'Draft'
                ? Colors.orange
                : s['status'] == 'Disetujui'
                    ? Colors.green
                    : Colors.red;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris utama SPJ
                InkWell(
                  onTap: () async {
                    if (isExpanded) {
                      setState(() => _expandedSpjId = null);
                    } else {
                      setState(() => _expandedSpjId = id);
                      await _loadPersonel(id);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    color: isExpanded
                        ? Color(0xFF0D6EFD).withOpacity(.03)
                        : Colors.white,
                    child: Row(children: [
                      // Expand icon
                      SizedBox(
                        width: _colExpand,
                        child: AnimatedRotation(
                          turns: isExpanded ? 0.25 : 0,
                          duration: Duration(milliseconds: 200),
                          child: Icon(Icons.chevron_right,
                              size: 20,
                              color: isExpanded
                                  ? Color(0xFF0D6EFD)
                                  : Colors.grey.shade400),
                        ),
                      ),

                      // Tanggal
                      SizedBox(
                        width: _colTanggal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${s['tgl_ajuan']}',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                            if (s['tgl_verif'] != '-')
                              Text('Verif: ${s['tgl_verif']}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),

                      // Kegiatan
                      SizedBox(
                        width: _colKegiatan,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['nama_keg'],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                            Text(s['kode_sub'],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontFamily: 'monospace')),
                          ],
                        ),
                      ),

                      // Rekening
                      SizedBox(
                        width: _colRekening,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['kode_rek'],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontFamily: 'monospace')),
                            Text(s['uraian'],
                                style: TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ],
                        ),
                      ),

                      // Nominal
                      SizedBox(
                        width: _colNominal,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.06),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                              'Rp ${_formatRupiah(s['nominal'] as int)}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700)),
                        ),
                      ),

                      // PIC
                      SizedBox(
                        width: _colPIC,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.person_outline,
                              size: 13, color: Colors.grey),
                          SizedBox(width: 4),
                          Flexible(
                              child: Text(s['pic'],
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis)),
                        ]),
                      ),

                      // Status
                      SizedBox(
                        width: _colStatus,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: statusColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(s['status'],
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor),
                              textAlign: TextAlign.center),
                        ),
                      ),

                      // Aksi
                      SizedBox(
                        width: _colAksi,
                        child: Center(child: _buildAksi(s)),
                      ),
                    ]),
                  ),
                ),

                // Sub-row personel (expandable)
                if (isExpanded)
                  Container(
                    margin: EdgeInsets.only(left: 52, right: 20, bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Color(0xFF0D6EFD).withOpacity(.15)),
                    ),
                    child: isLoadingP
                        ? Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2))))
                        : personelList.isEmpty
                            ? Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                    'Belum ada data personel untuk SPJ ini.',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header sub-row
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                                    child: Row(children: [
                                      Icon(Icons.people_outline,
                                          size: 14, color: Color(0xFF0D6EFD)),
                                      SizedBox(width: 6),
                                      Text('Personel & Kwitansi',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF0D6EFD))),
                                      SizedBox(width: 6),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF0D6EFD)
                                                .withOpacity(.1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text('${personelList.length}',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF0D6EFD),
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                      height: 1, color: Colors.grey.shade200),

                                  // List personel
                                  ...personelList.asMap().entries.map((entry) {
                                    final i = entry.key;
                                    final p = entry.value;
                                    final adaKwitansi =
                                        p['link_kwitansi'] != null &&
                                            p['link_kwitansi']
                                                .toString()
                                                .isNotEmpty;
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        border: i < personelList.length - 1
                                            ? Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade100))
                                            : null,
                                      ),
                                      child: Row(children: [
                                        // Nomor
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF0D6EFD)
                                                  .withOpacity(.1),
                                              shape: BoxShape.circle),
                                          child: Center(
                                              child: Text('${i + 1}',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xFF0D6EFD),
                                                      fontWeight:
                                                          FontWeight.w600))),
                                        ),
                                        SizedBox(width: 10),

                                        // Nama
                                        SizedBox(
                                          width: 260,
                                          child: Text(p['nama'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis),
                                        ),

                                        // Nominal
                                        Text(
                                            'Rp ${_formatRupiah(p['nominal'] as int)}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600)),
                                        SizedBox(width: 16),

                                        // Status kwitansi + tombol
                                        if (adaKwitansi) ...[
                                          TextButton.icon(
                                            onPressed: () => html.window.open(
                                                p['link_kwitansi'], '_blank'),
                                            icon: Icon(Icons.receipt_outlined,
                                                size: 14),
                                            label: Text('Lihat',
                                                style: TextStyle(fontSize: 11)),
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4)),
                                          ),
                                          SizedBox(width: 4),
                                          TextButton.icon(
                                            onPressed: () => _uploadKwitansi(
                                                context, p['id_personel'], id),
                                            icon: Icon(Icons.upload_outlined,
                                                size: 14),
                                            label: Text('Ganti',
                                                style: TextStyle(fontSize: 11)),
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.grey,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4)),
                                          ),
                                        ] else
                                          ElevatedButton.icon(
                                            onPressed: () => _uploadKwitansi(
                                                context, p['id_personel'], id),
                                            icon: Icon(
                                                Icons.upload_file_outlined,
                                                size: 14),
                                            label: Text('Upload Kwitansi',
                                                style: TextStyle(fontSize: 11)),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFF0D6EFD),
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 6),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                          ),
                                      ]),
                                    );
                                  }),
                                ],
                              ),
                  ),

                Divider(height: 1, color: Colors.grey.shade100),
              ],
            );
          }),
        ]),
      ),
    );
  }

  Widget _buildAksi(Map<String, dynamic> spj) {
    String status = spj['status'];
    String id = spj['id'];
    bool adaBukti =
        spj['link_bukti'] != null && spj['link_bukti'].toString().isNotEmpty;

    if (status == 'Draft') {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Tooltip(
          message: 'Setujui SPJ',
          child: IconButton(
            onPressed: () => _konfirmasiAksi(context,
                id: id,
                status: 'Disetujui',
                warna: Colors.green,
                icon: Icons.check_circle_outline,
                judul: 'Setujui SPJ?',
                pesan:
                    'SPJ senilai Rp ${_formatRupiah(spj['nominal'] as int)} akan disetujui.'),
            icon:
                Icon(Icons.check_circle_outline, color: Colors.green, size: 22),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ),
        SizedBox(width: 8),
        if (adaBukti) ...[
          Tooltip(
              message: 'Lihat Bukti',
              child: IconButton(
                onPressed: () => html.window.open(spj['link_bukti'], '_blank'),
                icon: Icon(Icons.file_present_outlined,
                    color: Colors.green, size: 20),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              )),
          SizedBox(width: 4),
          Tooltip(
              message: 'Perbarui Bukti',
              child: IconButton(
                onPressed: () => _uploadBuktiSPJ(context, id),
                icon: Icon(Icons.upload_outlined, color: Colors.grey, size: 18),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              )),
        ] else
          Tooltip(
              message: 'Upload Bukti',
              child: IconButton(
                onPressed: () => _uploadBuktiSPJ(context, id),
                icon: Icon(Icons.attach_file, size: 20, color: Colors.grey),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              )),
        Tooltip(
            message: 'Tolak SPJ',
            child: IconButton(
              onPressed: () => _bukaDialogTolak(context, id, spj),
              icon: Icon(Icons.cancel_outlined, color: Colors.red, size: 22),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            )),
      ]);
    } else if (status == 'Disetujui') {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        if (adaBukti) ...[
          Tooltip(
              message: 'Lihat Bukti',
              child: IconButton(
                onPressed: () => html.window.open(spj['link_bukti'], '_blank'),
                icon: Icon(Icons.file_present_outlined,
                    color: Colors.green, size: 20),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              )),
          SizedBox(width: 4),
          Tooltip(
              message: 'Perbarui Bukti',
              child: IconButton(
                onPressed: () => _uploadBuktiSPJ(context, id),
                icon: Icon(Icons.upload_outlined, color: Colors.grey, size: 18),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              )),
        ] else
          Tooltip(
              message: 'Upload Bukti Pembayaran',
              child: TextButton.icon(
                onPressed: () => _uploadBuktiSPJ(context, id),
                icon: Icon(Icons.attach_file, size: 14, color: Colors.amber),
                label: Text('Upload Bukti',
                    style: TextStyle(fontSize: 12, color: Colors.amber)),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
              )),
      ]);
    } else {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.cancel_outlined,
            size: 16, color: Colors.red.withOpacity(.5)),
        SizedBox(width: 4),
        if (spj['keterangan'].isNotEmpty)
          Tooltip(
              message: spj['keterangan'],
              child: Icon(Icons.info_outline, size: 18, color: Colors.grey)),
        if (spj['verifikator'] != '-')
          Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(spj['verifikator'],
                  style: TextStyle(fontSize: 11, color: Colors.grey))),
      ]);
    }
  }

  TextStyle get _thStyle =>
      TextStyle(fontWeight: FontWeight.w600, fontSize: 13);

  String _formatTgl(dynamic raw) {
    if (raw == null) return '-';
    try {
      DateTime dt = DateTime.parse(raw.toString());
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return raw.toString();
    }
  }

  String _formatRupiah(int angka) {
    String s = angka.toString();
    String result = '';
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) result = '.$result';
      result = s[i] + result;
      count++;
    }
    return result;
  }
} // ← tutup _SPJScreenState

// ============================================================
// FORM SPJ DIALOG
// ============================================================

// Model untuk satu baris personel di form
class _PersonelEntry {
  String? idPegawai;
  String namaPegawai = '';
  final TextEditingController nominalCtrl;
  String? linkKwitansi;

  _PersonelEntry({
    String nominal = '',
  }) : nominalCtrl = TextEditingController(text: nominal);

  int get nominal =>
      int.tryParse(nominalCtrl.text.replaceAll('.', '').replaceAll(',', '')) ??
      0;

  void dispose() => nominalCtrl.dispose();
}

class _FormSPJDialog extends StatefulWidget {
  final String refIdKegiatan;
  final String namaKegiatan;
  final VoidCallback onSaved;

  const _FormSPJDialog({
    required this.refIdKegiatan,
    required this.namaKegiatan,
    required this.onSaved,
  });

  @override
  State<_FormSPJDialog> createState() => _FormSPJDialogState();
}

class _FormSPJDialogState extends State<_FormSPJDialog> {
  final _supabase = Supabase.instance.client;
  final _keteranganCtrl = TextEditingController();

  List<Map<String, dynamic>> _listRekening = [];
  String? _selectedRekeningId;
  bool _loading = false;
  bool _loadingRekening = true;

  // RAK
  int _rakBulanIni = 0;
  int _rakTahunan = 0;
  int _totalSpjDisetujuiBulanIni = 0;
  int _totalSpjDisetujuiTahunan = 0;
  bool _loadingRAK = false;

  // Personel
  final List<_PersonelEntry> _personelList = [];
  List<Map<String, dynamic>> _semuaPegawai = [];
  bool _loadingPegawai = false;

  @override
  void initState() {
    super.initState();
    _loadRekening();
    _loadPegawai();
  }

  @override
  void dispose() {
    _keteranganCtrl.dispose();
    for (final p in _personelList) {
      p.dispose();
    }
    super.dispose();
  }

  Future<void> _loadPegawai() async {
    setState(() => _loadingPegawai = true);
    final data =
        await _supabase.from('pegawai').select('id, nama').order('nama');
    setState(() {
      _semuaPegawai = List<Map<String, dynamic>>.from(data);
      _loadingPegawai = false;
    });
  }

  Future<void> _loadRekening() async {
    final keg = await _supabase
        .from('data_kegiatan')
        .select('kode_sub_kegiatan')
        .eq('id_kegiatan', widget.refIdKegiatan)
        .single();

    final kodeSub = keg['kode_sub_kegiatan'];

    final data = await _supabase
        .from('master_dpa_rak')
        .select('id_rekening, kode_rekening, uraian_belanja, pagu_dpa')
        .eq('tahun_anggaran', 2026)
        .eq('kode_sub_kegiatan', kodeSub)
        .order('kode_rekening');

    setState(() {
      _listRekening = List<Map<String, dynamic>>.from(data);
      _loadingRekening = false;
    });
  }

  Future<void> _hitungRAK(String idRekening) async {
    setState(() => _loadingRAK = true);

    final now = DateTime.now();
    final bulan = now.month;
    final tahun = now.year;

    const bulanKolom = [
      '',
      'target_jan',
      'target_feb',
      'target_mar',
      'target_apr',
      'target_mei',
      'target_jun',
      'target_jul',
      'target_ags',
      'target_sep',
      'target_okt',
      'target_nov',
      'target_des'
    ];

    final rak = await _supabase
        .from('master_dpa_rak')
        .select(
            'target_jan, target_feb, target_mar, target_apr, target_mei, target_jun, target_jul, target_ags, target_sep, target_okt, target_nov, target_des, pagu_dpa')
        .eq('id_rekening', idRekening)
        .single();

    _rakBulanIni = (rak[bulanKolom[bulan]] as num?)?.toInt() ?? 0;
    _rakTahunan = (rak['pagu_dpa'] as num?)?.toInt() ?? 0;

    final spjBulan = await _supabase
        .from('data_spj')
        .select('nominal')
        .eq('ref_id_dpa', idRekening)
        .eq('status_verif', 'Disetujui')
        .gte('tgl_pengajuan', '$tahun-${bulan.toString().padLeft(2, '0')}-01')
        .lt(
            'tgl_pengajuan',
            bulan < 12
                ? '$tahun-${(bulan + 1).toString().padLeft(2, '0')}-01'
                : '${tahun + 1}-01-01');

    _totalSpjDisetujuiBulanIni = (spjBulan as List)
        .fold(0, (sum, s) => sum + ((s['nominal'] as num?)?.toInt() ?? 0));

    final spjTahun = await _supabase
        .from('data_spj')
        .select('nominal')
        .eq('ref_id_dpa', idRekening)
        .eq('status_verif', 'Disetujui')
        .gte('tgl_pengajuan', '$tahun-01-01')
        .lt('tgl_pengajuan', '${tahun + 1}-01-01');

    _totalSpjDisetujuiTahunan = (spjTahun as List)
        .fold(0, (sum, s) => sum + ((s['nominal'] as num?)?.toInt() ?? 0));

    setState(() => _loadingRAK = false);
  }

  // ── Total dari personel = nominal SPJ ────────────────────────
  int get _totalNominalPersonel =>
      _personelList.fold(0, (sum, p) => sum + p.nominal);

  // ── Simpan ───────────────────────────────────────────────────
  Future<void> _simpan() async {
    if (_selectedRekeningId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pilih rekening terlebih dahulu')));
      return;
    }
    if (_personelList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tambahkan minimal satu personel')));
      return;
    }
    final adaYangTidakLengkap =
        _personelList.any((p) => p.idPegawai == null || p.nominal <= 0);
    if (adaYangTidakLengkap) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lengkapi nama dan nominal semua personel')));
      return;
    }
    final nominal = _totalNominalPersonel;
    if (nominal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Total nominal personel harus lebih dari 0')));
      return;
    }

    setState(() => _loading = true);
    try {
      // 1. Insert SPJ → dapat id_spj
      final result = await _supabase
          .from('data_spj')
          .insert({
            'ref_id_kegiatan': widget.refIdKegiatan,
            'ref_id_dpa': _selectedRekeningId,
            'nominal': nominal,
            'keterangan': _keteranganCtrl.text.trim(),
            'link_bukti': '',
            'status_verif': 'Draft',
            'tgl_pengajuan': DateTime.now().toIso8601String(),
          })
          .select('id_spj')
          .single();

      final idSpj = result['id_spj'] as String;

      // 2. Bulk insert personel jika ada
      if (_personelList.isNotEmpty) {
        await _supabase.from('spj_personel').insert(
              _personelList
                  .map((p) => {
                        'ref_id_spj': idSpj,
                        'ref_id_pegawai': p.idPegawai,
                        'nominal': p.nominal,
                        'link_kwitansi': '',
                      })
                  .toList(),
            );
      }

      widget.onSaved();
      if (mounted) Navigator.pop(context);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('SPJ berhasil dibuat'),
            backgroundColor: Colors.green));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── RAK Info ─────────────────────────────────────────────────
  Widget _buildRAKInfo() {
    if (_selectedRekeningId == null) return SizedBox();
    if (_loadingRAK) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: LinearProgressIndicator(),
      );
    }

    final nominal = _totalNominalPersonel;
    final sisaBulanIni = _rakBulanIni - _totalSpjDisetujuiBulanIni;
    final sisaTahunan = _rakTahunan - _totalSpjDisetujuiTahunan;
    final melebihiBulan = nominal > 0 && nominal > sisaBulanIni;
    final melebihiTahunan = nominal > 0 && nominal > sisaTahunan;

    Color warna = nominal == 0
        ? Colors.grey
        : !melebihiBulan
            ? Colors.green
            : !melebihiTahunan
                ? Colors.orange
                : Colors.red;

    IconData ikon = nominal == 0
        ? Icons.info_outline
        : !melebihiBulan
            ? Icons.check_circle_outline
            : !melebihiTahunan
                ? Icons.warning_amber_outlined
                : Icons.error_outline;

    String pesan = nominal == 0
        ? 'Isi nominal untuk melihat status RAK'
        : !melebihiBulan
            ? 'Nominal dalam batas RAK bulan ini ✓'
            : !melebihiTahunan
                ? 'Melebihi RAK bulan ini, sisa tahunan masih mencukupi'
                : 'Melebihi sisa RAK tahunan — harap konsultasi ke pengelola anggaran';

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warna.withOpacity(.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: warna.withOpacity(.25)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(ikon, size: 14, color: warna),
          SizedBox(width: 6),
          Expanded(
              child: Text(pesan,
                  style: TextStyle(
                      fontSize: 12,
                      color: warna,
                      fontWeight: FontWeight.w500))),
        ]),
        SizedBox(height: 10),
        Row(children: [
          Expanded(child: _rakChip('RAK Bulan Ini', _rakBulanIni, Colors.blue)),
          SizedBox(width: 6),
          Expanded(
              child: _rakChip(
                  'Terpakai', _totalSpjDisetujuiBulanIni, Colors.orange)),
          SizedBox(width: 6),
          Expanded(
              child: _rakChip('Sisa Bulan', sisaBulanIni,
                  sisaBulanIni >= 0 ? Colors.green : Colors.red)),
        ]),
        SizedBox(height: 6),
        Row(children: [
          Expanded(child: _rakChip('Pagu Tahunan', _rakTahunan, Colors.blue)),
          SizedBox(width: 6),
          Expanded(
              child: _rakChip(
                  'Terpakai', _totalSpjDisetujuiTahunan, Colors.orange)),
          SizedBox(width: 6),
          Expanded(
              child: _rakChip('Sisa Tahunan', sisaTahunan,
                  sisaTahunan >= 0 ? Colors.green : Colors.red)),
        ]),
      ]),
    );
  }

  Widget _rakChip(String label, int nilai, Color warna) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          color: warna.withOpacity(.08),
          borderRadius: BorderRadius.circular(6)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        SizedBox(height: 2),
        Text(
          '${nilai < 0 ? '-' : ''}Rp ${_formatRupiah(nilai.abs())}',
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: warna),
        ),
      ]),
    );
  }

  // ── Section Personel ─────────────────────────────────────────
  Widget _buildSectionPersonel() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Header personel
      Row(children: [
        Icon(Icons.people_outline, size: 15, color: Color(0xFF0D6EFD)),
        SizedBox(width: 6),
        Text('Personel',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        SizedBox(width: 6),
        if (_personelList.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
                color: Color(0xFF0D6EFD).withOpacity(.1),
                borderRadius: BorderRadius.circular(8)),
            child: Text('${_personelList.length}',
                style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF0D6EFD),
                    fontWeight: FontWeight.w600)),
          ),
        Spacer(),
        TextButton.icon(
          onPressed: () => setState(() => _personelList.add(_PersonelEntry())),
          icon: Icon(Icons.add, size: 14),
          label: Text('Tambah', style: TextStyle(fontSize: 12)),
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        ),
      ]),
      SizedBox(height: 6),

      if (_personelList.isEmpty)
        Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200)),
          child: Text('Belum ada personel. Klik Tambah untuk menambahkan.',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        )
      else ...[
        // List personel
        ...List.generate(_personelList.length, (i) {
          final p = _personelList[i];
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(children: [
              Row(children: [
                // Nomor urut
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      color: Color(0xFF0D6EFD).withOpacity(.1),
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text('${i + 1}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF0D6EFD),
                              fontWeight: FontWeight.w600))),
                ),
                SizedBox(width: 8),
                // Search pegawai
                Expanded(
                  child: _loadingPegawai
                      ? SizedBox(
                          height: 36,
                          child: Center(child: LinearProgressIndicator()))
                      : Autocomplete<Map<String, dynamic>>(
                          initialValue: TextEditingValue(text: p.namaPegawai),
                          optionsBuilder: (textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable.empty();
                            }
                            final q = textEditingValue.text.toLowerCase();
                            return _semuaPegawai.where((pegawai) =>
                                pegawai['nama']
                                    .toString()
                                    .toLowerCase()
                                    .contains(q));
                          },
                          displayStringForOption: (option) =>
                              option['nama'] as String,
                          onSelected: (option) {
                            setState(() {
                              p.idPegawai = option['id'] as String;
                              p.namaPegawai = option['nama'] as String;
                            });
                          },
                          fieldViewBuilder:
                              (context, ctrl, focusNode, onFieldSubmitted) {
                            return TextField(
                              controller: ctrl,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText: 'Cari nama pegawai...',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              style: TextStyle(fontSize: 12),
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(8),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 200, maxWidth: 300),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return InkWell(
                                        onTap: () => onSelected(option),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                          child: Text(option['nama'] as String,
                                              style: TextStyle(fontSize: 13)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(width: 8),
                // Nominal
                SizedBox(
                  width: 130,
                  child: TextField(
                    controller: p.nominalCtrl,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      prefixText: 'Rp ',
                      hintText: '0',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(width: 6),
                // Hapus
                IconButton(
                  onPressed: () => setState(() {
                    _personelList[i].dispose();
                    _personelList.removeAt(i);
                  }),
                  icon: Icon(Icons.close, size: 16, color: Colors.red.shade300),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  tooltip: 'Hapus personel',
                ),
              ]),
            ]),
          );
        }),

        // Total nominal → jadi nominal SPJ
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF0D6EFD).withOpacity(.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF0D6EFD).withOpacity(.2)),
          ),
          child: Row(children: [
            Icon(Icons.calculate_outlined, size: 14, color: Color(0xFF0D6EFD)),
            SizedBox(width: 6),
            Text('Total Nominal SPJ',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            Spacer(),
            Text(
              'Rp ${_formatRupiah(_totalNominalPersonel)}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D6EFD)),
            ),
          ]),
        ),
        SizedBox(height: 10),
        // RAK warning berdasarkan total personel
        if (_selectedRekeningId != null) _buildRAKInfo(),
      ],
    ]);
  }

  String _formatRupiah(int angka) {
    String s = angka.toString();
    String result = '';
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) result = '.$result';
      result = s[i] + result;
      count++;
    }
    return result;
  }

  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600, // diperlebar dari 520 karena ada kolom personel
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(children: [
                Icon(Icons.receipt_long_outlined,
                    color: Color(0xFF0D6EFD), size: 20),
                SizedBox(width: 8),
                Text('Buat SPJ Baru',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ]),
              SizedBox(height: 12),

              // Label kegiatan
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xFF0D6EFD).withOpacity(.06),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  Icon(Icons.link, size: 14, color: Color(0xFF0D6EFD)),
                  SizedBox(width: 8),
                  Expanded(
                      child: Text(widget.namaKegiatan,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0D6EFD),
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis)),
                ]),
              ),
              SizedBox(height: 16),

              // Rekening
              Text('Kode Rekening / Belanja',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              _loadingRekening
                  ? Center(child: CircularProgressIndicator())
                  : _listRekening.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(.08),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                              'Tidak ada rekening untuk sub-kegiatan ini.',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.orange)),
                        )
                      : DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _selectedRekeningId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          hint: Text('Pilih rekening...',
                              style: TextStyle(fontSize: 13)),
                          items: _listRekening
                              .map((r) => DropdownMenuItem(
                                    value: r['id_rekening'] as String,
                                    child: Text(
                                        '${r['kode_rekening']} — ${r['uraian_belanja']}',
                                        style: TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            setState(() => _selectedRekeningId = v);
                            if (v != null) _hitungRAK(v);
                          },
                        ),
              SizedBox(height: 16),

              Divider(height: 1, color: Colors.grey.shade200),
              SizedBox(height: 14),

              // Personel + Total + RAK warning
              _buildSectionPersonel(),
              SizedBox(height: 16),

              Divider(height: 1, color: Colors.grey.shade200),
              SizedBox(height: 14),

              // Keterangan
              Text('Keterangan (opsional)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              TextField(
                controller: _keteranganCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Catatan tambahan...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 20),

              // Actions
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal')),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loading ? null : _simpan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D6EFD),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _loading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text('Simpan SPJ'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
