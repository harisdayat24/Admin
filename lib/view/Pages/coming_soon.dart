// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ComingSoon extends StatefulWidget {
  ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;
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

  // final Duration _duration =
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                "assets/image/coming/bg1.jpg",
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            color: AppColor.searchbackground.withOpacity(0.70),
            child: FittedBox(
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/minia_logo.svg"),
                            Container(width: 10),
                            Text(
                              "Minia",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColor.mainbackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 50),
                    Text(
                      "Let's get started with Minia",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.mainbackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 15),
                    Text(
                      "Donec pede justo fringilla vel aliquet nec vulputate eget arcu. In enim justo, rhoncus ut imperdiet a venenatis vitae, justo felis",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.mainbackground.withOpacity(.40),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 90,
                    ),
                    SlideCountdownSeparated(
                      duration: Duration(
                        days: 275,
                        hours: 23,
                        minutes: 60,
                        seconds: 00,
                      ),
                      slideDirection: SlideDirection.up,
                      style: TextStyle(
                        fontSize: width > 360 ? 25 : 18.0,
                        fontWeight: FontWeight.bold,
                        // color: Colors.amber,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5)),
                      separator: " : ",
                     /* height: 65,
                      width: width > 800 ? width / 10 : width / 8,*/
                      // countUp: true,
                      durationTitle: DurationTitle(
                        days: "Day",
                        hours: "Hours",
                        minutes: "Minutes",
                        seconds: "Seconds",
                      ),
                      // separatorType: SeparatorType.title,

                      separatorStyle:
                          TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Container(height: 70),
                    SizedBox(
                      height: 40,
                      width: 360,
                      child: TextField(
                        style: TextStyle(
                          color: AppColor.hintcolor,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Container(
                              // padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColor.searchbackground,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Icon(
                                size: 14,
                                Icons.send_outlined,
                                color: AppColor.mainbackground,
                              ),
                            ),
                          ),
                          isDense: true,
                          fillColor: AppColor.textfiledcolor,
                          hintText: "Enter your email address",
                          hintStyle: TextStyle(color: AppColor.hintcolor),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          // fillColor: AppColor.lightwhite.withOpacity(.25),
                          // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide:
                                BorderSide(color: AppColor.boxborder, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: AppColor.boxborder),
                          ),
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
    );
  }
}
