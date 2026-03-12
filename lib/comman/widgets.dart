// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minia_web_project/comman/text_style.dart';

import 'colors.dart';

class wallets extends StatelessWidget {
  final double width;
  final String text;
  final String amounts;
  final String profiteimage;
  final List<double> data;

  const wallets({
    super.key,
    required this.width,
    required this.text,
    required this.amounts,
    required this.profiteimage,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.mainbackground,
        border: Border.all(color: AppColor.boxborder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width > 360 ? 20 : 10,
              ),
              Expanded(
                flex: width > 240 ? 4 : 2,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.lightdark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(height: 15),
                    Text(
                      amounts,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 21,
                        color: AppColor.dark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100,
                  child: SparkLine(data: data),
                ),
              ),
              Container(width: width > 360 ? 40 : 10),
            ],
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: width > 360 ? 30 : 10),
                SvgPicture.asset(
                  profiteimage,
                ),
                Container(width: 10),
                Text(
                  "Since last week",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.lightdark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColumnTitel extends StatelessWidget {
  final String textL;
  final String texti;
  final String textii;
  const ColumnTitel({
    super.key,
    required this.textL,
    required this.texti,
    required this.textii,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: TitelText(
            color: AppColor.dark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            text: textL,
          ),
        ),
        Container(height: 5),
        Row(
          children: [
            TitelText(
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text: texti,
            ),
            Container(width: 2),
            Icon(Icons.chevron_right, color: AppColor.lightgrey),
            Container(width: 2),
            TitelText(
              color: AppColor.lightdark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text: textii,
            ),
          ],
        ),
      ],
    );
  }
}

class RowTitel extends StatelessWidget {
  final String textL;
  final String texti;
  final String textii;
  const RowTitel({
    super.key,
    required this.textL,
    required this.texti,
    required this.textii,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitelText(
          color: AppColor.dark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          text: textL,
        ),
        Spacer(),
        TitelText(
          color: AppColor.dark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          text: texti,
        ),
        Container(width: 10),
        Icon(Icons.chevron_right, color: AppColor.lightgrey),
        Container(width: 10),
        TitelText(
          color: AppColor.lightdark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          text: textii,
        )
      ],
    );
  }
}

class SparkLine extends StatefulWidget {
  final List<double> data;
  const SparkLine({super.key, required this.data});

  @override
  State<SparkLine> createState() => _SparkLineState();
}

class _SparkLineState extends State<SparkLine> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainbackground,
      body: Column(
        children: [
          Container(height: 16),
          Center(
            child: SizedBox(
              // color: Colors.blueAccent,
              // width: 500.0,
              height: 84.0,
              child: Sparkline(
                data: widget.data,
                useCubicSmoothing: true,
                lineWidth: 3.0,
                enableThreshold: true,
                thresholdSize: 0.55,
                lineGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.selecteColor, AppColor.selecteColor],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
