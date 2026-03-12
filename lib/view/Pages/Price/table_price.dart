// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../comman/colors.dart';

Widget table29() {
  return Table(
    border: TableBorder(left: BorderSide.none),
    children: [
      TableRow(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.boxborder),
        ),
        children: [
          TitleTableRow1(text: ''),
          TitleTableRow1(text: '1 Month'),
          TitleTableRow1(text: '3 Month'),
          TitleTableRow1(text: '6 Month'),
          TitleTableRow1(text: '1 Year'),
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
          LeftTableTitle(text: "User"),
          TitleTableRow2(text: '1'),
          TitleTableRow2(text: '3'),
          TitleTableRow2(text: '5'),
          TitleTableRow2(text: '7'),
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
          LeftTableTitle(text: "Storage"),
          TitleTableRow2(text: '1 GB'),
          TitleTableRow2(text: '10 GB'),
          TitleTableRow2(text: '20 GB'),
          TitleTableRow2(text: '40 GB'),
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
          LeftTableTitle(text: "Domain"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          TitleTableRow2(text: '1 '),
          TitleTableRow2(text: '2'),
          TitleTableRow2(text: '4'),
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
          LeftTableTitle(text: "Hidden \nFees"),
          TitleTableRow2(text: 'Yes'),
          TitleTableRow2(text: 'Yes'),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
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
          LeftTableTitle(text: "Support"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
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
          LeftTableTitle(text: "Update"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
        ],
      ),
    ],
  );
}

Widget table79() {
  return Table(
    border: TableBorder(left: BorderSide.none),
    children: [
      TableRow(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.boxborder),
        ),
        children: [
          TitleTableRow1(text: ''),
          TitleTableRow1(text: '1 Month'),
          TitleTableRow1(text: '3 Month'),
          TitleTableRow1(text: '6 Month'),
          TitleTableRow1(text: '1 Year'),
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
          LeftTableTitle(text: "User"),
          TitleTableRow2(text: '1'),
          TitleTableRow2(text: '3'),
          TitleTableRow2(text: '5'),
          TitleTableRow2(text: '7'),
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
          LeftTableTitle(text: "Storage"),
          TitleTableRow2(text: '5 GB'),
          TitleTableRow2(text: '15 GB'),
          TitleTableRow2(text: '25 GB'),
          TitleTableRow2(text: '50 GB'),
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
          LeftTableTitle(text: "Domain"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          TitleTableRow2(text: '3'),
          TitleTableRow2(text: '4'),
          TitleTableRow2(text: '8'),
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
          LeftTableTitle(text: "Hidden \nFees"),
          TitleTableRow2(text: 'Yes'),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
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
          LeftTableTitle(text: "Support"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
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
          LeftTableTitle(text: "Update"),
          PlansSign(icon: "assets/svg/pricing/close_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
        ],
      ),
    ],
  );
}

Widget table99() {
  return Table(
    border: TableBorder(left: BorderSide.none),
    children: [
      TableRow(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.boxborder),
        ),
        children: [
          TitleTableRow1(text: ''),
          TitleTableRow1(text: '1 Month'),
          TitleTableRow1(text: '3 Month'),
          TitleTableRow1(text: '6 Month'),
          TitleTableRow1(text: '1 Year'),
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
          LeftTableTitle(text: "User"),
          TitleTableRow2(text: '1'),
          TitleTableRow2(text: '3'),
          TitleTableRow2(text: '5'),
          TitleTableRow2(text: '7'),
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
          LeftTableTitle(text: "Storage"),
          TitleTableRow2(text: '5 GB'),
          TitleTableRow2(text: '30 GB'),
          TitleTableRow2(text: '50 GB'),
          TitleTableRow2(text: '100 GB'),
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
          LeftTableTitle(text: "Domain"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          TitleTableRow2(text: '3'),
          TitleTableRow2(text: '5'),
          TitleTableRow2(text: '10'),
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
          LeftTableTitle(text: "Hidden \nFees"),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
          TitleTableRow2(text: 'No'),
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
          LeftTableTitle(text: "Support"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
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
          LeftTableTitle(text: "Update"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
          PlansSign(icon: "assets/svg/pricing/check_circle.svg"),
        ],
      ),
    ],
  );
}

class PlansSign extends StatelessWidget {
  final String icon;

  const PlansSign({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColor.boxborder),
        ),
      ),
      height: 48,
      child: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(icon),
      ),
    );
  }
}

class LeftTableTitle extends StatelessWidget {
  final String text;

  const LeftTableTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: AppColor.boxborder)),
      ),
      height: 48,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}

class TitleTableRow1 extends StatelessWidget {
  final String text;

  const TitleTableRow1({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: AppColor.boxborder)),
      ),
      height: 77,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}

class TitleTableRow2 extends StatelessWidget {
  final String text;

  const TitleTableRow2({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColor.boxborder),
        ),
      ),
      height: 48,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}
