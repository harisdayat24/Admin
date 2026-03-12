// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VerticalChart extends StatefulWidget {
  const VerticalChart({super.key});

  @override
  State<VerticalChart> createState() => _VerticalChartState();
}

class _VerticalChartState extends State<VerticalChart> {
  final List<ChartData> chartData = [
    ChartData('Jan', 25, 20, 35),
    ChartData('Feb', 35, 35, 25),
    ChartData('Mar', 15, 15, 45),
    ChartData('Apr', 20, 20, 40),
    ChartData('May', 30, 25, 30),
    ChartData('Jun', 40, 35, 20),
    ChartData('Jul', 40, 35, 20),
    ChartData('Aug', 30, 25, 30),
    ChartData('Sep', 20, 20, 40),
    ChartData('Oct', 15, 15, 45),
    ChartData('Nov', 35, 35, 25),
    ChartData('Dec', 25, 20, 35),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColor.mainbackground,
        height: 400,
        // width: 600,
        child: SfCartesianChart(
          plotAreaBorderColor: Colors.transparent,
          primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(
            color: Colors.transparent,
          )),
          series: <CartesianSeries>[
            StackedColumnSeries<ChartData, String>(
              color: Colors.transparent,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y3,
            ),
            StackedColumnSeries<ChartData, String>(
              color: AppColor.darkGreen,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1,
            ),
            StackedColumnSeries<ChartData, String>(
                color: AppColor.selecteColor,
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y2),
            // StackedColumnSeries<ChartData, String>(
            //     dataSource: chartData,
            //     xValueMapper: (ChartData data, _) => data.x,
            //     yValueMapper: (ChartData data, _) => data.y4)
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y1,
    this.y2,
    this.y3,
    // this.y4,
  );
  final x;
  final num y1;
  final num y2;
  final num y3;
  // final num y4;
}
