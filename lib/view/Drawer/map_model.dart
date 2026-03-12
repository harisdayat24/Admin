// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

late List<Model> _data;
late MapShapeSource _shapeSource;
late MapZoomPanBehavior _zoomPanBehavior;

class _MapsState extends State<Maps> {
  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior();
    _data = <Model>[
      Model('North America', 50),
      Model('Asia', 50),
      Model('Australia', 50),
    ];

    _shapeSource = MapShapeSource.asset(
      "assets/world.json",
      shapeDataField: "continent",
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].continent,
      bubbleSizeMapper: (int index) => _data[index].populationDensityPerSqKm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
        child: SfMaps(
          layers: [
            MapShapeLayer(
              // Border width
              strokeWidth: .5,
              // Border Color
              strokeColor: AppColor.mainbackground,
              color: AppColor.boxborder,
              zoomPanBehavior: _zoomPanBehavior,
              source: _shapeSource,

              // legend: MapLegend(
              //   MapElement.bubble,

              //   position: MapLegendPosition.right,
              // ),
              bubbleSettings: MapBubbleSettings(
                strokeColor: AppColor.search,
                strokeWidth: 3,
                color: AppColor.searchbackground,
                // maxRadius: 30,
                // minRadius: 10,
                maxRadius: 12,
                minRadius: 8,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Model {
  const Model(
    this.continent,
    this.populationDensityPerSqKm,
  );
  final String continent;
  final double populationDensityPerSqKm;
}
