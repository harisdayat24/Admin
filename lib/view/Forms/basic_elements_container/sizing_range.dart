// Sizing //
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../../comman/colors.dart';

Column LeftSizinginputs(width) {
  return Column(
    children: [
      Container(
        width: width,
        decoration:
            BoxDecoration(border: Border.all(color: AppColor.boxborder)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 21, bottom: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sizing",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.dark,
                ),
              ),
              Container(height: 10),
              RichText(
                text: TextSpan(
                    text: 'Set heights using classes like',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' .form-control-lg',
                        style: TextStyle(color: AppColor.darkred, fontSize: 12),
                      ),
                      TextSpan(
                        text: ' and',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' .form-control-sm.',
                        style: TextStyle(
                          color: AppColor.darkred,
                          fontSize: 12,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
      SizingTextField(
        obscure: false,
        title: 'Default input',
        hintText: "Default input",
        height: 40,
        hintsize: 15,
        inputfontsize: 15,
      ),
      SizingTextField(
        obscure: false,
        title: 'Form Small input',
        hintText: '.form-control-sm',
        height: 30,
        hintsize: 12,
        inputfontsize: 12,
      ),
      SizingTextField(
        obscure: false,
        title: 'Form Large input',
        hintText: '.form-control-lg',
        height: 60,
        hintsize: 22,
        inputfontsize: 22,
      ),
    ],
  );
}

// Range Inputs //

class RightRangeinputs extends StatefulWidget {
  const RightRangeinputs({super.key});

  @override
  State<RightRangeinputs> createState() => _RightRangeinputsState();
}

class _RightRangeinputsState extends State<RightRangeinputs> {
  double value = 50;
  double value2 = 50;
  double value3 = 50;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 21, bottom: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Range Inputs",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Container(height: 10),
                RichText(
                  text: TextSpan(
                      text: 'Create custom',
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' <input type="range">',
                          style:
                              TextStyle(color: AppColor.darkred, fontSize: 12),
                        ),
                        TextSpan(
                          text: ' controls with',
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: ' .form-range.',
                          style: TextStyle(
                            color: AppColor.darkred,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Container(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Example range",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.dark,
            ),
          ),
        ),
        Slider(
          activeColor: AppColor.slider,
          inactiveColor: AppColor.slider,
          thumbColor: AppColor.searchbackground,
          value: value,
          min: 0,
          max: 100,
          onChanged: (value) => setState(
            () => this.value = value,
          ),
        ),
        Container(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Min and max",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.dark,
            ),
          ),
        ),
        Container(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Range inputs have implicit values for min and max—0 and 100, respectively.",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ),
        Slider(
          activeColor: AppColor.slider,
          inactiveColor: AppColor.slider,
          thumbColor: AppColor.searchbackground,
          value: value2,
          divisions: 6,
          min: 0,
          max: 100,
          onChanged: (value2) => setState(
            () => this.value2 = value2,
          ),
        ),
        Container(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Steps",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.dark,
            ),
          ),
        ),
        Container(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "By default, range inputs “snap” to integer values. To change this, you can specify a step value.",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ),
        Slider(
          activeColor: AppColor.slider,
          inactiveColor: AppColor.slider,
          thumbColor: AppColor.searchbackground,
          value: value3,
          divisions: 6,
          min: 0,
          max: 100,
          onChanged: (value3) => setState(
            () => this.value3 = value3,
          ),
        ),
      ],
    );
  }
}

class SizingTextField extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;
  final double hintsize;
  final double? inputfontsize;

  const SizingTextField({
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    required this.hintsize,
    this.inputfontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          SizedBox(
            height: height,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: inputfontsize,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: hintsize),
                // hintStyle: TextStyle(color: AppColor.black),
                filled: true,
                fillColor: AppColor.lightwhite.withOpacity(.25),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                      color: AppColor.searchbackground.withOpacity(.50)),
                ),
              ),
            ),
          ),
          Container(height: 10),
        ],
      ),
    );
  }
}
