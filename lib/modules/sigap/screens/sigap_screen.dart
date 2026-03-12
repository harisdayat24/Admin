import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sigap_controller.dart';
import '../widgets/sigap_map.dart';
import '../widgets/sigap_school_list.dart';
import '../widgets/sigap_kpi_panel.dart';

class SigapScreen extends StatelessWidget {
  const SigapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SigapController());

    // Tinggi eksplisit — drawer.dart pakai SingleChildScrollView + Column
    // yang tidak memberikan bounded height, FlutterMap butuh constraint
    final screenHeight = MediaQuery.of(context).size.height - 130;

    return Obx(() {
      // ═══ LOADING ═══
      if (c.isLoading.value) {
        return SizedBox(
          height: screenHeight,
          child: Container(
            color: const Color(0xFFF0F4F8),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'SIGAP BLUD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Memuat data ekosistem BLUD Jawa Timur...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // ═══ ERROR ═══
      if (c.errorMessage.value.isNotEmpty && c.allUnits.isEmpty) {
        return SizedBox(
          height: screenHeight,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                const Text(
                  'Gagal memuat data',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  c.errorMessage.value,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: c.loadAll,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        );
      }

      // ═══ RESPONSIVE LAYOUT ═══
      return SizedBox(
        height: screenHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Desktop: 3-panel
            if (constraints.maxWidth >= 1200) {
              return Row(
                children: [
                  SizedBox(
                    width: 320,
                    child: SigapSchoolList(controller: c),
                  ),
                  Container(width: 1, color: const Color(0xFFE2E8F0)),
                  Expanded(
                    child: SigapMap(controller: c),
                  ),
                  Container(width: 1, color: const Color(0xFFE2E8F0)),
                  SizedBox(
                    width: 300,
                    child: SigapKpiPanel(controller: c),
                  ),
                ],
              );
            }

            // Tablet: map + right panel
            if (constraints.maxWidth >= 768) {
              return Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SigapMap(controller: c),
                        Positioned(
                          top: 60,
                          left: 12,
                          child: _ListToggleButton(controller: c),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, color: const Color(0xFFE2E8F0)),
                  SizedBox(
                    width: 280,
                    child: SigapKpiPanel(controller: c),
                  ),
                ],
              );
            }

            // Mobile: tabs
            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      labelStyle:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: TextStyle(fontSize: 11),
                      labelColor: Color(0xFF2563EB),
                      unselectedLabelColor: Color(0xFF64748B),
                      indicatorColor: Color(0xFF2563EB),
                      tabs: [
                        Tab(icon: Icon(Icons.map, size: 18), text: 'Peta'),
                        Tab(icon: Icon(Icons.list, size: 18), text: 'Daftar'),
                        Tab(
                            icon: Icon(Icons.analytics, size: 18),
                            text: 'Analitik'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SigapMap(controller: c),
                        SigapSchoolList(controller: c),
                        SigapKpiPanel(controller: c),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

/// Tombol toggle list overlay di mode tablet
class _ListToggleButton extends StatefulWidget {
  final SigapController controller;
  const _ListToggleButton({required this.controller});

  @override
  State<_ListToggleButton> createState() => _ListToggleButtonState();
}

class _ListToggleButtonState extends State<_ListToggleButton> {
  bool _showList = false;

  @override
  Widget build(BuildContext context) {
    if (!_showList) {
      return Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => setState(() => _showList = true),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.list, size: 16, color: Color(0xFF2563EB)),
                SizedBox(width: 4),
                Text('Daftar',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2563EB))),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 300,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => setState(() => _showList = false),
              ),
            ),
            Expanded(
              child: SigapSchoolList(controller: widget.controller),
            ),
          ],
        ),
      ),
    );
  }
}
