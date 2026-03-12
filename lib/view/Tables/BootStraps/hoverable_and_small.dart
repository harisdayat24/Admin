// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../comman/colors.dart';
import 'basic_and_dark.dart';

class HoverableRows extends StatelessWidget {
  const HoverableRows({super.key});

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
                  "HoverableRows",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                      text: 'Add',
                      style: TextStyle(
                        color: AppColor.lightdark,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' .table-hover',
                          style: TextStyle(
                            color: AppColor.darkpink,
                            fontSize: 11.3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' to enable a hover state on table rows within a',
                          style: TextStyle(
                            color: AppColor.lightdark,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' <tbody> .',
                          style: TextStyle(
                            color: AppColor.darkpink,
                            fontSize: 11.3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: BasicExample(),
        ),
      ],
    );
  }
}

// # small

class SmallTable extends StatelessWidget {
  const SmallTable({super.key});

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
                  "Small table",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                    text: 'Add',
                    style: TextStyle(
                      color: AppColor.lightdark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' .table-sm',
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' to make tables more compact by cutting cell padding in half.',
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
          child: Smallest(),
        ),
      ],
    );
  }
}

// small
class Smallest extends StatelessWidget {
  const Smallest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 8),
          SizedBox(
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
                    text: "Username",
                    size: 15,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                flex: 2,
                child: BasicTexts(
                  text: "@mdo",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
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
                flex: 2,
                child: BasicTexts(
                  text: "@fat",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
                flex: 2,
                child: BasicTexts(
                  text: "@twitter",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
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
                flex: 2,
                child: BasicTexts(
                  text: "@mdo",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
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
                flex: 2,
                child: BasicTexts(
                  text: "@fat",
                  size: 15,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
