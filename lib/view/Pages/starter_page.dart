// ignore_for_file: prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import '../../comman/colors.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        if (width > 600) rowss() else columnss(),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              width: width,
              height: 760,
            )),
          ],
        ),
      ],
    );
  }
}

Row rowss() {
  return Row(
    children: [
      Text(
        "Starter Page",
        style: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      Spacer(),
      Text(
        "Pages",
        style: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      Container(width: 10),
      Icon(Icons.chevron_right),
      Container(width: 10),
      Text(
        "Starter Page",
        style: TextStyle(
          color: AppColor.lightdark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Column columnss() {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Starter Page",
          style: TextStyle(
            color: AppColor.dark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      Row(
        children: [
          Text(
            "Pages",
            style: TextStyle(
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Container(width: 2),
          Icon(Icons.chevron_right),
          Text(
            "Starter Page",
            style: TextStyle(
              color: AppColor.lightdark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  );
}
