// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';
import '../../../comman/colors.dart';
import 'login.dart';

class TwoStepVerify extends StatefulWidget {
  const TwoStepVerify({super.key});

  @override
  State<TwoStepVerify> createState() => _TwoStepVerifyState();
}

class _TwoStepVerifyState extends State<TwoStepVerify> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: width > 750
          ? row(context, height, width)
          : column(context, height, width),
    );
  }

  Row row(BuildContext context, double height, double width) {
    return Row(
      children: [
        Expanded(
            flex: width > 1100
                ? 1
                : width > 1030
                    ? 2
                    : width > 750
                        ? 2
                        : 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  twoStepPage(width, height),
                ],
              ),
            )),
        Expanded(
          flex: width > 1100
              ? 3
              : width > 1030
                  ? 2
                  : width > 750
                      ? 2
                      : 3,
          child: imageLogin(context),
        )
      ],
    );
  }

  SingleChildScrollView column(
      BuildContext context, double height, double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          twoStepPage(height, width),
          imageLogin(context),
        ],
      ),
    );
  }
}

SizedBox twoStepPage(height, width) {
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
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(text: 'Please enter the 4 digit code sent to'),
                    TextSpan(
                      text: ' example@abc.com,',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
            ),
            SizedBox(
              height: 45,
              child: OtpTextField(
                enabledBorderColor: AppColor.lightgrey.withOpacity(.50),
                cursorColor: AppColor.black,
                focusedBorderColor: AppColor.searchbackground,
                borderWidth: .50,
                // numberOfFields: 4,

                // fieldWidth: width < 366
                //     ? 50
                //     : width > 670
                //         ? 50
                //         : width / 5 / 1.toDouble(),
                showFieldAsBox: true,
              ),
            ),
            Container(height: 35),
            InkWell(
              onTap: () => Get.offAll(SideBarPage()),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 38,
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
                            text: "Confirm",
                            size: 14,
                            color: AppColor.mainbackground,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
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
                InkWell(
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
                Spacer(flex: 2),
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
