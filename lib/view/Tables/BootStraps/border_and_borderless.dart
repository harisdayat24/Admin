// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
// # Bordered table

class Borderedtable extends StatelessWidget {
  const Borderedtable({super.key});

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
                  "Bordered table",
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
                        text: ' .table-bordered',
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            '  for borders on all sides of the table and cells.',
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
                  HeadingText(text: "Username")
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
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColor.boxborder),
                    bottom: BorderSide(color: AppColor.boxborder),
                  ),
                ),
                children: [
                  HeadingText(text: "2"),
                  InnerText(text: "Jacob"),
                  InnerText(text: "Thornton"),
                  InnerText(text: "@fat"),
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
                  HeadingText(text: "3"),
                  InnerText(text: "Larry"),
                  InnerText(text: "the Bird	"),
                  InnerText(text: "@twitter"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// # Borderless table

class Borderless extends StatelessWidget {
  const Borderless({super.key});

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
                  "Borderless table",
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
                        text: ' .table-borderless ',
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '  for a table without borders.',
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
          padding: const EdgeInsets.all(15.0),
          child: Borderlesstable(),
        ),
      ],
    );
  }
}

// Borderless table

class Borderlesstable extends StatelessWidget {
  const Borderlesstable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Divider(),
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child:
                        HeadingText2(text: "3", textAlign: TextAlign.center)),
                Expanded(flex: 2, child: InnerText2(text: "Larry")),
                Expanded(flex: 2, child: InnerText2(text: "the Bird")),
                Expanded(flex: 2, child: InnerText2(text: "@twitter")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  final TextAlign? textAlign;
  const HeadingText({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColor.boxborder),
          right: BorderSide(color: AppColor.boxborder),
          bottom: BorderSide(color: AppColor.boxborder),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 15,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class InnerText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const InnerText({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColor.boxborder),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 15,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class HeadingText2 extends StatelessWidget {
  final String text;

  final TextAlign? textAlign;
  const HeadingText2({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 15,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class InnerText2 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const InnerText2({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 15,
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
