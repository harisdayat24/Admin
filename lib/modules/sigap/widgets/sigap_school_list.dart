import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sigap_controller.dart';
import '../models/sigap_constants.dart';
import '../models/sigap_enums.dart';
import '../models/unit_blud.dart';
import 'sigap_map.dart';

class SigapSchoolList extends StatelessWidget {
  final SigapController controller;
  const SigapSchoolList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ═══ SEKTOR PILLS ═══
          _SektorFilter(controller: controller),

          // ═══ TIER CHIPS ═══
          _TierChips(controller: controller),

          // ═══ SEARCH ═══
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
            child: TextField(
              onChanged: controller.setSearch,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: '🔍  Cari nama sekolah / kabupaten...',
                hintStyle:
                    const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                isDense: true,
              ),
            ),
          ),

          // ═══ KAB DROPDOWN + SORT ═══
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Row(
              children: [
                Expanded(child: _KabDropdown(controller: controller)),
                const SizedBox(width: 8),
                _SortDropdown(controller: controller),
              ],
            ),
          ),

          const Divider(height: 1),

          // ═══ LIST ═══
          Expanded(
            child: Obx(() {
              final units = controller.filteredUnits;
              if (units.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada unit ditemukan',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                itemCount: units.length,
                itemBuilder: (_, i) => _SchoolItem(
                  unit: units[i],
                  isSelected: controller.selectedUnit.value?.kodeUnit ==
                      units[i].kodeUnit,
                  onTap: () {
                    controller.selectUnit(units[i]);
                    // Fly to unit on map
                    SigapMap.mapKey.currentState?.flyToUnit(units[i]);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SEKTOR FILTER
// ═══════════════════════════════════════════════════════════════

class _SektorFilter extends StatelessWidget {
  final SigapController controller;
  const _SektorFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedSektor.value;
      return Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SEKTOR',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _sektorChip('📊', 'Semua', null, selected == null),
                ...Sektor.values.map((s) => _sektorChip(
                      s.icon,
                      s.label,
                      s,
                      selected == s,
                    )),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _sektorChip(String icon, String label, Sektor? sektor, bool isActive) {
    final color = sektor != null
        ? SigapConstants.sektorColor(sektor)
        : const Color(0xFF374151);
    final bg = sektor != null
        ? SigapConstants.sektorBg(sektor)
        : const Color(0xFFF1F5F9);

    return GestureDetector(
      onTap: () => controller.setSektor(sektor),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? bg : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? color : const Color(0xFFE2E8F0),
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? color : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TIER CHIPS
// ═══════════════════════════════════════════════════════════════

class _TierChips extends StatelessWidget {
  final SigapController controller;
  const _TierChips({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tc = controller.tierCounts;
      final active = controller.activeTiers;
      final st = controller.statsGlobal.value;

      return Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FILTER KESIAPAN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                // BLUD toggle
                _chip(
                  'BLUD (${st?.totalBlud ?? 0})',
                  SigapConstants.bludColor,
                  SigapConstants.bludBg,
                  controller.showBlud.value,
                  () => controller.showBlud.toggle(),
                ),
                // Tier 1-4
                for (int t = 1; t <= 4; t++)
                  _chip(
                    '${SigapConstants.tierLabel(t)} (${tc[t] ?? 0})',
                    SigapConstants.tierColor(t),
                    SigapConstants.tierBg(t),
                    active.contains(t),
                    () => controller.toggleTier(t),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _chip(
      String label, Color color, Color bg, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: isActive ? 1.0 : 0.35,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// KAB DROPDOWN
// ═══════════════════════════════════════════════════════════════

class _KabDropdown extends StatelessWidget {
  final SigapController controller;
  const _KabDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
          value: controller.selectedKab.value.isEmpty
              ? null
              : controller.selectedKab.value,
          isExpanded: true,
          isDense: true,
          style: const TextStyle(fontSize: 11, color: Color(0xFF0F172A)),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            isDense: true,
          ),
          hint: const Text('📍 Semua Kab/Kota',
              style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
          items: [
            const DropdownMenuItem(
              value: '',
              child: Text('📍 Semua Kab/Kota', style: TextStyle(fontSize: 11)),
            ),
            ...controller.kabList.map((k) => DropdownMenuItem(
                  value: k,
                  child: Text(k, style: const TextStyle(fontSize: 11)),
                )),
          ],
          onChanged: (v) => controller.setKab(v ?? ''),
        ));
  }
}

// ═══════════════════════════════════════════════════════════════
// SORT DROPDOWN
// ═══════════════════════════════════════════════════════════════

class _SortDropdown extends StatelessWidget {
  final SigapController controller;
  const _SortDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<String>(
          value: controller.sortBy.value,
          isDense: true,
          underline: const SizedBox.shrink(),
          style: const TextStyle(fontSize: 11, color: Color(0xFF0F172A)),
          items: const [
            DropdownMenuItem(value: 'score', child: Text('Skor ↓')),
            DropdownMenuItem(value: 'kab', child: Text('Kab A-Z')),
            DropdownMenuItem(value: 'nama', child: Text('Nama A-Z')),
          ],
          onChanged: (v) => controller.setSort(v ?? 'score'),
        ));
  }
}

// ═══════════════════════════════════════════════════════════════
// SCHOOL ITEM
// ═══════════════════════════════════════════════════════════════

class _SchoolItem extends StatelessWidget {
  final UnitBlud unit;
  final bool isSelected;
  final VoidCallback onTap;

  const _SchoolItem({
    required this.unit,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = unit.isBludAktif
        ? SigapConstants.bludColor
        : unit.hasScore
            ? SigapConstants.tierColor(unit.tier)
            : SigapConstants.belumColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            // Tier bar
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Sektor icon
                      Text(unit.sektor.icon,
                          style: const TextStyle(fontSize: 10)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          unit.nama,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${unit.kabKota}${unit.subSektor != null && unit.subSektor != 'SMKN' ? ' · ${unit.subSektor}' : ''}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            // Score + badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (unit.hasScore)
                  Text(
                    '${unit.skorTotal}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: unit.isBludAktif
                        ? SigapConstants.bludBg
                        : unit.hasScore
                            ? SigapConstants.tierBg(unit.tier)
                            : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    unit.badgeText,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
