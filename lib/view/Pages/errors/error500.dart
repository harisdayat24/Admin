// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../comman/colors.dart';

class Error500 extends StatelessWidget {
  const Error500({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 55),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "5",
                  style: TextStyle(
                    fontSize: width > 200 ? 96 : 35,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(width: width > 200 ? 10 : 2),
                Text(
                  "0",
                  style: TextStyle(
                    fontSize: width > 200 ? 96 : 35,
                    color: AppColor.searchbackground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(width: width > 200 ? 10 : 2),
                Text(
                  "0",
                  style: TextStyle(
                    fontSize: width > 200 ? 96 : 35,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              "INTERNAL SERVER ERROR",
              style: TextStyle(
                fontSize: 25,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 50),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 144,
                height: 38,
                decoration: BoxDecoration(color: AppColor.searchbackground),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Back to Dashboard",
                    style: TextStyle(
                      color: AppColor.mainbackground,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 40),
            Image.asset(
              "assets/image/error/img.png",
              height: 400,
              width: 740,
            ),
          ],
        ),
      ),
    );
  }
}
