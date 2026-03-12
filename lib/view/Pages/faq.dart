// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../comman/colors.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (width > 600) rowFaq() else columnFaq(),
          Container(height: 20),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Can't find what you are looking for?",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  Text(
                    "If several languages coalesce, the grammar of the resulting language is more simple and regular than that of the individual",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.dark,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(height: 25),
                  width > 300 ? FaQButtons(width) : FaQButtonsExpanded(),
                  Container(height: 40),
                  width > 900
                      ? SizedBox(
                          height: 40,
                          width: width / 3,
                          child: TextFormField(
                              decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            hintText: "search...",
                            hintStyle:
                                TextStyle(fontSize: 14, color: AppColor.black),
                            fillColor: AppColor.textfiledcolor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(
                                  right: 6,
                                  top: 4,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.searchbackground,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: SvgPicture.asset(
                                    "assets/svg/topbar_search.svg"),
                              ),
                            ),
                          )),
                        )
                      : Container(),
                  Container(height: 40),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > 968
                          ? 3
                          : width > 575
                              ? 2
                              : 1,
                      mainAxisExtent: 170,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder),
                          borderRadius: BorderRadius.circular(4),
                          // color: Colors.amber,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SvgPicture.asset(
                                "assets/svg/half_question.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                15.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "01",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.searchbackground,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "What is Lorem Ipsum?",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "New common language will be more simple and regular than the existing European languages. It will be as simple as occidental.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.dark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(height: 120),
        ],
      ),
    );
  }

  Row FaQButtons(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.searchbackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Email Us",
                style: TextStyle(fontSize: 15, color: AppColor.mainbackground),
              ),
            ),
          ),
        ),
        Container(width: 10),
        InkWell(
          onTap: () {},
          child: Container(
            width: width < 350 ? 100 : 150,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.darkGreen,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Send us a tweet",
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 15, color: AppColor.mainbackground),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row FaQButtonsExpanded() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.searchbackground,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Email",
                  style:
                      TextStyle(fontSize: 15, color: AppColor.mainbackground),
                ),
              ),
            ),
          ),
        ),
        Container(width: 10),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.darkGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Send us a tweet",
                  style:
                      TextStyle(fontSize: 15, color: AppColor.mainbackground),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Row rowFaq() {
  return Row(
    children: [
      Text(
        "FAQs",
        style: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      Spacer(),
      Text(
        "Pages",
        style: TextStyle(
          color: AppColor.dark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      Container(width: 10),
      Icon(Icons.chevron_right),
      Container(width: 10),
      Text(
        "FAQs",
        style: TextStyle(
          color: AppColor.lightdark,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Column columnFaq() {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "FAQs",
          style: TextStyle(
            color: AppColor.dark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      Row(
        children: [
          Text(
            "Pages",
            style: TextStyle(
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Container(width: 2),
          Icon(Icons.chevron_right),
          Text(
            "FAQs",
            style: TextStyle(
              color: AppColor.lightdark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  );
}
