// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:excel/excel.dart' hide Border;
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/widgets/breadcrumb_widget.dart';

class MasterDataScreen extends StatefulWidget {
  const MasterDataScreen({super.key});

  @override
  State<MasterDataScreen> createState() => _MasterDataScreenState();
}

class _MasterDataScreenState extends State<MasterDataScreen>
    with SingleTickerProviderStateMixin {
  final _supabase = Supabase.instance.client;
  late TabController _tabController;

  // Tahun anggaran aktif
  int _tahun = 2026;
  final List<int> _tahunList = [2024, 2025, 2026, 2027];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbWidget(items: [
          BreadcrumbItem(
            label: 'Manajemen Operasional',
            onTap: () => Get.find<SideBarController>().index.value = 0,
          ),
          BreadcrumbItem(label: 'Master Data'),
        ]),
        Row(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Master Data',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(
                      'Kelola Sub-kegiatan, DPA, RAK bulanan, dan List Pegawai Biro Perekonomian.',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            // Selector tahun anggaran
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF0D6EFD).withOpacity(.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF0D6EFD).withOpacity(.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: Color(0xFF0D6EFD)),
                  SizedBox(width: 8),
                  Text('Tahun Anggaran:',
                      style: TextStyle(fontSize: 13, color: Color(0xFF0D6EFD))),
                  SizedBox(width: 8),
                  DropdownButton<int>(
                    value: _tahun,
                    underline: SizedBox.shrink(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D6EFD)),
                    onChanged: (v) => setState(() => _tahun = v!),
                    items: _tahunList
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text('$t'),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Tab bar
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
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFF0D6EFD),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF0D6EFD),
                indicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.symmetric(horizontal: 16),
                tabs: [
                  Tab(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.account_tree_outlined, size: 16),
                      SizedBox(width: 6),
                      Text('Sub-Kegiatan'),
                    ]),
                  ),
                  Tab(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.pie_chart_outline, size: 16),
                      SizedBox(width: 6),
                      Text('DPA / Pagu'),
                    ]),
                  ),
                  Tab(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.bar_chart_outlined, size: 16),
                      SizedBox(width: 6),
                      Text('RAK Bulanan'),
                    ]),
                  ),
                  Tab(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.people_outline, size: 16),
                      SizedBox(width: 6),
                      Text('Pegawai'),
                    ]),
                  ),
                ],
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              SizedBox(
                height: 600,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _SubKegiatanTab(),
                    _DPATab(tahun: _tahun),
                    _RAKTab(tahun: _tahun),
                    _PegawaiTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// TAB 1: SUB-KEGIATAN (PERMANEN)
// ============================================================
class _SubKegiatanTab extends StatefulWidget {
  @override
  State<_SubKegiatanTab> createState() => _SubKegiatanTabState();
}

class _SubKegiatanTabState extends State<_SubKegiatanTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _data = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data =
        await _supabase.from('master_sub_kegiatan').select().order('kode_sub');
    setState(() {
      _data = List<Map<String, dynamic>>.from(data);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text('${_data.length} sub-kegiatan terdaftar',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () => _bukaForm(context),
                icon: Icon(Icons.add, size: 16),
                label: Text('Tambah Sub-Kegiatan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D6EFD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          if (_loading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(Colors.grey.shade50),
                        columnSpacing: 20,
                        columns: [
                          DataColumn(label: Text('Kode Sub', style: _th)),
                          DataColumn(label: Text('Nomenklatur', style: _th)),
                          DataColumn(label: Text('Tahun', style: _th)),
                          DataColumn(label: Text('Status', style: _th)),
                          DataColumn(label: Text('Aksi', style: _th)),
                        ],
                        rows: _data
                            .map((d) => DataRow(cells: [
                                  DataCell(Text(d['kode_sub'],
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 12))),
                                  DataCell(ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 300),
                                    child: Text(d['nomenklatur'] ?? '-',
                                        style: TextStyle(fontSize: 13)),
                                  )),
                                  DataCell(Text('${d['tahun_anggaran']}',
                                      style: TextStyle(fontSize: 13))),
                                  DataCell(Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: (d['is_aktif'] == true)
                                          ? Colors.green.withOpacity(.1)
                                          : Colors.grey.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      (d['is_aktif'] == true)
                                          ? 'Aktif'
                                          : 'Nonaktif',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: (d['is_aktif'] == true)
                                              ? Colors.green
                                              : Colors.grey),
                                    ),
                                  )),
                                  DataCell(Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            _bukaForm(context, data: d),
                                        icon: Icon(Icons.edit_outlined,
                                            size: 18, color: Colors.blue),
                                        tooltip: 'Edit',
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () => _toggleAktif(d),
                                        icon: Icon(
                                          (d['is_aktif'] == true)
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        tooltip: (d['is_aktif'] == true)
                                            ? 'Nonaktifkan'
                                            : 'Aktifkan',
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                    ],
                                  )),
                                ]))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _toggleAktif(Map<String, dynamic> d) async {
    await _supabase.from('master_sub_kegiatan').update(
        {'is_aktif': !(d['is_aktif'] as bool)}).eq('kode_sub', d['kode_sub']);
    await _load();
  }

  void _bukaForm(BuildContext context, {Map<String, dynamic>? data}) {
    final kodeCtrl = TextEditingController(text: data?['kode_sub'] ?? '');
    final nomCtrl = TextEditingController(text: data?['nomenklatur'] ?? '');
    int tahun = data?['tahun_anggaran'] ?? 2026;
    bool isEdit = data != null;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (ctx, setS) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(isEdit ? 'Edit Sub-Kegiatan' : 'Tambah Sub-Kegiatan'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: kodeCtrl,
                  enabled: !isEdit,
                  decoration:
                      _inputDeco('Kode Sub (contoh: 4.01.06.1.03.0004)'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: nomCtrl,
                  decoration: _inputDeco('Nomenklatur'),
                  maxLines: 2,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: tahun,
                  decoration: _inputDeco('Tahun Anggaran'),
                  onChanged: (v) => setS(() => tahun = v!),
                  items: [2024, 2025, 2026, 2027]
                      .map((t) => DropdownMenuItem(
                            value: t,
                            child: Text('$t'),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                if (isEdit) {
                  await _supabase.from('master_sub_kegiatan').update({
                    'nomenklatur': nomCtrl.text,
                    'tahun_anggaran': tahun,
                  }).eq('kode_sub', data['kode_sub']);
                } else {
                  await _supabase.from('master_sub_kegiatan').insert({
                    'kode_sub': kodeCtrl.text,
                    'nomenklatur': nomCtrl.text,
                    'tahun_anggaran': tahun,
                    'is_aktif': true,
                  });
                }
                Navigator.pop(ctx);
                await _load();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D6EFD),
                  foregroundColor: Colors.white),
              child: Text('Simpan'),
            ),
          ],
        );
      }),
    );
  }

  TextStyle get _th => TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
}

