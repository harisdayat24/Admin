// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'dart:math' as math;

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 40),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/minia_logo.svg",
                        height: 35, width: 35),
                    Spacer(),
                    MText(
                      text: "Minia",
                      size: 25,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            Container(height: 50),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48, top: 2),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _controller.value * -18 * math.pi,
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/svg/maintenance/setting2.svg",
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          // alignment: Alignment.bottomLeft,
                          angle: _controller.value * 18 * math.pi,
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/svg/maintenance/settings.svg",
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 25),
            MText(
              text: "Site is Under Maintenance",
              size: 25,
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
            Container(height: 10),
            MText(
              text: "Please check back in sometime.",
              size: 15,
              color: AppColor.lightgrey,
              fontWeight: FontWeight.bold,
            ),
            Container(height: 50),
            width > 771 ? row() : column(),
            Container(height: 50),
          ],
        ),
      ),
    );
  }

  Padding column() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: [
          SvgPicture.asset("assets/svg/maintenance/Icon1.svg"),
          Container(height: 20),
          MText(
            text: "WHY IS THE SITE DOWN?",
            size: 16,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          Container(
            height: 20,
          ),
          MText(
            text:
                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.",
            size: 14,
            color: AppColor.lightgrey,
            fontWeight: FontWeight.bold,
          ),
          Container(height: 60),
          SvgPicture.asset("assets/svg/maintenance/Icon2.svg"),
          Container(height: 20),
          MText(
            text: "WHAT IS THE DOWNTIME?",
            size: 16,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          Container(height: 20),
          MText(
            text:
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical.",
            size: 14,
            color: AppColor.lightgrey,
            fontWeight: FontWeight.bold,
          ),
          Container(height: 60),
          SvgPicture.asset("assets/svg/maintenance/Icon3.svg"),
          Container(height: 20),
          MText(
            text: "DO YOU NEED SUPPORT?",
            size: 16,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          Container(
            height: 20,
          ),
          MText(
            text:
                "If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embar.. ",
            size: 14,
            color: AppColor.lightgrey,
            fontWeight: FontWeight.bold,
          ),
          Container(height: 60),
        ],
      ),
    );
  }

  Row row() {
    return Row(
      children: [
        Spacer(),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                SvgPicture.asset("assets/svg/maintenance/Icon1.svg"),
                Container(height: 20),
                MText(
                  text: "WHY IS THE SITE DOWN?",
                  size: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  height: 20,
                ),
                MText(
                  text:
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.",
                  size: 14,
                  color: AppColor.lightgrey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
        Container(width: 40),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                SvgPicture.asset("assets/svg/maintenance/Icon2.svg"),
                Container(height: 20),
                MText(
                  text: "WHAT IS THE DOWNTIME?",
                  size: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
                Container(height: 20),
                MText(
                  text:
                      "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical.",
                  size: 14,
                  color: AppColor.lightgrey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
        Container(width: 40),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                SvgPicture.asset("assets/svg/maintenance/Icon3.svg"),
                Container(height: 20),
                MText(
                  text: "DO YOU NEED SUPPORT?",
                  size: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  height: 20,
                ),
                MText(
                  text:
                      "If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embar.. ",
                  size: 14,
                  color: AppColor.lightgrey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class MText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double size;

  const MText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      // softWrap: false,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
