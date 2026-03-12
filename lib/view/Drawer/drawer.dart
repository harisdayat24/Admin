// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minia_web_project/view/Authentication/pages/lock_screen.dart';
import 'package:minia_web_project/view/Authentication/pages/log_out.dart';
import '../../comman/colors.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/sidebar_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  RxBool isExpanded = true.obs;
  RxBool hide = true.obs;

  SideBarController controller = Get.put(SideBarController());
  final DashboardController dashcontroller = Get.put(DashboardController());
  final _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _searching = false;
  final _supabase = Supabase.instance.client;
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  Future<void> _search(String q) async {
    if (q.length < 2) return;
    setState(() => _searching = true);
    try {
      final keyword = '%$q%';

      final futures = await Future.wait([
        _supabase
            .from('log_surat')
            .select('id_surat, no_surat, hal, jenis_surat')
            .or('no_surat.ilike.$keyword,hal.ilike.$keyword')
            .limit(3),
        _supabase
            .from('data_kegiatan')
            .select('id_kegiatan, nama_kegiatan, status_proses')
            .ilike('nama_kegiatan', keyword)
            .limit(3),
        _supabase
            .from('data_spj')
            .select(
                'id_spj, nominal, status_verif, data_kegiatan(nama_kegiatan)')
            .ilike('data_kegiatan.nama_kegiatan', keyword)
            .limit(3),
      ]);

      print('Surat: ${futures[0]}');
      print('Kegiatan: ${futures[1]}');
      print('SPJ: ${futures[2]}');

      List<Map<String, dynamic>> results = [];

      for (var s in (futures[0] as List)) {
        results.add({
          'tipe': 'Surat',
          'icon': Icons.email_outlined,
          'warna': Colors.blue,
          'judul': s['hal'] ?? '-',
          'sub': '${s['jenis_surat']} • ${s['no_surat']}',
          'index': 4,
        });
      }
      for (var k in (futures[1] as List)) {
        results.add({
          'tipe': 'Kegiatan',
          'icon': Icons.calendar_month_outlined,
          'warna': Colors.green,
          'judul': k['nama_kegiatan'] ?? '-',
          'sub': k['status_proses'] ?? '-',
          'index': 5,
        });
      }
      for (var s in (futures[2] as List)) {
        results.add({
          'tipe': 'SPJ',
          'icon': Icons.receipt_long_outlined,
          'warna': Colors.orange,
          'judul': s['data_kegiatan']?['nama_kegiatan'] ?? '-',
          'sub': 'Status: ${s['status_verif']}',
          'index': 6,
        });
      }

      setState(() {
        _searchResults = results;
        _searching = false;
      });
      _showOverlay();
    } catch (e) {
      print('ERROR search: $e');
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        width: 400,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 44),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: _searchResults.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Tidak ada hasil.',
                        style: TextStyle(color: Colors.grey)),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_searchResults.length} hasil ditemukan',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            GestureDetector(
                              onTap: _removeOverlay,
                              child: Icon(Icons.close,
                                  size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      // Hasil
                      ..._searchResults.map((r) => InkWell(
                            onTap: () {
                              Get.find<SideBarController>().index.value =
                                  r['index'] as int;
                              _searchCtrl.clear();
                              setState(() => _searchResults = []);
                              _removeOverlay();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Row(children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color:
                                        (r['warna'] as Color).withOpacity(.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(r['icon'] as IconData,
                                      color: r['warna'] as Color, size: 16),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(r['judul'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis),
                                      Row(children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: (r['warna'] as Color)
                                                .withOpacity(.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(r['tipe'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: r['warna'] as Color)),
                                        ),
                                        SizedBox(width: 6),
                                        Text(r['sub'],
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey),
                                            overflow: TextOverflow.ellipsis),
                                      ]),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 12, color: Colors.grey),
                              ]),
                            ),
                          )),
                    ],
                  ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.mainbackground,
      appBar: width < 983 ? smallAppBar(width) : null,
      drawer: smallDrawer(),
      body: Row(
        children: [
          isExpanded.isFalse && width > 983
              ? sideBarIcon(controller)
              : width > 983
                  ? sideBar(controller)
                  : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                width > 983 ? Appbar(width) : Container(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 18, bottom: 20),
                          child: Container(
                            color: AppColor.mainbackground,
                            child: Obx(
                              () => controller.page[controller.index.value],
                            ),
                          ),
                        ),
                        Divider(color: AppColor.boxborder, height: 1),
                        bottomText()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SMALL DRAWER (MOBILE)
  // ============================================================
  Drawer smallDrawer() {
    return Drawer(
      child: Container(
        color: AppColor.backgorundDrawer,
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              // Logo KERJA.in
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.account_balance,
                        color: AppColor.selecteColor, size: 25),
                    Container(width: 10),
                    Text(
                      "KERJA.in",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    InkWell(onTap: () => Get.back(), child: Icon(Icons.menu)),
                  ],
                ),
              ),
              Container(height: 15),
              // ... sisa menu items tetap sama (dari Section header sampai Logout)
              // Section header
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "MENU UTAMA",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

// Dashboard Monitor
              _menuItem(
                controller: controller,
                index: 0,
                icon: Icons.dashboard_outlined,
                label: "Monitor",
                onTap: () => controller.index.value = 0,
              ),

              Container(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "MODUL BLUD",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

// SIGAP BLUD
              _expansionModule(
                controller: controller,
                icon: Icons.map_outlined,
                label: "SIGAP BLUD",
                activeIndices: [1],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 1,
                    label: "Peta & Analitik",
                    onTap: () => controller.index.value = 1,
                  ),
                ],
              ),

