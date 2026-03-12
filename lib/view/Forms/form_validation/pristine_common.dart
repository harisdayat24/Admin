// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../../comman/colors.dart';

class PristineJS extends StatefulWidget {
  const PristineJS({super.key});

  @override
  State<PristineJS> createState() => _PristineJSState();
}

class _PristineJSState extends State<PristineJS> {
  bool valuefirst = false;
  bool valuecheck = false;
  bool valuecheck2 = false;
  bool valuecheck3 = false;

  String? _dropDownValue2;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Validation Examples",
            style: TextStyle(
              fontSize: 16,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(height: 20),
        width > 1210
            ? User_Email_age()
            : width > 770
                ? User_Email_Row()
                : User_Email_Column(),

        // ----------------------------- //
        width > 1210
            ? Pass_Retrypass(width)
            : width > 770
                ? Age_pass_Row()
                : Age_pass_Column(),
        RetryPassword(width),

        Padding(
          padding: const EdgeInsets.only(left: 9.0, bottom: 10.0),
          child: termsAndCondition(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: submitform(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Divider(),
        ),
        Container(height: 30),

        // Common validations //

        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Common validations",
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(height: 20),

        // 1 --------
        width > 1210
            ? Required_mini_type()
            : width > 770
                ? Required_mini_Row()
                : Required_mini_Column(),
        // 2 --------
        width > 1210
            ? Num_miniNum_select()
            : width > 770
                ? Type_num_Row()
                : Type_num_Column(),
        // 3 --------
        width > 1210
            ? Container()
            : width > 770
                ? Num_Select_Row()
                : Num_Select_Column(),

        //*------------------------------
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Hobbies (required, min=2)",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(height: 10),
        // check box

        // CheckboxListTile

        // Container(
        //   width: 100,
        //   child: ListTileTheme(
        //     contentPadding: EdgeInsets.zero,
        //     child: CheckboxListTile(
        //       controlAffinity: ListTileControlAffinity.leading,
        //       contentPadding: EdgeInsets.zero,
        //       value: valuecheck,
        //       title: Text('Writing'),
        //       visualDensity: VisualDensity.compact,
        //       onChanged: (value) {
        //         setState(() {
        //           valuecheck = value!;
        //         });
        //       },
        //     ),
        //   ),
        // ),
        width > 370
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(width: 12),
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: AppColor.hintcolor),
                      checkColor: AppColor.mainbackground,
                      activeColor: AppColor.searchbackground,
                      value: valuecheck,
                      onChanged: (value) {
                        setState(() {
                          valuecheck = value!;
                        });
                      }),
                  Text(
                    "Writing",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Container(width: 12),
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: AppColor.hintcolor),
                      checkColor: AppColor.mainbackground,
                      activeColor: AppColor.searchbackground,
                      value: valuecheck2,
                      onChanged: (value) {
                        setState(() {
                          valuecheck2 = value!;
                        });
                      }),
                  Text(
                    "Photography",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Container(width: 12),
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: AppColor.hintcolor),
                      checkColor: AppColor.mainbackground,
                      activeColor: AppColor.searchbackground,
                      value: valuecheck3,
                      onChanged: (value) {
                        setState(() {
                          valuecheck3 = value!;
                        });
                      }),
                  Text(
                    "Cycling",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 15),
                  Row(
                    children: [
                      Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          side: BorderSide(color: AppColor.hintcolor),
                          checkColor: AppColor.mainbackground,
                          activeColor: AppColor.searchbackground,
                          value: valuecheck,
                          onChanged: (value) {
                            setState(() {
                              valuecheck = value!;
                            });
                          }),
                      Text(
                        "Writing",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: BorderSide(color: AppColor.hintcolor),
                              checkColor: AppColor.mainbackground,
                              activeColor: AppColor.searchbackground,
                              value: valuecheck2,
                              onChanged: (value) {
                                setState(() {
                                  valuecheck2 = value!;
                                });
                              }),
                          Text(
                            "Photography",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.dark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: BorderSide(color: AppColor.hintcolor),
                              checkColor: AppColor.mainbackground,
                              activeColor: AppColor.searchbackground,
                              value: valuecheck3,
                              onChanged: (value) {
                                setState(() {
                                  valuecheck3 = value!;
                                });
                              }),
                          Text(
                            "Cycling",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.dark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

        Container(height: 20),
        width > 1210
            ? Container(
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      child: PristineJSTextField(
                        obscure: false,
                        title:
                            "pattern=/^\\d+\\.\\d{2}\$/ (match decimal with 2 points), required",
                        hintText: "Two decimal digits with two points",
                        height: 40,
                        hintsize: 15,
                      ),
                    ),
                    Expanded(
                      child: PristineJSTextField(
                        obscure: false,
                        title: "above field with custom message",
                        hintText: "Write custom message",
                        height: 40,
                        hintsize: 15,
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              )
            : width > 770
                ? Row(
                    children: [
                      Expanded(
                        child: PristineJSTextField(
                          obscure: false,
                          title:
                              "pattern=/^\\d+\\.\\d{2}\$/ (match decimal with 2 points), required",
                          hintText: "Two decimal digits with two points",
                          height: 40,
                          hintsize: 15,
                        ),
                      ),
                      Expanded(
                        child: PristineJSTextField(
                          obscure: false,
                          title: "above field with custom message",
                          hintText: "Write custom message",
                          height: 40,
                          hintsize: 15,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      PristineJSTextField(
                        obscure: false,
                        title:
                            "pattern=/^\\d+\\.\\d{2}\$/ (match decimal with 2 points), required",
                        hintText: "Two decimal digits with two points",
                        height: 40,
                        hintsize: 15,
                      ),
                      PristineJSTextField(
                        obscure: false,
                        title: "above field with custom message",
                        hintText: "Write custom message",
                        height: 40,
                        hintsize: 15,
                      ),
                    ],
                  ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: submit(),
          ),
        ),
        Container(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Divider(),
        ),
        Container(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Validator to a specific field",
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: PristineJSTextField(
            obscure: false,
            title: "required, first letter capitalized",
            height: 40,
            hintsize: 14,
            hintText: "Enter first letter capitalized",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: submitform(),
        ),
        Container(height: 15),
      ],
    );
  }

  Column Num_Select_Column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PristineJSTextField(
          obscure: false,
          title: "number, min=100, not required",
          hintText: "Enter number",
          height: 40,
          hintsize: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Select",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              border: Border.all(
                  color: AppColor.boxborder,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconEnabledColor: Colors.transparent,
                underline: Container(color: AppColor.darkred),
                hint: _dropDownValue2 == null
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(' Select any one'))
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_dropDownValue2!)),
                isExpanded: true,
                iconSize: 30.0,

                // style: TextStyle(color: AppColor.boxborder),
                items: [
                  '  Select any one',
                  '  Writing',
                  '  Photography',
                  '  Cycling',
                ].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownValue2 = val!;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Container(height: 15),
        // PristineJSTextField(
        //   obscure: false,
        //   title: "Select",
        //   hintText: "Select any one",
        //   height: 40,
        //   hintsize: 15,
        // ),
      ],
    );
  }

  Row Num_Select_Row() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "number, min=100, not required",
            hintText: "Enter number",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Select",
            hintText: "Select any one",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Column Type_num_Column() {
    return Column(
      children: [
        PristineJSTextField(
          obscure: false,
          title: "type=email, not required",
          hintText: "Email",
          height: 40,
          hintsize: 15,
        ),
        PristineJSTextField(
          obscure: false,
          title: "number, not required",
          hintText: "Enter number",
          height: 40,
          hintsize: 15,
        ),
      ],
    );
  }

  Row Type_num_Row() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "type=email, not required",
            hintText: "Email",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "number, not required",
            hintText: "Enter number",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Row Num_miniNum_select() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "number, not required",
            hintText: "Enter number",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "number, min=100, not required",
            hintText: "Enter number",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Select",
            hintText: "Select any one",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Column Required_mini_Column() {
    return Column(
      children: [
        PristineJSTextField(
          obscure: false,
          title: "Required",
          hintText: "Required",
          height: 40,
          hintsize: 15,
        ),
        PristineJSTextField(
          obscure: false,
          title: "minlength=5, but not required",
          hintText: "Minimum Length",
          height: 40,
          hintsize: 15,
        ),
      ],
    );
  }

  Row Required_mini_Row() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Required",
            hintText: "Required",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "minlength=5, but not required",
            hintText: "Minimum Length",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Row Required_mini_type() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Required",
            hintText: "Required",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "minlength=5, but not required",
            hintText: "Minimum Length",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "type=email, not required",
            hintText: "Email",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Container RetryPassword(double width) {
    return Container(
      child: width > 1210
          ? Container()
          : width > 770
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: width / 2,
                        child: PristineJSTextField(
                          obscure: false,
                          title: "Retype password",
                          hintText: "Re-Enter your password",
                          height: 40,
                          hintsize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                )
              : PristineJSTextField(
                  obscure: false,
                  title: "Retype password",
                  hintText: "Re-Enter your password",
                  height: 40,
                  hintsize: 14,
                ),
    );
  }

  Column Age_pass_Column() {
    return Column(
      children: [
        PristineJSTextField(
          obscure: false,
          title: "Your age (required, min. 14)",
          hintText: "Enter your age",
          initialValue: "14",
          height: 40,
          hintsize: 14,
        ),
        PristineJSTextField(
          obscure: false,
          title: "Password (required)",
          hintText: "Enter your password",
          height: 40,
          hintsize: 14,
        ),
      ],
    );
  }

  Row Age_pass_Row() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Your age (required, min. 14)",
            hintText: "Enter your age",
            initialValue: "14",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Password (required)",
            hintText: "Enter your password",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Row Pass_Retrypass(double width) {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Password (required)",
            hintText: "Enter your password",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Retype password",
            hintText: "Re-Enter your password",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Column User_Email_Column() {
    return Column(
      children: [
        PristineJSTextField(
          obscure: false,
          title: "Username",
          hintText: "First name",
          height: 40,
          hintsize: 14,
        ),
        PristineJSTextField(
          obscure: false,
          title: "Email",
          hintText: "Enter your Email",
          height: 40,
          hintsize: 14,
        ),
      ],
    );
  }

  Row User_Email_Row() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Username",
            hintText: "First name",
            height: 40,
            hintsize: 14,
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Email",
            hintText: "Enter your Email",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Row User_Email_age() {
    return Row(
      children: [
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Username",
            hintText: "First name",
            height: 40,
            hintsize: 14,
            // validation: () {},
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Email",
            hintText: "Enter your Email",
            height: 40,
            hintsize: 14,
            // validation: () {},
          ),
        ),
        Expanded(
          child: PristineJSTextField(
            obscure: false,
            title: "Your age (required, min. 14)",
            hintText: "Enter your age",
            initialValue: "14",
            height: 40,
            hintsize: 14,
          ),
        ),
      ],
    );
  }

  Row termsAndCondition() {
    return Row(
      children: [
        Container(width: 5),
        Checkbox(
            checkColor: AppColor.mainbackground,
            activeColor: AppColor.searchbackground,
            value: valuefirst,
            onChanged: (value) {
              setState(() {
                valuefirst = value!;
              });
            }),
        Expanded(
          child: Text(
            " I accept the terms and conditions",
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Container submitform() {
    return Container(
      height: 38,
      width: 104,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: AppColor.searchbackground, blurRadius: 1),
          ],
          color: AppColor.searchbackground,
          borderRadius: BorderRadius.circular(4)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Submit form",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.mainbackground,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container submit() {
    return Container(
      height: 38,
      width: 71,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: AppColor.searchbackground, blurRadius: 1),
          ],
          color: AppColor.searchbackground,
          borderRadius: BorderRadius.circular(4)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.mainbackground,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class PristineJSTextField extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;
  final double hintsize;
  final double? inputfontsize;
  final dynamic prefixIcon;
  final dynamic validation;

  const PristineJSTextField({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    required this.hintsize,
    this.inputfontsize,
    this.prefixIcon,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
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
          Container(height: 10),
          Container(
            height: height,
            child: TextFormField(
              validator: validation,
              initialValue: initialValue,
              style: TextStyle(
                fontSize: inputfontsize,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
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
          Container(height: 10),
        ],
      ),
    );
  }
}
