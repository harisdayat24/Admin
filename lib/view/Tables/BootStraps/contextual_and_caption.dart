// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../../../comman/colors.dart';
import 'basic_and_dark.dart';
import 'border_and_borderless.dart';

class ContextualClasses extends StatelessWidget {
  const ContextualClasses({super.key});

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
                  "Contextual classes",
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
                        'Use contextual classes to color table rows or individual cells.',
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
          child: ColorFull(),
        ),
      ],
    );
  }
}

// captions

class Caption extends StatelessWidget {
  const Caption({super.key});

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
                  "Captions",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                    text: 'A',
                    style: TextStyle(
                      color: AppColor.lightdark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                          text: " <caption>",
                          style: TextStyle(
                            color: AppColor.darkpink,
                            fontSize: 11.3,
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                        text:
                            " functions like a heading for a table. It helps users with screen readers to find a table and understand what it’s about and decide if they want to read it.",
                        style: TextStyle(
                          color: AppColor.lightdark,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 5),
          child: Captionview(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12),
            child: Text(
              "List of users",
              style: TextStyle(color: AppColor.black, fontSize: 14),
            ),
          ),
        )
      ],
    );
  }
}

// Borderless table

class Captionview extends StatelessWidget {
  const Captionview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: HeadingText2(text: "#", textAlign: TextAlign.center)),
              Expanded(flex: 2, child: HeadingText2(text: "First Name")),
              Expanded(flex: 2, child: HeadingText2(text: "Last Name")),
              Expanded(flex: 2, child: HeadingText2(text: "Username")),
            ],
          ),
          Divider(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child:
                        HeadingText2(text: "1", textAlign: TextAlign.center)),
                Expanded(flex: 2, child: InnerText2(text: "Mark")),
                Expanded(flex: 2, child: InnerText2(text: "Otto")),
                Expanded(flex: 2, child: InnerText2(text: "@mdo")),
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
                child: HeadingText2(
                  text: "2",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(flex: 2, child: InnerText2(text: "Jacob")),
              Expanded(flex: 2, child: InnerText2(text: "Thornton")),
              Expanded(flex: 2, child: InnerText2(text: "@fat")),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: HeadingText2(text: "3", textAlign: TextAlign.center)),
              Expanded(flex: 2, child: InnerText2(text: "Larry")),
              Expanded(flex: 2, child: InnerText2(text: "the Bird")),
              Expanded(flex: 2, child: InnerText2(text: "@twitter")),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

class ColorFull extends StatelessWidget {
  const ColorFull({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width < 302
          ? 450
          : width < 510
              ? 420
              : width < 984
                  ? 305
                  : width < 1225
                      ? 420
                      : 350,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    text: "Column heading",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Column heading",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: BasicTexts(
                    text: "Column heading",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 4),
          // newDivider(),
          Container(
            color: AppColor.boxborder,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          newDivider(),
          Container(
            color: AppColor.lightgreen,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          newDivider(),
          Container(
            color: AppColor.mintblue,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
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
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          newDivider(),
          Container(
            color: AppColor.lightyellow,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: BasicTexts(
                      text: "4",
                      textAlign: TextAlign.center,
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider(),
          newDivider(),
          Container(
            color: AppColor.lightred,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: BasicTexts(
                      text: "5",
                      textAlign: TextAlign.center,
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BasicTexts(
                      text: "Column content",
                      size: 15,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          newDivider(),
        ],
      ),
    );
  }

  Container newDivider() => Container(
        height: 1,
        color: AppColor.black.withOpacity(.25),
      );
}
