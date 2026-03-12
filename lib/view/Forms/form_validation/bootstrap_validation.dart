// Sizing //
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/controller/edit_table.dart';
import '../../../comman/colors.dart';

class LeftBootstrap extends StatefulWidget {
  const LeftBootstrap({super.key});

  @override
  State<LeftBootstrap> createState() => _LeftBootstrapState();
}

class _LeftBootstrapState extends State<LeftBootstrap> {
  bool valuefirst = false;
  final EditController controller = Get.put(EditController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            width: width,
            decoration:
                BoxDecoration(border: Border.all(color: AppColor.boxborder)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 21, bottom: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bootstrap Validation - Normal",
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
                          'Provide valuable, actionable feedback to your users with HTML5 form validation–available in all our supported browsers.',
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
          Container(height: 20),
          width > 775 ? RowFirstt() : ColumnLast(),
          width > 775 ? RowCIty() : ColumnCity(),
          Padding(
            padding: const EdgeInsets.only(left: 9.0, bottom: 10.0),
            child: termsAndCondition(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: submitform(
                formKey,
                () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column ColumnCity() {
    return Column(
      children: [
        BootstrapTextField(
          obscure: false,
          title: 'City',
          hintText: "City",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a valid city.';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          obscure: false,
          title: 'State',
          hintText: "State",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a valid state.';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          obscure: false,
          title: 'Zip',
          hintText: "Zip",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a valid zip.';
            }
            return null; // Return null if the value is valid
          },
        ),
      ],
    );
  }

  Row RowCIty() {
    return Row(
      children: [
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'City',
            hintText: "City",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please provide a valid city.';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'State',
            hintText: "State",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please provide a valid state.';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'Zip',
            hintText: "Zip",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ' Please provide a valid zip.';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
      ],
    );
  }

  Widget ColumnLast() {
    return Column(
      children: [
        BootstrapTextField(
          allowDecimal: false,
          obscure: false,
          title: 'First name',
          hintText: "First name",
          initialValue: "Mark",
          height: 40,
          hintsize: 14,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          allowDecimal: false,
          obscure: false,
          title: 'Last name',
          hintText: "Last name",
          initialValue: "Otto",
          height: 40,
          hintsize: 14,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
      ],
    );
  }

  Row RowFirstt() {
    return Row(
      children: [
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'First name',
            hintText: "First name",
            initialValue: "Mark",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'Last name',
            hintText: "Last name",
            initialValue: "Otto",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
      ],
    );
  }

  Row termsAndCondition() {
    return Row(
      children: [
        Container(width: 5),
        Obx(
          () => Checkbox(
            checkColor: AppColor.mainbackground,
            activeColor: AppColor.searchbackground,
            value: controller.valueFirst.value,
            onChanged: (value) {
              controller.toggleCheckbox(value!);
            },
          ),
        ),
        Expanded(
          child: Text(
            " Agree to terms and conditions",
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
}

// Range Inputs //

class RightBootstrap extends StatefulWidget {
  const RightBootstrap({super.key});

  @override
  State<RightBootstrap> createState() => _RightBootstrapState();
}

class _RightBootstrapState extends State<RightBootstrap> {
  double value = 50;
  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            decoration:
                BoxDecoration(border: Border.all(color: AppColor.boxborder)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bootstrap Validation (Tooltips)",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                  Container(height: 10),
                  RichText(
                    text: TextSpan(
                        text: 'If your form layout allows it, you can swap the',
                        style: TextStyle(
                          color: AppColor.lightgrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' .{valid|invalid}-feedback',
                            style: TextStyle(
                                color: AppColor.darkred, fontSize: 12),
                          ),
                          TextSpan(
                            text: ' classes for',
                            style: TextStyle(
                              color: AppColor.lightgrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: ' .{valid|invalid}-tooltip',
                            style: TextStyle(
                              color: AppColor.darkred,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' classes to display validation feedback in a styled tooltip.',
                            style: TextStyle(
                              color: AppColor.lightgrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 15),
          width > 775 ? RowFirstname() : Columnfirstname(width),
          width > 775 ? RowCIty() : ColumnCIty(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: submitform2(formKey, () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Column ColumnCIty() {
    return Column(
      children: [
        BootstrapTextField(
          obscure: false,
          title: 'City',
          hintText: "City",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          obscure: false,
          title: 'State',
          hintText: "State",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
      ],
    );
  }

  Row RowCIty() {
    return Row(
      children: [
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'City',
            hintText: "City",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'State',
            hintText: "State",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
      ],
    );
  }

  Column Columnfirstname(double width) {
    return Column(
      children: [
        BootstrapTextField(
          obscure: false,
          title: 'First name',
          hintText: "First name",
          initialValue: "Mark$width",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          obscure: false,
          title: 'Last name',
          hintText: "Last name",
          initialValue: "Otto",
          height: 40,
          hintsize: 15,
          inputfontsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
        ),
        BootstrapTextField(
          obscure: false,
          title: "Username",
          hintText: "Username",
          height: 40,
          hintsize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null; // Return null if the value is valid
          },
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 8.0, left: 8.0, bottom: 8.0),
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
      ],
    );
  }

  Row RowFirstname() {
    return Row(
      children: [
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'First name',
            hintText: "First name",
            initialValue: "Mark",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: 'Last name',
            hintText: "Last name",
            initialValue: "Otto",
            height: 40,
            hintsize: 14,
            inputfontsize: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
          ),
        ),
        Expanded(
          child: BootstrapTextField(
            obscure: false,
            title: "Username",
            hintText: "Username",
            height: 40,
            hintsize: 14,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null; // Return null if the value is valid
            },
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
        Text(
          " Agree to terms and conditions",
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

class BootstrapTextField extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;
  final double hintsize;
  final double? inputfontsize;
  final dynamic prefixIcon;
  final dynamic validator;
  final dynamic onChanged;
  final dynamic controller;

  const BootstrapTextField({
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    required this.hintsize,
    this.inputfontsize,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20),
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
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            initialValue: initialValue,
            style: TextStyle(
              fontSize: inputfontsize,
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
            ),
            // validator: validator!(),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(
                  color: Colors.red, // Customize the error border color
                  width: 1.0, // Customize the error border width
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

InkWell submitform(key, ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
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
    ),
  );
}

InkWell submitform2(key, ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
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
    ),
  );
}
