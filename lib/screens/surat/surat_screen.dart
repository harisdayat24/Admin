// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:minia_web_project/widgets/upload_dokumen_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;
import 'package:minia_web_project/widgets/breadcrumb_widget.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:get/get.dart';

class SuratScreen extends StatefulWidget {
  const SuratScreen({super.key});

  @override
  State<SuratScreen> createState() => _SuratScreenState();
}

class _SuratScreenState extends State<SuratScreen> {
  final _supabase = Supabase.instance.client;

  bool _loading = true;
  String _error = '';
  List<Map<String, dynamic>> _cacheSurat = [];
  List<Map<String, dynamic>> _filtered = [];
  List<Map<String, dynamic>> _instansi = [];
  List<Map<String, dynamic>> _pegawai = [];
  int _halamanAktif = 1;
  final int _itemPerHalaman = 10;

  List<Map<String, dynamic>> get _halamanData {
    int start = (_halamanAktif - 1) * _itemPerHalaman;
    int end = (start + _itemPerHalaman).clamp(0, _filtered.length);
    return _filtered.sublist(start, end);
  }

  int get _totalHalaman => (_filtered.length / _itemPerHalaman).ceil();

  // Filter state
  String _filterJenis = 'SEMUA';
  String _cariKeyword = '';
  final _cariController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _cariController.dispose();
    super.dispose();
  }

  // ============================================================
  // DATA LOADING
  // ============================================================

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = '';
    });
    try {
      await Future.wait([_loadSurat(), _loadInstansi(), _loadPegawai()]);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadSurat() async {
    final masuk = await _supabase
        .from('log_surat')
        .select('''
          id_surat, jenis_surat, no_surat, tgl_surat, hal,
          isi_disposisi, link_file_surat, status,
          pengirim:pengirim_id ( nama_instansi ),
          pic:pic_disposisi_id ( nama )
        ''')
        .eq('jenis_surat', 'MASUK')
        .order('tgl_surat', ascending: false)
        .limit(100);

    final keluar = await _supabase
        .from('log_surat')
        .select('''
          id_surat, jenis_surat, no_surat, tgl_surat, hal,
          link_file_surat, status,
          pic:pic_disposisi_id ( nama ),
          tujuan:log_surat_tujuan ( instansi:id_instansi ( nama_instansi ) )
        ''')
        .eq('jenis_surat', 'KELUAR')
        .order('tgl_surat', ascending: false)
        .limit(100);

    List<Map<String, dynamic>> semua = [];

    for (var s in masuk) {
      semua.add({
        'id': s['id_surat'],
        'jenis': s['jenis_surat'],
        'no': s['no_surat'] ?? '-',
        'tgl': _formatTgl(s['tgl_surat']),
        'asal': s['pengirim']?['nama_instansi'] ?? '-',
        'hal': s['hal'] ?? '-',
        'disposisi': s['isi_disposisi'] ?? '-',
        'pic': s['pic']?['nama'] ?? '-',
        'link': s['link_file_surat'] ?? '-',
        'status': s['status'] ?? '-',
      });
    }

    for (var s in keluar) {
      List tujuanList = s['tujuan'] ?? [];
      String tujuan = tujuanList
          .map((t) => t['instansi']?['nama_instansi'] ?? '')
          .where((n) => n.isNotEmpty)
          .join(', ');
      semua.add({
        'id': s['id_surat'],
        'jenis': s['jenis_surat'],
        'no': s['no_surat'] ?? '-',
        'tgl': _formatTgl(s['tgl_surat']),
        'asal': tujuan.isEmpty ? '-' : tujuan,
        'hal': s['hal'] ?? '-',
        'disposisi': '-',
        'pic': s['pic']?['nama'] ?? '-',
        'link': s['link_file_surat'] ?? '-',
        'status': s['status'] ?? '-',
      });
    }

    semua.sort((a, b) => b['tgl'].compareTo(a['tgl']));

    _cacheSurat = semua;
    _applyFilter();
  }

  Future<void> _loadInstansi() async {
    final data = await _supabase
        .from('master_instansi')
        .select('id, nama_instansi, kategori')
        .order('nama_instansi');
    _instansi = List<Map<String, dynamic>>.from(data);
  }

  Future<void> _loadPegawai() async {
    final data = await _supabase
        .from('pegawai')
        .select('id, nama, jabatan')
        .eq('is_internal', true) // ← tambah ini
        .neq('nama', 'MASFUFAH, S.H., M.PSDM.')
        .order('nama');
    _pegawai = List<Map<String, dynamic>>.from(data);
    _pegawai.sort((a, b) => a['nama']
        .toString()
        .toLowerCase()
        .compareTo(b['nama'].toString().toLowerCase()));
  }

  void _applyFilter() {
    setState(() {
      _halamanAktif = 1;
      _filtered = _cacheSurat.where((s) {
        bool cocokJenis = _filterJenis == 'SEMUA' || s['jenis'] == _filterJenis;
        bool cocokCari = _cariKeyword.isEmpty ||
            s['no'].toLowerCase().contains(_cariKeyword) ||
            s['hal'].toLowerCase().contains(_cariKeyword) ||
            s['asal'].toLowerCase().contains(_cariKeyword) ||
            s['pic'].toLowerCase().contains(_cariKeyword);
        return cocokJenis && cocokCari;
      }).toList();
    });
  }

  Future<void> _tandaiSelesai(String idSurat) async {
    await _supabase
        .from('log_surat')
        .update({'status': 'Selesai'}).eq('id_surat', idSurat);
    await _loadSurat();
  }

  // ============================================================
  // EXPORT PDF
  // ============================================================

  Future<void> _exportPDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.all(24),
        build: (ctx) => [
          pw.Text('Rekapitulasi Arsip Persuratan',
              style:
                  pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Text('Sub BLUD — Biro Perekonomian Setda Prov. Jatim',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
          pw.SizedBox(height: 16),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            columnWidths: {
              0: pw.FixedColumnWidth(25),
              1: pw.FixedColumnWidth(55),
              2: pw.FixedColumnWidth(70),
              3: pw.FixedColumnWidth(60),
              4: pw.FlexColumnWidth(2),
              5: pw.FlexColumnWidth(2),
              6: pw.FixedColumnWidth(60),
              7: pw.FixedColumnWidth(55),
            },
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.blue50),
                children: [
                  _pdfCell('No', bold: true),
                  _pdfCell('Jenis', bold: true),
                  _pdfCell('No Surat', bold: true),
                  _pdfCell('Tanggal', bold: true),
                  _pdfCell('Asal / Tujuan', bold: true),
                  _pdfCell('Perihal', bold: true),
                  _pdfCell('PIC', bold: true),
                  _pdfCell('Status', bold: true),
                ],
              ),
              ..._filtered.asMap().entries.map((entry) {
                int i = entry.key + 1;
                var s = entry.value;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: i % 2 == 0 ? PdfColors.grey50 : PdfColors.white,
                  ),
                  children: [
                    _pdfCell('$i'),
                    _pdfCell(s['jenis'] ?? '-'),
                    _pdfCell(s['no'] ?? '-'),
                    _pdfCell(s['tgl'] ?? '-'),
                    _pdfCell(s['asal'] ?? '-'),
                    _pdfCell(s['hal'] ?? '-'),
                    _pdfCell(s['pic'] ?? '-'),
                    _pdfCell(s['status'] ?? '-'),
                  ],
                );
              }),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text('Total: ${_filtered.length} surat',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Rekapitulasi_Surat.pdf',
    );
  }

  pw.Widget _pdfCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
            ],
          ),
          child: Column(
            children: [
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
              SizedBox(height: 12),
              _buildPaginasi(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaginasi() {
    if (_totalHalaman <= 1) return SizedBox();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Menampilkan ${((_halamanAktif - 1) * _itemPerHalaman) + 1}–'
            '${(_halamanAktif * _itemPerHalaman).clamp(0, _filtered.length)} '
            'dari ${_filtered.length} data',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(width: 16),
          IconButton(
            onPressed: _halamanAktif > 1
                ? () => setState(() => _halamanAktif--)
                : null,
            icon: Icon(Icons.chevron_left),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 8),
          ...List.generate(_totalHalaman, (i) {
            int h = i + 1;
            bool aktif = h == _halamanAktif;
            return GestureDetector(
              onTap: () => setState(() => _halamanAktif = h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: aktif ? Color(0xFF0D6EFD) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: aktif ? Color(0xFF0D6EFD) : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text('$h',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              aktif ? FontWeight.w700 : FontWeight.normal,
                          color: aktif ? Colors.white : Colors.grey)),
                ),
              ),
            );
          }),
          SizedBox(width: 8),
          IconButton(
            onPressed: _halamanAktif < _totalHalaman
                ? () => setState(() => _halamanAktif++)
                : null,
            icon: Icon(Icons.chevron_right),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
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
                  onTap: () => Get.find<SideBarController>().index.value = 0,
                ),
                BreadcrumbItem(label: 'Korespondensi'),
              ]),
              SizedBox(height: 20),
              Text('Arsip Persuratan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              Text('Riwayat surat masuk & keluar beserta disposisi.',
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
        ElevatedButton.icon(
          onPressed: () => _bukaFormSurat(context),
          icon: Icon(Icons.add, size: 18),
          label: Text('Catat Surat Baru'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D6EFD),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            width: 260,
            child: TextField(
              controller: _cariController,
              onChanged: (v) {
                _cariKeyword = v.toLowerCase();
                _applyFilter();
              },
              decoration: InputDecoration(
                hintText: 'Cari no surat / perihal...',
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
          _filterBtn('Masuk', 'MASUK'),
          SizedBox(width: 6),
          _filterBtn('Keluar', 'KELUAR'),
          Spacer(),
          IconButton(
            onPressed: _loadData,
            icon: Icon(Icons.refresh, color: Color(0xFF0D6EFD)),
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }

  Widget _filterBtn(String label, String value) {
    bool active = _filterJenis == value;
    return InkWell(
      onTap: () {
        setState(() => _filterJenis = value);
        _applyFilter();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? Color(0xFF0D6EFD) : Colors.grey.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
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
            Icon(Icons.email_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Belum ada data surat.', style: TextStyle(color: Colors.grey)),
          ]),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1600),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
          dataRowMinHeight: 52,
          dataRowMaxHeight: 90,
          columnSpacing: 20,
          columns: [
            DataColumn(label: Text('Jenis', style: _thStyle)),
            DataColumn(label: Text('No Surat', style: _thStyle)),
            DataColumn(label: Text('Tanggal', style: _thStyle)),
            DataColumn(label: Text('Asal / Tujuan', style: _thStyle)),
            DataColumn(label: Text('Perihal / Hal', style: _thStyle)),
            DataColumn(label: Text('PIC', style: _thStyle)),
            DataColumn(label: Text('File', style: _thStyle)),
            DataColumn(label: Text('Status', style: _thStyle)),
          ],
          rows: _halamanData.map((s) {
            bool isMasuk = s['jenis'] == 'MASUK';
            bool isSelesai =
                s['status'] == 'Selesai' || s['status'] == 'Terkirim';

            return DataRow(cells: [
              DataCell(Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isMasuk
                      ? Colors.green.withOpacity(.1)
                      : Colors.grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    isMasuk ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 12,
                    color: isMasuk ? Colors.green : Colors.grey.shade700,
                  ),
                  SizedBox(width: 4),
                  Text(
                    isMasuk ? 'Masuk' : 'Keluar',
                    style: TextStyle(
                        fontSize: 12,
                        color: isMasuk ? Colors.green : Colors.grey.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              )),
              DataCell(Text(s['no'],
                  style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
              DataCell(Text(s['tgl'],
                  style: TextStyle(fontSize: 12, color: Colors.grey))),
              DataCell(ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 160),
                child: Text(s['asal'],
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              )),
              DataCell(ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 220),
                child: Text(s['hal'],
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              )),
              DataCell(Text(s['pic'], style: TextStyle(fontSize: 12))),
              DataCell(
                s['link'] != null && s['link'] != '-'
                    ? IconButton(
                        onPressed: () => html.window.open(s['link'], '_blank'),
                        icon: Icon(Icons.picture_as_pdf,
                            color: Colors.red, size: 20),
                        tooltip: 'Lihat File',
                      )
                    : Text('-', style: TextStyle(color: Colors.grey)),
              ),
              DataCell(
                isSelesai
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Selesai',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500)),
                      )
                    : TextButton.icon(
                        onPressed: () => _tandaiSelesai(s['id']),
                        icon: Icon(Icons.check, size: 14),
                        label: Text('Proses', style: TextStyle(fontSize: 12)),
                      ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  // ============================================================
  // FORM INPUT SURAT
  // ============================================================

  void _bukaFormSurat(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _FormSuratDialog(
        instansi: _instansi,
        pegawai: _pegawai,
        onSimpan: (data) async {
          try {
            if (data['jenis'] == 'MASUK') {
              await _supabase.rpc('simpan_surat_masuk', params: {
                'p_no_surat': data['no_surat'],
                'p_tgl_surat': data['tgl_surat'],
                'p_hal': data['hal'],
                'p_pengirim_id': data['pengirim_id'],
                'p_pic_id': data['pic_id'],
                'p_disposisi': data['disposisi'],
                'p_link_file': data['link_file'],
              });
            } else {
              await _supabase.rpc('simpan_surat_keluar', params: {
                'p_no_surat': data['no_surat'],
                'p_tgl_surat': data['tgl_surat'],
                'p_hal': data['hal'],
                'p_pic_id': data['pic_id'],
                'p_link_file': data['link_file'],
                'p_tujuan_ids': data['tujuan_ids'],
              });
            }
            await _loadSurat();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('✅ Surat berhasil disimpan'),
                backgroundColor: Colors.green,
              ));
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('❌ Gagal: $e'),
                backgroundColor: Colors.red,
              ));
            }
          }
        },
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  TextStyle get _thStyle =>
      TextStyle(fontWeight: FontWeight.w600, fontSize: 13);

  String _formatTgl(dynamic raw) {
    if (raw == null) return '-';
    try {
      DateTime dt = DateTime.parse(raw.toString());
      return '${dt.day.toString().padLeft(2, '0')}/'
          '${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return raw.toString();
    }
  }
}

// ============================================================
// DIALOG FORM INPUT SURAT
// ============================================================

class _FormSuratDialog extends StatefulWidget {
  final List<Map<String, dynamic>> instansi;
  final List<Map<String, dynamic>> pegawai;
  final Function(Map<String, dynamic>) onSimpan;

  const _FormSuratDialog({
    required this.instansi,
    required this.pegawai,
    required this.onSimpan,
  });

  @override
  State<_FormSuratDialog> createState() => _FormSuratDialogState();
}

class _FormSuratDialogState extends State<_FormSuratDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  // State form
  String _jenis = 'MASUK';
  String _noSurat = '';
  DateTime? _tglSurat;
  String _hal = '';
  String? _pengirimId;
  List<String> _tujuanIds = [];
  String? _picId;
  String _disposisi = '';
  String _linkFile = '';

  final _noSuratCtrl = TextEditingController();
  final _halCtrl = TextEditingController();

  // Instansi baru manual
  final _supabase = Supabase.instance.client;
  bool _showInstansiBaru = false;
  final _instansiBaruCtrl = TextEditingController();

  @override
  void dispose() {
    _instansiBaruCtrl.dispose();
    _noSuratCtrl.dispose();
    _halCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          children: [
            // Header dialog
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF0D6EFD),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text('Catat Surat Baru',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.white, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Isi form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Jenis Surat Toggle
                      _label('Jenis Surat'),
                      Row(
                        children: [
                          _jenisBtn(
                              'MASUK', 'Surat Masuk', Icons.arrow_downward),
                          SizedBox(width: 10),
                          _jenisBtn(
                              'KELUAR', 'Surat Keluar', Icons.arrow_upward),
                        ],
                      ),
                      SizedBox(height: 16),

                      // No Surat
                      _label('Nomor Surat'),
                      TextFormField(
                        controller: _noSuratCtrl,
                        onChanged: (v) => _noSurat = v,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                        decoration: _inputDeco('Contoh: 005/PWK.BLD/V/2026'),
                      ),
                      SizedBox(height: 14),

                      // Tanggal + Instansi
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Tanggal Surat'),
                                InkWell(
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2024),
                                      lastDate: DateTime(2027),
                                    );
                                    if (picked != null) {
                                      setState(() => _tglSurat = picked);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 8),
                                        Text(
                                          _tglSurat == null
                                              ? 'Pilih tanggal...'
                                              : '${_tglSurat!.day}/${_tglSurat!.month}/${_tglSurat!.year}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: _tglSurat == null
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label(_jenis == 'MASUK'
                                    ? 'Asal Instansi (Pengirim)'
                                    : 'Tujuan Instansi (Penerima)'),
                                _buildInstansiPicker(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),

                      // Perihal
                      _label('Perihal / Hal'),
                      TextFormField(
                        controller: _halCtrl,
                        onChanged: (v) => _hal = v,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                        maxLines: 2,
                        decoration: _inputDeco('Isi perihal surat...'),
                      ),
                      SizedBox(height: 14),

                      // Disposisi (hanya surat masuk)
                      if (_jenis == 'MASUK') ...[
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.05),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.green.withOpacity(.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.edit_note,
                                    color: Colors.green, size: 18),
                                SizedBox(width: 6),
                                Text('Lembar Disposisi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green)),
                              ]),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Isi Disposisi'),
                                        TextFormField(
                                          onChanged: (v) => _disposisi = v,
                                          decoration: _inputDeco(
                                              'Contoh: Hadiri dan laporkan...'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _label('Diteruskan ke (PIC)'),
                                        DropdownButtonFormField<String>(
                                          value: _picId,
                                          onChanged: (v) =>
                                              setState(() => _picId = v),
                                          decoration: _inputDeco('Pilih PIC'),
                                          items: widget.pegawai
                                              .map((p) =>
                                                  DropdownMenuItem<String>(
                                                    value: p['id'].toString(),
                                                    child: Text(p['nama'],
                                                        style: TextStyle(
                                                            fontSize: 13)),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                      ],

                      // Upload file surat
                      Text('File Surat',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6),
                      UploadDokumenWidget(
                        folder: 'surat',
                        label: 'Upload File Surat',
                        onUploaded: (url) => setState(() => _linkFile = url),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _saving ? null : _simpan,
                    icon: _saving
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : Icon(Icons.save, size: 16),
                    label: Text(_saving ? 'Menyimpan...' : 'Simpan Surat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0D6EFD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstansiPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Autocomplete<Map<String, dynamic>>(
                displayStringForOption: (ins) =>
                    ins['nama_instansi'].toString(),
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return widget.instansi;
                  }
                  return widget.instansi.where((ins) => ins['nama_instansi']
                      .toString()
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (ins) {
                  final v = ins['id'].toString();
                  setState(() {
                    if (_jenis == 'MASUK') {
                      _pengirimId = v;
                    } else {
                      if (!_tujuanIds.contains(v)) {
                        _tujuanIds.add(v);
                      }
                    }
                  });
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onSubmitted) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: _inputDeco('Ketik nama instansi...'),
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 200, maxWidth: 400),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final ins = options.elementAt(index);
                            return ListTile(
                              dense: true,
                              title: Text(ins['nama_instansi'],
                                  style: TextStyle(fontSize: 13)),
                              onTap: () => onSelected(ins),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 6),
            IconButton(
              onPressed: () =>
                  setState(() => _showInstansiBaru = !_showInstansiBaru),
              icon: Icon(Icons.add_circle_outline, color: Color(0xFF0D6EFD)),
              tooltip: 'Tambah instansi baru',
            ),
          ],
        ),
        if (_showInstansiBaru) ...[
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _instansiBaruCtrl,
                  decoration: _inputDeco('Nama instansi baru...'),
                ),
              ),
              SizedBox(width: 6),
              ElevatedButton(
                onPressed: _simpanInstansiBaru,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: Text('Simpan'),
              ),
            ],
          ),
        ],
        if (_jenis == 'MASUK' && _pengirimId != null) ...[
          SizedBox(height: 6),
          _instansiTag(_pengirimId!, onRemove: () {
            setState(() => _pengirimId = null);
          }),
        ],
        if (_jenis == 'KELUAR' && _tujuanIds.isNotEmpty) ...[
          SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _tujuanIds
                .map((id) => _instansiTag(id, onRemove: () {
                      setState(() => _tujuanIds.remove(id));
                    }))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _instansiTag(String id, {required VoidCallback onRemove}) {
    String nama = widget.instansi
        .firstWhere((i) => i['id'].toString() == id,
            orElse: () => {'nama_instansi': id})['nama_instansi']
        .toString();
    String namaRingkas =
        nama.length > 25 ? '${nama.substring(0, 25)}...' : nama;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF0D6EFD).withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF0D6EFD).withOpacity(.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(namaRingkas,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0D6EFD),
                  fontWeight: FontWeight.w500)),
          SizedBox(width: 4),
          InkWell(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14, color: Color(0xFF0D6EFD)),
          ),
        ],
      ),
    );
  }

  Future<void> _simpanInstansiBaru() async {
    String nama = _instansiBaruCtrl.text.trim();
    if (nama.isEmpty) return;

    final result = await _supabase
        .from('master_instansi')
        .insert({'nama_instansi': nama, 'kategori': 'Lainnya'})
        .select()
        .single();

    setState(() {
      widget.instansi.add(result);
      if (_jenis == 'MASUK') {
        _pengirimId = result['id'].toString();
      } else {
        _tujuanIds.add(result['id'].toString());
      }
      _instansiBaruCtrl.clear();
      _showInstansiBaru = false;
    });
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    if (_tglSurat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pilih tanggal surat terlebih dahulu')));
      return;
    }
    if (_jenis == 'MASUK' && _pengirimId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pilih instansi pengirim')));
      return;
    }
    if (_jenis == 'KELUAR' && _tujuanIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pilih minimal satu instansi tujuan')));
      return;
    }

    setState(() => _saving = true);

    String tglStr =
        '${_tglSurat!.year}-${_tglSurat!.month.toString().padLeft(2, '0')}-${_tglSurat!.day.toString().padLeft(2, '0')}';

    await widget.onSimpan({
      'jenis': _jenis,
      'no_surat': _noSurat,
      'tgl_surat': tglStr,
      'hal': _hal,
      'pengirim_id': _pengirimId,
      'tujuan_ids': _tujuanIds,
      'pic_id': _picId,
      'disposisi': _disposisi,
      'link_file': _linkFile,
    });

    setState(() => _saving = false);
    if (mounted) Navigator.pop(context);
  }

  Widget _jenisBtn(String value, String label, IconData icon) {
    bool active = _jenis == value;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _jenis = value;
          _pengirimId = null;
          _tujuanIds = [];
        }),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Color(0xFF0D6EFD) : Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: active ? Color(0xFF0D6EFD) : Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: active ? Colors.white : Colors.grey),
              SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: active ? Colors.white : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF0D6EFD))),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      );
}
