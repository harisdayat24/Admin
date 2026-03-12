// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';
import '../../../comman/colors.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: width > 750
            ? row(context, height, width)
            : column(context, height));
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
                registerfileds(width),
              ],
            ),
          ),
        ),
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
          registerfileds(height),
          imageLogin(context),
        ],
      ),
    );
  }
}

Container registerfileds(height) {
  return Container(
      // color: Colors.amber,
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
              text: "Register Account",
            ),
            Container(height: 8),
            LoginText(
                color: AppColor.lightdark,
                text: "Get your free Minia account now.",
                size: 14,
                fontWeight: FontWeight.w500),
            Container(height: 35),
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
            Container(height: 17),
            Align(
              alignment: Alignment.centerLeft,
              child: LoginText(
                text: "Username",
                size: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(height: 10),
            AuthFields(hint: "Enter username", obscure: false),
            Container(height: 17),
            Align(
              alignment: Alignment.centerLeft,
              child: LoginText(
                text: "Password",
                size: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(height: 10),
            AuthFields(hint: "Enter password", obscure: true),
            Container(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "By registering you agree to the Minia ",
                      overflow: TextOverflow.clip,
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
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Terms of Use',
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
                Spacer(flex: 1),
              ],
            ),
            Container(height: 25),
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
                            text: "Register",
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
            LoginText(
              text: "- Sign up using -",
              size: 14,
              color: AppColor.lightgrey,
              fontWeight: FontWeight.w500,
            ),
            Container(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/facebook.svg"),
                Container(width: 11),
                SvgPicture.asset("assets/svg/twitter.svg"),
                Container(width: 11),
                SvgPicture.asset("assets/svg/google.svg")
              ],
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
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.lightgrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(() => Login()),
                  child: Text(
                    ' Login',
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