// ============================================================
// TAB 2: DPA / PAGU
// ============================================================
class _DPATab extends StatefulWidget {
  final int tahun;
  const _DPATab({required this.tahun});

  @override
  State<_DPATab> createState() => _DPATabState();
}

class _DPATabState extends State<_DPATab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> _subList = [];
  bool _loading = true;
  bool _uploading = false;
  String? _kodeSub;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(_DPATab old) {
    super.didUpdateWidget(old);
    if (old.tahun != widget.tahun) _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final sub = await _supabase
        .from('master_sub_kegiatan')
        .select('kode_sub, nomenklatur')
        .eq('is_aktif', true)
        .order('kode_sub');
    _subList = List<Map<String, dynamic>>.from(sub);

    await _loadDPA();
    setState(() => _loading = false);
  }

  Future<void> _loadDPA() async {
    var query = _supabase
        .from('master_dpa_rak')
        .select(
            'id_rekening, kode_sub_kegiatan, kode_rekening, uraian_belanja, pagu_dpa, tahun_anggaran')
        .eq('tahun_anggaran', widget.tahun);

    if (_kodeSub != null) query = query.eq('kode_sub_kegiatan', _kodeSub!);

    final data = await query.order('kode_sub_kegiatan');
    setState(() => _data = List<Map<String, dynamic>>.from(data));
  }

  // Upload Excel
  Future<void> _uploadExcel() async {
    setState(() => _uploading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true,
      );
      if (result == null) return;

      Uint8List? bytes = result.files.first.bytes;
      if (bytes == null) return;

      var excel = Excel.decodeBytes(bytes);
      var sheet = excel.tables[excel.tables.keys.first];
      if (sheet == null) return;

      int berhasil = 0;
      int gagal = 0;

      // Baris pertama = header, mulai baris ke-2
      for (int i = 1; i < sheet.rows.length; i++) {
        var row = sheet.rows[i];
        if (row.isEmpty) continue;

        String? kodeSub = row[0]?.value?.toString();
        String? kodeRek = row[1]?.value?.toString();
        if (kodeSub == null || kodeRek == null) continue;

        try {
          await _supabase.from('master_dpa_rak').upsert({
            'kode_sub_kegiatan': kodeSub.trim(),
            'kode_rekening': kodeRek.trim(),
            'uraian_belanja': row[2]?.value?.toString() ?? '',
            'pagu_dpa': int.tryParse(row[3]?.value?.toString() ?? '0') ?? 0,
            'tahun_anggaran': widget.tahun,
          }, onConflict: 'kode_sub_kegiatan,kode_rekening,tahun_anggaran');
          berhasil++;
        } catch (_) {
          gagal++;
        }
      }

      await _loadDPA();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('✅ Import selesai: $berhasil berhasil, $gagal gagal'),
          backgroundColor: berhasil > 0 ? Colors.green : Colors.red,
        ));
      }
    } finally {
      setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPagu = _data.fold(0, (s, d) => s + ((d['pagu_dpa'] as int?) ?? 0));

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Toolbar
          Row(
            children: [
              // Filter sub-kegiatan
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<String>(
                  value: _kodeSub,
                  decoration: InputDecoration(
                    hintText: 'Filter sub-kegiatan...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  onChanged: (v) {
                    setState(() => _kodeSub = v);
                    _loadDPA();
                  },
                  items: [
                    DropdownMenuItem(value: null, child: Text('Semua')),
                    ..._subList.map((s) => DropdownMenuItem(
                          value: s['kode_sub'],
                          child: Text(
                            '${s['kode_sub']}',
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // Total pagu
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Total Pagu: Rp ${_formatRupiah(totalPagu)}',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700),
                ),
              ),
              Spacer(),
              // Upload CSV
              OutlinedButton.icon(
                onPressed: _uploading ? null : _uploadExcel,
                icon: _uploading
                    ? SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.upload_file_outlined, size: 16),
                label: Text(_uploading ? 'Mengimpor...' : 'Import Excel'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF0D6EFD),
                  side: BorderSide(color: Color(0xFF0D6EFD)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(width: 8),
              // Tambah manual
              ElevatedButton.icon(
                onPressed: () => _bukaForm(context),
                icon: Icon(Icons.add, size: 16),
                label: Text('Tambah Manual'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D6EFD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),

          // Info format CSV
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(children: [
              Icon(Icons.info_outline, size: 14, color: Colors.blue),
              SizedBox(width: 6),
              Text(
                'Format CSV: kode_sub;kode_rekening;uraian_belanja;pagu_dpa (separator titik koma)',
                style: TextStyle(fontSize: 11, color: Colors.blue),
              ),
            ]),
          ),

          SizedBox(height: 12),

          // Tabel
          if (_loading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_data.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pie_chart_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Belum ada data DPA untuk tahun ${widget.tahun}.',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text('Tambah manual atau import dari CSV.',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: constraints.maxWidth),
                        child: DataTable(
                          headingRowColor:
                              WidgetStateProperty.all(Colors.grey.shade50),
                          columnSpacing: 16,
                          columns: [
                            DataColumn(label: Text('Sub-Keg', style: _th)),
                            DataColumn(
                                label: Text('Kode Rekening', style: _th)),
                            DataColumn(
                                label: Text('Uraian Belanja', style: _th)),
                            DataColumn(label: Text('Pagu DPA', style: _th)),
                            DataColumn(label: Text('Aksi', style: _th)),
                          ],
                          rows: _data
                              .map((d) => DataRow(cells: [
                                    DataCell(Text(d['kode_sub_kegiatan'] ?? '-',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'monospace',
                                            color: Colors.grey))),
                                    DataCell(Text(d['kode_rekening'] ?? '-',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'monospace'))),
                                    DataCell(ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 240),
                                      child: Text(d['uraian_belanja'] ?? '-',
                                          style: TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
                                    )),
                                    DataCell(Text(
                                      'Rp ${_formatRupiah((d['pagu_dpa'] as int?) ?? 0)}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green.shade700),
                                    )),
                                    DataCell(Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              _bukaForm(context, data: d),
                                          icon: Icon(Icons.edit_outlined,
                                              size: 18, color: Colors.blue),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                        SizedBox(width: 8),
                                        IconButton(
                                          onPressed: () =>
                                              _hapus(d['id_rekening']),
                                          icon: Icon(Icons.delete_outline,
                                              size: 18, color: Colors.red),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                      ],
                                    )),
                                  ]))
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _hapus(String id) async {
    await _supabase.from('master_dpa_rak').delete().eq('id_rekening', id);
    await _loadDPA();
  }

  void _bukaForm(BuildContext context, {Map<String, dynamic>? data}) {
    String? kodeSub = data?['kode_sub_kegiatan'];
    final kodeRekCtrl =
        TextEditingController(text: data?['pagu_dpa']?.toString() ?? '');
    final uraianCtrl =
        TextEditingController(text: data?['uraian_belanja'] ?? '');
    final paguCtrl =
        TextEditingController(text: data?['pagu_dpa']?.toString() ?? '');
    final kodeRekening =
        TextEditingController(text: data?['kode_rekening'] ?? '');
    bool isEdit = data != null;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (ctx, setS) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(isEdit ? 'Edit DPA' : 'Tambah DPA'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sub-kegiatan
                DropdownButtonFormField<String>(
                  value: kodeSub,
                  decoration: _inputDeco('Sub-Kegiatan'),
                  onChanged: (v) => setS(() => kodeSub = v),
                  items: _subList
                      .map((s) => DropdownMenuItem(
                            value: s['kode_sub'] as String,
                            child: Text(
                              '${s['kode_sub']}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: kodeRekening,
                  enabled: !isEdit,
                  decoration:
                      _inputDeco('Kode Rekening (contoh: 5.2.02.01.01.0001)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: uraianCtrl,
                  decoration: _inputDeco('Uraian Belanja'),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: paguCtrl,
                  keyboardType: TextInputType.number,
                  decoration: _inputDeco('Pagu DPA (angka, tanpa titik)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                if (isEdit) {
                  await _supabase.from('master_dpa_rak').update({
                    'uraian_belanja': uraianCtrl.text,
                    'pagu_dpa': int.tryParse(paguCtrl.text) ?? 0,
                  }).eq('id_rekening', data['id_rekening']);
                } else {
                  await _supabase.from('master_dpa_rak').insert({
                    'kode_sub_kegiatan': kodeSub,
                    'kode_rekening': kodeRekening.text,
                    'uraian_belanja': uraianCtrl.text,
                    'pagu_dpa': int.tryParse(paguCtrl.text) ?? 0,
                    'tahun_anggaran': widget.tahun,
                  });
                }
                Navigator.pop(ctx);
                await _loadDPA();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D6EFD),
                  foregroundColor: Colors.white),
              child: Text('Simpan'),
            ),
          ],
        );
      }),
    );
  }

  TextStyle get _th => TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
}

class _PegawaiTab extends StatefulWidget {
  @override
  State<_PegawaiTab> createState() => _PegawaiTabState();
}

class _PegawaiTabState extends State<_PegawaiTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _data = [];
  bool _loading = true;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data =
        await _supabase.from('pegawai').select().order('nama', ascending: true);
    setState(() {
      _data = List<Map<String, dynamic>>.from(data);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [
            Text('${_data.length} pegawai terdaftar',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            Spacer(),
            OutlinedButton.icon(
              onPressed: _uploading ? null : _importExcel,
              icon: _uploading
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Icon(Icons.upload_file_outlined, size: 16),
              label: Text(_uploading ? 'Mengimpor...' : 'Import Excel'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF0D6EFD),
                side: BorderSide(color: Color(0xFF0D6EFD)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => _bukaForm(context),
              icon: Icon(Icons.add, size: 16),
              label: Text('Tambah Pegawai'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D6EFD),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ]),
          SizedBox(height: 12),
          if (_loading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_data.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Belum ada data pegawai.',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minWidth: constraints.maxWidth),
                        child: DataTable(
                          headingRowColor:
                              WidgetStateProperty.all(Colors.grey.shade50),
                          columnSpacing: 20,
                          columns: [
                            DataColumn(label: Text('No', style: _th)),
                            DataColumn(label: Text('Nama', style: _th)),
                            DataColumn(label: Text('NIP', style: _th)),
                            DataColumn(label: Text('Jabatan', style: _th)),
                            DataColumn(label: Text('Golongan', style: _th)),
                            DataColumn(label: Text('Unit Kerja', style: _th)),
                            DataColumn(label: Text('No. HP', style: _th)),
                            DataColumn(label: Text('Tipe', style: _th)),
                            DataColumn(label: Text('Aksi', style: _th)),
                          ],
                          rows: _data.asMap().entries.map((entry) {
                            int idx = entry.key + 1;
                            var p = entry.value;
                            return DataRow(cells: [
                              DataCell(Text('$idx',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                              DataCell(Text(p['nama'] ?? '-',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500))),
                              DataCell(Text(p['nip'] ?? '-',
                                  style: TextStyle(
                                      fontSize: 11, fontFamily: 'monospace'))),
                              DataCell(Text(p['jabatan'] ?? '-',
                                  style: TextStyle(fontSize: 12))),
                              DataCell(Text(p['golongan'] ?? '-',
                                  style: TextStyle(fontSize: 12))),
                              DataCell(Text(p['unit_kerja'] ?? '-',
                                  style: TextStyle(fontSize: 12))),
                              DataCell(Text(p['no_hp'] ?? '-',
                                  style: TextStyle(fontSize: 12))),
                              DataCell(Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: (p['is_internal'] == true)
                                      ? Colors.blue.withOpacity(.1)
                                      : Colors.orange.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  (p['is_internal'] == true)
                                      ? 'Internal'
                                      : 'Eksternal',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: (p['is_internal'] == true)
                                          ? Colors.blue
                                          : Colors.orange),
                                ),
                              )),
                              DataCell(Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _bukaForm(context, data: p),
                                    icon: Icon(Icons.edit_outlined,
                                        size: 18, color: Colors.blue),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              )),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _importExcel() async {
    setState(() => _uploading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true,
      );
      if (result == null) return;

      Uint8List? bytes = result.files.first.bytes;
      if (bytes == null) return;

      var excelFile = Excel.decodeBytes(bytes);
      var sheet = excelFile.tables[excelFile.tables.keys.first];
      if (sheet == null) return;

      int berhasil = 0;
      int gagal = 0;

      for (int i = 1; i < sheet.rows.length; i++) {
        var row = sheet.rows[i];
        if (row.isEmpty) continue;
        String? nama = row[0]?.value?.toString();
        String? nip = row[1]?.value?.toString();
        print('Baris $i: nama=$nama, nip=$nip');
        if (nama == null || nama.isEmpty) continue;
        String? isInternal = row[9]?.value?.toString(); // ← tambah ini
        print('Baris $i is_internal: "$isInternal"'); // ← tambah ini
        try {
          await _supabase.from('pegawai').upsert({
            'nama': nama,
            'nip': row[1]?.value?.toString() ?? '',
            'jabatan': row[2]?.value?.toString() ?? '',
            'golongan': row[3]?.value?.toString() ?? '',
            'unit_kerja': row[4]?.value?.toString() ?? '',
            'no_hp': row[5]?.value?.toString() ?? '',
            'no_rekening': row[6]?.value?.toString() ?? '',
            'nama_bank': row[7]?.value?.toString() ?? '',
            'email': row[8]?.value?.toString().isNotEmpty == true
                ? row[8]?.value?.toString()
                : null,
            'is_internal':
                (row[9]?.value?.toString().toLowerCase() ?? 'true') == 'true',
          });
          berhasil++;
        } catch (e, stack) {
          print('GAGAL baris $i nama=$nama nip=${row[1]?.value}: $e');
          print(stack);
          gagal++;
        }
      }

      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('✅ Import selesai: $berhasil berhasil, $gagal gagal'),
          backgroundColor: berhasil > 0 ? Colors.green : Colors.red,
        ));
      }
    } finally {
      setState(() => _uploading = false);
    }
  }

  void _bukaForm(BuildContext context, {Map<String, dynamic>? data}) {
    final namaCtrl = TextEditingController(text: data?['nama'] ?? '');
    final nipCtrl = TextEditingController(text: data?['nip'] ?? '');
    final jabatanCtrl = TextEditingController(text: data?['jabatan'] ?? '');
    final golCtrl = TextEditingController(text: data?['golongan'] ?? '');
    final unitCtrl = TextEditingController(text: data?['unit_kerja'] ?? '');
    final hpCtrl = TextEditingController(text: data?['no_hp'] ?? '');
    final rekCtrl = TextEditingController(text: data?['no_rekening'] ?? '');
    final bankCtrl = TextEditingController(text: data?['nama_bank'] ?? '');
    final emailCtrl = TextEditingController(text: data?['email'] ?? '');
    bool isInternal = data?['is_internal'] ?? true;
    bool isEdit = data != null;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (ctx, setS) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(isEdit ? 'Edit Pegawai' : 'Tambah Pegawai'),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tipe internal/eksternal
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [
                      Icon(Icons.person_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Pegawai Internal (Sub-BLUD)',
                          style: TextStyle(fontSize: 13)),
                      Spacer(),
                      Switch(
                        value: isInternal,
                        onChanged: (v) => setS(() => isInternal = v),
                        activeColor: Color(0xFF0D6EFD),
                      ),
                    ]),
                  ),
                  SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                        child: TextField(
                            controller: namaCtrl,
                            decoration: _inputDeco('Nama Lengkap'))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                            controller: nipCtrl,
                            decoration: _inputDeco('NIP'))),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: TextField(
                            controller: jabatanCtrl,
                            decoration: _inputDeco('Jabatan'))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                            controller: golCtrl,
                            decoration:
                                _inputDeco('Golongan (contoh: III/c)'))),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: TextField(
                            controller: unitCtrl,
                            decoration: _inputDeco('Unit Kerja'))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                            controller: hpCtrl,
                            decoration: _inputDeco('No. HP'))),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: TextField(
                            controller: rekCtrl,
                            decoration: _inputDeco('No. Rekening'))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                            controller: bankCtrl,
                            decoration: _inputDeco('Nama Bank'))),
                  ]),
                  SizedBox(height: 10),
                  TextField(
                      controller: emailCtrl, decoration: _inputDeco('Email')),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> payload = {
                  'nama': namaCtrl.text,
                  'nip': nipCtrl.text,
                  'jabatan': jabatanCtrl.text,
                  'golongan': golCtrl.text,
                  'unit_kerja': unitCtrl.text,
                  'no_hp': hpCtrl.text,
                  'no_rekening': rekCtrl.text,
                  'nama_bank': bankCtrl.text,
                  'email': emailCtrl.text.isNotEmpty ? emailCtrl.text : null,
                  'is_internal': isInternal,
                };
                if (isEdit) {
                  await _supabase
                      .from('pegawai')
                      .update(payload)
                      .eq('id', data['id']);
                } else {
                  await _supabase.from('pegawai').insert(payload);
                }
                Navigator.pop(ctx);
                await _load();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D6EFD),
                  foregroundColor: Colors.white),
              child: Text('Simpan'),
            ),
          ],
        );
      }),
    );
  }

  TextStyle get _th => TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
}

