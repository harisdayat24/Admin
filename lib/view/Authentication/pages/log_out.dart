// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/view/Authentication/pages/sign_up.dart';

import '../../../comman/colors.dart';
import 'login.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

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
                  lockPage(width),
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
          lockPage(height),
          imageLogin(context),
        ],
      ),
    );
  }
}

SizedBox lockPage(height) {
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
                height: 80,
                width: 80,
                padding: EdgeInsets.all(5),
                // margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: AppColor.lightwhite.withOpacity(.50),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.person_sharp,
                  size: 30,
                  color: AppColor.searchbackground,
                )),
            Container(height: 30),
            LoginText(
              color: AppColor.dark,
              fontWeight: FontWeight.w700,
              size: 18,
              text: "You are Logged Out",
            ),
            Container(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginText(
                    color: AppColor.lightdark,
                    text: "Thank you for using",
                    size: 14,
                    fontWeight: FontWeight.w500),
                LoginText(
                    color: AppColor.darkblack,
                    text: " Minia",
                    size: 14,
                    fontWeight: FontWeight.w900),
              ],
            ),
            Container(height: 15),
            InkWell(
              onTap: () => Get.to(() => Login()),
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
                            text: "Sign In",
                            size: 14,
                            color: AppColor.mainbackground,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Don't have an account ?",
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
                    onTap: () => Get.to(() => Signup()),
                    child: Text(
                      ' Signup',
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
