// captions

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../../comman/colors.dart';
import 'border_and_borderless.dart';

class Responsivetable extends StatelessWidget {
  const Responsivetable({super.key});

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
                  "Responsive table",
                  style: TextStyle(
                    fontSize: 15.4,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 6),
                RichText(
                  text: TextSpan(
                    text: 'Create responsive tables by wrapping any',
                    style: TextStyle(
                      color: AppColor.lightdark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: " .table",
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: " in",
                        style: TextStyle(
                          color: AppColor.lightdark,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: " .table-responsive",
                        style: TextStyle(
                          color: AppColor.darkpink,
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            "  to make them scroll horizontally on small devices (under 768px).",
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
        width > 768 ? RowRespons(width) : ColumnRespons(width),
      ],
    );
  }

  Scrollbar ColumnRespons(double width) {
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 350,
                width: width,
                child: Table(
                  // border: TableBorder(left: BorderSide.none),
                  border:
                      TableBorder(left: BorderSide(color: AppColor.boxborder)),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.boxborder),
                      ),
                      children: [
                        HeadText(text: '#'),
                        Tableheading(),
                        Tableheading(),
                        Tableheading(),
                        Tableheading(),
                        Tableheading(),
                        Tableheading(),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.boxborder),
                        ),
                      ),
                      children: [
                        HeadText(text: '1'),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.boxborder),
                        ),
                      ),
                      children: [
                        HeadText(text: '2'),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.boxborder),
                        ),
                      ),
                      children: [
                        HeadText(text: '3'),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                        Tablecelltext(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding RowRespons(double width) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 200,
        width: width,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          // border: TableBorder(left: BorderSide.none),
          border: TableBorder(left: BorderSide(color: AppColor.boxborder)),
          children: [
            TableRow(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: HeadText(text: '#'),
                ),
                Tableheading(),
                Tableheading(),
                Tableheading(),
                Tableheading(),
                Tableheading(),
                Tableheading(),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadText(text: '1'),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Tablecelltext(),
                ),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadText(text: '2'),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Tablecelltext(),
                ),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              children: [
                HeadText(text: '3'),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Tablecelltext(),
                ),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
                Tablecelltext(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeadText extends StatelessWidget {
  final String text;
  const HeadText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
        ));
  }
}

class Tableheading extends StatelessWidget {
  const Tableheading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 30.0, bottom: 15.0, right: 8.0),
      child: Text(
        "Table heading",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),
      ),
    );
  }
}

class Tablecelltext extends StatelessWidget {
  const Tablecelltext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Table cell",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

class Responsivetableview extends StatelessWidget {
  const Responsivetableview({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: width > 450
          ? 250
          : width > 345
              ? 300
              : 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: HeadingText2(text: "#", textAlign: TextAlign.center)),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
              Expanded(flex: 2, child: HeadingText2(text: "Table heading")),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: HeadingText2(text: "1", textAlign: TextAlign.center)),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
            ],
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
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
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
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
              Expanded(flex: 2, child: InnerText2(text: "Table cell")),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
