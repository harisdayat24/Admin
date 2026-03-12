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

class KegiatanScreen extends StatefulWidget {
  const KegiatanScreen({super.key});

  @override
  State<KegiatanScreen> createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  final _supabase = Supabase.instance.client;

  bool _loading = true;
  String _error = '';
  List<Map<String, dynamic>> _cacheKegiatan = [];
  List<Map<String, dynamic>> _filtered = [];
  int _halamanAktif = 1;
  final int _itemPerHalaman = 10;
  List<Map<String, dynamic>> get _halamanData {
    int start = (_halamanAktif - 1) * _itemPerHalaman;
    int end = (start + _itemPerHalaman).clamp(0, _filtered.length);
    return _filtered.sublist(start, end);
  }

  int get _totalHalaman => (_filtered.length / _itemPerHalaman).ceil();

  // Master data untuk form
  List<Map<String, dynamic>> _subKegiatan = [];
  List<Map<String, dynamic>> _pegawai = [];
  List<Map<String, dynamic>> _surat = [];
  List<Map<String, dynamic>> _rekening = [];
  Map<String, Map<String, dynamic>> _sisaPaguMap = {};
  List<Map<String, String>> _bulanOptions() {
    const bulan = [
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
    int tahun = DateTime.now().year;
    return List.generate(
        12,
        (i) => {
              'value': '$tahun-${(i + 1).toString().padLeft(2, '0')}',
              'label': bulan[i],
            });
  }

  // Filter
  String _filterStatus = 'SEMUA';
  String _cariKeyword = '';
  String? _filterDari;
  String? _filterSampai;
  final _cariCtrl = TextEditingController();

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
      await Future.wait([
        _loadKegiatan(),
        _loadMasterData(),
      ]);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _exportPDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.all(24),
        build: (ctx) => [
          // Header
          pw.Text('Rekapitulasi Agenda Kegiatan',
              style:
                  pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Text('Sub BLUD — Biro Perekonomian Setda Prov. Jatim',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
          pw.Text('Tahun Anggaran 2026',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
          pw.SizedBox(height: 16),

          // Tabel
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            columnWidths: {
              0: pw.FixedColumnWidth(30),
              1: pw.FixedColumnWidth(70),
              2: pw.FlexColumnWidth(3),
              3: pw.FlexColumnWidth(2),
              4: pw.FixedColumnWidth(80),
              5: pw.FixedColumnWidth(80),
            },
            children: [
              // Header tabel
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.blue50),
                children: [
                  _pdfCell('No', bold: true),
                  _pdfCell('Tanggal', bold: true),
                  _pdfCell('Nama Kegiatan', bold: true),
                  _pdfCell('PIC', bold: true),
                  _pdfCell('Jenis', bold: true),
                  _pdfCell('Status', bold: true),
                ],
              ),
              // Data
              ..._filtered.asMap().entries.map((entry) {
                int i = entry.key + 1;
                var k = entry.value;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: i % 2 == 0 ? PdfColors.grey50 : PdfColors.white,
                  ),
                  children: [
                    _pdfCell('$i'),
                    _pdfCell(k['tgl'] ?? '-'),
                    _pdfCell(k['nama'] ?? '-'),
                    _pdfCell(k['pic'] ?? '-'),
                    _pdfCell(k['butuh_anggaran'] == true ? 'SPJ' : 'Non-SPJ'),
                    _pdfCell(k['status'] ?? '-'),
                  ],
                );
              }),
            ],
          ),

          pw.SizedBox(height: 12),
          pw.Text('Total: ${_filtered.length} kegiatan',
              style: pw.TextStyle(fontSize: 11, color: PdfColors.grey)),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Rekapitulasi_Kegiatan_2026.pdf',
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

  Future<void> _loadKegiatan() async {
    final data = await _supabase.from('data_kegiatan').select('''
          id_kegiatan, nama_kegiatan, tgl_pelaksanaan,
          kode_sub_kegiatan, sumber, butuh_anggaran,
          output_substansi, link_laporan, status_proses, is_output_utama,
          pic:pic_kegiatan_id ( nama ),
          surat:ref_id_surat ( no_surat, hal )
        ''').order('tgl_pelaksanaan', ascending: false).limit(100);

    _cacheKegiatan = data
        .map<Map<String, dynamic>>((k) => {
              'id': k['id_kegiatan'],
              'nama': k['nama_kegiatan'] ?? '-',
              'tgl': _formatTgl(k['tgl_pelaksanaan']),
              'kode_sub': k['kode_sub_kegiatan'] ?? '-',
              'sumber': k['sumber'] ?? '-',
              'anggaran': k['butuh_anggaran'] == true ? 'YA' : 'TIDAK',
              'is_output_utama': k['is_output_utama'] ?? false,
              'output': k['output_substansi'] ?? '-',
              'link_lap': k['link_laporan'] ?? '-',
              'status': k['status_proses'] ?? '-',
              'pic': k['pic']?['nama'] ?? '-',
              'ref_surat': k['surat']?['no_surat'] ?? '-',
            })
        .toList();

    _applyFilter();
  }

