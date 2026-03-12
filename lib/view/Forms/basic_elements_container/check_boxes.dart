// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../comman/colors.dart';

class FormCheckboxes extends StatefulWidget {
  const FormCheckboxes({super.key});

  @override
  State<FormCheckboxes> createState() => _FormCheckboxesState();
}

class _FormCheckboxesState extends State<FormCheckboxes> {
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valuefour = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 21, bottom: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkboxes",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 20),
        width > 700
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 15),
                  Expanded(child: LeftCHecks()),
                  Container(width: 10),
                  Expanded(child: RightCHecks()),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20),
                    LeftCHecks(),
                    Container(height: 10),
                    RightCHecks(),
                  ],
                ),
              ),
        Container(height: 20),
      ],
    );
  }

  Column RightCHecks() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Form Checkboxes Right",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                "   Form Checkbox Right",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(width: 5),
            Checkbox(
                checkColor: AppColor.mainbackground,
                activeColor: AppColor.searchbackground,
                value: valuethird,
                onChanged: (value) {
                  setState(() {
                    valuethird = value!;
                  });
                }),
            Container(width: 15),
          ],
        ),
        Container(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(
                "   Form Checkbox Right checked",
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Container(width: 5),
            Checkbox(
                checkColor: AppColor.mainbackground,
                activeColor: AppColor.searchbackground,
                value: valuefour,
                onChanged: (value) {
                  setState(() {
                    valuefour = value!;
                  });
                }),
            Container(width: 15),
          ],
        ),
      ],
    );
  }

  Column LeftCHecks() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Form Checkboxes",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          children: [
            Checkbox(
                checkColor: AppColor.mainbackground,
                activeColor: AppColor.searchbackground,
                value: valuefirst,
                onChanged: (value) {
                  setState(() {
                    valuefirst = value!;
                  });
                }),
            Container(width: 5),
            Text(
              "Form Checkbox",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(height: 5),
        Row(
          children: [
            Checkbox(
                checkColor: AppColor.mainbackground,
                activeColor: AppColor.searchbackground,
                value: valuesec,
                onChanged: (value) {
                  setState(() {
                    valuesec = value!;
                  });
                }),
            Container(width: 5),
            Text(
              "Form Checkbox checked",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Radios //
class Radiosbutton extends StatefulWidget {
  const Radiosbutton({super.key});

  @override
  State<Radiosbutton> createState() => _RadiosbuttonState();
}

class _RadiosbuttonState extends State<Radiosbutton> {
  bool valuefirst = false;
  bool valuesec = false;
  bool valuethird = false;
  bool valuefour = false;

  // static const String _title = 'Radio Button Example';
  String gender = "male";
  String odd = "true";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
            color: AppColor.boxborder,
          )),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 21, bottom: 22, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Radios",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 20),
        width > 700
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 15),
                  Expanded(child: LeftRadios()),
                  Container(width: 10),
                  Expanded(child: RightCHecks()),
                  Container(width: 15),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20),
                    LeftRadios(),
                    Container(height: 10),
                    RightCHecks(),
                  ],
                ),
              ),
        Container(height: 12),
      ],
    );
  }

  Column LeftRadios() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Form Radios",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(height: 10),
        RadioListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Form Radio",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          value: "male",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
        RadioListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Form Radio checked",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          value: "female",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
      ],
    );
  }

  Widget RightCHecks() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Form Radios Right",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(height: 10),
        RadioListTile(
          dense: true,
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "   Form Radio",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          value: "true",
          groupValue: odd,
          onChanged: (value) {
            setState(() {
              odd = value.toString();
            });
          },
        ),
        RadioListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "   Form Radio checked",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          value: "false",
          groupValue: odd,
          onChanged: (value) {
            setState(() {
              odd = value.toString();
            });
          },
        ),
      ],
    );
  }
}

// Switch //
class SwitchesButtons extends StatefulWidget {
  const SwitchesButtons({super.key});

  @override
  State<SwitchesButtons> createState() => _SwitchesButtonsState();
}

class _SwitchesButtonsState extends State<SwitchesButtons> {
  bool value = true;
  bool value3 = true;
  bool value4 = false;
  bool value5 = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(height: 20),
        width > 700
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 15),
                  Expanded(child: LeftCHecks()),
                  Container(width: 10),
                  Expanded(child: RightCHecks()),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftCHecks(),
                    Container(height: 20),
                    RightCHecks(),
                  ],
                ),
              ),
        Container(height: 20),
      ],
    );
  }

  Widget buildIosSwitch() => Transform.scale(
        scale: .50,
        child: CupertinoSwitch(
            activeTrackColor: AppColor.searchbackground,
            value: value,
            onChanged: (value) => setState(() => this.value = value)),
      );

  Widget buildIosSwitch3() => Transform.scale(
        scale: .50,
        child: CupertinoSwitch(
            activeTrackColor: AppColor.searchbackground,
            value: value3,
            onChanged: (value3) => setState(() => this.value3 = value3)),
      );

  Widget buildIosSwitch4() => Transform.scale(
        scale: .80,
        child: CupertinoSwitch(
            activeTrackColor: AppColor.searchbackground,
            value: value4,
            onChanged: (value4) => setState(() => this.value4 = value4)),
      );
  Widget buildIosSwitch5() => Transform.scale(
        scale: .99,
        child: CupertinoSwitch(
            activeTrackColor: AppColor.searchbackground,
            value: value5,
            onChanged: (value5) => setState(() => this.value5 = value5)),
      );

  Column LeftCHecks() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Switch examples",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          children: [
            buildIosSwitch(),
            Container(width: 5),
            Expanded(
              child: Text(
                "Toggle this switch element",
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(width: 12),
            SvgPicture.asset(
              "assets/svg/switch/switch.svg",
              fit: BoxFit.fill,
              height: 16.5,
              // width: 15,
            ),
            Container(width: 20),
            Expanded(
              child: Text(
                "Disabled switch element",
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column RightCHecks() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColor.searchbackground,
              size: 15,
            ),
            Text(
              "  Switch sizes",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            buildIosSwitch3(),
            Container(width: 5),
            Text(
              "Small Size Switch",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            buildIosSwitch4(),
            Container(width: 5),
            Text(
              "Medium Size Switch",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            buildIosSwitch5(),
            Container(width: 5),
            Text(
              "Large Size Switch",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
