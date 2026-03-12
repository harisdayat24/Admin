// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Represents MyHomePage class
class RadialChart extends StatefulWidget {
  /// Creates the instance of MyHomePage
  const RadialChart({super.key});

  @override
  _RadialChartState createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  Widget _getGauge({bool isRadialGauge = true}) {
    if (isRadialGauge) {
      return _getRadialGauge();
    } else {
      return _getLinearGauge();
    }
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 0,
          maximum: 500,
          axisLineStyle: AxisLineStyle(
            color: Colors.grey.withOpacity(.10),
            thickness: 25.0,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 8,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 16,
              endValue: 24,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 32,
              endValue: 40,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 48,
              endValue: 56,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 64,
              endValue: 72,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 80,
              endValue: 88,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 96,
              endValue: 104,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 112,
              endValue: 120,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 128,
              endValue: 136,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 144,
              endValue: 152,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 160,
              endValue: 168,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 176,
              endValue: 184,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 192,
              endValue: 200,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 208,
              endValue: 216,
              color: AppColor.selecteColor,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 224,
              endValue: 232,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 240,
              endValue: 248,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 256,
              endValue: 264,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 272,
              endValue: 280,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 288,
              endValue: 296,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 304,
              endValue: 312,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 320,
              endValue: 328,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 336,
              endValue: 344,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 352,
              endValue: 360,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 368,
              endValue: 376,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 384,
              endValue: 392,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
            GaugeRange(
              startValue: 400,
              endValue: 408,
              color: AppColor.darkGreen,
              startWidth: 25,
              endWidth: 25,
            ),
          ],
          pointers: <GaugePointer>[
            // NeedlePointer(value: 90)
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: const Text('',
                  style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold)),
              positionFactor: 0.5,
            )
          ])
    ]);
  }

  Widget _getLinearGauge() {
    return Container(
      child: SfLinearGauge(
          minimum: 0.0,
          maximum: 100.0,
          orientation: LinearGaugeOrientation.horizontal,
          majorTickStyle: LinearTickStyle(length: 20),
          axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
          axisTrackStyle: LinearAxisTrackStyle(
              color: Colors.cyan,
              edgeStyle: LinearEdgeStyle.bothFlat,
              thickness: 15.0,
              borderColor: Colors.grey)),
      margin: EdgeInsets.all(50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: _getGauge(),
    );
  }
}
