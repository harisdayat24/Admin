import 'package:carousel_slider/carousel_slider.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:minia_web_project/view/Authentication/pages/reset_pass.dart';
import 'package:minia_web_project/view/Authentication/pages/sign_up.dart';
import 'package:minia_web_project/view/Drawer/drawer.dart';

import '../../Forms/form_validation/controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool valuefirst = false;

  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> rowFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> columnFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // key: scaffoldKey,
      body: width > 750 ? row(context, height, width) : column(context, height),
    );
  }

  Form row(BuildContext context, double height, double width) {
    return Form(
      key: rowFormKey,
      child: Row(
        children: [
          Expanded(
              flex: width > 880
                  ? 1
                  : width > 750
                      ? 1
                      : 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    loginfileds(width),
                  ],
                ),
              )),
          Expanded(
            flex: width > 880
                ? 3
                : width > 750
                    ? 2
                    : 3,
            child: imageLogin(context),
          )
        ],
      ),
    );
  }

  SingleChildScrollView column(BuildContext context, double height) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        key: columnFormKey,
        child: Column(
          children: [
            loginfileds(height),
            imageLogin(context),
          ],
        ),
      ),
    );
  }

  Widget loginfileds(height) {
    LoginController loginController = Get.find();
    SideBarController controller = Get.find();
    return SizedBox(
        // color: Colors.amber,
        // height: height > 670 ? height : 670,
        height: 900,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/minia_logo.svg"),
                  LoginText(
                    color: AppColor.darkblack,
                    fontWeight: FontWeight.w800,
                    size: 20,
                    text: "Minia",
                  ),
                ],
              ),
              Spacer(),
              LoginText(
                color: AppColor.dark,
                fontWeight: FontWeight.w700,
                size: 18,
                text: "Welcome Back !",
              ),
              Container(height: 8),
              LoginText(
                  color: AppColor.lightdark,
                  text: "KERJAin",
                  size: 14,
                  fontWeight: FontWeight.w500),
              Container(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: LoginText(
                  text: "Username",
                  size: 14,
                  color: AppColor.dark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(height: 10),
              AuthFields(
                hint: 'Enter username',
                obscure: false,
              ),
              Container(height: 17),
              Row(
                children: [
                  LoginText(
                    text: "Password",
                    size: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w500,
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () => Get.to(() => ResetPassword()),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LoginText(
                          text: "Forgot password?",
                          size: 14,
                          color: AppColor.lightgrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 10),
              SizedBox(
                height: 40,
                child: Obx(() => TextFormField(
                      obscureText: loginController.isShow.value,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.hintcolor,
                        fontWeight: FontWeight.w400,
                      ),
                      autocorrect: true,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            loginController.isShow.value =
                                !loginController.isShow.value;
                          },
                          child: Container(
                            color: AppColor.boxborder,
                            width: 50,
                            child: Icon(
                              loginController.isShow.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        isDense: true,
                        // fillColor: AppColor.mainbackground,
                        hintText: "Enter password",
                        hintStyle: TextStyle(
                            color: AppColor.hintcolor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        // filled: true,
                        // fillColor: AppColor.boxborder.withOpacity(.50),
                        // fillColor: AppColor.lightwhite.withOpacity(.25),
                        // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide:
                              BorderSide(color: AppColor.borders, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: AppColor.borders),
                        ),
                      ),
                    )),
              ),
              Container(height: 17),
              Row(
                children: [
                  Checkbox(
                    side: BorderSide(color: AppColor.hintcolor),
                    // activeColor: Colors.amber,
                    // overlayColor: MaterialStatePropertyAll(
                    //   AppColor.darkGreen,
                    // ),
                    fillColor: WidgetStatePropertyAll(
                      valuefirst == true
                          ? AppColor.selecteColor
                          : AppColor.mainbackground,
                    ),
                    value: valuefirst,
                    onChanged: (value) {
                      setState(() {
                        valuefirst = value!;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: LoginText(
                      text: "Remember me",
                      size: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(height: 25),
              InkWell(
                onTap: () {
                  Get.offAll(SideBarPage());
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: AppColor.searchbackground),
                            ],
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.searchbackground,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: LoginText(
                              text: "Log in",
                              size: 14,
                              color: AppColor.mainbackground,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Container(height: 40),
              LoginText(
                text: "- Sign in with - ",
                size: 14,
                color: AppColor.lightgrey,
                fontWeight: FontWeight.w500,
              ),
              Container(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/facebook.svg"),
                  Container(width: 11),
                  SvgPicture.asset("assets/svg/twitter.svg"),
                  Container(width: 11),
                  SvgPicture.asset("assets/svg/google.svg")
                ],
              ),
              Container(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.lightgrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => Signup()),
                    child: Text(
                      ' Signup now',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColor.searchbackground,
                      ),
                    ),
                  ),
                  Spacer(flex: 2)
                ],
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: LoginText(
                        text: "© 2023 Minia. Crafted with",
                        size: 14,
                        color: AppColor.dark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(width: 4),
                  Icon(
                    Icons.favorite,
                    size: 14,
                    color: AppColor.darkred,
                  ),
                  Container(width: 4),
                  Expanded(
                    flex: 3,
                    child: LoginText(
                      text: "by Themesbrand",
                      size: 14,
                      color: AppColor.dark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(height: 20),
            ],
          ),
        ));
  }
}

class AuthFields extends StatelessWidget {
  final String hint;
  final bool obscure;

  const AuthFields({
    super.key,
    required this.hint,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        obscureText: obscure,
        initialValue: "",
        style: TextStyle(
          fontSize: 14,
          color: AppColor.hintcolor,
          fontWeight: FontWeight.w400,
        ),
        autocorrect: true,
        decoration: InputDecoration(
          isDense: true,
          // fillColor: AppColor.mainbackground,
          hintText: hint,
          hintStyle: TextStyle(
              color: AppColor.hintcolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          // filled: true,
          // fillColor: AppColor.boxborder.withOpacity(.50),
          // fillColor: AppColor.lightwhite.withOpacity(.25),
          // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: AppColor.borders, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: AppColor.borders),
          ),
        ),
      ),
    );
  }
}

Stack loginNews1(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/double_quote.svg"),
          Container(height: 25),
          Text(
            "“I feel confident imposing change on myself. It's a lot more progressing fun than looking back. That's why I ultricies enim at malesuada nibh diam on tortor neaded to throw curve balls.”",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColor.mainbackground,
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 40),
          Row(
            children: [
              Image.asset(
                "assets/image/avatar5.png",
                fit: BoxFit.cover,
                height: 48,
                width: 48,
              ),
              Container(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Richard Drews",
                    style: TextStyle(
                        color: AppColor.mainbackground,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: 10),
                  Text(
                    "Web Developer",
                    style: TextStyle(
                        color: AppColor.mainbackground.withOpacity(.50),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ],
      ))
    ],
  );
}

Stack loginNews2(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/double_quote.svg"),
          Container(height: 23),
          Text(
            "“Our task must be to free ourselves by widening our circle of compassion to embrace all living creatures and the whole of quis consectetur nunc sit amet semper justo. nature and its beauty.”",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColor.mainbackground,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 40),
          Row(
            children: [
              Image.asset(
                "assets/image/avatar.png",
                fit: BoxFit.cover,
                height: 48,
                width: 48,
              ),
              Container(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rosanna French",
                    style: TextStyle(
                        color: AppColor.mainbackground,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: 10),
                  Text(
                    "Web Developer",
                    style: TextStyle(
                        color: AppColor.mainbackground.withOpacity(.50),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ],
      ))
    ],
  );
}

Stack loginNews3(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/double_quote.svg"),
          Container(height: 25),
          Text(
            "“I've learned that people will forget what you said, people will forget what you did, but people will never forget how donec in efficitur lectus, nec lobortis metus you made them feel.”",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColor.mainbackground,
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 40),
          Row(
            children: [
              Image.asset(
                "assets/image/avatar2.png",
                fit: BoxFit.cover,
                height: 48,
                width: 48,
              ),
              Container(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ilse R. Eaton",
                    style: TextStyle(
                        color: AppColor.mainbackground,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: 10),
                  Text(
                    "Manager",
                    style: TextStyle(
                        color: AppColor.mainbackground.withOpacity(.50),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ],
      ))
    ],
  );
}

Stack imageLogin(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          "assets/image/login.png",
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: 10,
          colorsOfBubbles: [
            AppColor.lightgrey,
            AppColor.lightblue,
          ],
          sizeFactor: 0.05,
          opacity: 35,
          paintingStyle: PaintingStyle.fill,
          shape: BubbleShape.roundedRectangle,
          speed: BubbleSpeed.values[1],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.amber,
                  width: 787,
                  height: 400,
                  child: CarouselSlider(
                      items: [
                        loginNews1(context),
                        loginNews2(context),
                        loginNews3(context),
                      ],
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      )),
                  /*child: CarouselSlider(
                      images: [
                        loginNews1(context),
                        loginNews2(context),
                        loginNews3(context),
                      ],
                      dotPosition: DotPosition.bottomLeft,
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      // overlayShadowSize: 5.0,
                      // showIndicator: true,
                      boxFit: BoxFit.contain,
                      autoplayDuration: Duration(seconds: 6),
                      dotColor: AppColor.dotscolor,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.transparent,
                      borderRadius: false,
                    )*/
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class LoginText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double size;

  const LoginText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text, overflow: TextOverflow.fade,
      softWrap: false,
      // textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
