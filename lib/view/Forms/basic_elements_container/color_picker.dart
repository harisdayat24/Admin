// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../comman/colors.dart';

class ColorPickernew extends StatefulWidget {
  const ColorPickernew({super.key});

  @override
  _ColorPickernewState createState() => _ColorPickernewState();
}

class _ColorPickernewState extends State<ColorPickernew> {
  Color selectedColor = AppColor.selecteColor;

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color picker",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
            padding: EdgeInsets.all(7.5),
            decoration: BoxDecoration(
              color: AppColor.mainbackground,
              border: Border.all(
                color: AppColor.borders,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        // color: AppColor.darkGreen,
                        child: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: selectedColor,
                            onColorChanged: changeColor,
                            showLabel: true,
                            pickerAreaHeightPercent: 0.8,
                            colorPickerWidth: 200,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                height: 21,
                width: 31,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
