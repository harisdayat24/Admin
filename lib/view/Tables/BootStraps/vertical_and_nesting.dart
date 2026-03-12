// # Table head
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:minia_web_project/view/Tables/BootStraps/basic_and_dark.dart';
import '../../../comman/colors.dart';
import 'border_and_borderless.dart';

class VerticalA extends StatelessWidget {
  const VerticalA({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vertical alignment",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                    text: "Table cells in",
                    style: TextStyle(
                      color: AppColor.lightdark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '  <tbody>',
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ' inherit their alignment from',
                        style: TextStyle(
                          color: AppColor.lightdark,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '  <table>',
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' and are aligned to the the top by default. Use the vertical align classes to re-align where needed.',
                        style: TextStyle(
                          color: AppColor.lightdark,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Vertical(),
        ),
      ],
    );
  }
}

//  vertical
class Vertical extends StatelessWidget {
  const Vertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: AppColor.boxborder,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: BasicTexts(
                      text: "#",
                      textAlign: TextAlign.center,
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "First Name",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Last Name",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Action",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: BasicTexts(
                    text: "1",
                    textAlign: TextAlign.center,
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Mark",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Otto",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: AppColor.boxborder,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "view",
                        style: TextStyle(color: AppColor.black),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: BasicTexts(
                    text: "2",
                    textAlign: TextAlign.center,
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Jacob",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Thornton",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: AppColor.boxborder,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "view",
                        style: TextStyle(color: AppColor.black),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: BasicTexts(
                  text: "3",
                  textAlign: TextAlign.center,
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                flex: 2,
                child: BasicTexts(
                  text: "Larry",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                flex: 2,
                child: BasicTexts(
                  text: "the Bird",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 30,
                  color: AppColor.boxborder,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "view",
                      style: TextStyle(color: AppColor.black),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

// Nesting

class NestingView extends StatelessWidget {
  const NestingView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nesting",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                    text:
                        "Border styles, active styles, and table variants are not inherited by nested tables.",
                    style: TextStyle(
                      color: AppColor.lightdark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Nesting(),
        ),
      ],
    );
  }
}

class Nesting extends StatelessWidget {
  const Nesting({super.key});

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Table(
            border: TableBorder(left: BorderSide.none),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxborder),
                ),
                children: [
                  HeadingText(text: "#"),
                  HeadingText(text: "First Name"),
                  HeadingText(text: "Last Name"),
                  HeadingText(text: "Handle")
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColor.boxborder),
                    bottom: BorderSide(color: AppColor.boxborder),
                  ),
                ),
                children: [
                  HeadingText(text: "1"),
                  InnerText(text: "Mark"),
                  InnerText(text: "Otto"),
                  InnerText(text: "@mdo")
                ],
              ),
            ],
          ),
        ),
        Table(
          // border: TableBorder(left: BorderSide.none),
          children: [
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.boxborder),
                  left: BorderSide(color: AppColor.boxborder),
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadingText(text: "Header"),
                InnerText(text: "A"),
                InnerText(text: "First"),
                InnerText(text: "Last"),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColor.boxborder),
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadingText(text: "Header"),
                InnerText(text: "B"),
                InnerText(text: "First"),
                InnerText(text: "Last"),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColor.boxborder),
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadingText(text: "Header"),
                InnerText(text: "Larry"),
                InnerText(text: "the Bird	"),
                InnerText(text: "@twitter"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
