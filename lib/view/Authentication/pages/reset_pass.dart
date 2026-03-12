// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';
import 'login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minia_web_project/comman/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                  resetPage(width),
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
          resetPage(height),
          imageLogin(context),
        ],
      ),
    );
  }
}

Container resetPage(height) {
  return Container(
      // color: Colors.amber,
      // height: height > 670 ? height : 670,
      height: 900,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
            LoginText(
              color: AppColor.dark,
              fontWeight: FontWeight.w700,
              size: 18,
              text: "Reset Password",
            ),
            Container(height: 8),
            LoginText(
                color: AppColor.lightdark,
                text: "Reset Password with Minia.",
                size: 14,
                fontWeight: FontWeight.w500),
            Container(height: 35),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.darkGreen.withOpacity(.40),
                  border: Border.all(color: AppColor.darkGreen),
                  borderRadius: BorderRadius.circular(4)),
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                    "Enter your Email and instructions will be sent to you!"),
              ),
            ),
            Container(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: LoginText(
                text: "Email",
                size: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(height: 10),
            AuthFields(hint: "Enter email", obscure: false),
            Container(height: 25),
            InkWell(
              onTap: () {
                Get.offAll(SideBarPage());
              },
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
                            text: "Reset",
                            size: 14,
                            color: AppColor.mainbackground,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Remember It ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.lightgrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: () => Get.to(() => Login()),
                    child: Text(
                      ' Sign In',
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
