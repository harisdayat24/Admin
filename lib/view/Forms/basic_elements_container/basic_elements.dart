// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';
import 'package:minia_web_project/view/Forms/basic_elements_container/check_boxes.dart';
import 'form_layout.dart';
import 'sizing_range.dart';
import 'textaual.dart';

class BasicElements extends StatefulWidget {
  const BasicElements({super.key});

  @override
  State<BasicElements> createState() => _BasicElementsState();
}

class _BasicElementsState extends State<BasicElements> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? RowTitel(
                  textL: "Basic Elements",
                  texti: "Forms",
                  textii: "Basic Elements",
                )
              : ColumnTitel(
                  textL: "Basic Elements",
                  texti: "Forms",
                  textii: "Basic Elements",
                ),
          Container(height: 20),
          // Textual inputs //
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 21, bottom: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Textual inputs",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark,
                          ),
                        ),
                        Container(height: 10),
                        RichText(
                          text: TextSpan(
                              text: 'Here are examples of',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' .form-control',
                                  style: TextStyle(
                                      color: AppColor.darkred, fontSize: 12),
                                ),
                                TextSpan(
                                  text: ' applied to each textual HTML5',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: ' <input> type.',
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
              ),
            ],
          ),
          width > 1000
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 25, right: 9, bottom: 25),
                        child: LeftTextualinputs(),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, right: 20, bottom: 25),
                        child: RightTextualinputs(),
                      )),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Column(
                      children: [
                        LeftTextualinputs(),
                        RightTextualinputs(),
                      ],
                    ),
                  ),
                ),
          Container(height: 20),

          //   Sizing //
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.boxborder)),
                          child: LeftSizinginputs(width)),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.boxborder)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, right: 0, bottom: 25),
                            child: RightRangeinputs(),
                          )),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: LeftSizinginputs(width)),
                    Container(height: 20),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: RightRangeinputs()),
                  ],
                ),
          Container(height: 20),

          // Form layouts //

          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 21, bottom: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Form layouts",
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
                                'Form layout options : from inline, horizontal & custom grid implementations',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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
          width > 1000
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: LeftformGroup()),
                          Expanded(child: RightformGroup()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Inlineformslayout()),
                          Expanded(child: FloatingLabel()),
                        ],
                      ),
                      InlineHstack(),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Column(
                    children: [
                      LeftformGroup(),
                      RightformGroup(),
                      Inlineformslayout(),
                      FloatingLabel(),
                      InlineHstack(),
                    ],
                  ),
                ),
          Container(height: 20),

          //  Check boxes //
          width > 1275
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.boxborder)),
                          child: FormCheckboxes()),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.boxborder)),
                          child: Radiosbutton()),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: FormCheckboxes()),
                    Container(height: 20),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: Radiosbutton()),
                  ],
                ),
          Container(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 21, bottom: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Switches",
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
                                  'A switch has the markup of a custom checkbox but uses the',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '  .form-switch',
                                  style: TextStyle(
                                      color: AppColor.darkred, fontSize: 12),
                                ),
                                TextSpan(
                                  text:
                                      ' class to render a toggle switch. Switches also support the',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: ' disabled',
                                  style: TextStyle(
                                    color: AppColor.darkred,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: " attribute.",
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          width > 1000
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SwitchesButtons()),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Column(
                    children: [
                      SwitchesButtons(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
