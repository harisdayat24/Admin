// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../comman/colors.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: SizedBox(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (width > 600) rowtimeline() else timelines(),
            Container(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 21),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bootstrap Timeline",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                  ),
                  Container(height: 10),
                  Divider(),
                  TimelineTile(
                    afterLineStyle: LineStyle(
                        color: AppColor.searchbackground, thickness: 2),
                    // lineXY: 50,
                    hasIndicator: true,
                    isFirst: true,
                    alignment: TimelineAlign.center,
                    indicatorStyle: IndicatorStyle(
                      // drawGap: true,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.searchbackground,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "START",
                            style: TextStyle(
                              color: AppColor.mainbackground,
                            ),
                          ),
                        ),
                      ),
                      height: 80,
                      width: 80,
                    ),
                  ),
                  LeftTimeline(
                    picture: "assets/svg/timeline/b1.svg",
                    title: 'Timeline Event One',
                    description:
                        'Perspitis unde omnis it voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae explicabo.',
                  ),
                  RightTimeline(
                    picture: "assets/svg/timeline/b2.svg",
                    title: 'Timeline Event two',
                    description:
                        'At vero eos dignissimos ducimus quos dolores chooses to enjoy pleasure that has no annoying.',
                  ),
                  LeftTimeline(
                    picture: "assets/svg/timeline/b3.svg",
                    title: 'Timeline Event Three',
                    description:
                        'Vivamus ultrices massa turna interdum eu. Pellentesque habitant morbi tristique eget justo sit amet est varius mollis et quis nisi. Suspendisse potenti. senectus et netus et malesuada fames ac turpis egestas.',
                  ),
                  RightTimeline(
                    picture: "assets/svg/timeline/b4.svg",
                    title: 'Timeline Event Four',
                    description:
                        "'Printing and typesetting industry. been the industry'scrambled it make a type specimen book.'",
                  ),
                  LeftTimeline(
                    picture: "assets/svg/timeline/b5.svg",
                    title: 'Timeline Event Five',
                    description:
                        'Excepturi, obcaecati, quisquam id molestias eaque asperiores voluptatibus cupiditate error assumenda delectus odit similique earum voluptatem Odit, itaque, deserunt corporis vero ipsum nisi repellat ... Read more',
                  ),
                  RightTimeline(
                    picture: "assets/svg/timeline/b6.svg",
                    title: 'Timeline Event End',
                    description:
                        'Suspendisse tempor porttitor elit non maximus. Sed suscipit, purus in convallis condimentum, risus ex pellentesque sapien, vel tempor arcu dolor ut est. Nam ac felis id mauris fermentum nisl pharetra auctor.',
                  ),
                  TimelineTile(
                    beforeLineStyle: LineStyle(
                        color: AppColor.searchbackground, thickness: 2),
                    // lineXY: 50,
                    hasIndicator: true,
                    isLast: true,
                    alignment: TimelineAlign.center,
                    indicatorStyle: IndicatorStyle(
                      color: AppColor.darkred,
                      // drawGap: true,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.searchbackground,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "END",
                            style: TextStyle(
                              color: AppColor.mainbackground,
                            ),
                          ),
                        ),
                      ),
                      height: 80,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightTimeline extends StatelessWidget {
  final String picture;
  final String title;
  final String description;
  const RightTimeline({
    super.key,
    required this.picture,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 800,
      child: TimelineTile(
        afterLineStyle:
            LineStyle(color: AppColor.searchbackground, thickness: 2),
        beforeLineStyle:
            LineStyle(color: AppColor.searchbackground, thickness: 2),
        startChild: Container(
          color: AppColor.boxborder,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      description,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        endChild: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              picture,
            ),
          ),
        ),
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          color: AppColor.searchbackground,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}

class LeftTimeline extends StatelessWidget {
  final String picture;
  final String title;
  final String description;
  const LeftTimeline({
    super.key,
    required this.picture,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      width: 800,
      child: TimelineTile(
        afterLineStyle:
            LineStyle(color: AppColor.searchbackground, thickness: 2),
        beforeLineStyle:
            LineStyle(color: AppColor.searchbackground, thickness: 2),
        endChild: Container(
          color: AppColor.boxborder,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      description,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        startChild: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(picture),
          ),
        ),
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          color: AppColor.searchbackground,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}

Row rowtimeline() {
  return Row(
    children: [
      Text(
        "Timeline",
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
        "Timeline",
        style: TextStyle(
          color: AppColor.lightdark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Column timelines() {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Timeline",
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
            "Timeline",
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
