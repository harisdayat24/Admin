// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:minia_web_project/view/Forms/form_validation/pristine_common.dart';
import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';
import 'bootstrap_validation.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? RowTitel(
                  textL: "Form Validation",
                  texti: "Forms",
                  textii: "Form Validation",
                )
              : ColumnTitel(
                  textL: "Form Validation",
                  texti: "Forms",
                  textii: "Form Validation",
                ),
          Container(height: 20),
          // Text("$width"),
          // Bootstrap validation //
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: LeftBootstrap(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.boxborder)),
                          child: RightBootstrap()),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: LeftBootstrap()),
                    Container(height: 20),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: RightBootstrap()),
                  ],
                ),
          Container(height: 20),

          // Pristine JS //
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PristineJS Validation",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark,
                          ),
                        ),
                        Container(height: 10),
                        RichText(
                          text: TextSpan(
                            text:
                                'PristineJS Vanilla javascript form validation library',
                            style: TextStyle(
                              color: AppColor.lightgrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: AppColor.boxborder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20),
                PristineJS(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
