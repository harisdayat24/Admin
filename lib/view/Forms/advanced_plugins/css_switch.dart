// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../comman/colors.dart';

class CssSwitch extends StatefulWidget {
  const CssSwitch({super.key});

  @override
  State<CssSwitch> createState() => _CssSwitchState();
}

class _CssSwitchState extends State<CssSwitch> {
  // bool value = false;
  bool switchValue = false;
  bool switchValue1 = true;
  bool switchValue2 = true;
  bool switchValue3 = true;
  bool switchValue4 = true;
  bool switchValue5 = true;
  bool switchValue6 = true;
  bool switchValue7 = true;
  bool switchValue8 = true;
  bool? switchV = true;
  bool status = false;
  bool statuss = true;
  bool statuss1 = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width < 983 ? width - 42 : width - 292,
      child: width > 983
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 20.0),
                        child: Text(
                          "Example switch",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      width < 1346
                          ? Big_Screen_Switch3()
                          : width < 1650
                              ? Big_Screen_Switch2()
                              : Big_Screen_Switch(),
                      Container(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 20.0),
                        child: Text("Square switch"),
                      ),
                      SqSwitch1(),
                      Container(height: 20),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                  child: Text("Example switch"),
                ),
                width < 430
                    ? Big_Screen_Switch4()
                    : width < 585
                        ? Big_Screen_Switch3()
                        : width < 735
                            ? Big_Screen_Switch2()
                            : Big_Screen_Switch(),
                Container(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                  child: Text("Square switch"),
                ),
                SqSwitch1(),
                Container(height: 20),
              ],
            ),
    );
  }

  Widget Big_Screen_Switch() {
    return Row(
      children: [
        Container(width: 20),
        switch1(),
        Container(width: 10),
        switch2(),
        Container(width: 10),
        switch3(),
        Container(width: 10),
        switch4(),
        Container(width: 10),
        switch5(),
        Container(width: 10),
        switch6(),
        Container(width: 10),
        switch7(),
        Container(width: 10),
        switch8(),
        Container(width: 10),
        switch9(),
      ],
    );
  }

  Widget Big_Screen_Switch2() {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 20),
            switch1(),
            Container(width: 10),
            switch2(),
            Container(width: 10),
            switch3(),
            Container(width: 10),
            switch4(),
            Container(width: 10),
            switch5(),
            Container(width: 10),
            switch6(),
            Container(width: 10),
            switch7(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              switch8(),
              Container(width: 10),
              switch9(),
            ],
          ),
        )
      ],
    );
  }

  Widget Big_Screen_Switch3() {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 20),
            switch1(),
            Container(width: 10),
            switch2(),
            Container(width: 10),
            switch3(),
            Container(width: 10),
            switch4(),
            Container(width: 10),
            switch5(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              switch6(),
              Container(width: 10),
              switch7(),
              Container(width: 10),
              switch8(),
              Container(width: 10),
              switch9(),
            ],
          ),
        )
      ],
    );
  }

  Widget Big_Screen_Switch4() {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 20),
            switch1(),
            Container(width: 10),
            switch2(),
            Container(width: 10),
            switch3(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              switch4(),
              Container(width: 10),
              switch5(),
              Container(width: 10),
              switch6(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              switch7(),
              Container(width: 10),
              switch8(),
              Container(width: 10),
              switch9(),
            ],
          ),
        )
      ],
    );
  }

  Widget SqSwitch1() {
    return Row(
      children: [
        Container(width: 20),
        CustomSwitch(
          value: status,
          onChanged: (bool val) {
            setState(() {
              status = val;
            });
          },
        ),
        Container(width: 20),
        CustomSwitchs(
          value: statuss,
          onChanged: (bool val) {
            setState(() {
              statuss = val;
            });
          },
        ),
        Container(width: 20),
        Customsq(
          value: statuss1,
          onChanged: (bool val) {
            setState(() {
              statuss1 = val;
            });
          },
        ),
      ],
    );
  }

  FlutterSwitch switch9() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue8,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.darkblack,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue8 = val;
        });
      },
    );
  }

  FlutterSwitch switch8() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue7,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.darkred,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue7 = val;
        });
      },
    );
  }

  FlutterSwitch switch7() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue6,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.darkyellow,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue6 = val;
        });
      },
    );
  }

  FlutterSwitch switch6() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue5,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.darkblue,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue5 = val;
        });
      },
    );
  }

  FlutterSwitch switch5() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue4,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.darkGreen,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue4 = val;
        });
      },
    );
  }

  FlutterSwitch switch4() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue3,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.dark.withOpacity(.40),
      activeColor: AppColor.selecteColor,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue3 = val;
        });
      },
    );
  }

  FlutterSwitch switch3() {
    return FlutterSwitch(
      height: 30, width: 65,
      showOnOff: true,
      value: switchValue2,
      // activeIcon: Text("On"),
      activeText: "Yes",
      // inactiveIcon: Text("BUY"),
      inactiveText: "No",
      inactiveColor: AppColor.darkred,
      activeColor: AppColor.darkGreen,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.mainbackground,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue2 = val;
        });
      },
    );
  }

  FlutterSwitch switch2() {
    return FlutterSwitch(
      height: 30, width: 60,
      showOnOff: false,
      value: switchValue1,
      // activeIcon: Text("On"),
      // activeText: "On",
      // inactiveIcon: Text("BUY"),
      // inactiveText: "Off",
      inactiveColor: Colors.grey.shade400,
      activeColor: Colors.grey,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.black,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue1 = val;
        });
      },
    );
  }

  FlutterSwitch switch1() {
    return FlutterSwitch(
      height: 30, width: 60,
      showOnOff: true,
      value: switchValue,
      // activeIcon: Text("On"),
      activeText: "On",
      // inactiveIcon: Text("BUY"),
      inactiveText: "Off",
      inactiveColor: Colors.grey.shade400,
      activeColor: AppColor.selecteColor,
      activeTextColor: AppColor.mainbackground,
      inactiveTextColor: AppColor.black,
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      onToggle: (val) {
        setState(() {
          switchValue = val;
        });
      },
    );
  }
  // Widget buildIosSwitch() => Transform.scale(
  //       scale: .70,
  //       child: CupertinoSwitch(
  //         thumbColor: AppColor.boxborder,
  //         activeColor: AppColor.searchbackground,
  //         value: value,
  //         onChanged: (value) => setState(() => this.value = value),
  //       ),
  //     );
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.grey
                  : Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerRight
                        : Alignment.centerLeft)
                    : ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        shape: BoxShape.rectangle,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomSwitchs extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchs({super.key, required this.value, required this.onChanged});

  @override
  _CustomSwitchsState createState() => _CustomSwitchsState();
}

class _CustomSwitchsState extends State<CustomSwitchs>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.grey
                  : AppColor.selecteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerRight
                        : Alignment.centerLeft)
                    : ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        shape: BoxShape.rectangle,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Customsq extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const Customsq({super.key, required this.value, required this.onChanged});

  @override
  _CustomsqState createState() => _CustomsqState();
}

class _CustomsqState extends State<Customsq>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.grey
                  : AppColor.darkred,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerRight
                        : Alignment.centerLeft)
                    : ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        shape: BoxShape.rectangle,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
