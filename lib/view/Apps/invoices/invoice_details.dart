// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RowTitel(
                  textL: "Invoice Detail",
                  texti: "Invoices",
                  textii: "Invoice Detail",
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ColumnTitel(
                  textL: "Invoice Detail",
                  texti: "Invoices",
                  textii: "Invoice Detail",
                ),
              ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: AppColor.boxborder,
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/minia_logo.svg",
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      Container(width: 5),
                      InvoiceText(
                        text: "Minia",
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Spacer(),
                      InvoiceText(
                        text: "Invoice # 12345",
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Container(height: 27),
                  InvoiceText(
                    text: "1874 County Line Road City, FL 33566",
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(height: 7),
                  Row(
                    children: [
                      Icon(Icons.mail, size: 15),
                      Container(width: 5),
                      InvoiceText(
                        text: "abc@123.com",
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Container(height: 7),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 15),
                      Container(width: 5),
                      InvoiceText(
                        text: "012-345-6789",
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Container(height: 22),
                  Divider(color: AppColor.boxborder),
                  Container(height: 15),
                  width > 600
                      ? Row(
                          children: [
                            Flexible(flex: 1, child: bill1()),
                            Container(width: 10),
                            Flexible(flex: 1, child: bill2()),
                          ],
                        )
                      : Column(
                          children: [
                            bill1(),
                            Container(height: 10),
                            bill2(),
                          ],
                        ),
                  Container(height: 45),
                  InvoiceText(
                    text: "Order summary",
                    size: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AppColor.boxborder,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 38),
                          Row(
                            children: [
                              Container(width: 10),
                              InvoiceText(
                                text: "No.",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: 40),
                              InvoiceText(
                                text: "Item",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              InvoiceText(
                                text: "price",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Container(height: 10),
                          Divider(color: AppColor.boxborder),
                          Container(height: 8),
                          Row(
                            children: [
                              Container(width: 10),
                              InvoiceText(
                                text: "01",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: 45),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InvoiceText(
                                      text: "Minia",
                                      size: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Container(height: 5),
                                    InvoiceText(
                                      text: "Bootstrap 5 Admin Dashboard",
                                      size: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox.shrink(),
                              InvoiceText(
                                text: "\$499.00",
                                size: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(height: 10),
                          Divider(color: AppColor.boxborder),
                          Container(height: 8),
                          Row(
                            children: [
                              Container(width: 10),
                              InvoiceText(
                                text: "02",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: 43),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InvoiceText(
                                      text: "Skote",
                                      size: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Container(height: 5),
                                    InvoiceText(
                                      text: "Bootstrap 5 Admin Dashboard",
                                      size: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox.shrink(),
                              InvoiceText(
                                text: "\$499.00",
                                size: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(height: 10),
                          Divider(color: AppColor.boxborder),
                          Container(height: 8),
                          Row(
                            children: [
                              Spacer(),
                              InvoiceText(
                                text: "Sub Total",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: width > 335 ? 70 : 35),
                              InvoiceText(
                                text: "\$998.00",
                                size: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(height: 10),
                          Divider(color: AppColor.boxborder),
                          Container(height: 8),
                          Row(
                            children: [
                              Spacer(),
                              InvoiceText(
                                text: "Tax",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: 80),
                              InvoiceText(
                                text: "\$12.00",
                                size: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(height: 20),
                          Row(
                            children: [
                              Spacer(),
                              InvoiceText(
                                text: "Total",
                                size: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(width: 30),
                              InvoiceText(
                                text: "\$1010.00",
                                size: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Container(height: 30),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 38,
                        width: 40,
                        padding: EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.darkGreen,
                                blurRadius: 2,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.darkGreen),
                        child: SvgPicture.asset(
                          "assets/svg/mail_in.svg",
                          // fit: BoxFit.contain,
                          // height: 10,
                          // width: 10,
                        ),
                      ),
                      Container(width: 7),
                      Container(
                          height: 38,
                          width: 110,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.searchbackground,
                                  blurRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.searchbackground),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Send",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.mainbackground,
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column bill2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvoiceText(
          text: "Order Date:",
          size: 15,
          fontWeight: FontWeight.w600,
        ),
        Container(height: 6),
        InvoiceText(
          text: "February 16, 2020",
          size: 14,
          fontWeight: FontWeight.w400,
        ),
        Container(height: 15),
        InvoiceText(
          text: "Payment Method:",
          size: 15,
          fontWeight: FontWeight.w600,
        ),
        Container(height: 8),
        InvoiceText(
          text: "Visa ending **** 4242\nrichards@email.com",
          size: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Column bill1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvoiceText(
          text: "Billed To:",
          size: 15,
          fontWeight: FontWeight.w600,
        ),
        Container(height: 14),
        InvoiceText(
          text: "Richard Saul",
          size: 14,
          fontWeight: FontWeight.w600,
        ),
        Container(height: 9),
        InvoiceText(
          text:
              "1208 Sherwood Circle Lafayette, LA 70506\nRichardSaul@rhyta.com\n337-256-9134",
          size: 14,
          fontWeight: FontWeight.w400,
        ),
        Container(height: 10),
      ],
    );
  }
}

class InvoiceText extends StatelessWidget {
  final String text;
  final double size;

  final FontWeight fontWeight;

  const InvoiceText({
    super.key,
    required this.text,
    required this.size,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        overflow: TextOverflow.ellipsis,
        color: AppColor.dark,
        fontWeight: fontWeight,
        height: 1.6,
      ),
    );
  }
}
