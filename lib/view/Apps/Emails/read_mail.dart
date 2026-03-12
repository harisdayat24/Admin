// import 'package:universal_html/html.dart' as html;

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_web_libraries_in_flutter, non_constant_identifier_names

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/view/Apps/Emails/emailview.dart';
// import 'package:universal_html/html.dart';

class Readmail extends StatelessWidget {
  const Readmail({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return readmails(width, height);
  }

  Container readmails(double width, double height) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.boxborder),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Emailbuttons(),
            Container(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/image/avatar.png",
                  fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                ),
                Container(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Humberto D. Champion",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dark,
                      ),
                    ),
                    Text(
                      "support@domin.com",
                      style: TextStyle(
                        fontSize: 11.2,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgrey,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(height: 26),
            Text(
              "This Week's Top Stories",
              style: TextStyle(
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Container(height: 10),
            Text(
              """
Dear Lorem Ipsum,
      
Praesent dui ex, dapibus eget mauris ut, finibus vestibulum enim. Quisque arcu leo, facilisis in fringilla id, luctus in tortor. Nunc vestibulum est quis orci varius viverra. Curabitur dictum volutpat massa vulputate molestie. In at felis ac velit maximus convallis.
      
Sed elementum turpis eu lorem interdum, sed porttitor eros commodo. Nam eu venenatis tortor, id lacinia diam. Sed aliquam in dui et porta. Sed bibendum orci non tincidunt ultrices. Vivamus fringilla, mi lacinia dapibus condimentum, ipsum urna lacinia lacus, vel tincidunt mi nibh sit amet lorem.
      
Sincerly,""",
              style: TextStyle(
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
                // fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                fontSize: 14,
              ),
            ),
            Container(height: 10),
            Divider(),
            Container(height: 10),
            Row(
              children: [
                width > 465 ? LeftImage() : Expanded(child: LeftImage()),
                Container(width: 12),
                width > 465 ? RightImage() : Expanded(child: RightImage()),
              ],
            ),
            Container(height: 40),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: .99,
                        offset: Offset(1, 1),
                        color: AppColor.searchbackground),
                  ],
                  color: AppColor.lightgrey,
                  borderRadius: BorderRadius.circular(5)),
              height: 40,
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.reply,
                        color: AppColor.mainbackground,
                        size: 15,
                      )),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Reply",
                      style: TextStyle(
                        color: AppColor.mainbackground,
                      ),
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

  Container RightImage() {
    return Container(
      height: 160,
      width: 185,
      decoration: BoxDecoration(border: Border.all(color: AppColor.boxborder)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        // fit: StackFit.passthrough,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/image/tree.jpg",
              fit: BoxFit.cover,
              // height: 130,
              // width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: InkWell(
                // onTap: () => downloadfile("assets/image/tree.jpg"),
                child: Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.searchbackground,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container LeftImage() {
    return Container(
      height: 160,
      width: 185,
      decoration: BoxDecoration(border: Border.all(color: AppColor.boxborder)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        // fit: StackFit.passthrough,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/image/image1.jpg",
              fit: BoxFit.cover,
              // height: 130,
              // width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: InkWell(
                // onTap: () => downloadfile("assets/image/image1.jpg"),
                child: Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.searchbackground,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // downloadfile(url) {
  //   AnchorElement anchorElement = AnchorElement(href: url);
  //   anchorElement.download = "image";
  //   anchorElement.click();
  // }
}