// Reviu Penerapan
              _expansionModule(
                controller: controller,
                icon: Icons.verified_outlined,
                label: "Reviu Penerapan",
                activeIndices: [2],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 2,
                    label: "Reviu Penerapan BLUD",
                    onTap: () => controller.index.value = 2,
                  ),
                ],
              ),

// Reviu Perencanaan
              _expansionModule(
                controller: controller,
                icon: Icons.assignment_outlined,
                label: "Reviu Perencanaan",
                activeIndices: [3],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 3,
                    label: "Reviu Perencanaan BLUD",
                    onTap: () => controller.index.value = 3,
                  ),
                ],
              ),

// Manajemen Operasional
              _expansionModule(
                controller: controller,
                icon: Icons.work_outline,
                label: "Manajemen Operasional",
                activeIndices: [4, 5, 6, 7],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 4,
                    label: "Korespondensi",
                    onTap: () => controller.index.value = 4,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 5,
                    label: "Kegiatan",
                    onTap: () => controller.index.value = 5,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 6,
                    label: "SPJ",
                    onTap: () => controller.index.value = 6,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 7,
                    label: "Master Data",
                    onTap: () => controller.index.value = 7,
                  ),
                ],
              ),

              Container(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "SISTEM",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

              // Logout
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.logout, color: Colors.red, size: 20),
                ),
                title: Text("Keluar",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w400)),
                onTap: () => Get.to(Logout()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // APPBAR MOBILE
  // ============================================================
  AppBar smallAppBar(double width) {
    return AppBar(
        elevation: 1,
        backgroundColor: AppColor.mainbackground,
        toolbarHeight: 72,
        leadingWidth: 80,
        leading: Container(
          color: AppColor.selecteColor.withOpacity(.10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.account_balance,
                color: AppColor.selecteColor, size: 28),
          ),
        ),
        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  hoverColor: AppColor.mainbackground,
                  highlightColor: AppColor.mainbackground,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(Icons.menu, color: AppColor.black),
                ),
              ),
              Text(
                "KERJA.in",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.selecteColor),
              ),
              Spacer(),
              _offsetPopup(width),
              Container(width: 10),
              _offsetProfile(width),
            ],
          ),
        ));
  }

  // ============================================================
  // APPBAR DESKTOP
  // ============================================================
  Row Appbar(double width) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColor.boxborder))),
            height: 72,
            child: Row(
              children: [
                Container(width: 15),
                isExpanded.isFalse && width > 983
                    ? InkWell(
                        onTap: () => expandOrShrinkDrawer(),
                        child: Icon(Icons.menu),
                      )
                    : Container(),
                Container(width: 15),
                SizedBox.shrink(), // ← hapus judul topbar
                Spacer(),
                // Smart Search
                CompositedTransformTarget(
                  link: _layerLink,
                  child: SizedBox(
                    width: 400,
                    height: 40,
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (v) {
                        setState(() {});
                        if (v.length >= 2) _search(v);
                        if (v.isEmpty) _removeOverlay();
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari data apapun di KERJA.in...',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        prefixIcon: _searching
                            ? Padding(
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2)))
                            : Icon(Icons.search, size: 18, color: Colors.grey),
                        suffixIcon: _searchCtrl.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchCtrl.clear();
                                  _removeOverlay();
                                  setState(() {});
                                },
                                icon: Icon(Icons.close, size: 16),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Color(0xFF0D6EFD), width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                _offsetProfile(width),
                Container(width: width > 1200 ? 35 : 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SIDEBAR DESKTOP (FULL)
  // ============================================================
  Container sideBar(SideBarController controller) {
    return Container(
      width: 250,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.backgorundDrawer,
            border: Border(right: BorderSide(color: AppColor.boxborder))),
        child: Obx(
          () => ListView(
            physics: ScrollPhysics(),
            children: [
              // Logo
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.account_balance,
                        color: AppColor.selecteColor, size: 25),
                    Container(
                        width:
                            10), // Bisa juga diganti dengan SizedBox(width: 10)

                    // 1. Bungkus Column dengan Expanded
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "KERJA.in",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Mengubah Data menjadi Arah",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                            // 2. Tambahkan ini agar teks otomatis terpotong rapi (ellipsis) jika masih kepanjangan
                            overflow: TextOverflow.ellipsis,

                            // Alternatif: Jika ingin teksnya turun ke baris bawah saat ruang sempit,
                            // hapus baris 'overflow' di atas dan gunakan baris di bawah ini:
                            // maxLines: 2,
                          ),
                        ],
                      ),
                    ),

                    // 3. Spacer() DIHAPUS karena Expanded sudah mengambil sisa ruang

                    InkWell(
                        onTap: () => expandOrShrinkDrawer(),
                        child: Icon(Icons.menu)),
                  ],
                ),
              ),
              // ... widget lainnya

              // Section header
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "MENU UTAMA",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

              _menuItem(
                controller: controller,
                index: 0,
                icon: Icons.dashboard_outlined,
                label: "Monitor",
                onTap: () => controller.index.value = 0,
              ),

              Container(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "MODUL BLUD",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

              _expansionModule(
                controller: controller,
                icon: Icons.map_outlined,
                label: "SIGAP BLUD",
                activeIndices: [1],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 1,
                    label: "Peta & Analitik",
                    onTap: () => controller.index.value = 1,
                  ),
                ],
              ),

              _expansionModule(
                controller: controller,
                icon: Icons.verified_outlined,
                label: "Reviu Penerapan",
                activeIndices: [2],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 2,
                    label: "Reviu Penerapan BLUD",
                    onTap: () => controller.index.value = 2,
                  ),
                ],
              ),

              _expansionModule(
                controller: controller,
                icon: Icons.assignment_outlined,
                label: "Reviu Perencanaan",
                activeIndices: [3],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 3,
                    label: "Reviu Perencanaan BLUD",
                    onTap: () => controller.index.value = 3,
                  ),
                ],
              ),

              _expansionModule(
                controller: controller,
                icon: Icons.work_outline,
                label: "Manajemen Operasional",
                activeIndices: [4, 5, 6, 7],
                children: [
                  _subMenuItem(
                    controller: controller,
                    index: 4,
                    label: "Korespondensi",
                    onTap: () => controller.index.value = 4,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 5,
                    label: "Kegiatan",
                    onTap: () => controller.index.value = 5,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 6,
                    label: "SPJ",
                    onTap: () => controller.index.value = 6,
                  ),
                  _subMenuItem(
                    controller: controller,
                    index: 7,
                    label: "Master Data",
                    onTap: () => controller.index.value = 7,
                  ),
                ],
              ),

              Container(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Text(
                  "SISTEM",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightgrey,
                      letterSpacing: 1.2),
                ),
              ),

              // Logout
              ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.logout, color: Colors.red, size: 20),
                  ),
                  title: Text("Keluar",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w400)),
                  onTap: () async {
                    await Supabase.instance.client.auth.signOut();
                  }),

              Container(height: 30),

              // Info tahun anggaran
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.selecteColor.withOpacity(.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColor.selecteColor.withOpacity(.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: AppColor.selecteColor),
                          Container(width: 6),
                          Text("Tahun Anggaran",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColor.selecteColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Container(height: 4),
                      Text("2026",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColor.selecteColor)),
                      Container(height: 2),
                      Text("Prov. Jawa Timur",
                          style: TextStyle(
                              fontSize: 11, color: AppColor.lightgrey)),
                    ],
                  ),
                ),
              ),
              Container(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SIDEBAR ICON (COLLAPSED)
  // ============================================================
  Container sideBarIcon(SideBarController controller) {
    return Container(
      width: 70,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.backgorundDrawer,
            border: Border(right: BorderSide(color: AppColor.boxborder))),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListView(
              children: [
                Container(height: 20),
                Icon(Icons.account_balance,
                    color: AppColor.selecteColor, size: 25),
                Container(height: 30),
                // Monitor
                _iconItem(
                  icon: Icons.dashboard_outlined,
                  selected: controller.index.value == 0,
                  onTap: () {
                    expandOrShrinkDrawer();
                    controller.index.value = 0;
                  },
                ),
                // SIGAP
                _iconItem(
                  icon: Icons.map_outlined,
                  selected: controller.index.value == 1,
                  onTap: () {
                    expandOrShrinkDrawer();
                    controller.index.value = 1;
                  },
                ),
                // Reviu Penerapan
                _iconItem(
                  icon: Icons.verified_outlined,
                  selected: controller.index.value == 2,
                  onTap: () {
                    expandOrShrinkDrawer();
                    controller.index.value = 2;
                  },
                ),
                // Reviu Perencanaan
                _iconItem(
                  icon: Icons.assignment_outlined,
                  selected: controller.index.value == 3,
                  onTap: () {
                    expandOrShrinkDrawer();
                    controller.index.value = 3;
                  },
                ),
                // Manajemen Operasional (buka sidebar expand)
                _iconItem(
                  icon: Icons.work_outline,
                  selected: [4, 5, 6, 7].contains(controller.index.value),
                  onTap: () {
                    expandOrShrinkDrawer();
                    // Buka sidebar full supaya user bisa pilih sub-menu
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HELPER WIDGETS
  // ============================================================

  Widget _menuItem({
    required SideBarController controller,
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? badge,
  }) {
    bool isActive = controller.index.value == index;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColor.selecteColor.withOpacity(.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColor.selecteColor : AppColor.lightgrey,
            ),
            Container(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? AppColor.selecteColor : AppColor.black,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(badge,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
              ),
            if (isActive)
              Icon(Icons.chevron_right, size: 16, color: AppColor.selecteColor),
          ],
        ),
      ),
    );
  }

  Widget _iconItem({
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          size: 22,
          color: selected ? AppColor.selecteColor : AppColor.lightgrey,
        ),
        onTap: onTap,
        selected: selected,
      ),
    );
  }

  Widget _expansionModule({
    required SideBarController controller,
    required IconData icon,
    required String label,
    required List<int> activeIndices,
    required List<Widget> children,
  }) {
    bool isActive = activeIndices.contains(controller.index.value);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        color: isActive
            ? AppColor.selecteColor.withOpacity(.06)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isActive,
          tilePadding: EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: EdgeInsets.only(bottom: 4),
          leading: Icon(icon,
              size: 20,
              color: isActive ? AppColor.selecteColor : AppColor.lightgrey),
          title: Text(label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColor.selecteColor : AppColor.black,
              )),
          trailing: Icon(Icons.keyboard_arrow_down,
              size: 16, color: AppColor.lightgrey),
          children: children,
        ),
      ),
    );
  }

  Widget _subMenuItem({
    required SideBarController controller,
    required int index,
    required String label,
    required VoidCallback onTap,
  }) {
    bool isActive = controller.index.value == index;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColor.selecteColor.withOpacity(.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColor.selecteColor : Colors.grey.shade400,
              ),
            ),
            SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? AppColor.selecteColor : AppColor.black,
                )),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE POPUP
  // ============================================================
  Widget _offsetProfile(width) => PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minHeight: 50,
          maxHeight: 128,
          minWidth: 160,
          maxWidth: 165,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            height: 35,
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Icon(Icons.person_outline, size: 15),
                Container(width: 5),
                Text("Profil",
                    style: TextStyle(
                        fontSize: 13.5,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          PopupMenuItem(
            value: 'lock',
            height: 35,
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Icon(Icons.lock_outline, size: 15),
                Container(width: 5),
                Text("Kunci Layar",
                    style: TextStyle(
                        fontSize: 13.5,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          PopupMenuItem(
            value: 'logout',
            height: 38,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
                  child: Divider(color: AppColor.borders, thickness: 1.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 23.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 15),
                      Container(width: 5),
                      Text("Keluar",
                          style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.red,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 'lock':
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LockScreen()));
              break;
            case 'logout':
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Logout()));
              break;
          }
        },
        offset: Offset(0, 72),
        child: Container(
          width: width > 1200 ? 148 : 70,
          height: 72,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.boxborder),
              color: AppColor.selecteColor.withOpacity(.06)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColor.selecteColor.withOpacity(.15),
                  child: Icon(Icons.person,
                      size: 18, color: AppColor.selecteColor),
                ),
                if (width > 1200) ...[
                  Container(width: 8),
                  Expanded(
                    child: Text(
                      "Pengguna",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 15),
                ]
              ],
            ),
          ),
        ),
      );

  // ============================================================
  // NOTIFIKASI POPUP
  // ============================================================
  Widget _offsetPopup(width) => PopupMenuButton<int>(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minHeight: 50,
          maxHeight: 200,
          minWidth: 250,
          maxWidth: 310,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Notifikasi",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF313533))),
                Container(height: 12),
                Text("Tidak ada notifikasi baru.",
                    style: TextStyle(fontSize: 13, color: AppColor.lightgrey)),
              ],
            ),
          ),
        ],
        icon: Icon(Icons.notifications_none_rounded, color: AppColor.black),
        offset: Offset(0, 56),
      );

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded.value = !isExpanded.value;
    });
  }
}