// ============================================================
// TAB 3: RAK BULANAN
// ============================================================
class _RAKTab extends StatefulWidget {
  final int tahun;
  const _RAKTab({required this.tahun});

  @override
  State<_RAKTab> createState() => _RAKTabState();
}

class _RAKTabState extends State<_RAKTab> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _rekening = [];
  List<Map<String, dynamic>> _subList = [];
  String? _kodeSub;
  bool _loading = true;
  bool _saving = false;

  // Map id_rekening -> list 12 bulan nominal
  Map<String, List<int>> _rakMap = {};

  static const List<String> _namaBulan = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ags',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];

  @override
  void initState() {
    super.initState();
    _loadSub();
  }

  @override
  void didUpdateWidget(_RAKTab old) {
    super.didUpdateWidget(old);
    if (old.tahun != widget.tahun) {
      _kodeSub = null;
      _rekening = [];
      _rakMap = {};
      _loadSub();
    }
  }

  Future<void> _loadSub() async {
    setState(() => _loading = true);
    final sub = await _supabase
        .from('master_sub_kegiatan')
        .select('kode_sub, nomenklatur')
        .eq('is_aktif', true)
        .order('kode_sub');
    setState(() {
      _subList = List<Map<String, dynamic>>.from(sub);
      _loading = false;
    });
  }

  Future<void> _loadRAK(String kodeSub) async {
    setState(() => _loading = true);

    final rek = await _supabase.from('master_dpa_rak').select('''
        id_rekening, kode_rekening, uraian_belanja, pagu_dpa,
        target_jan, target_feb, target_mar, target_apr,
        target_mei, target_jun, target_jul, target_ags,
        target_sep, target_okt, target_nov, target_des
      ''').eq('kode_sub_kegiatan', kodeSub).eq('tahun_anggaran', widget.tahun);

    _rekening = List<Map<String, dynamic>>.from(rek);

    // Build rakMap dari kolom bulanan
    _rakMap = {};
    for (var r in _rekening) {
      _rakMap[r['id_rekening']] = [
        (r['target_jan'] as int?) ?? 0,
        (r['target_feb'] as int?) ?? 0,
        (r['target_mar'] as int?) ?? 0,
        (r['target_apr'] as int?) ?? 0,
        (r['target_mei'] as int?) ?? 0,
        (r['target_jun'] as int?) ?? 0,
        (r['target_jul'] as int?) ?? 0,
        (r['target_ags'] as int?) ?? 0,
        (r['target_sep'] as int?) ?? 0,
        (r['target_okt'] as int?) ?? 0,
        (r['target_nov'] as int?) ?? 0,
        (r['target_des'] as int?) ?? 0,
      ];
    }

    setState(() => _loading = false);
  }

  Future<void> _simpanRAK() async {
    setState(() => _saving = true);
    try {
      for (var entry in _rakMap.entries) {
        String idRek = entry.key;
        List<int> v = entry.value;

        await _supabase.from('master_dpa_rak').update({
          'target_jan': v[0],
          'target_feb': v[1],
          'target_mar': v[2],
          'target_apr': v[3],
          'target_mei': v[4],
          'target_jun': v[5],
          'target_jul': v[6],
          'target_ags': v[7],
          'target_sep': v[8],
          'target_okt': v[9],
          'target_nov': v[10],
          'target_des': v[11],
        }).eq('id_rekening', idRek);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('✅ RAK bulanan berhasil disimpan'),
          backgroundColor: Colors.green,
        ));
      }
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pilih sub-kegiatan
          Row(
            children: [
              SizedBox(
                width: 320,
                child: DropdownButtonFormField<String>(
                  isExpanded: true, // ← tambah ini
                  value: _kodeSub,
                  decoration: InputDecoration(
                    hintText: 'Pilih sub-kegiatan untuk setting RAK...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _kodeSub = v);
                    _loadRAK(v);
                  },
                  items: _subList
                      .map((s) => DropdownMenuItem(
                            value: s['kode_sub'] as String,
                            child: Text(
                              '${s['kode_sub']} — ${_truncate(s['nomenklatur'] ?? '', 35)}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Spacer(),
              if (_kodeSub != null && _rekening.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: _saving ? null : _simpanRAK,
                  icon: _saving
                      ? SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Icon(Icons.save_outlined, size: 16),
                  label: Text(_saving ? 'Menyimpan...' : 'Simpan RAK'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),

          if (_kodeSub == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart_outlined,
                        size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Pilih sub-kegiatan untuk mulai setting RAK.',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )
          else if (_loading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_rekening.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Belum ada rekening DPA untuk sub-kegiatan ini di tahun ${widget.tahun}.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info total per bulan
                    _buildRingkasanBulan(),
                    SizedBox(height: 16),

                    // Grid input per rekening
                    ..._rekening.map((rek) {
                      String idRek = rek['id_rekening'];
                      int pagu = (rek['pagu_dpa'] as int?) ?? 0;
                      int totalRAK =
                          _rakMap[idRek]?.fold<int>(0, (s, v) => s + v) ?? 0;
                      bool sisaOk = totalRAK <= pagu;

                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: sisaOk
                                ? Colors.grey.withOpacity(.2)
                                : Colors.red.withOpacity(.4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(rek['kode_rekening'],
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'monospace',
                                            color: Colors.grey)),
                                    Text(rek['uraian_belanja'] ?? '-',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              // Status total vs pagu
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: sisaOk
                                      ? Colors.green.withOpacity(.1)
                                      : Colors.red.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Total: Rp ${_formatRupiah(totalRAK)}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: sisaOk
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    if (!sisaOk)
                                      Text(
                                        '⚠️ Melebihi pagu!',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.red),
                                      ),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(height: 12),

                            // Grid 12 bulan
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(12, (i) {
                                return SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_namaBulan[i],
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      SizedBox(height: 4),
                                      TextFormField(
                                        initialValue: _rakMap[idRek]![i] > 0
                                            ? _rakMap[idRek]![i].toString()
                                            : '',
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 12),
                                        onChanged: (v) {
                                          setState(() {
                                            _rakMap[idRek]![i] =
                                                int.tryParse(v) ?? 0;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade400),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300)),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 6),
                                          isDense: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRingkasanBulan() {
    // Hitung total semua rekening per bulan
    List<int> totalPerBulan = List<int>.filled(12, 0);
    for (var values in _rakMap.values) {
      for (int i = 0; i < 12; i++) {
        totalPerBulan[i] += values[i];
      }
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF0D6EFD).withOpacity(.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF0D6EFD).withOpacity(.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ringkasan Target RAK per Bulan',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D6EFD))),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: List.generate(
                12,
                (i) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: totalPerBulan[i] > 0
                            ? Color(0xFF0D6EFD).withOpacity(.1)
                            : Colors.grey.withOpacity(.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Text(_namaBulan[i],
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                          Text(
                            _formatRupiah(totalPerBulan[i]),
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: totalPerBulan[i] > 0
                                    ? Color(0xFF0D6EFD)
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  String _truncate(String s, int max) =>
      s.length > max ? '${s.substring(0, max)}...' : s;
}

// ============================================================
// HELPERS GLOBAL
// ============================================================
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
