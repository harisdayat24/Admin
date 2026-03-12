import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/screens/dashboard/dashboard_screen.dart';
import 'package:minia_web_project/screens/surat/surat_screen.dart';
import 'package:minia_web_project/screens/kegiatan/kegiatan_screen.dart';
import 'package:minia_web_project/screens/spj/spj_screen.dart';
import 'package:minia_web_project/screens/master/master_data_screen.dart';
import 'package:minia_web_project/modules/sigap/sigap_module.dart';

class SideBarController extends GetxController {
  RxInt index = 0.obs;

  var page = [
    DashboardScreen(), // 0 - Monitor
    const SigapScreen(), // 1 - SIGAP BLUD  ← ganti ini
    _ComingSoon('Reviu Penerapan BLUD'), // 2
    _ComingSoon('Reviu Perencanaan BLUD'), // 3
    SuratScreen(), // 4 - Korespondensi
    KegiatanScreen(), // 5 - Kegiatan
    SPJScreen(), // 6 - SPJ
    MasterDataScreen(), // 7 - Master Data
  ];
}

class _ComingSoon extends StatelessWidget {
  final String modul;
  const _ComingSoon(this.modul);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction_outlined,
              size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(modul,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Modul ini sedang dalam pengembangan.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
