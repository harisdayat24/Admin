// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../comman/colors.dart';

class WProgressbar extends StatefulWidget {
  const WProgressbar({super.key});

  @override
  State<WProgressbar> createState() => _WProgressbarState();
}

class _WProgressbarState extends State<WProgressbar> {
  int currentStep = 0;

  List<String> steps = [
    "Step1",
    "Step2",
    "Step3",
  ];

  List<Widget> steps2 = [
    OneWizard(),
    TwoWizard(),
    ThreeWizard(),
  ];

  void goToNextStep() {
    setState(() {
      if (currentStep < steps.length - 1) {
        currentStep++;
      }
    });
  }

  void goToPreviousStep() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            title(width),
            Container(
              width: width,
              height: width > 1000
                  ? 550
                  : currentStep == 1
                      ? 795
                      : 712,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColor.boxborder),
                  right: BorderSide(color: AppColor.boxborder),
                  bottom: BorderSide(color: AppColor.boxborder),
                ),
              ),
              child: Column(
                children: [
                  Container(height: 10),
                  HeaderIcons(currentStep: currentStep),
                  Container(height: 30),
                  LinearProgressIndicator(
                    value: currentStep <= 0
                        ? .33
                        : currentStep <= 1
                            ? .66
                            : currentStep <= 2
                                ? 1
                                : .0,
                    minHeight: 10,
                    backgroundColor: AppColor.boxborder,

                    // borderRadius: BorderRadius.circular(10),
                    color: AppColor.darkGreen,
                  ),
                  SizedBox(height: 16.0),
                  steps2[currentStep],
                  Buttons(width),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row Buttons(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentStep > 0
            ? InkWell(
                onTap: currentStep > 0 ? goToPreviousStep : null,
                child: Container(
                  height: 38,
                  width: 101,
                  decoration: BoxDecoration(
                    color: AppColor.selecteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.navigate_before_rounded,
                          color: AppColor.mainbackground,
                          size: 15,
                        ),
                        Text(
                          "  Previous",
                          style: TextStyle(
                            color: AppColor.mainbackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 38,
                width: 101,
              ),
        SizedBox(width: 5.0),
        currentStep == 1 || currentStep == 0
            ? InkWell(
                onTap: currentStep < steps.length - 1 ? goToNextStep : null,
                child: Container(
                  height: 38,
                  width: 77,
                  decoration: BoxDecoration(
                    color: AppColor.selecteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            color: AppColor.mainbackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: AppColor.mainbackground,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  openDilog(width);
                },
                child: Container(
                  height: 38,
                  width: 110,
                  decoration: BoxDecoration(
                    color: AppColor.selecteColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "  Save Changes",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: AppColor.mainbackground,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Future openDilog(width) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: SvgPicture.asset(
            "assets/svg/pricing/check_circle_blue.svg",
            color: AppColor.darkGreen,
            height: 55,
            width: 55,
            fit: BoxFit.contain,
          ),
          content: SizedBox(
            height: width > 358 ? 110 : 200,
            width: 440,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Confirm Save Changes",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 10),
                  width > 358
                      ? Row(
                          children: [
                            Spacer(),
                            PopClose(),
                            SizedBox(width: 8),
                            PopSave(),
                            Spacer(),
                          ],
                        )
                      : Column(
                          children: [
                            PopSave(),
                            SizedBox(height: 8),
                            PopClose(),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      );

  InkWell PopSave() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 38,
        width: 110,
        decoration: BoxDecoration(
          color: AppColor.selecteColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            "Save Changes",
            style: TextStyle(
              color: AppColor.mainbackground,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  InkWell PopClose() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 38,
        width: 110,
        decoration: BoxDecoration(
          color: AppColor.boxborder,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            "Close",
            style: TextStyle(
              color: AppColor.black,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Container title(double width) {
    return Container(
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
              "Wizard with Progressbar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderIcons extends StatelessWidget {
  const HeaderIcons({
    super.key,
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        width > 500 ? Spacer(flex: 2) : Container(width: 0),
        Expanded(
          flex: 1,
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: currentStep == 0
                  ? AppColor.selecteColor.withOpacity(.20)
                  : AppColor.mainbackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: currentStep == 0
                    ? AppColor.selecteColor.withOpacity(.40)
                    : AppColor.boxborder,
                width: 1,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/svg/wizard/menu.svg",
                height: 10,
                width: 10,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        width > 500
            ? Expanded(
                flex: 4,
                child: Container(
                  width: 50,
                  height: 1,
                  color: AppColor.borders,
                ),
              )
            : Flexible(
                flex: 1,
                child: Container(
                  width: 50,
                  height: 1,
                  color: AppColor.borders,
                ),
              ),
        Expanded(
          flex: 1,
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: currentStep == 1
                  ? AppColor.selecteColor.withOpacity(.20)
                  : AppColor.mainbackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: currentStep == 1
                    ? AppColor.selecteColor.withOpacity(.40)
                    : AppColor.boxborder,
                width: 1,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/svg/wizard/book.svg",
                height: 15,
                width: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        width > 500
            ? Expanded(
                flex: 4,
                child: Container(
                  width: 50,
                  height: 1,
                  color: AppColor.borders,
                ),
              )
            : Flexible(
                flex: 1,
                child: Container(
                  width: 50,
                  height: 1,
                  color: AppColor.borders,
                ),
              ),
        Expanded(
          flex: 1,
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: currentStep == 2
                  ? AppColor.selecteColor.withOpacity(.20)
                  : AppColor.mainbackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: currentStep == 2
                    ? AppColor.selecteColor.withOpacity(.40)
                    : AppColor.boxborder,
                width: 1,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/svg/wizard/bank.svg",
                height: 15,
                width: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        width > 500 ? Spacer(flex: 2) : Container(width: 0),
      ],
    );
  }
}

class OneWizard extends StatelessWidget {
  const OneWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(height: 20),
              Text(
                "Seller Details",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(height: 15),
              Text("Fill all information below"),
              Container(height: 27),
              width > 1000 ? BasicRowName() : BasicColumnName(),
              width > 1000 ? BasicRowphone() : BasicColumnphone(),
              WizardTextField(
                title: "Address",
                height: 40,
                obscure: false,
                hintText: "Enter your Address",
              ),
            ],
          ),
        );
      },
    );
  }

  Column BasicColumnName() {
    return Column(
      children: [
        WizardTextField(
          title: "First name",
          height: 40,
          obscure: false,
          hintText: "Enter Your First Name",
        ),
        WizardTextField(
          title: "Last name",
          height: 40,
          obscure: false,
          hintText: "Enter Your Last Name",
        ),
      ],
    );
  }

  Row BasicRowName() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "First name",
            height: 40,
            obscure: false,
            hintText: "Enter Your First Name",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Last name",
            height: 40,
            obscure: false,
            hintText: "Enter Your Last Name",
          ),
        ),
      ],
    );
  }

  Column BasicColumnphone() {
    return Column(
      children: [
        WizardTextField(
          title: "Phone",
          height: 40,
          obscure: false,
          hintText: "Enter your Phone No.",
        ),
        WizardTextField(
          title: "Email",
          height: 40,
          obscure: false,
          hintText: "Enter Your email",
        ),
      ],
    );
  }

  Row BasicRowphone() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "Phone",
            height: 40,
            obscure: false,
            hintText: "Enter your Phone No.",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Email",
            height: 40,
            obscure: false,
            hintText: "Enter Your email",
          ),
        ),
      ],
    );
  }
}

class TwoWizard extends StatelessWidget {
  const TwoWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        return Column(
          children: [
            Container(height: 20),
            Text(
              "Company Document",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 15),
            Text("Fill all information below"),
            Container(height: 27),
            width > 1000 ? BasicRowPan() : BasicColumnPan(),
            width > 1000 ? BasicRowGST() : BasicColumGST(),
            width > 1000 ? BasicRowUin() : BasicColumnUin(),
          ],
        );
      },
    );
  }

  Column BasicColumnPan() {
    return Column(
      children: [
        WizardTextField(
          title: "PAN Card",
          height: 40,
          obscure: false,
          hintText: "Enter your PAN No.",
        ),
        WizardTextField(
          title: "VAT/TIN No.",
          height: 40,
          obscure: false,
          hintText: "Enter your VAT/TIN No.",
        ),
      ],
    );
  }

  Row BasicRowPan() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "PAN Card",
            height: 40,
            obscure: false,
            hintText: "Enter your PAN No.",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "VAT/TIN No.",
            height: 40,
            obscure: false,
            hintText: "Enter your VAT/TIN No.",
          ),
        ),
      ],
    );
  }

  Column BasicColumGST() {
    return Column(
      children: [
        WizardTextField(
          title: "GST No.",
          height: 40,
          obscure: false,
          hintText: "Enter your GST No.",
        ),
        WizardTextField(
          title: "Service Tax No.",
          height: 40,
          obscure: false,
          hintText: "Enter your VAT/TIN No.",
        ),
      ],
    );
  }

  Row BasicRowGST() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "GST No.",
            height: 40,
            obscure: false,
            hintText: "Enter your GST No.",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Service Tax No.",
            height: 40,
            obscure: false,
            hintText: "Enter your VAT/TIN No.",
          ),
        ),
      ],
    );
  }

  Column BasicColumnUin() {
    return Column(
      children: [
        WizardTextField(
          title: "Company UIN",
          height: 40,
          obscure: false,
          hintText: "Enter your Company UIN.",
        ),
        WizardTextField(
          title: "Declaration",
          height: 40,
          obscure: false,
          hintText: "Enter your Declaration",
        ),
      ],
    );
  }

  Row BasicRowUin() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "Company UIN",
            height: 40,
            obscure: false,
            hintText: "Enter your Company UIN.",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Declaration",
            height: 40,
            obscure: false,
            hintText: "Enter your Declaration",
          ),
        ),
      ],
    );
  }
}

