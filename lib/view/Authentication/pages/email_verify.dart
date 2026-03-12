// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';
import '../../../comman/colors.dart';
import 'login.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: width > 750 ? row(context, height, width) : column(context, height),
    );
  }

  Row row(BuildContext context, double height, double width) {
    return Row(
      children: [
        Expanded(
            flex: width > 880
                ? 1
                : width > 750
                    ? 1
                    : 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verifyPage(width),
                ],
              ),
            )),
        Expanded(
          flex: width > 880
              ? 3
              : width > 750
                  ? 2
                  : 3,
          child: imageLogin(context),
        )
      ],
    );
  }

  SingleChildScrollView column(BuildContext context, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verifyPage(height),
          imageLogin(context),
        ],
      ),
    );
  }
}

SizedBox verifyPage(height) {
  return SizedBox(
      // color: Colors.amber,
      // height: height > 670 ? height : 670,
      height: 900,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/minia_logo.svg"),
                LoginText(
                  color: AppColor.darkblack,
                  fontWeight: FontWeight.w800,
                  size: 20,
                  text: "Minia",
                ),
              ],
            ),
            Spacer(),
            Container(
                height: 68,
                width: 70,
                padding: EdgeInsets.all(5),
                // margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: AppColor.lightwhite,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.mail,
                  size: 30,
                  color: AppColor.searchbackground,
                )),
            Container(height: 30),
            LoginText(
              color: AppColor.dark,
              fontWeight: FontWeight.w700,
              size: 18,
              text: "Verify your email",
            ),
            Container(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(text: 'We have sent you verification email'),
                    TextSpan(
                      text: ' example@abc.com,',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' Please check it'),
                  ],
                ),
              ),
            ),
            Container(height: 15),
            InkWell(
              onTap: () {
                Get.offAll(SideBarPage());
              },
              child: Container(
                  height: 38,
                  width: 110,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: AppColor.searchbackground),
                    ],
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.searchbackground,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: LoginText(
                      text: "Verify email",
                      size: 14,
                      color: AppColor.mainbackground,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Container(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Didn't receive an email ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.lightgrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      ' Resend',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColor.searchbackground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: LoginText(
                      text: "© 2023 Minia. Crafted with",
                      size: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(width: 4),
                Icon(
                  Icons.favorite,
                  size: 14,
                  color: AppColor.darkred,
                ),
                Container(width: 4),
                Expanded(
                  flex: 3,
                  child: LoginText(
                    text: "by Themesbrand",
                    size: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(height: 20),
          ],
        ),
      ));
}