// ============================================================
// BOTTOM FOOTER
// ============================================================
class bottomText extends StatelessWidget {
  const bottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.mainbackground,
        height: 50,
        child: Row(
          children: [
            Container(width: 18),
            Text(
              "2026 © KERJA.in — Sub BLUD Biro Perekonomian Jatim | Developed by Abdul Haris Hidayat",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightgrey),
            ),
          ],
        ));
  }
}

// ============================================================
// KOMPONEN BAWAAN MINIA (DIPERTAHANKAN)
// ============================================================
class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    super.key,
    this.onTap,
    required this.text,
    required this.iconData,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(iconData, color: AppColor.black),
            if (notificationCount > 0)
              Positioned(
                right: 1,
                top: -6,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String text;
  final dynamic color;
  final VoidCallback onTap;
  const Menu({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        child: Row(
          children: [
            Container(width: 53),
            Expanded(
              child: Text(
                text.tr,
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubMenu extends StatelessWidget {
  final String subtext;
  final dynamic color;
  final VoidCallback onTap;
  const SubMenu({
    super.key,
    required this.subtext,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        child: Row(
          children: [
            Container(width: 72),
            Expanded(
              child: Text(
                subtext.tr,
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommanListTile extends StatelessWidget {
  final String text;
  final String? icon;
  final VoidCallback onTap;
  final dynamic selected;
  final dynamic color;
  final double minWidth;

  const CommanListTile({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.selected,
    required this.color,
    required this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      selectedColor: AppColor.selecteColor,
      title: Text(
        text.tr,
        style: TextStyle(
            overflow: TextOverflow.clip,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
      ),
      contentPadding: EdgeInsets.zero,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SvgPicture.asset(
          icon!,
          fit: BoxFit.cover,
          height: 17,
          width: 22,
          color: color,
        ),
      ),
      onTap: onTap,
      selected: selected,
    );
  }
}

class ExpansionListCustom extends StatefulWidget {
  final String title;
  final String? icon;
  final dynamic selected;
  final dynamic color;
  final dynamic children;
  const ExpansionListCustom({
    super.key,
    required this.title,
    this.selected,
    this.color,
    this.children,
    this.icon,
  });

  @override
  State<ExpansionListCustom> createState() => _ExpansionListCustomState();
}

class _ExpansionListCustomState extends State<ExpansionListCustom> {
  SideBarController controller = Get.find();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      dense: true,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool isExpanded) {
            setState(() => _isExpanded = isExpanded);
          },
          trailing: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.keyboard_arrow_down,
                      size: 16, color: AppColor.lightgrey),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.arrow_forward_ios,
                      color: AppColor.lightgrey, size: 12),
                ),
          textColor: AppColor.searchbackground,
          iconColor: AppColor.searchbackground,
          tilePadding: EdgeInsets.zero,
          title: Text(
            widget.title.tr,
            style: TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
          children: widget.children,
          leading: widget.icon != null && widget.icon!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SvgPicture.asset(
                    widget.icon!,
                    fit: BoxFit.cover,
                    height: 17,
                    width: 22,
                    color: _isExpanded ? AppColor.searchbackground : null,
                  ),
                )
              : Container(width: 0.0),
        ),
      ),
    );
  }
}
