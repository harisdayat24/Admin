// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _supabase = Supabase.instance.client;

  // State data
  bool _loading = true;
  String _error = '';

  // Statistik kartu
  int _suratPending = 0;
  int _spjDraft = 0;
  int _kegiatanTotal = 0;
  int _kegiatanSelesai = 0;
  double _realisasiPersen = 0;
  int _kegiatanBelumLaporan = 0; // ← tambah ini
  int _realisasiRp = 0;
  int _paguRp = 0;

  // Insight data
  int _kegiatanUtama = 0;
  int _kegiatanBiasa = 0;
  int _spjUtama = 0;
  int _spjBiasa = 0;
  List<Map<String, dynamic>> _perBulan = [];
  List<Map<String, dynamic>> _perSub = [];

  // Data monitoring
  List<Map<String, dynamic>> _alerts = [];
  List<Map<String, dynamic>> _teamStats = [];
  List<Map<String, dynamic>> _heatmap = [];

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    // Pengecekan awal, untuk berjaga-jaga
    if (!mounted) return;

    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      await Future.wait([
        _loadStats(),
        _loadHeatmap(),
      ]);
    } catch (e) {
      // Gunakan if (mounted) karena kita berada di dalam blok try-catch
      if (mounted) {
        setState(() => _error = e.toString());
      }
    } finally {
      // Sama di sini, pastikan widget masih hidup sebelum mengakhiri loading
      if (mounted) {
        setState(() => _loading = false);
      }
    }

    // REM OTOMATIS: Jika halaman sudah ditutup, hentikan pengambilan data ke Supabase di bawah ini
    if (!mounted) return;

    // Kegiatan selesai belum upload laporan
    final belumLaporan = await _supabase
        .from('data_kegiatan')
        .select()
        .eq('status_proses', 'Selesai')
        .or('link_laporan.is.null,link_laporan.eq.');

    // REM OTOMATIS KEDUA
    if (!mounted) return;

    // Load insight data
    final insight = await _supabase.rpc(
      'get_dashboard_insight',
      params: {'p_tahun': 2026},
    );

    // REM OTOMATIS KETIGA sebelum memperbarui UI
    if (!mounted) return;

    // Masukkan modifikasi variabel ini ke dalam setState agar UI langsung bereaksi (Pop!)
    setState(() {
      _kegiatanBelumLaporan = belumLaporan.length;

      if (insight != null) {
        _kegiatanUtama = (insight['kegiatan_utama'] as int?) ?? 0;
        _kegiatanBiasa = (insight['kegiatan_biasa'] as int?) ?? 0;
        _spjUtama = (insight['spj_utama'] as int?) ?? 0;
        _spjBiasa = (insight['spj_biasa'] as int?) ?? 0;
        _perBulan = List<Map<String, dynamic>>.from(insight['per_bulan'] ?? []);
        _perSub = List<Map<String, dynamic>>.from(insight['per_sub'] ?? []);
      }
    });
  }

  Future<void> _loadStats() async {
    // Surat pending
    final surat = await _supabase
        .from('log_surat')
        .select('id_surat, status, jenis_surat')
        .eq('jenis_surat', 'MASUK')
        .neq('status', 'Selesai');
    _suratPending = surat.length;

    // SPJ draft
    final spj = await _supabase
        .from('data_spj')
        .select('id_spj, status_verif, nominal')
        .eq('status_verif', 'Draft');
    _spjDraft = spj.length;

    // Total kegiatan
    final keg = await _supabase
        .from('data_kegiatan')
        .select('id_kegiatan, status_proses');
    _kegiatanTotal = keg.length;
    _kegiatanSelesai = keg
        .where((k) =>
            k['status_proses'] == 'Selesai' || k['status_proses'] == 'Lunas')
        .length;

    // Total pagu dari master DPA
    final dpa = await _supabase
        .from('master_dpa_rak')
        .select('pagu_dpa')
        .eq('tahun_anggaran', 2026);
    _paguRp = dpa.fold(0, (sum, r) => sum + ((r['pagu_dpa'] as int?) ?? 0));

    // Total realisasi SPJ disetujui
    final spjOK = await _supabase
        .from('data_spj')
        .select('nominal, status_verif')
        .inFilter('status_verif', ['Disetujui', 'Lunas']);
    _realisasiRp =
        spjOK.fold(0, (sum, r) => sum + ((r['nominal'] as int?) ?? 0));

    _realisasiPersen = _paguRp > 0 ? (_realisasiRp / _paguRp * 100) : 0;

    // Team stats dari pegawai
    final pegawai = await _supabase
        .from('pegawai')
        .select('id, nama, jabatan')
        .eq('is_internal', true)
        .neq('nama', 'MASFUFAH, S.H., M.PSDM.')
        .order('nama');

    // Hitung beban per pegawai
    final suratAll = await _supabase
        .from('log_surat')
        .select('pic_disposisi_id, status')
        .eq('jenis_surat', 'MASUK')
        .neq('status', 'Selesai');

    final kegAll = await _supabase
        .from('data_kegiatan')
        .select('pic_kegiatan_id, status_proses')
        .not('status_proses', 'in', '("Selesai","Lunas")');

    _teamStats = pegawai.map<Map<String, dynamic>>((p) {
      int bebanSurat =
          suratAll.where((s) => s['pic_disposisi_id'] == p['id']).length;
      int bebanKeg =
          kegAll.where((k) => k['pic_kegiatan_id'] == p['id']).length;
      return {
        'nama': p['nama'],
        'jabatan': p['jabatan'],
        'surat': bebanSurat,
        'keg': bebanKeg,
      };
    }).toList();
    _teamStats.sort((a, b) => a['nama']
        .toString()
        .toLowerCase()
        .compareTo(b['nama'].toString().toLowerCase()));
    // Bangun alerts sederhana
    _alerts = [];
    if (_suratPending > 0) {
      _alerts.add({
        'tipe': 'danger',
        'pesan': '$_suratPending surat masuk belum ditindaklanjuti',
      });
    }
    if (_spjDraft > 0) {
      _alerts.add({
        'tipe': 'warning',
        'pesan': '$_spjDraft SPJ menunggu verifikasi bendahara',
      });
    }
    if (_realisasiPersen < 50 && _paguRp > 0) {
      _alerts.add({
        'tipe': 'info',
        'pesan':
            'Serapan anggaran ${_realisasiPersen.toStringAsFixed(1)}% — perlu akselerasi',
      });
    }
  }

  Future<void> _loadHeatmap() async {
    // Ambil data DPA per sub-kegiatan
    final dpa = await _supabase
        .from('master_dpa_rak')
        .select('kode_sub_kegiatan, nomenklatur_sub, pagu_dpa')
        .eq('tahun_anggaran', 2026);

    // Ambil realisasi dari RPC
    final realisasi = await _supabase.rpc(
      'get_realisasi_per_sub_rekening',
      params: {'p_tahun': 2026},
    );

    // Akumulasi pagu per sub
    Map<String, Map<String, dynamic>> subMap = {};
    for (var row in dpa) {
      String kode = row['kode_sub_kegiatan'] ?? '';
      String nama = row['nomenklatur_sub'] ?? kode;
      int pagu = (row['pagu_dpa'] as int?) ?? 0;

      if (!subMap.containsKey(kode)) {
        subMap[kode] = {'nama': nama, 'pagu': 0, 'realisasi': 0};
      }
      subMap[kode]!['pagu'] = (subMap[kode]!['pagu'] as int) + pagu;
    }

    // Akumulasi realisasi per sub
    for (var row in realisasi) {
      String kode = row['kode_sub'] ?? '';
      int real = (row['total_realisasi'] as int?) ?? 0;
      if (subMap.containsKey(kode)) {
        subMap[kode]!['realisasi'] = (subMap[kode]!['realisasi'] as int) + real;
      }
    }

    _heatmap = subMap.entries.map((e) {
      int pagu = e.value['pagu'] as int;
      int real = e.value['realisasi'] as int;
      double pct = pagu > 0 ? (real / pagu * 100) : 0;
      return {
        'nama': e.value['nama'],
        'pagu': pagu,
        'realisasi': real,
        'sisa': pagu - real,
        'persen': pct,
      };
    }).toList();
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF0D6EFD)),
            SizedBox(height: 16),
            Text('Memuat dashboard...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 12),
            Text('Gagal memuat data:', style: TextStyle(color: Colors.red)),
            SizedBox(height: 8),
            Text(_error, style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadDashboard,
              icon: Icon(Icons.refresh),
              label: Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 20),
          _buildKartuStatistik(),
          SizedBox(height: 20),
          _buildAlerts(),
          SizedBox(height: 20),
          // ↓ TAMBAHKAN DI SINI
          _buildPolicyOutputRatio(),
          SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _buildBudgetHealth()),
                  SizedBox(width: 16),
                  Expanded(flex: 5, child: _buildTimelineHeatmap()),
                ],
              );
            }
            return Column(children: [
              _buildBudgetHealth(),
              SizedBox(height: 16),
              _buildTimelineHeatmap(),
            ]);
          }),
          SizedBox(height: 20),
          // ↑ SAMPAI SINI
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: _buildHeatmap()),
                  SizedBox(width: 16),
                  Expanded(flex: 4, child: _buildBebanTim()),
                ],
              );
            }
            return Column(children: [
              _buildHeatmap(),
              SizedBox(height: 16),
              _buildBebanTim(),
            ]);
          }),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Color(0xFF0D6EFD).withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Icon(Icons.account_balance, color: Color(0xFF0D6EFD), size: 22),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sub BLUD — Biro Perekonomian Setda Prov. Jatim',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87)),
                Text(
                  'Tahun Anggaran 2026  |  ${_formatTanggal(DateTime.now())}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _loadDashboard,
            icon: Icon(Icons.refresh, color: Color(0xFF0D6EFD)),
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KARTU STATISTIK
  // ============================================================
  Widget _buildKartuStatistik() {
    return LayoutBuilder(builder: (context, constraints) {
      bool isNarrow = constraints.maxWidth < 600;
      return isNarrow
          ? Column(children: [
              Row(children: [
                Expanded(
                    child: _kartu('Surat Pending', '$_suratPending',
                        Icons.email_outlined, Colors.red)),
                SizedBox(width: 12),
                Expanded(
                    child: _kartu('Antrean SPJ', '$_spjDraft',
                        Icons.receipt_long_outlined, Colors.orange)),
              ]),
              SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: _kartu('Total Kegiatan', '$_kegiatanTotal',
                        Icons.calendar_month_outlined, Color(0xFF0D6EFD))),
                SizedBox(width: 12),
                Expanded(
                    child: _kartu(
                        'Realisasi',
                        '${_realisasiPersen.toStringAsFixed(1)}%',
                        Icons.pie_chart_outline,
                        Colors.green,
                        sub: 'Rp ${_formatRupiah(_realisasiRp)}')),
              ]),
            ])
          : Row(children: [
              Expanded(
                  child: _kartu('Surat Pending', '$_suratPending',
                      Icons.email_outlined, Colors.red,
                      sub: _suratPending > 0
                          ? 'Butuh disposisi'
                          : 'Semua tertangani ✓')),
              SizedBox(width: 12),
              Expanded(
                  child: _kartu('Antrean SPJ', '$_spjDraft',
                      Icons.receipt_long_outlined, Colors.orange,
                      sub: _spjDraft > 0
                          ? 'Menunggu verifikasi'
                          : 'Antrean kosong ✓')),
              SizedBox(width: 12),
              Expanded(
                  child: _kartu('Total Kegiatan', '$_kegiatanTotal',
                      Icons.calendar_month_outlined, Color(0xFF0D6EFD),
                      sub:
                          '$_kegiatanSelesai selesai / ${_kegiatanTotal - _kegiatanSelesai} berjalan')),
              SizedBox(width: 12),
              Expanded(
                  child: _kartu(
                      'Realisasi',
                      '${_realisasiPersen.toStringAsFixed(1)}%',
                      Icons.pie_chart_outline,
                      Colors.green,
                      sub: 'dari Rp ${_formatRupiah(_paguRp)}')),
            ]);
    });
  }

  Widget _kartu(String label, String nilai, IconData icon, Color warna,
      {String? sub}) {
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
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: warna.withOpacity(.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, color: warna, size: 15),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(nilai,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: warna)),
                    if (sub != null) ...[
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(sub,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade400),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ALERTS
  // ============================================================
  Widget _buildAlerts() {
    final controller = Get.find<SideBarController>();
    List<Map<String, dynamic>> alerts = [];

    if (_suratPending > 0) {
      alerts.add({
        'warna': Colors.red,
        'icon': Icons.email_outlined,
        'judul': '$_suratPending Surat Belum Diproses',
        'pesan':
            'Terdapat surat masuk yang menunggu disposisi dan tindak lanjut.',
        'aksi': 'Lihat Persuratan',
        'index': 4,
      });
    }

    if (_spjDraft > 0) {
      alerts.add({
        'warna': Colors.orange,
        'icon': Icons.receipt_long_outlined,
        'judul': '$_spjDraft SPJ Menunggu Verifikasi',
        'pesan': 'SPJ dalam status Draft perlu segera diverifikasi.',
        'aksi': 'Buka SPJ',
        'index': 6,
      });
    }

    if (_realisasiPersen < 50) {
      alerts.add({
        'warna': Colors.blue,
        'icon': Icons.bar_chart_outlined,
        'judul': 'Realisasi Anggaran ${_realisasiPersen.toStringAsFixed(1)}%',
        'pesan':
            'Serapan anggaran masih rendah. Percepat pelaksanaan kegiatan.',
        'aksi': 'Lihat Kegiatan',
        'index': 5,
      });
    }

    // Kegiatan belum upload laporan
    if (_kegiatanBelumLaporan > 0) {
      alerts.add({
        'warna': Colors.purple,
        'icon': Icons.upload_file_outlined,
        'judul': '$_kegiatanBelumLaporan Kegiatan Belum Upload Laporan',
        'pesan':
            'Terdapat kegiatan selesai yang belum dilengkapi dokumen laporan.',
        'aksi': 'Lengkapi Laporan',
        'index': 5,
      });
    }

    if (alerts.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(.2)),
        ),
        child: Row(children: [
          Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
          SizedBox(width: 10),
          Text('Semua berjalan lancar. Tidak ada item yang perlu perhatian.',
              style: TextStyle(fontSize: 13, color: Colors.green)),
        ]),
      );
    }

    return Column(
      children: alerts
          .map((a) => Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: (a['warna'] as Color).withOpacity(.05),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: (a['warna'] as Color).withOpacity(.25)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => controller.index.value = a['index'] as int,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: (a['warna'] as Color).withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(a['icon'] as IconData,
                                color: a['warna'] as Color, size: 18),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a['judul'] as String,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: a['warna'] as Color)),
                                SizedBox(height: 2),
                                Text(a['pesan'] as String,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: a['warna'] as Color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(a['aksi'] as String,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward,
                                  size: 12, color: Colors.white),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  // ============================================================
  // HEATMAP
  // ============================================================
  Widget _buildHeatmap() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department,
                  color: Colors.deepOrange, size: 18),
              SizedBox(width: 8),
              Text('Heat Map Serapan Anggaran',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          SizedBox(height: 16),
          if (_heatmap.isEmpty)
            Center(
              child: Text('Belum ada data anggaran.',
                  style: TextStyle(color: Colors.grey)),
            )
          else
            ..._heatmap.map((item) {
              double pct = item['persen'] as double;
              Color warna = pct >= 90
                  ? Colors.red
                  : pct >= 70
                      ? Colors.orange
                      : pct >= 40
                          ? Color(0xFF0D6EFD)
                          : Colors.grey;
              String label = pct >= 90
                  ? '🔴 Hampir habis'
                  : pct >= 70
                      ? '🟡 Perlu akselerasi'
                      : pct < 20
                          ? '🔵 Sangat lambat'
                          : '🟢 Berjalan';

              String nama = item['nama'].toString();
              if (nama.length > 40) nama = '${nama.substring(0, 40)}...';

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(nama,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text('$label — ${pct.toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: pct / 100,
                        minHeight: 10,
                        backgroundColor: Colors.grey.withOpacity(.15),
                        valueColor: AlwaysStoppedAnimation<Color>(warna),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Realisasi: Rp ${_formatRupiah(item['realisasi'] as int)}',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          'Sisa: Rp ${_formatRupiah(item['sisa'] as int)}',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  // ============================================================
  // BEBAN TIM
  // ============================================================
  Widget _buildBebanTim() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people_outline, color: Color(0xFF0D6EFD), size: 18),
              SizedBox(width: 8),
              Text('Distribusi Beban Tim',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          SizedBox(height: 12),
          if (_teamStats.isEmpty)
            Center(
                child: Text('Memuat data tim...',
                    style: TextStyle(color: Colors.grey)))
          else
            ..._teamStats.map((p) {
              int total = (p['surat'] as int) + (p['keg'] as int);
              String status = total == 0
                  ? '✅'
                  : total >= 3
                      ? '🔴'
                      : '🟡';
              Color warnaBar = total == 0
                  ? Colors.green
                  : total >= 3
                      ? Colors.red
                      : Colors.orange;

              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.withOpacity(.1)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${p['nama']} $status',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              Text(p['jabatan'] ?? '',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        // Badge surat
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: (p['surat'] as int) > 0
                                ? Colors.orange.withOpacity(.15)
                                : Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${p['surat']} surat',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: (p['surat'] as int) > 0
                                      ? Colors.orange
                                      : Colors.grey)),
                        ),
                        SizedBox(width: 4),
                        // Badge kegiatan
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: (p['keg'] as int) > 0
                                ? Color(0xFF0D6EFD).withOpacity(.1)
                                : Colors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${p['keg']} keg',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: (p['keg'] as int) > 0
                                      ? Color(0xFF0D6EFD)
                                      : Colors.grey)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: total > 0 ? (total / 5).clamp(0.0, 1.0) : 0,
                        minHeight: 4,
                        backgroundColor: Colors.grey.withOpacity(.15),
                        valueColor: AlwaysStoppedAnimation<Color>(warnaBar),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================
  String _formatRupiah(int angka) {
    if (angka >= 1000000000) {
      return '${(angka / 1000000000).toStringAsFixed(1)} M';
    } else if (angka >= 1000000) {
      return '${(angka / 1000000).toStringAsFixed(1)} Jt';
    } else if (angka >= 1000) {
      return '${(angka / 1000).toStringAsFixed(0)} Rb';
    }
    return angka.toString();
  }

  String _formatTanggal(DateTime dt) {
    List<String> bulan = [
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
    List<String> hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return '${hari[dt.weekday - 1]}, ${dt.day} ${bulan[dt.month]} ${dt.year}';
  }

  // ============================================================
// POLICY OUTPUT RATIO
// ============================================================
  Widget _buildPolicyOutputRatio() {
    int totalKeg = _kegiatanUtama + _kegiatanBiasa;
    int totalSpj = _spjUtama + _spjBiasa;
    double pctKeg = totalKeg > 0 ? (_kegiatanUtama / totalKeg * 100) : 0;
    double pctSpj = totalSpj > 0 ? (_spjUtama / totalSpj * 100) : 0;
    double target = 70.0;
    bool tercapai = pctKeg >= target;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.donut_large_outlined,
                  color: Colors.purple, size: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Policy Output Ratio',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text(
                      'Proporsi kegiatan & anggaran untuk output utama kebijakan',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tercapai
                    ? Colors.green.withOpacity(.1)
                    : Colors.orange.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tercapai ? '✅ Target Tercapai' : '⚠️ Di bawah Target',
                style: TextStyle(
                    fontSize: 12,
                    color: tercapai ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            bool narrow = constraints.maxWidth < 600;

            Widget bagianKegiatan = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Jumlah Kegiatan',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('Target: ${target.toInt()}% Utama',
                        style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 8),
                Stack(children: [
                  Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: pctKeg / 100,
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$_kegiatanUtama Utama (${pctKeg.toStringAsFixed(0)}%)',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$_kegiatanBiasa Biasa',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            );

            Widget bagianAnggaran = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Serapan Anggaran',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 8),
                Stack(children: [
                  Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  if (totalSpj > 0)
                    FractionallySizedBox(
                      widthFactor: (pctSpj / 100).clamp(0.0, 1.0),
                      child: Container(
                        height: 28,
                        decoration: BoxDecoration(
                          color: Color(0xFF0D6EFD).withOpacity(.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Utama: Rp ${_formatRupiah(_spjUtama)} (${pctSpj.toStringAsFixed(0)}%)',
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    totalSpj > 0 ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Biasa: Rp ${_formatRupiah(_spjBiasa)}',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            );

            if (narrow) {
              return Column(children: [
                bagianKegiatan,
                SizedBox(height: 16),
                bagianAnggaran,
              ]);
            }
            return Row(children: [
              Expanded(child: bagianKegiatan),
              SizedBox(width: 24),
              Expanded(child: bagianAnggaran),
            ]);
          }),
        ],
      ),
    );
  }

// ============================================================
// BUDGET HEALTH METER
// ============================================================
  Widget _buildBudgetHealth() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.monitor_heart_outlined,
                  color: Colors.green, size: 20),
            ),
            SizedBox(width: 10),
            Text('Budget Health Meter',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ]),
          SizedBox(height: 16),
          if (_perSub.isEmpty)
            Center(
              child: Text('Belum ada data anggaran.',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
            )
          else
            ..._perSub.map((sub) {
              int pagu = (sub['pagu'] as num?)?.toInt() ?? 0;
              int realisasi = (sub['realisasi'] as num?)?.toInt() ?? 0;
              double pct = pagu > 0 ? (realisasi / pagu * 100) : 0;
              int sisa = pagu - realisasi;

              Color warna = pct >= 90
                  ? Colors.red
                  : pct >= 70
                      ? Colors.orange
                      : pct >= 40
                          ? Color(0xFF0D6EFD)
                          : Colors.grey;

              String status = pct >= 90
                  ? 'Kritis'
                  : pct >= 70
                      ? 'Perlu Akselerasi'
                      : pct >= 40
                          ? 'Berjalan'
                          : 'Sangat Lambat';

              return Container(
                margin: EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sub['kode_sub'] ?? '-',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace'),
                        ),
                        Row(children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: warna.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(status,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: warna,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${pct.toStringAsFixed(1)}%',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: warna),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (pct / 100).clamp(0.0, 1.0),
                        backgroundColor: Colors.grey.withOpacity(.1),
                        valueColor: AlwaysStoppedAnimation(warna),
                        minHeight: 10,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Realisasi: Rp ${_formatRupiah(realisasi)}',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text('Sisa: Rp ${_formatRupiah(sisa)}',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

// ============================================================
// TIMELINE HEATMAP
// ============================================================
  Widget _buildTimelineHeatmap() {
    const List<String> namaBulan = [
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

    // Build map bulan → data
    Map<int, Map<String, dynamic>> bulanMap = {};
    for (var b in _perBulan) {
      bulanMap[b['bulan'] as int] = b;
    }

    int maxTotal = _perBulan.isEmpty
        ? 1
        : _perBulan
            .map((b) => (b['total'] as int?) ?? 0)
            .reduce((a, b) => a > b ? a : b);
    if (maxTotal == 0) maxTotal = 1;

    int bulanIni = DateTime.now().month;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.calendar_view_month_outlined,
                  color: Colors.orange, size: 20),
            ),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Timeline Kegiatan',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Text('Sebaran kegiatan per bulan — waspadai penumpukan',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ]),
          SizedBox(height: 20),

          // Grid 12 bulan
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            itemCount: 12,
            itemBuilder: (context, i) {
              int bulan = i + 1;
              var data = bulanMap[bulan];
              int total = (data?['total'] as int?) ?? 0;
              int utama = (data?['utama'] as int?) ?? 0;
              bool aktif = bulan == bulanIni;
              double intensity = total / maxTotal;

              Color bgColor = total == 0
                  ? Colors.grey.withOpacity(.08)
                  : Color.lerp(
                      Colors.orange.withOpacity(.15),
                      Colors.orange,
                      intensity,
                    )!;

              return Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: aktif ? Color(0xFF0D6EFD) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(namaBulan[i],
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: total > 0 ? Colors.white : Colors.grey)),
                    if (total > 0) ...[
                      SizedBox(height: 2),
                      Text('$total keg',
                          style: TextStyle(fontSize: 10, color: Colors.white)),
                      if (utama > 0)
                        Text('$utama utama',
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.white.withOpacity(.8))),
                    ] else
                      Text('—',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 12),
          // Legend
          Row(children: [
            _legendItem(Colors.orange.withOpacity(.2), 'Sedikit'),
            SizedBox(width: 12),
            _legendItem(Colors.orange.withOpacity(.6), 'Sedang'),
            SizedBox(width: 12),
            _legendItem(Colors.orange, 'Padat'),
            SizedBox(width: 12),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0D6EFD), width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(width: 4),
            Text('Bulan ini',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey)),
    ]);
  }
}
