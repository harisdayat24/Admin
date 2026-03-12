import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/sigap_controller.dart';
import '../models/sigap_constants.dart';
import '../models/sigap_enums.dart';
import '../models/unit_blud.dart';

class SigapMap extends StatefulWidget {
  final SigapController controller;

  /// GlobalKey untuk akses flyTo dari luar (list click)
  static final GlobalKey<SigapMapState> mapKey = GlobalKey<SigapMapState>();

  SigapMap({required this.controller}) : super(key: mapKey);

  @override
  State<SigapMap> createState() => SigapMapState();
}

class SigapMapState extends State<SigapMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();

  // Popup state
  UnitBlud? _popupUnit;

  /// Dipanggil dari luar (list click) untuk fly ke unit
  void flyToUnit(UnitBlud unit) {
    if (!SigapConstants.isValidJatimCoord(unit.lat, unit.lng)) return;

    _mapController.move(
      LatLng(unit.lat, unit.lng),
      13.0,
    );
    setState(() {
      _popupUnit = unit;
    });
  }

  void _showPopup(UnitBlud unit) {
    widget.controller.selectUnit(unit);
    setState(() {
      _popupUnit = unit;
    });
  }

  void _hidePopup() {
    setState(() {
      _popupUnit = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // ═══ MAP ═══
          Obx(() {
            final blud = widget.controller.visibleBludUnits;
            final calon = widget.controller.visibleCalonUnits;
            final belumData = widget.controller.visibleBelumDataUnits;
            final selected = widget.controller.selectedUnit.value;

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(
                  SigapConstants.jatimLat,
                  SigapConstants.jatimLng,
                ),
                initialZoom: SigapConstants.jatimZoom,
                onTap: (_, __) {
                  _hidePopup();
                  widget.controller.clearSelection();
                },
              ),
              children: [
                // Tile layer
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                  subdomains: const ['a', 'b', 'c', 'd'],
                  maxZoom: 19,
                ),

                // Layer 1: Belum data (small grey dots)
                CircleLayer(
                  circles: belumData
                      .where(
                          (u) => SigapConstants.isValidJatimCoord(u.lat, u.lng))
                      .map((u) => CircleMarker(
                            point: LatLng(u.lat, u.lng),
                            radius: 3,
                            color: SigapConstants.belumColor.withOpacity(0.4),
                            borderColor: Colors.white.withOpacity(0.6),
                            borderStrokeWidth: 0.5,
                          ))
                      .toList(),
                ),

                // Layer 2: BLUD aktif (tappable markers)
                MarkerLayer(
                  markers: blud
                      .where(
                          (u) => SigapConstants.isValidJatimCoord(u.lat, u.lng))
                      .map((u) => Marker(
                            point: LatLng(u.lat, u.lng),
                            width: selected?.kodeUnit == u.kodeUnit ? 24 : 18,
                            height: selected?.kodeUnit == u.kodeUnit ? 24 : 18,
                            child: GestureDetector(
                              onTap: () => _showPopup(u),
                              child: _BludMarker(
                                sektor: u.sektor,
                                isSelected: selected?.kodeUnit == u.kodeUnit,
                              ),
                            ),
                          ))
                      .toList(),
                ),

                // Layer 3: Calon BLUD dengan skor (tier dot markers)
                MarkerLayer(
                  markers: calon
                      .where(
                          (u) => SigapConstants.isValidJatimCoord(u.lat, u.lng))
                      .map((u) {
                    final isSel = selected?.kodeUnit == u.kodeUnit;
                    final size = isSel ? 28.0 : 20.0;
                    return Marker(
                      point: LatLng(u.lat, u.lng),
                      width: size,
                      height: size,
                      child: GestureDetector(
                        onTap: () => _showPopup(u),
                        child: _TierMarker(
                          tier: u.tier,
                          isSelected: isSel,
                          skorTotal: u.skorTotal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }),

          // ═══ POPUP CARD ═══
          if (_popupUnit != null)
            Positioned(
              top: 60,
              right: 16,
              child: _PopupCard(
                unit: _popupUnit!,
                onClose: _hidePopup,
                onDetail: () {
                  widget.controller.selectUnit(_popupUnit!);
                  _hidePopup();
                },
              ),
            ),

          // ═══ COUNTER BAR (top center) ═══
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Center(child: _CounterBar(controller: widget.controller)),
          ),

          // ═══ LEGEND (bottom left) ═══
          Positioned(
            bottom: 20,
            left: 16,
            child: _MapLegend(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// BLUD MARKER
// ═══════════════════════════════════════════════════════════════

class _BludMarker extends StatelessWidget {
  final Sektor sektor;
  final bool isSelected;

  const _BludMarker({required this.sektor, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SigapConstants.bludColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.white : SigapConstants.sektorColor(sektor),
          width: isSelected ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.35 : 0.15),
            blurRadius: isSelected ? 6 : 3,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TIER MARKER
// ═══════════════════════════════════════════════════════════════

class _TierMarker extends StatelessWidget {
  final int tier;
  final bool isSelected;
  final int skorTotal;

  const _TierMarker({
    required this.tier,
    this.isSelected = false,
    this.skorTotal = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SigapConstants.tierColor(tier),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: isSelected ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.35 : 0.2),
            blurRadius: isSelected ? 8 : 4,
          ),
        ],
      ),
      child: isSelected
          ? Center(
              child: Text(
                '$skorTotal',
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// POPUP CARD
// ═══════════════════════════════════════════════════════════════

class _PopupCard extends StatelessWidget {
  final UnitBlud unit;
  final VoidCallback onClose;
  final VoidCallback onDetail;

  const _PopupCard({
    required this.unit,
    required this.onClose,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    final color = unit.isBludAktif
        ? SigapConstants.bludColor
        : SigapConstants.tierColor(unit.tier);

    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.sektor.icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit.nama,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        unit.kabKota,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(Icons.close,
                      size: 16, color: Color(0xFF94A3B8)),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Status + skor
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: unit.isBludAktif
                        ? SigapConstants.bludBg
                        : SigapConstants.tierBg(unit.tier),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    unit.isBludAktif
                        ? '✅ Sudah BLUD'
                        : SigapConstants.tierLabel(unit.tier),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (unit.hasScore)
                  Text(
                    '${unit.skorTotal}/100',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
              ],
            ),

            // Sub-sektor
            if (unit.subSektor != null && unit.subSektor!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: SigapConstants.sektorBg(unit.sektor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  unit.subSektor!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: SigapConstants.sektorColor(unit.sektor),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 10),

            // Tombol detail
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onDetail,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lihat Detail →',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
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

// ═══════════════════════════════════════════════════════════════
// COUNTER BAR
// ═══════════════════════════════════════════════════════════════

class _CounterBar extends StatelessWidget {
  final SigapController controller;
  const _CounterBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final st = controller.statsGlobal.value;
      if (st == null) return const SizedBox.shrink();
      final tc = controller.tierCounts;

      final items = [
        (st.totalBlud.toString(), 'BLUD', SigapConstants.bludColor),
        ('${tc[1] ?? 0}', 'T1', SigapConstants.tierColor(1)),
        ('${tc[2] ?? 0}', 'T2', SigapConstants.tierColor(2)),
        ('${tc[3] ?? 0}', 'T3', SigapConstants.tierColor(3)),
        ('${tc[4] ?? 0}', 'T4', SigapConstants.tierColor(4)),
        (
          '${st.totalCalon - st.sudahDinilai}',
          'Belum',
          SigapConstants.belumColor
        ),
      ];

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: item.$3, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 4),
                        Text(item.$1,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 2),
                        Text(item.$2,
                            style: const TextStyle(
                                fontSize: 10, color: Color(0xFF64748B))),
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════
// LEGEND
// ═══════════════════════════════════════════════════════════════

class _MapLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(maxWidth: 220),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('KETERANGAN',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                  color: Color(0xFF64748B))),
          const SizedBox(height: 8),
          _row(SigapConstants.bludColor, 'Sudah BLUD',
              sub: '🎓 Pendidikan  🏥 Kesehatan  🏛️ UPT'),
          const Divider(height: 12),
          _row(SigapConstants.tierColor(1), 'Tier 1 — Siap (≥75)'),
          _row(SigapConstants.tierColor(2), 'Tier 2 — Hampir (50–74)'),
          _row(SigapConstants.tierColor(3), 'Tier 3 — Pembinaan (30–49)'),
          _row(SigapConstants.tierColor(4), 'Tier 4 — Belum (<30)'),
          _row(SigapConstants.belumColor, 'Belum Ada Data'),
        ],
      ),
    );
  }

  Widget _row(Color color, String label, {String? sub}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12, width: 1.5))),
            const SizedBox(width: 8),
            Flexible(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500))),
          ]),
          if (sub != null)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 2),
              child: Text(sub,
                  style:
                      const TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
            ),
        ],
      ),
    );
  }
}
