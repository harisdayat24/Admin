// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';

class FormMask extends StatefulWidget {
  const FormMask({super.key});

  @override
  State<FormMask> createState() => _FormMaskState();
}

class _FormMaskState extends State<FormMask> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskcurrency = MaskTextInputFormatter(
      mask: '\$ ### ### ### ### ### ### ### ### ###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? RowTitel(
                  textL: "Form Mask",
                  texti: "Forms",
                  textii: "Form Mask",
                )
              : ColumnTitel(
                  textL: "Form Mask",
                  texti: "Forms",
                  textii: "Form Mask",
                ),
          Container(height: 20),
          Container(
            width: width,
            // height: 500, width: 500,
            decoration:
                BoxDecoration(border: Border.all(color: AppColor.boxborder)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Imask",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 5),
                  Text(
                    "vanilla javascript input mask",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            // height: 500, width: 500,
            decoration:
                BoxDecoration(border: Border.all(color: AppColor.boxborder)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1 to 6 input
                  width > 1000
                      ? Row(
                          children: [
                            Expanded(child: Column1()),
                            Container(width: 20),
                            Expanded(child: Column2()),
                          ],
                        )
                      : Column(
                          children: [
                            Column1(),
                            Column2(),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Container(height: 280)
        ],
      ),
    );
  }

  Column Column2() {
    return Column(
      children: [
        FormesTextField(
          obscure: false,
          title: "Date",
          height: 40,
          hintsize: 15,
          belowtext: "'dd.mm.yyyy' in range [01.01.1990, 01.01.2020]",
        ),
        FormesTextField(
          obscure: false,
          title: "On-the-fly select",
          height: 40,
          hintsize: 15,
          belowtext: "phone or email",
        ),
        FormesTextField(
          obscure: false,
          title: "Mask in mask",
          height: 40,
          hintsize: 15,
          inputFormatters: [maskcurrency],
          belowtext: "currency input",
        ),
      ],
    );
  }

  Column Column1() {
    return Column(
      children: [
        FormesTextField(
          obscure: false,
          title: "RegExp (Russian postal code)",
          height: 40,
          hintsize: 15,
          belowtext: """/^[1-6]\\d{0,5}\$/""",
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(r'^[0-6]{0,6}'),
            ),
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        // phone number
        FormesTextField(
          obscure: false,
          title: "Pattern (Phone)",
          height: 40,
          hintsize: 15,
          belowtext: "+{7}(000)000-00-00",
          inputFormatters: [maskFormatter],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        FormesTextField(
          obscure: false,
          title: "Number",
          height: 40,
          hintsize: 15,
          belowtext: "in range [-10000, 10000]",
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(
                  r'^((-10000)|(-[1-9][0-9]{3})|(-[1-9][0-9]{2})|(-[1-9][0-9]{1})|(-[1-9])|(10000)|([0-9]{1,4}))'),
            ),
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }
}

class FormesTextField extends StatelessWidget {
  final String? initialValue;
  final String title;
  final String belowtext;
  final bool obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;
  final double hintsize;
  final double? inputfontsize;
  final dynamic prefixIcon;
  final Function? validator;
  final dynamic inputFormatters;
  final dynamic keyboardType;

  const FormesTextField({
    super.key,
    this.initialValue,
    required this.title,
    required this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    required this.hintsize,
    this.inputfontsize,
    this.prefixIcon,
    this.validator,
    required this.belowtext,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, bottom: 10.0),
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
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              initialValue: initialValue,
              style: TextStyle(
                fontSize: inputfontsize,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              // validator: validator!(),
              obscureText: obscure,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
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
          Container(height: 2),
          Text(
            belowtext,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 20),
        ],
      ),
    );
  }
}
