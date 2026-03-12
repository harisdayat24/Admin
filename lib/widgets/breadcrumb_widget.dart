import 'package:flutter/material.dart';

class BreadcrumbWidget extends StatelessWidget {
  final List<BreadcrumbItem> items;
  const BreadcrumbWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.home_outlined, size: 14, color: Colors.grey.shade400),
          SizedBox(width: 6),
          ...items.asMap().entries.map((entry) {
            bool isLast = entry.key == items.length - 1;
            final item = entry.value;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_right,
                    size: 14, color: Colors.grey.shade300),
                SizedBox(width: 4),
                isLast
                    ? Text(item.label,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0D6EFD),
                            fontWeight: FontWeight.w600))
                    : InkWell(
                        onTap: item.onTap,
                        borderRadius: BorderRadius.circular(4),
                        hoverColor: Color(0xFF0D6EFD).withOpacity(0.08),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          child: Text(item.label,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF0D6EFD).withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color(0xFF0D6EFD).withOpacity(0.4))),
                        ),
                      ),
                SizedBox(width: 4),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  const BreadcrumbItem({required this.label, this.onTap});
}
