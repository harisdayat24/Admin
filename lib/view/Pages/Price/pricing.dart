// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minia_web_project/view/Pages/Price/table_price.dart';
import '../../../comman/colors.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

var selecting = "first";

class _PricingState extends State<Pricing> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 2;
  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  @override
  void initState() {
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          if (width > 600) rowPricing() else columnPricing(),
          Container(height: 20),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxborder),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: mothlyplanName(),
                    ),
                    // Container(height: 20),
                    underLine(),
                    Container(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: monthlyplan(width),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.boxborder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "Project Plans",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 6),
                  child: Text(
                    "Call to action pricing table is really crucial to your for your business website. Make your bids stand-out with amazing options.",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightdark),
                  ),
                ),
                Container(height: 15),
                Divider(),
                width > 1201
                    ? Row(
                        children: [
                          Expanded(flex: 1, child: planNames(width)),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 12.0),
                              child: Container(
                                // width: 500,
                                child: currentTabIndex == 0
                                    ? table99()
                                    : currentTabIndex == 2
                                        ? table29()
                                        : table79(),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: planNames(width)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20.0, top: 20.0),
                            child: Container(
                              child: currentTabIndex == 0
                                  ? table99()
                                  : currentTabIndex == 2
                                      ? table29()
                                      : table79(),
                            ),
                          ),
                        ],
                      ),
                Container(height: 20)
              ],
            ),
          ),
        ],
      ),
    );
  }

  RotatedBox planNames(double width) {
    return RotatedBox(
      quarterTurns: 3,
      // quarterTurns: 1,
      child: SizedBox(
        // color: Colors.amber,
        // height: width,
        width: width < 420
            ? 410
            : width < 580
                ? 350
                : width < 1202
                    ? 300
                    : width < 1420
                        ? 550
                        : 360,
        child: TabBar(
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding:
              EdgeInsets.only(left: 5, right: 10, top: 20, bottom: 20),
          controller: tabController,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          tabs: [
            Tab(
              height: width,
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  // width: width,
                  // height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: currentTabIndex == 0
                        ? AppColor.searchbackground
                        : AppColor.boxborder,
                  )),
                  child: Row(
                    children: [
                      Container(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/pricing/check_circle_black.svg",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  pricingText(
                                    text: "\$99 ",
                                    fontSize: 25,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Expanded(
                                    child: pricingText(
                                      text: "/ Month Plans ",
                                      fontSize: 13,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "For extra large business or those in regulated industries",
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Tab(
              height: width,
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  // width: width,
                  // height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: currentTabIndex == 1
                        ? AppColor.searchbackground
                        : AppColor.boxborder,
                  )),
                  child: Row(
                    children: [
                      Container(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/pricing/check_circle_black.svg",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  pricingText(
                                    text: "\$79 ",
                                    fontSize: 25,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Expanded(
                                    child: pricingText(
                                      text: "/ Month Plans ",
                                      fontSize: 13,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "For larger businesses or those with onal administration needs",
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Tab(
              height: width,
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  // width: width,
                  // height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: currentTabIndex == 2
                        ? AppColor.searchbackground
                        : AppColor.boxborder,
                  )),
                  child: Row(
                    children: [
                      Container(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/pricing/check_circle_black.svg",
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    pricingText(
                                      text: "\$29 ",
                                      fontSize: 25,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Expanded(
                                      child: pricingText(
                                        text: "/ Month Plans ",
                                        fontSize: 13,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "For small teams trying out Minia for an unlimited period of time",
                                overflow: TextOverflow.clip,
                                // maxLines: 3,
                                // softWrap: false,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView monthlyplan(double width) {
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 1200
            ? 4
            : width > 590
                ? 2
                : 1,
        // childAspectRatio: 50,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        mainAxisExtent: width < 306
            ? 700
            : width < 340
                ? 650
                : width < 365
                    ? 600
                    : width < 591
                        ? 540
                        : width < 620
                            ? 620
                            : width < 655
                                ? 570
                                : width < 1201
                                    ? 550
                                    : width < 1260
                                        ? 700
                                        : width < 1360
                                            ? 650
                                            : width < 1415
                                                ? 620
                                                : width < 1490
                                                    ? 570
                                                    : width < 1500
                                                        ? 550
                                                        : 550,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: index == 2
                  ? AppColor.searchbackground
                  : AppColor.textfiledcolor.withOpacity(.25),
              border: Border.all(
                color: AppColor.boxborder,
              )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pricingText(
                  text: "Starter",
                  color: index == 2 ? AppColor.mainbackground : AppColor.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                Container(height: 14),
                Row(
                  children: [
                    pricingText(
                      text: selecting == "first"
                          ? (index == 0)
                              ? "\$29 "
                              : (index == 1)
                                  ? "\$49 "
                                  : (index == 2)
                                      ? "\$79 "
                                      : (index == 3)
                                          ? "\$99 "
                                          : "\$0"
                          : (index == 0)
                              ? "\$129 "
                              : (index == 1)
                                  ? "\$149 "
                                  : (index == 2)
                                      ? "\$179 "
                                      : (index == 3)
                                          ? "\$199 "
                                          : "\$0",
                      fontSize: 35,
                      color:
                          index == 2 ? AppColor.mainbackground : AppColor.dark,
                      fontWeight: FontWeight.bold,
                    ),
                    pricingText(
                      text: selecting == "first" ? " /  Month" : " /  Yearly",
                      fontSize: 15,
                      color:
                          index == 2 ? AppColor.mainbackground : AppColor.dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Container(height: 19),
                pricingText(
                  text: (index == 1)
                      ? "For larger businesses or those with onal administration needs"
                      : (index == 2)
                          ? "For extra large businesses or those in regulated industries"
                          : "For small teams trying out Minia for an unlimited period of time",
                  color: index == 2
                      ? AppColor.mainbackground.withOpacity(.50)
                      : AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
                Container(height: 38),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Verifide work and reviews",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 23),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Dedicated Ac managers",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 23),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Unlimited proposals",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 23),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Project tracking",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 23),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Dedicated Ac managers",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 23),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/true.svg",
                      color: index == 2
                          ? AppColor.mainbackground.withOpacity(.70)
                          : null,
                    ),
                    Container(width: 9),
                    Expanded(
                      child: pricingText(
                        text: "Unlimited proposals",
                        color: index == 2
                            ? AppColor.mainbackground
                            : AppColor.dark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(height: 34),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: index == 2 ? AppColor.lightwhite : null,
                          border: Border.all(
                              color: index == 2
                                  ? AppColor.lightwhite
                                  : AppColor.searchbackground),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: pricingText(
                            text: "Choose Plan",
                            color: index == 2
                                ? AppColor.black
                                : AppColor.searchbackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Row underLine() {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 2,
          color: AppColor.boxborder,
        )),
        Container(
            height: 2,
            width: 75,
            color: selecting == "first"
                ? AppColor.searchbackground
                : Color.fromRGBO(233, 233, 239, 1)),
        Container(
            height: 2,
            width: 70,
            color: selecting == "first"
                ? AppColor.boxborder
                : AppColor.searchbackground),
      ],
    );
  }

  Row mothlyplanName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Start your creative project right plans",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.44,
              ),
            ),
          ),
        ),
        // Spacer(),
        InkWell(
          onTap: () {
            setState(() {
              selecting = "first";
            });
          },
          child: SizedBox(
            height: 60,
            width: 75,
            child: Center(
              child: Text(
                "Monthly",
                style: TextStyle(
                  color: selecting == "first"
                      ? AppColor.searchbackground
                      : AppColor.dark,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selecting = "sec";
            });
          },
          child: SizedBox(
            height: 60,
            width: 70,
            child: Center(
              child: Text(
                "Yearly",
                style: TextStyle(
                  color: selecting == "sec"
                      ? AppColor.searchbackground
                      : AppColor.dark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row rowPricing() {
    return Row(
      children: [
        Text(
          "Pricing",
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
          "Pricing",
          style: TextStyle(
            color: AppColor.lightdark,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Column columnPricing() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Pricing",
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
              "Pricing",
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
}

class pricingText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const pricingText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      // softWrap: false,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  // Widget _tabSection(BuildContext context) {
  //   return DefaultTabController(
  //     length: 3,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Container(
  //           child: TabBar(
  //             tabs: [
  //               Tab(text: "Home"),
  //               Tab(text: "Articles"),
  //               Tab(text: "User"),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           //Add this to give height
  //           height: MediaQuery.of(context).size.height,
  //           child: TabBarView(children: [
  //             Container(
  //               child: Text("Home Body"),
  //             ),
  //             Container(
  //               child: Text("Articles Body"),
  //             ),
  //             Container(
  //               child: Text("User Body"),
  //             ),
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
