import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';
import 'colors.dart';

class Drawertextstyle extends StatelessWidget {
  final String text;

  Drawertextstyle({
    super.key,
    required this.text,
  });

  final DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.4,
        fontWeight: FontWeight.bold,
        color: controller.selected.isFalse
            ? AppColor.notselecteColor
            : AppColor.selecteColor,
      ),
    );
  }
}

// dashboard text
class TitelText extends StatelessWidget {
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String text;

  const TitelText({
    super.key,
    required this.color,
    required this.fontWeight,
    required this.fontSize, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