class ThreeWizard extends StatelessWidget {
  const ThreeWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var width = MediaQuery.of(context).size.width;
        return Column(
          children: [
            Container(height: 20),
            Text(
              "Bank Details",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 15),
            Text("Fill all information below"),
            Container(height: 27),
            width > 1000 ? BasicRowCard() : BasicColumCard(),
            width > 1000 ? BasicRowCC() : BasicColumCC(),
            width > 1000
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: width / 2,
                      child: WizardTextField(
                        title: "Expiration Date",
                        height: 40,
                        obscure: false,
                        hintText: "11/02/2023",
                      ),
                    ),
                  )
                : WizardTextField(
                    title: "Expiration Date",
                    height: 40,
                    obscure: false,
                    hintText: "11/02/2023",
                  )
          ],
        );
      },
    );
  }

  Column BasicColumCard() {
    return Column(
      children: [
        WizardTextField(
          title: "Name on Card",
          height: 40,
          obscure: false,
          hintText: "Enter your Name on Card",
        ),
        WizardTextField(
          title: "Credit Card Type",
          height: 40,
          obscure: false,
          hintText: "American Express",
        ),
      ],
    );
  }

  Row BasicRowCard() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "Name on Card",
            height: 40,
            obscure: false,
            hintText: "Enter your Name on Card",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Credit Card Type",
            height: 40,
            obscure: false,
            hintText: "American Express",
          ),
        ),
      ],
    );
  }

  Column BasicColumCC() {
    return Column(
      children: [
        WizardTextField(
          title: "Credit Card Number",
          height: 40,
          obscure: false,
          hintText: "Enter your Credit Card Number",
        ),
        WizardTextField(
          title: "Card Verification Number",
          height: 40,
          obscure: false,
          hintText: "Enter your Card Verification Number",
        ),
      ],
    );
  }

  Row BasicRowCC() {
    return Row(
      children: [
        Expanded(
          child: WizardTextField(
            title: "Credit Card Number",
            height: 40,
            obscure: false,
            hintText: "Enter your Credit Card Number",
          ),
        ),
        Container(width: 20),
        Expanded(
          child: WizardTextField(
            title: "Card Verification Number",
            height: 40,
            obscure: false,
            hintText: "Enter your Card Verification Number",
          ),
        ),
      ],
    );
  }
}

class WizardTextField extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;

  final dynamic prefixIcon;
  final Function? validator;

  const WizardTextField({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    this.prefixIcon,
    this.validator,
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
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              // validator: validator!(),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColor.dark,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
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