  Future<void> _loadMasterData() async {
    // Sub-kegiatan
    final sub = await _supabase
        .from('master_sub_kegiatan')
        .select('kode_sub, nomenklatur')
        .eq('is_aktif', true)
        .eq('tahun_anggaran', 2026);
    _subKegiatan = List<Map<String, dynamic>>.from(sub);

    // Pegawai (hanya internal, exclude Katim)
    final peg = await _supabase
        .from('pegawai')
        .select('id, nama, jabatan')
        .eq('is_internal', true)
        .neq('nama', 'MASFUFAH, S.H., M.PSDM.')
        .order('nama');
    _pegawai = List<Map<String, dynamic>>.from(peg);
    _pegawai.sort((a, b) => a['nama']
        .toString()
        .toLowerCase()
        .compareTo(b['nama'].toString().toLowerCase()));

    // Surat masuk untuk referensi
    final srt = await _supabase
        .from('log_surat')
        .select(
            'id_surat, no_surat, tgl_surat, hal, pengirim:pengirim_id(nama_instansi), pic:pic_disposisi_id(id, nama)')
        .eq('jenis_surat', 'MASUK')
        .order('tgl_surat', ascending: false)
        .limit(50);
    _surat = List<Map<String, dynamic>>.from(srt);

    // Hitung sisa pagu per sub-kegiatan
    await _hitungSisaPagu();
  }

  Future<void> _hitungSisaPagu() async {
    final dpa = await _supabase
        .from('master_dpa_rak')
        .select('kode_sub_kegiatan, kode_rekening, pagu_dpa')
        .eq('tahun_anggaran', 2026);

    final realisasi = await _supabase.rpc(
      'get_realisasi_per_sub_rekening',
      params: {'p_tahun': 2026},
    );

    // Akumulasi pagu per sub
    Map<String, int> paguPerSub = {};
    Map<String, int> realPerSub = {};

    for (var r in dpa) {
      String kode = r['kode_sub_kegiatan'] ?? '';
      int pagu = (r['pagu_dpa'] as int?) ?? 0;
      paguPerSub[kode] = (paguPerSub[kode] ?? 0) + pagu;
    }

    for (var r in realisasi) {
      String kode = r['kode_sub'] ?? '';
      int real = (r['total_realisasi'] as int?) ?? 0;
      realPerSub[kode] = (realPerSub[kode] ?? 0) + real;
    }

    _sisaPaguMap = {};
    for (var kode in paguPerSub.keys) {
      int pagu = paguPerSub[kode] ?? 0;
      int real = realPerSub[kode] ?? 0;
      int sisa = pagu - real;
      double pct = pagu > 0 ? (real / pagu * 100) : 0;
      _sisaPaguMap[kode] = {
        'pagu': pagu,
        'realisasi': real,
        'sisa': sisa,
        'persen': pct,
      };
    }
  }

  Future<void> _loadRekeningBySub(String kodeSub) async {
    final data = await _supabase
        .from('master_dpa_rak')
        .select('id_rekening, kode_rekening, uraian_belanja, pagu_dpa')
        .eq('kode_sub_kegiatan', kodeSub)
        .eq('tahun_anggaran', 2026);

    // Ambil realisasi per rekening untuk sub ini
    final realisasi = await _supabase.rpc(
      'get_realisasi_per_sub_rekening',
      params: {'p_tahun': 2026},
    );

    Map<String, int> realMap = {};
    for (var r in realisasi) {
      if (r['kode_sub'] == kodeSub) {
        realMap[r['kode_rekening']] = (r['total_realisasi'] as int?) ?? 0;
      }
    }

    setState(() {
      _rekening = data.map<Map<String, dynamic>>((r) {
        int pagu = (r['pagu_dpa'] as int?) ?? 0;
        int real = realMap[r['kode_rekening']] ?? 0;
        int sisa = pagu - real;
        return {
          'id': r['id_rekening'],
          'kode': r['kode_rekening'],
          'uraian': r['uraian_belanja'],
          'pagu': pagu,
          'real': real,
          'sisa': sisa,
        };
      }).toList();
    });
  }

