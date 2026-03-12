// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';

//  Form groups //
class LeftformGroup extends StatefulWidget {
  const LeftformGroup({super.key});

  @override
  State<LeftformGroup> createState() => _LeftformGroupState();
}

class _LeftformGroupState extends State<LeftformGroup> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 20),
          Row(
            children: [
              Icon(
                Icons.arrow_forward_sharp,
                color: AppColor.searchbackground,
                size: 15,
              ),
              Text(
                "  Form groups",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(height: 10),
          FormTextFields(
            obscure: false,
            title: 'First name',
            hintText: 'Enter Name',
          ),
          FormTextFields(
            obscure: false,
            title: 'Email',
            hintText: 'Enter your Email',
          ),
          FormTextFields(
            obscure: false,
            title: 'Password',
            hintText: 'Enter your password',
          ),
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
              Text(
                " Check me out",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 40,
              width: 110,
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
                    fontSize: 13,
                    color: AppColor.mainbackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//  Form groups //
class RightformGroup extends StatefulWidget {
  const RightformGroup({super.key});

  @override
  State<RightformGroup> createState() => _RightformGroupState();
}

class _RightformGroupState extends State<RightformGroup> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColor.searchbackground,
                  size: 15,
                ),
                Text(
                  "  Horizontal form",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.dark,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          FormTextFieldsrow(
            obscure: false,
            title: 'First name',
            initialValue: 'Artisanal kale',
          ),
          FormTextFieldsrow(
            obscure: false,
            title: 'Email',
            initialValue: 'How do I shoot web',
          ),
          FormTextFieldsrow(
            obscure: false,
            title: 'Password',
            initialValue: 'bootstrap@example.com',
          ),
          width > 530
              ? Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(flex: 3, child: remeberMe()),
                  ],
                )
              : remeberMe(),
          Container(height: 20),
          width > 530
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: submit(),
                    ),
                    Spacer(flex: 2),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: submit(),
                ),
        ],
      ),
    );
  }

  Container submit() {
    return Container(
      height: 40,
      width: 110,
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
            fontSize: 13,
            color: AppColor.mainbackground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Row remeberMe() {
    return Row(
      children: [
        Container(width: 10),
        Checkbox(
            checkColor: AppColor.mainbackground,
            activeColor: AppColor.searchbackground,
            value: valuefirst,
            onChanged: (value) {
              setState(() {
                valuefirst = value!;
              });
            }),
        Text(
          " Remember me",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Inline forms layout //

class Inlineformslayout extends StatefulWidget {
  const Inlineformslayout({super.key});

  @override
  State<Inlineformslayout> createState() => _InlineformslayoutState();
}

class _InlineformslayoutState extends State<Inlineformslayout> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColor.searchbackground,
                  size: 15,
                ),
                Text(
                  "   Inline forms layout",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          width > 530 ? RowInline(context) : ColumnInline(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (width < 1260 && width > 1000) remeberMe() else Container(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: submit(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row RowInline(context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: InlineformField(
            obscure: false,
            hintText: 'Enter Name',
          ),
        ),
        Expanded(
          child: InlineformField(
            obscure: false,
            hintText: 'Username',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  right: BorderSide(
                    color: AppColor.boxborder,
                    width: 2,
                  ),
                )),
                child: Text(
                  "@",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        if (width > 1260 || width < 1000)
          Expanded(child: remeberMe())
        else
          Container(),
      ],
    );
  }

  Column ColumnInline() {
    return Column(
      children: [
        InlineformField(
          obscure: false,
          hintText: 'Enter Name',
        ),
        InlineformField(
          obscure: false,
          hintText: 'Username',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColor.boxborder,
                  width: 2,
                ),
              )),
              child: Text(
                "@",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        remeberMe(),
        Container(height: 10),
      ],
    );
  }

  Container submit() {
    return Container(
      height: 40,
      width: 70,
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
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Row remeberMe() {
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
        Text(
          " Remember me",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Floating forms layout //

class FloatingLabel extends StatefulWidget {
  const FloatingLabel({super.key});

  @override
  State<FloatingLabel> createState() => _FloatingLabelState();
}

class _FloatingLabelState extends State<FloatingLabel> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColor.searchbackground,
                  size: 15,
                ),
                Text(
                  "   Floating Label",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          width > 1000 ? RowInline() : ColumnInline(),
          // submit(),
        ],
      ),
    );
  }

  Row RowInline() {
    return Row(
      children: [
        Expanded(
          child: FloatingField(
            obscure: false,
            hintText: 'Email address',
          ),
        ),
        Container(width: 10),
        Expanded(
          child: FloatingField(
            obscure: false,
            hintText: 'Password',
          ),
        ),
      ],
    );
  }

  Column ColumnInline() {
    return Column(
      children: [
        FloatingField(
          obscure: false,
          hintText: 'Email address',
        ),
        FloatingField(
          obscure: false,
          hintText: 'Password',
        ),
        // remeberMe(),
        Container(height: 10),
      ],
    );
  }
}

// InlineHstack //

class InlineHstack extends StatefulWidget {
  const InlineHstack({super.key});

  @override
  State<InlineHstack> createState() => _InlineHstackState();
}

class _InlineHstackState extends State<InlineHstack> {
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColor.searchbackground,
                  size: 15,
                ),
                Expanded(
                  child: Text(
                    "   Inline forms layout used by hstack",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          Row(
            children: [
              width > 1000
                  ? SizedBox(
                      width: width / 3,
                      child: InlineformField(
                        obscure: false,
                        hintText: 'Add your item here...',
                      ),
                    )
                  : Expanded(
                      child: InlineformField(
                        obscure: false,
                        hintText: 'Add your item here...',
                      ),
                    ),
              Container(width: 10),
              Container(
                height: 40,
                width: width < 365 ? 70 : 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: AppColor.lightgrey, blurRadius: 1),
                    ],
                    color: AppColor.lightgrey,
                    borderRadius: BorderRadius.circular(4)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.mainbackground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(width: 10),
              SizedBox(
                  height: 40,
                  child:
                      VerticalDivider(color: AppColor.boxborder, thickness: 2)),
              Container(width: 10),
              Container(
                height: 40,
                width: width < 365 ? 70 : 110,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.darkred),
                    borderRadius: BorderRadius.circular(4)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.darkred,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 15),
        ],
      ),
    );
  }
}

class FormTextFields extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const FormTextFields({
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: hintText,
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

class FormTextFieldsrow extends StatelessWidget {
  final String? initialValue;
  final String? title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const FormTextFieldsrow({
    this.initialValue,
    this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          width > 530 ? rowfield() : columnfield(),
          Container(height: 10),
        ],
      ),
    );
  }

  Column columnfield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            fontSize: 14,
            color: AppColor.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(height: 5),
        SizedBox(
          height: 40,
          child: TextFormField(
            initialValue: initialValue,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
            ),
            obscureText: obscure!,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: hintText ?? "",
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
      ],
    );
  }

  Row rowfield() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(width: 20),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: hintText,
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
        ),
      ],
    );
  }
}

class InlineformField extends StatelessWidget {
  final String? initialValue;
  final dynamic prefixIcon;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const InlineformField({
    this.initialValue,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                hintText: hintText,
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
        ],
      ),
    );
  }
}

class FloatingField extends StatelessWidget {
  final String? initialValue;
  final dynamic prefixIcon;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const FloatingField({
    this.initialValue,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: initialValue,
          style: TextStyle(
            fontSize: 14,
            color: AppColor.black,
            fontWeight: FontWeight.w400,
          ),
          obscureText: obscure!,
          autocorrect: true,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: hintText,
            // hintText: hintText,
            // hintStyle: TextStyle(color: AppColor.black),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 10.0,
            ),
            filled: true,
            fillColor: AppColor.lightwhite.withOpacity(.25),
            // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: AppColor.boxborder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide:
                  BorderSide(color: AppColor.searchbackground.withOpacity(.50)),
            ),
          ),
        ),
        Container(height: 10),
      ],
    );
  }
}