  void _applyFilter() {
    setState(() {
      _halamanAktif = 1;
      _filtered = _cacheKegiatan.where((k) {
        bool cocokStatus = _filterStatus == 'SEMUA' ||
            (_filterStatus == 'Selesai' &&
                (k['status'] == 'Selesai' || k['status'] == 'Lunas')) ||
            (_filterStatus == 'Berjalan' &&
                k['status'] != 'Selesai' &&
                k['status'] != 'Lunas');
        bool cocokCari = _cariKeyword.isEmpty ||
            k['nama'].toLowerCase().contains(_cariKeyword) ||
            k['pic'].toLowerCase().contains(_cariKeyword);
        bool cocokTgl = true;
        if ((_filterDari != null || _filterSampai != null) &&
            k['tgl'] != null) {
          String tglBulan = k['tgl'].toString().substring(0, 7); // 'yyyy-MM'
          if (_filterDari != null && tglBulan.compareTo(_filterDari!) < 0) {
            cocokTgl = false;
          }
          if (_filterSampai != null && tglBulan.compareTo(_filterSampai!) > 0) {
            cocokTgl = false;
          }
        }
        return cocokStatus && cocokCari && cocokTgl; // ← tambah cocokTgl
      }).toList();
    });
  }

  void _uploadLaporanKegiatan(
      BuildContext context, String idKegiatan, String? existingUrl) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Icon(Icons.upload_file_outlined, color: Color(0xFF0D6EFD)),
          SizedBox(width: 8),
          Text('Upload Laporan Kegiatan'),
        ]),
        content: UploadDokumenWidget(
          folder: 'kegiatan',
          existingUrl: existingUrl,
          label: 'Upload Laporan',
          onUploaded: (url) async {
            await _supabase
                .from('data_kegiatan')
                .update({'link_laporan': url}).eq('id_kegiatan', idKegiatan);
            Navigator.pop(context);
            await _loadKegiatan();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('✅ Laporan berhasil diupload'),
                backgroundColor: Colors.green,
              ));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
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
              SizedBox(height: 12), // ← tambah ini
              _buildPaginasi(), // ← tambah ini
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaginasi() {
    if (_totalHalaman <= 1) return SizedBox();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Menampilkan ${((_halamanAktif - 1) * _itemPerHalaman) + 1}–'
          '${(_halamanAktif * _itemPerHalaman).clamp(0, _filtered.length)} '
          'dari ${_filtered.length} data',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(width: 16),
        // Tombol prev
        IconButton(
          onPressed:
              _halamanAktif > 1 ? () => setState(() => _halamanAktif--) : null,
          icon: Icon(Icons.chevron_left),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        SizedBox(width: 8),
        // Nomor halaman
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
                        fontWeight: aktif ? FontWeight.w700 : FontWeight.normal,
                        color: aktif ? Colors.white : Colors.grey)),
              ),
            ),
          );
        }),
        SizedBox(width: 8),
        // Tombol next
        IconButton(
          onPressed: _halamanAktif < _totalHalaman
              ? () => setState(() => _halamanAktif++)
              : null,
          icon: Icon(Icons.chevron_right),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
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
                  onTap: () => Get.find<SideBarController>().index.value = 4,
                ),
                BreadcrumbItem(label: 'Agenda Kegiatan'),
              ]),
              SizedBox(height: 20),
              Text('Agenda Kegiatan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              Text('Rekapitulasi seluruh kegiatan dan status pelaksanaannya.',
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
          onPressed: () => _bukaFormKegiatan(context),
          icon: Icon(Icons.add, size: 18),
          label: Text('Buat Kegiatan Baru'),
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
              controller: _cariCtrl,
              onChanged: (v) {
                _cariKeyword = v.toLowerCase();
                _applyFilter();
              },
              decoration: InputDecoration(
                hintText: 'Cari nama kegiatan / PIC...',
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
          _filterBtn('Berjalan', 'Berjalan'),
          SizedBox(width: 6),
          _filterBtn('Selesai', 'Selesai'),
          SizedBox(width: 12),

// Filter tanggal
          SizedBox(width: 12),
// Filter dari bulan
          DropdownButton<String>(
            value: _filterDari,
            hint: Text('Dari', style: TextStyle(fontSize: 12)),
            underline: SizedBox(),
            style: TextStyle(fontSize: 12, color: Colors.black),
            items: _bulanOptions()
                .map((b) => DropdownMenuItem(
                      value: b['value'],
                      child: Text(b['label']!),
                    ))
                .toList(),
            onChanged: (v) {
              setState(() => _filterDari = v);
              _applyFilter();
            },
          ),
          SizedBox(width: 6),
          Text('s/d', style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(width: 6),
// Filter sampai bulan
          DropdownButton<String>(
            value: _filterSampai,
            hint: Text('Bulan', style: TextStyle(fontSize: 12)),
            underline: SizedBox(),
            style: TextStyle(fontSize: 12, color: Colors.black),
            items: _bulanOptions()
                .map((b) => DropdownMenuItem(
                      value: b['value'],
                      child: Text(b['label']!),
                    ))
                .toList(),
            onChanged: (v) {
              setState(() => _filterSampai = v);
              _applyFilter();
            },
          ),
          if (_filterDari != null || _filterSampai != null)
            IconButton(
              onPressed: () {
                setState(() {
                  _filterDari = null;
                  _filterSampai = null;
                });
                _applyFilter();
              },
              icon: Icon(Icons.close, size: 14, color: Colors.grey),
              tooltip: 'Reset filter tanggal',
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),

          Spacer(),
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
    bool active = _filterStatus == value;
    return InkWell(
      onTap: () {
        setState(() => _filterStatus = value);
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
            Icon(Icons.calendar_month_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Belum ada data kegiatan.',
                style: TextStyle(color: Colors.grey)),
          ]),
        ),
      );
    }
    // ... sisa kode existing
    rows:
    _halamanData.map(
      (k) {
        return Padding(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(children: [
              Icon(Icons.event_busy_outlined, size: 48, color: Colors.grey),
              SizedBox(height: 8),
              Text('Belum ada data kegiatan.',
                  style: TextStyle(color: Colors.grey)),
            ]),
          ),
        );
      },
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1600),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
          dataRowMinHeight: 56,
          dataRowMaxHeight: 80,
          columnSpacing: 24,
          horizontalMargin: 20,
          columns: [
            DataColumn(label: Text('Tanggal', style: _thStyle)),
            DataColumn(label: Text('Nama Kegiatan', style: _thStyle)),
            DataColumn(label: Text('PIC', style: _thStyle)),
            DataColumn(label: Text('Jenis', style: _thStyle)),
            DataColumn(label: Text('Dokumen', style: _thStyle)),
            DataColumn(label: Text('Status', style: _thStyle)),
          ],
          rows: _halamanData.map((k) {
            bool selesai = k['status'] == 'Selesai' || k['status'] == 'Lunas';
            bool adaAnggaran = k['anggaran'] == 'YA';
            bool adaDokumen = k['link_lap'] != '-' && k['link_lap'].isNotEmpty;

            return DataRow(cells: [
              // Tanggal
              DataCell(Text(k['tgl'],
                  style: TextStyle(fontSize: 12, color: Colors.grey))),

              // Nama Kegiatan
              DataCell(ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      if (k['is_output_utama'] == true) ...[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('UTAMA',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(k['nama'],
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ]),
                    Text('ID: ${k['id']}',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              )),

              // PIC
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_outline, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(k['pic'], style: TextStyle(fontSize: 12)),
                ],
              )),

              // Jenis (SPJ / Adm)
              // Jenis (SPJ / Adm) — sekarang bisa diklik
              DataCell(
                GestureDetector(
                  onTap: () async {
                    final newVal = !adaAnggaran;
                    await _supabase.from('data_kegiatan').update(
                        {'butuh_anggaran': newVal}).eq('id_kegiatan', k['id']);
                    _loadData();
                  },
                  child: Tooltip(
                    message: adaAnggaran
                        ? 'Klik untuk hapus SPJ'
                        : 'Klik untuk tandai butuh SPJ',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: adaAnggaran
                            ? Color(0xFF0D6EFD).withOpacity(.1)
                            : Colors.grey.withOpacity(.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: adaAnggaran
                              ? Color(0xFF0D6EFD).withOpacity(.3)
                              : Colors.grey.withOpacity(.2),
                        ),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(
                          adaAnggaran
                              ? Icons.monetization_on_outlined
                              : Icons.description_outlined,
                          size: 12,
                          color: adaAnggaran ? Color(0xFF0D6EFD) : Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          adaAnggaran ? 'SPJ' : 'Adm',
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  adaAnggaran ? Color(0xFF0D6EFD) : Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.touch_app_outlined,
                          size: 10,
                          color: adaAnggaran
                              ? Color(0xFF0D6EFD).withOpacity(.5)
                              : Colors.grey.withOpacity(.5),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),

              // Dokumen
              DataCell(adaDokumen
                  ? Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        onPressed: () =>
                            html.window.open(k['link_lap'], '_blank'),
                        icon: Icon(Icons.file_present_outlined,
                            color: Colors.green, size: 20),
                        tooltip: 'Lihat Dokumen',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      SizedBox(width: 4),
                      IconButton(
                        onPressed: () => _uploadLaporanKegiatan(
                            context, k['id'], k['link_lap']),
                        icon: Icon(Icons.upload_outlined,
                            color: Colors.grey, size: 18),
                        tooltip: 'Perbarui',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ])
                  : TextButton.icon(
                      onPressed: () =>
                          _uploadLaporanKegiatan(context, k['id'], null),
                      icon: Icon(Icons.upload_outlined, size: 14),
                      label: Text('Upload', style: TextStyle(fontSize: 12)),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.orange,
                          padding: EdgeInsets.zero),
                    )),

              // Status
              DataCell(Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: selesai
                      ? Colors.green.withOpacity(.1)
                      : Colors.orange.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selesai ? 'Selesai' : 'Berjalan',
                  style: TextStyle(
                      fontSize: 12,
                      color: selesai ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w500),
                ),
              )),
            ]);
          }).toList(),
        ), // DataTable
      ), // ConstrainedBox
    ); // SingleChildScrollView
  }

  // ============================================================
  // FORM KEGIATAN
  // ============================================================
  void _bukaFormKegiatan(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _FormKegiatanDialog(
        subKegiatan: _subKegiatan,
        pegawai: _pegawai,
        surat: _surat,
        sisaPaguMap: _sisaPaguMap,
        onLoadRekening: _loadRekeningBySub,
        getRekening: () => _rekening,
        onSimpan: (data) async {
          try {
            // Insert kegiatan
            final kegResult = await _supabase
                .from('data_kegiatan')
                .insert({
                  'ref_id_surat': data['ref_id_surat'],
                  'kode_sub_kegiatan': data['kode_sub'],
                  'sumber': data['sumber'],
                  'nama_kegiatan': data['nama_kegiatan'],
                  'tgl_pelaksanaan': data['tgl_pelaksanaan'],
                  'pic_kegiatan_id': data['pic_id'],
                  'butuh_anggaran': data['butuh_anggaran'],
                  'is_output_utama': data['is_output_utama'], // ← tambah ini
                  'link_laporan': data['link_laporan'],
                  'id_klaster': data['id_klaster'], // ← tambah ini
                  'status_proses': data['butuh_anggaran'] == true
                      ? 'Menunggu Verifikasi'
                      : 'Selesai',
                })
                .select('id_kegiatan')
                .single();

            String idKegiatan = kegResult['id_kegiatan'];

            // Insert SPJ items jika butuh anggaran
            if (data['butuh_anggaran'] == true) {
              List items = data['spj_items'] ?? [];
              for (var item in items) {
                await _supabase.from('data_spj').insert({
                  'ref_id_kegiatan': idKegiatan,
                  'ref_id_dpa': item['id_rekening'],
                  'nominal': item['nominal'],
                  'status_verif': 'Draft',
                });
              }
            }

            await _loadKegiatan();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('✅ Kegiatan berhasil disimpan'),
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
// DIALOG FORM INPUT KEGIATAN
// ============================================================
class _FormKegiatanDialog extends StatefulWidget {
  final List<Map<String, dynamic>> subKegiatan;
  final List<Map<String, dynamic>> pegawai;
  final List<Map<String, dynamic>> surat;
  final Map<String, Map<String, dynamic>> sisaPaguMap;
  final Future<void> Function(String) onLoadRekening;
  final List<Map<String, dynamic>> Function() getRekening;
  final Function(Map<String, dynamic>) onSimpan;

  const _FormKegiatanDialog({
    required this.subKegiatan,
    required this.pegawai,
    required this.surat,
    required this.sisaPaguMap,
    required this.onLoadRekening,
    required this.getRekening,
    required this.onSimpan,
  });

  @override
  State<_FormKegiatanDialog> createState() => _FormKegiatanDialogState();
}

class _FormKegiatanDialogState extends State<_FormKegiatanDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  String _sumber = 'SURAT';
  String? _refSuratId;
  String _namaKegiatan = '';
  DateTime? _tglKeg;
  String? _picId;
  String? _kodeSub;
  bool _isOutputUtama = false; // ← tambah ini
  bool _loadingRekening = false;
  String _linkLaporan = '';
  String? _idKlaster;
  List<Map<String, dynamic>> _klasterList = [];
  bool _loadingKlaster = false;
  DateTimeRange? _filterTanggal;
  List<Map<String, String>> _bulanOptions() {
    const bulan = [
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
    List<Map<String, String>> opts = [];
    for (int y = 2024; y <= 2027; y++) {
      for (int m = 1; m <= 12; m++) {
        opts.add({
          'value': '$y-${m.toString().padLeft(2, '0')}',
          'label': '${bulan[m - 1]} $y',
        });
      }
    }
    return opts;
  }

  // SPJ items
  List<Map<String, dynamic>> _spjItems = [];

  Map<String, dynamic>? get _sisaPaguSub =>
      _kodeSub != null ? widget.sisaPaguMap[_kodeSub] : null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 680, maxHeight: 750),
        child: Column(
          children: [
            // Header
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
                  Icon(Icons.calendar_month_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text('Buat Kegiatan Baru',
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

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sumber kegiatan
                      _label('Sumber Kegiatan'),
                      Row(children: [
                        _sumberBtn(
                            'SURAT', 'Berdasarkan Surat', Icons.email_outlined),
                        SizedBox(width: 10),
                        _sumberBtn(
                            'MANUAL', 'Input Manual', Icons.edit_outlined),
                      ]),
                      SizedBox(height: 14),

                      if (_sumber == 'SURAT') ...[
                        _label('Referensi Surat Masuk'),
                        Autocomplete<Map<String, dynamic>>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return widget.surat;
                            }
                            return widget.surat.where((s) {
                              final no =
                                  s['no_surat']?.toString().toLowerCase() ?? '';
                              final hal =
                                  s['hal']?.toString().toLowerCase() ?? '';
                              final query = textEditingValue.text.toLowerCase();
                              return no.contains(query) || hal.contains(query);
                            });
                          },
                          displayStringForOption: (s) =>
                              '${s['no_surat']} — ${s['pengirim']?['nama_instansi'] ?? ''} — ${_truncate(s['hal'] ?? '', 30)}',
                          fieldViewBuilder:
                              (context, controller, focusNode, onSubmit) {
                            // Sync initial value
                            if (_refSuratId != null &&
                                controller.text.isEmpty) {
                              final selected = widget.surat.firstWhere(
                                (s) => s['id_surat'].toString() == _refSuratId,
                                orElse: () => {},
                              );
                              if (selected.isNotEmpty) {
                                controller.text =
                                    '${selected['no_surat']} — ${_truncate(selected['hal'] ?? '', 40)}';
                              }
                            }
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration:
                                  _inputDeco('Cari no surat / perihal...'),
                              onFieldSubmitted: (_) => onSubmit(),
                            );
                          },
                          onSelected: (s) {
                            setState(() {
                              _refSuratId = s['id_surat'].toString();
                              // Auto-fill PIC dari disposisi surat
                              if (s['pic'] != null && s['pic']['id'] != null) {
                                _picId = s['pic']['id'].toString();
                              }
                            });
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(8),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 250, maxWidth: 560),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final s = options.elementAt(index);
                                      final tgl = s['tgl_surat'] ?? '-';
                                      final asal = s['pengirim']
                                              ?['nama_instansi'] ??
                                          '-';
                                      return ListTile(
                                        dense: true,
                                        title: Text(
                                          '${s['no_surat']}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(
                                          '$tgl  •  $asal\n${_truncate(s['hal'] ?? '', 50)}',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600),
                                        ),
                                        isThreeLine: true,
                                        onTap: () => onSelected(s),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 14),
                      ],

                      // Nama Kegiatan + Tanggal
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Nama Kegiatan'),
                                TextFormField(
                                  onChanged: (v) => _namaKegiatan = v,
                                  validator: (v) =>
                                      v!.isEmpty ? 'Wajib diisi' : null,
                                  decoration:
                                      _inputDeco('Isi nama kegiatan...'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Tanggal Pelaksanaan'),
                                InkWell(
                                  onTap: () async {
                                    DateTime? p = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2024),
                                      lastDate: DateTime(2027),
                                    );
                                    if (p != null) setState(() => _tglKeg = p);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(children: [
                                      Icon(Icons.calendar_today,
                                          size: 16, color: Colors.grey),
                                      SizedBox(width: 8),
                                      Text(
                                        _tglKeg == null
                                            ? 'Pilih tanggal...'
                                            : '${_tglKeg!.day}/${_tglKeg!.month}/${_tglKeg!.year}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: _tglKeg == null
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),

                      // PIC + Sub Kegiatan
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('PIC / Penanggung Jawab'),
                                DropdownButtonFormField<String>(
                                  value: _picId,
                                  onChanged: (v) => setState(() => _picId = v),
                                  validator: (v) =>
                                      v == null ? 'Wajib dipilih' : null,
                                  decoration: _inputDeco('Pilih PIC'),
                                  items: widget.pegawai
                                      .map((p) => DropdownMenuItem<String>(
                                            value: p['id'].toString(),
                                            child: Text(p['nama'],
                                                style: TextStyle(fontSize: 13)),
                                          ))
                                      .toList(),
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
                                _label('Sub-Kegiatan'),
                                DropdownButtonFormField<String>(
                                  value: _kodeSub,
                                  onChanged: (v) async {
                                    setState(() {
                                      _kodeSub = v;
                                      _spjItems = [];
                                      _loadingRekening = true;
                                      _idKlaster = null; // ← reset klaster
                                      _klasterList = []; // ← reset list
                                    });
                                    if (v != null) {
                                      await widget.onLoadRekening(v);
                                      await _loadKlaster(v); // ← tambah ini
                                    }
                                    setState(() => _loadingRekening = false);
                                  },
                                  validator: (v) =>
                                      v == null ? 'Wajib dipilih' : null,
                                  decoration: _inputDeco('Pilih sub-kegiatan'),
                                  items: widget.subKegiatan
                                      .map((s) => DropdownMenuItem<String>(
                                            value: s['kode_sub'],
                                            child: Text(
                                              '${s['kode_sub']} — ${_truncate(s['nomenklatur'], 30)}',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ))
                                      .toList(),
                                ),
// Klaster kegiatan
                                if (_klasterList.isNotEmpty) ...[
                                  SizedBox(height: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _label('Klaster / Rencana Aksi'),
                                      _loadingKlaster
                                          ? LinearProgressIndicator()
                                          : DropdownButtonFormField<String>(
                                              isExpanded: true, // ← tambah ini
                                              value: _idKlaster,
                                              onChanged: (v) => setState(
                                                  () => _idKlaster = v),
                                              decoration: _inputDeco(
                                                  'Pilih klaster kegiatan...'),
                                              items: _klasterList
                                                  .map((k) =>
                                                      DropdownMenuItem<String>(
                                                        value: k['id_klaster']
                                                            .toString(),
                                                        child: Text(
                                                          k['nama_klaster'],
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                    ],
                                  ),
                                ],

                                // Info sisa pagu sub terpilih
                                if (_kodeSub != null && _sisaPaguSub != null)
                                  Container(
                                    margin: EdgeInsets.only(top: 6),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(.05),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.blue.withOpacity(.2)),
                                    ),
                                    child: Row(children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Sisa RAK:',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey)),
                                            Text(
                                              'Rp ${_formatRupiah(_sisaPaguSub!['sisa'] as int)}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      (_sisaPaguSub!['persen']
                                                                  as double) >=
                                                              90
                                                          ? Colors.red
                                                          : Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${(_sisaPaguSub!['persen'] as double).toStringAsFixed(1)}%',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ]),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

// Toggle output utama
                      SizedBox(height: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(.05),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.purple.withOpacity(.2)),
                        ),
                        child: Row(children: [
                          Switch(
                            value: _isOutputUtama,
                            onChanged: (v) =>
                                setState(() => _isOutputUtama = v),
                            activeColor: Colors.purple,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Output Utama Kebijakan',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    'Tandai jika kegiatan ini menghasilkan output utama Biro.',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                          if (_isOutputUtama)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('UTAMA',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w700)),
                            ),
                        ]),
                      ),

                      SizedBox(height: 14),
                      _label('Laporan Kegiatan'),
                      Material(
                        color: Colors.transparent,
                        child: UploadDokumenWidget(
                          folder: 'kegiatan',
                          label: 'Upload Laporan',
                          onUploaded: (url) =>
                              setState(() => _linkLaporan = url),
                        ),
                      ),
                      SizedBox(height: 14),
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
                    label: Text(_saving ? 'Menyimpan...' : 'Simpan Data'),
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

  Widget _buildItemSPJ(int idx, Map<String, dynamic> item) {
    List<Map<String, dynamic>> rekening = widget.getRekening();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(.15)),
      ),
      child: Column(
        children: [
          // Rekening dropdown (full width)
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: item['id_rekening'],
                  onChanged: (v) {
                    setState(() {
                      _spjItems[idx]['id_rekening'] = v;
                      var rek = rekening.firstWhere(
                          (r) => r['id'].toString() == v,
                          orElse: () => {});
                      _spjItems[idx]['sisa'] = rek['sisa'] ?? 0;
                      _spjItems[idx]['kode'] = rek['kode'] ?? '';
                    });
                  },
                  decoration: _inputDeco('Pilih rekening belanja'),
                  items: rekening
                      .map((r) => DropdownMenuItem<String>(
                            value: r['id'].toString(),
                            child: Text(
                              '${r['kode']} — ${_truncate(r['uraian'] ?? '', 30)} (sisa: Rp ${_formatRupiah(r['sisa'] as int)})',
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(width: 6),
              IconButton(
                onPressed: () => setState(() => _spjItems.removeAt(idx)),
                icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Nominal (full width)
          TextFormField(
            onChanged: (v) {
              int nominal = int.tryParse(v) ?? 0;
              setState(() => _spjItems[idx]['nominal'] = nominal);
            },
            keyboardType: TextInputType.number,
            decoration: _inputDeco('Nominal (Rp)'),
          ),

          // Validasi RAK
          if (item['id_rekening'] != null && item['nominal'] != null) ...[
            SizedBox(height: 6),
            _buildRakValidator(item),
          ],
        ],
      ),
    );
  }

  Widget _buildRakValidator(Map<String, dynamic> item) {
    int sisa = (item['sisa'] as int?) ?? 0;
    int nominal = (item['nominal'] as int?) ?? 0;

    if (sisa <= 0) {
      return _rakAlert(
          Colors.red, Icons.block_outlined, 'RAK bulan ini sudah habis!');
    } else if (nominal > sisa) {
      return _rakAlert(Colors.orange, Icons.warning_amber_outlined,
          '⚠️ Melebihi sisa RAK! Tersedia: Rp ${_formatRupiah(sisa)}');
    } else if (nominal > 0) {
      return _rakAlert(Colors.green, Icons.check_circle_outline,
          '✅ Aman. Sisa setelah input: Rp ${_formatRupiah(sisa - nominal)}');
    }
    return SizedBox.shrink();
  }

  Widget _rakAlert(Color color, IconData icon, String pesan) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(children: [
        Icon(icon, color: color, size: 14),
        SizedBox(width: 6),
        Expanded(
            child: Text(pesan, style: TextStyle(fontSize: 12, color: color))),
      ]),
    );
  }

  void _tambahItemSPJ() {
    setState(() => _spjItems.add({
          'id_rekening': null,
          'nominal': 0,
          'sisa': 0,
          'kode': '',
        }));
  }

  Future<void> _loadKlaster(String kodeSub) async {
    setState(() {
      _loadingKlaster = true;
      _idKlaster = null;
    });
    final data = await Supabase.instance.client
        .from('master_klaster')
        .select('id_klaster, nama_klaster')
        .eq('kode_sub_kegiatan', kodeSub)
        .order('nama_klaster');
    setState(() {
      _klasterList = List<Map<String, dynamic>>.from(data);
      _loadingKlaster = false;
    });
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    if (_tglKeg == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pilih tanggal pelaksanaan')));
      return;
    }
    if (_kodeSub == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pilih sub-kegiatan')));
      return;
    }

    setState(() => _saving = true);

    String tglStr =
        '${_tglKeg!.year}-${_tglKeg!.month.toString().padLeft(2, '0')}-${_tglKeg!.day.toString().padLeft(2, '0')}';

    List<Map<String, dynamic>> spjItems = [];

    await widget.onSimpan({
      'ref_id_surat': _refSuratId,
      'kode_sub': _kodeSub,
      'sumber': _sumber,
      'nama_kegiatan': _namaKegiatan,
      'tgl_pelaksanaan': tglStr,
      'pic_id': _picId,
      'is_output_utama': _isOutputUtama, // ← tambah ini
      'spj_items': spjItems,
      'link_laporan': _linkLaporan, // ← tambah ini
      'id_klaster': _idKlaster, // ← tambah ini
    });

    setState(() => _saving = false);
    if (mounted) Navigator.pop(context);
  }

  Widget _sumberBtn(String value, String label, IconData icon) {
    bool active = _sumber == value;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _sumber = value;
          _refSuratId = null;
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

  String _truncate(String s, int max) =>
      s.length > max ? '${s.substring(0, max)}...' : s;

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
}
