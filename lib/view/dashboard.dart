// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, depend_on_referenced_packages, non_constant_identifier_names, unused_local_variable, sized_box_for_whitespace

// import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minia_web_project/view/Forms/basic_elements_container/textaual.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../comman/colors.dart';
import '../comman/widgets.dart';
import 'Apps/chats/chatdetailpage.dart';
import 'Apps/chats/radial_chart.dart';
import 'Authentication/pages/login.dart';
import 'Drawer/map_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          if (width > 600)
            RowTitel(
              textL: "Dashboard",
              texti: "Dashboard",
              textii: "Dashboard",
            )
          else
            ColumnTitel(
              textL: 'Dashboard',
              texti: 'Dashboard',
              textii: 'Dashboard',
            ),
          Container(height: 20),
          SizedBox(
            height: (width > 1200)
                ? 150
                : (width > 900)
                    ? 300
                    : 600,
            child: Wallet(width: width),
          ),
          if (width > 1200) RowChar() else ColumnChart(),
          Container(height: 20),
          if (width > 1200) RowMarket() else ColumnMarket(),
          Container(height: 20),
          if (width > 1200) RowTrading() else ColumnTrading(),
        ],
      ),
    );
  }
}

List<PieChartSectionData> data = [
  PieChartSectionData(
      title: "58.3%",
      titleStyle: TextStyle(color: AppColor.mainbackground),
      color: Color(0xff5156BE),
      value: 60,
      titlePositionPercentageOffset: .70,
      radius: 80),
  PieChartSectionData(
      title: "12.5%",
      titleStyle: TextStyle(color: AppColor.mainbackground),
      color: Color(0xffA8AADA),
      value: 15,
      titlePositionPercentageOffset: .80,
      radius: 80),
  PieChartSectionData(
      title: "29.2%",
      titleStyle: TextStyle(color: AppColor.mainbackground),
      color: Color(0xff777ACA),
      value: 30,
      titlePositionPercentageOffset: .70,
      radius: 80),
];

class RowChar extends StatelessWidget {
  const RowChar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: WalletBalance()),
        Container(width: 20),
        Expanded(flex: 4, child: InvestedOverview()),
        Container(width: 20),
        Expanded(flex: 2, child: BitcoinNews()),
      ],
    );
  }
}

class RowMarket extends StatelessWidget {
  const RowMarket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(flex: 2, child: MarketOverview()),
        Container(width: 20),
        Expanded(
            flex: 1,
            child: Container(
              height: width > 600
                  ? 450
                  : width > 400
                      ? 750
                      : 500,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: Row(
                      children: [
                        Flexible(
                          // Wrap in Flexible
                          child: Text(
                            "Sales by Locations",
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 15.44,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Location(),
                  Container(height: 10),
                  ProgressBar(),
                ],
              ),
            )),
      ],
    );
  }
}

class RowTrading extends StatelessWidget {
  const RowTrading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // textDirection: TextDirection.rtl,
      children: [
        Expanded(flex: 1, child: TradingView()),
        Container(width: 20),
        Expanded(flex: 1, child: TransactionView()),
        Container(width: 20),
        Expanded(flex: 1, child: RecentActivity()),
      ],
    );
  }
}

class ColumnTrading extends StatefulWidget {
  const ColumnTrading({
    super.key,
  });

  @override
  State<ColumnTrading> createState() => _ColumnTradingState();
}

String isSelected = "All";
String isSelected2 = "Buy";

class _ColumnTradingState extends State<ColumnTrading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TradingView(),
        Container(height: 20),
        TransactionView(),
        Container(height: 20),
        RecentActivity(),
      ],
    );
  }
}

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  List<Map<String, String>> all = [
    {
      'buyname': 'Buy BTC',
      'date': '14 Mar, 2021',
      'coinvalue': '0.56 BTC',
      'amount': '\$125.20',
      'icon': 'assets/svg/down_arrow_circle.svg',
    },
    {
      'buyname': 'Sell BTC',
      'date': '15 Mar, 2021',
      'coinvalue': '0.016 BTC',
      'amount': '\$112.34',
      'icon': 'assets/svg/up_arrow_circle.svg',
    },
    {
      'buyname': 'Buy LTC',
      'date': '16 Mar, 2021',
      'coinvalue': '1.88 LTC',
      'amount': '\$94.22',
      'icon': 'assets/svg/down_arrow_circle.svg',
    },
    {
      'buyname': 'Sell BTC',
      'date': '18 Mar, 2021',
      'coinvalue': '0.070 BTC',
      'amount': '\$102.34',
      'icon': 'assets/svg/up_arrow_circle.svg',
    },
    {
      'buyname': 'Buy LTC',
      'date': '17 Mar, 2021',
      'coinvalue': '1.45 LTC',
      'amount': '\$89.22',
      'icon': 'assets/svg/down_arrow_circle.svg',
    },
    {
      'buyname': 'Sell BTC',
      'date': '31 Mar, 2021',
      'coinvalue': '0.49 BTC',
      'amount': '\$142.34',
      'icon': 'assets/svg/up_arrow_circle.svg',
    },
    {
      'buyname': 'Buy LTC',
      'date': '16 Mar, 2021',
      'coinvalue': '1.88 LTC',
      'amount': '\$94.22',
      'icon': 'assets/svg/down_arrow_circle.svg',
    },
  ];

  List<Map<String, String>> buy = [
    {
      'buyname': 'Buy BTC',
      'date': '14 Mar, 2021',
      'coinvalue': '0.016 BTC',
      'amount': '\$125.20',
    },
    {
      'buyname': 'Buy BTC',
      'date': '18 Mar, 2021',
      'coinvalue': '0.018 BTC',
      'amount': '\$145.80',
    },
    {
      'buyname': 'Buy LTC',
      'date': '16 Mar, 2021',
      'coinvalue': '1.78 LTC',
      'amount': '\$94.22',
    },
    {
      'buyname': 'Buy LTC',
      'date': '20 Mar, 2021',
      'coinvalue': '0.016 LTC',
      'amount': '\$105.20',
    },
    {
      'buyname': 'Buy BTC',
      'date': '21 Mar, 2021',
      'coinvalue': '0.018 BTC',
      'amount': '\$195.80',
    },
    {
      'buyname': 'Buy LTC',
      'date': '06 Mar, 2021',
      'coinvalue': '1.88 LTC',
      'amount': '\$110.22',
    },
    {
      'buyname': 'Buy BTC',
      'date': '18 Mar, 2021',
      'coinvalue': '0.018 BTC',
      'amount': '\$145.80',
    },
  ];

  List<Map<String, String>> sell = [
    {
      'buyname': 'Sell ETH',
      'date': '15 Mar, 2021',
      'coinvalue': '0.56 ETH',
      'amount': '\$112.34',
    },
    {
      'buyname': 'Sell ETH',
      'date': '14 Mar, 2021',
      'coinvalue': '0.016 ETH',
      'amount': '\$125.20',
    },
    {
      'buyname': 'Sell BTC',
      'date': '18 Mar, 2021',
      'coinvalue': '0.018 BTC',
      'amount': '\$145.80',
    },
    {
      'buyname': 'Sell LTC',
      'date': '19 Mar, 2021',
      'coinvalue': '0.49 ETH',
      'amount': '\$112.34',
    },
    {
      'buyname': 'Sell ETH',
      'date': '25 Mar, 2021',
      'coinvalue': '0.028 ETH',
      'amount': '\$125.20',
    },
    {
      'buyname': 'Sell BTC',
      'date': '16 Mar, 2021',
      'coinvalue': '0.098 BTC',
      'amount': '\$145.80',
    },
    {
      'buyname': 'Sell ETH',
      'date': '14 Mar, 2021',
      'coinvalue': '0.016 ETH',
      'amount': '\$125.20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 457,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Container(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 14, bottom: 0),
            child: Row(
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 15.44,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = 'All';
                    });
                  },
                  child: SizedBox(
                    height: 60,
                    width: width > 335 ? 60 : 30,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "All",
                        style: TextStyle(
                          color: isSelected == 'All'
                              ? AppColor.searchbackground
                              : AppColor.dark,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = 'Buy';
                    });
                  },
                  child: Container(
                    height: 60,
                    width: width > 335 ? 60 : 30,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Buy",
                        style: TextStyle(
                          color: isSelected == 'Buy'
                              ? AppColor.searchbackground
                              : AppColor.dark,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = 'Sell';
                    });
                  },
                  child: Container(
                    height: 60,
                    width: width > 335 ? 60 : 30,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Sell",
                        style: TextStyle(
                          color: isSelected == 'Sell'
                              ? AppColor.searchbackground
                              : AppColor.dark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(height: 2, color: AppColor.boxborder),
              ),
              Container(
                  height: 2,
                  width: width > 335 ? 60 : 30,
                  color: isSelected == "All"
                      ? AppColor.searchbackground
                      : AppColor.boxborder),
              Container(
                  height: 2,
                  width: width > 335 ? 60 : 30,
                  color: isSelected == "Buy"
                      ? AppColor.searchbackground
                      : AppColor.boxborder),
              Container(
                height: 2,
                width: width > 335 ? 60 : 30,
                color: isSelected == "Sell"
                    ? AppColor.searchbackground
                    : AppColor.boxborder,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 360,
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: buy.length,
                itemBuilder: (context, index) {
                  var width = MediaQuery.of(context).size.width;
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width < 401
                              ? 10
                              : width < 1200
                                  ? 30
                                  : 20,
                        ),
                        if (isSelected == "Buy")
                          SvgPicture.asset(
                            "assets/svg/down_arrow_circle.svg",
                            fit: BoxFit.contain,
                          )
                        else if (isSelected == "Sell")
                          SvgPicture.asset(
                            "assets/svg/up_arrow_circle.svg",
                            fit: BoxFit.contain,
                          )
                        else
                          SvgPicture.asset("${all[index]['icon']}"),
                        Container(
                          width: width < 401
                              ? 10
                              : width < 1200
                                  ? 30
                                  : 20,
                        ),
                        Expanded(
                          flex: width < 1385 ? 1 : 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isSelected == "Buy")
                                Text(
                                  '${buy[index]['buyname']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                )
                              else if (isSelected == "Sell")
                                Text(
                                  '${sell[index]['buyname']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                )
                              else
                                Text(
                                  '${all[index]['buyname']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                ),
                              Container(height: 5),
                              if (isSelected == "Buy")
                                Text(
                                  '${buy[index]['date']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightdark),
                                )
                              else if (isSelected == "Sell")
                                Text(
                                  '${sell[index]['date']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightdark),
                                )
                              else
                                Text(
                                  '${all[index]['date']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightdark),
                                )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (isSelected == "Buy")
                                Text(
                                  '${buy[index]['coinvalue']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                )
                              else if (isSelected == "Buy")
                                Text(
                                  '${sell[index]['coinvalue']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                )
                              else
                                Text(
                                  '${all[index]['coinvalue']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.dark),
                                ),
                              Text(
                                "Coin Value",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.lightdark),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (isSelected == "Buy")
                                Text(
                                  '${buy[index]['amount']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.lightdark),
                                )
                              else if (isSelected == "Sell")
                                Text(
                                  '${sell[index]['amount']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.lightdark),
                                )
                              else
                                Text(
                                  '${all[index]['amount']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.lightdark),
                                ),
                              Text(
                                "Amount",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.lightdark),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width < 401
                              ? 10
                              : width < 1200
                                  ? 30
                                  : 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TradingView extends StatefulWidget {
  const TradingView({super.key});

  @override
  State<TradingView> createState() => _TradingViewState();
}

class _TradingViewState extends State<TradingView> {
  String? _dropDownValue;
  String? _dropDownValue2;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 457,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, bottom: 0),
            child: Row(
              children: [
                Text(
                  "Trading",
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 15.44,
                    fontWeight: FontWeight.w600,
                    color: AppColor.dark,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected2 = "Buy";
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Buy",
                        style: TextStyle(
                          color: isSelected2 == "Buy"
                              ? AppColor.searchbackground
                              : AppColor.dark,
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(width: 22),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected2 = "Sell";
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Text(
                        "Sell",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected2 == "Sell"
                              ? AppColor.searchbackground
                              : AppColor.dark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 2,
                  color: AppColor.boxborder,
                )),
                Container(
                    height: 2,
                    width: 60,
                    color: isSelected2 == "Buy"
                        ? AppColor.searchbackground
                        : AppColor.boxborder),
                Container(
                  height: 2,
                  width: 60,
                  color: isSelected2 == "Sell"
                      ? AppColor.searchbackground
                      : AppColor.boxborder,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      isSelected2 == "Buy" ? "Buy Coins" : "Sell Coins",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.dark),
                    ),
                    Spacer(),
                    Icon(Icons.wallet),
                    Container(width: 10),
                    isSelected2 == "Buy"
                        ? Text("\$4335.23",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ))
                        : Text("\$4235.23",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                  ],
                ),
                Container(height: 18),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isSelected2 == "Buy" ? "Payment method :" : "Wallet ID :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.dark),
                  ),
                ),
                Container(height: 10),
                Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                          color: AppColor.boxborder,
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                    child: isSelected2 == "Buy"
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: _dropDownValue == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Direct Bank Payment',
                                          style: TextStyle(
                                              color: AppColor.dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _dropDownValue!,
                                        style: TextStyle(
                                            color: AppColor.dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(
                                  color: AppColor.dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              items: [
                                'Direct Bank Payment',
                                'Credit/Debit Card',
                                'Paypal',
                                'Payoneer',
                                'Stripe',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val,
                                        style: TextStyle(
                                            color: AppColor.dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val!;
                                  },
                                );
                              },
                            ),
                          )
                        : BasicTextFieldonly(
                            hintText: "1cvb256efsge5428fe",
                            obscure: false,
                          )),
                Container(height: 17),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Add Amount :",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.dark),
                  ),
                ),
                Container(height: 10),
                Container(),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.boxborder),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.dark),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        border: Border.all(
                            color: AppColor.boxborder,
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          underline: Container(color: AppColor.darkred),
                          hint: _dropDownValue2 == null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text('LTC'))
                              : Align(
                                  alignment: Alignment.center,
                                  child: Text(_dropDownValue2!)),
                          isExpanded: true,
                          iconSize: 30.0,
                          // style: TextStyle(color: AppColor.boxborder),
                          items: [
                            'LTC',
                            'BTC',
                            'ETH',
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
                    isSelected2 == "Buy"
                        ? Expanded(
                            child: BasicTextFieldonly(
                              hintText: "0.00121255",
                              //value: "",
                              obscure: false,
                            ),
                          )
                        : Expanded(
                            child: BasicTextFieldonly2(
                              hintText: "0.00121255",
                              //value: "",
                              obscure: false,
                            ),
                          ),
                  ],
                ),
                Container(height: 14),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.boxborder),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Price",
                        ),
                      ),
                    ),
                    isSelected2 == "Buy"
                        ? Expanded(
                            child: BasicTextFieldonly(
                              hintText: "\$58,245",
                              //value: "",
                              obscure: false,
                            ),
                          )
                        : Expanded(
                            child: BasicTextFieldonly2(
                              hintText: "\$23,754.54",
                              //value: "",
                              obscure: false,
                            ),
                          ),
                    Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.boxborder),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.attach_money_sharp),
                      ),
                    ),
                  ],
                ),
                Container(height: 14),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.boxborder),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Total",
                        ),
                      ),
                    ),
                    isSelected2 == "Buy"
                        ? Expanded(
                            child: BasicTextFieldonly(
                              hintText: "\$36,854.25",
                              //value: "",
                              obscure: false,
                            ),
                          )
                        : Expanded(
                            child: BasicTextFieldonly2(
                              hintText: "\$6,852.41",
                              //value: "",
                              obscure: false,
                            ),
                          ),
                  ],
                ),
                Container(height: 14),
                Container(
                  height: 38,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shadowColor: isSelected2 == "Buy"
                          ? AppColor.background
                          : AppColor.darkred,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      backgroundColor: isSelected2 == "Buy"
                          ? AppColor.background
                          : AppColor.darkred,
                    ),
                    child: Text(
                      isSelected2 == "Buy" ? "Buy Coin" : "Sell Coin",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.mainbackground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColumnMarket extends StatelessWidget {
  const ColumnMarket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MarketOverview(),
        Container(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 21),
                child: Row(
                  children: [
                    Text(
                      "Sales by Locations",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dark,
                      ),
                    ),
                  ],
                ),
              ),
              Location(),
              Container(height: 10),
              ProgressBar(),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnChart extends StatelessWidget {
  const ColumnChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WalletBalance(),
        Container(height: 15),
        InvestedOverview(),
        Container(height: 15),
        BitcoinNews()
      ],
    );
  }
}

class BitcoinNews extends StatelessWidget {
  const BitcoinNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: width < 320
          ? 320
          : width < 530
              ? 280
              : width < 1201
                  ? 250
                  : width < 1275
                      ? 350
                      : 307,
      child: CarouselSlider(
          items: [
            BitNews(context),
            BitNews(context),
            BitNews(context),
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
      /*child: Carousel(
          images: [

          ],
          dotSize: 5.0,
          dotSpacing: 15.0,
          dotColor: AppColor.dotscolor,
          indicatorBgPadding: 12.0,
          dotBgColor: Colors.transparent,
          borderRadius: true,
        )*/
    );
  }
}
// class BitcoinNews extends StatefulWidget {
//   const BitcoinNews({
//     super.key,
//   });

//   @override
//   State<BitcoinNews> createState() => _BitcoinNewsState();
// }

// class _BitcoinNewsState extends State<BitcoinNews> {
//   List<Widget> imageList = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize imageList here if necessary
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Update imageList here based on the new MediaQuery or other inherited widget changes
//     // imageList = [
//     //   BitNews(),
//     //   BitNews(),
//     //   BitNews(),
//     // ];
//   }

//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         Container(
//           color: AppColor.darkyellow,
//           width: width,
//           height: width > 400 ? 300 : 500,
//           // height: width < 320
//           //     ? 320
//           //     : width < 530
//           //         ? 280
//           //         : width < 1201
//           //             ? 250
//           //             : width < 1275
//           //                 ? 350
//           //                 : 307,
//           child: Column(
//             children: [
//               Carousel(
//                 images: [
//                   BitNews(context),
//                   BitNews(context),
//                   BitNews(context),
//                 ],
//                 dotSize: 5.0,
//                 dotSpacing: 15.0,
//                 dotColor: AppColor.dotscolor,
//                 indicatorBgPadding: 12.0,
//                 dotBgColor: Colors.transparent,
//                 borderRadius: true,
//               ),
//               // Expanded(
//               //   child: CarouselSlider(
//               //     options: CarouselOptions(
//               //       autoPlay: true,
//               //       viewportFraction: 1,
//               //       // enlargeCenterPage: true,
//               //       onPageChanged: (index, reason) {
//               //         setState(() {
//               //           currentIndex = index;
//               //         });
//               //       },
//               //     ),
//               //     items: imageList.map((item) {
//               //       return Builder(
//               //         builder: (BuildContext context) {
//               //           return item;
//               //         },
//               //       );
//               //     }).toList(),
//               //   ),
//               // ),
//               // DotsIndicator(
//               //   dotsCount: imageList.length,
//               //   position: currentIndex,
//               //   decorator: DotsDecorator(
//               //     color: AppColor.dotscolor,
//               //     activeColor: AppColor.mainbackground,
//               //     activeSize: Size.fromRadius(5),
//               //     spacing: EdgeInsets.only(left: 3.5, right: 3.5, bottom: 10),
//               //     size: Size(10, 10),
//               //     activeShape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(5.0),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

Container BitNews(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Container(
    color: AppColor.selecteColor,
    // color: Colors.amber,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/svg/bitcoin_news.svg",
          width: width,
          fit: BoxFit.fitWidth,
        ),
        Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            SvgPicture.asset(
              "assets/svg/bitcoin.svg",
            ),
            SizedBox(height: 18),
            Text(
              "Bitcoin News",
              style: TextStyle(
                  color: AppColor.mainbackground,
                  fontSize: 21,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Bitcoin prices fell sharply amid the global sell-off in equities. Negative news over the Bitcoin past week has dampened Bitcoin basics entiment for bitcoin.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.mainbackground.withOpacity(.80),
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 103,
              height: 30,
              decoration: BoxDecoration(
                  color: AppColor.boxborder,
                  borderRadius: BorderRadius.circular(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "View details",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 12,
                    color: AppColor.black,
                  )
                ],
              ),
            ),
          ],
        ))
      ],
    ),
  );
}

class WalletBalance extends StatefulWidget {
  const WalletBalance({
    super.key,
  });

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  late List<ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  int selectedOption = -1;

  @override
  initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: width,
      height: width < 325
          ? 580
          : width < 601
              ? 520
              : width < 1275
                  ? 350
                  : 307,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 20.0,
                left: 16.0,
                right: 15,
                bottom: width < 1470 ? 20.0 : 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Wallet Balance",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15.44,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                ),
                Spacer(),
                buildOptionButton(0, 'ALL', AppColor.lightgrey),
                buildOptionButton(1, '1M', AppColor.selecteColor),
                buildOptionButton(2, '6M', AppColor.lightgrey),
                buildOptionButton(3, '1Y', AppColor.lightgrey),
              ],
            ),
          ),
          width > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          ),
                      width: width < 1201
                          ? 250
                          : width < 1470
                              ? 150
                              : width < 1485
                                  ? 200
                                  : 250,
                      height: width < 1201
                          ? 250
                          : width < 1470
                              ? 150
                              : width < 1485
                                  ? 200
                                  : 250,
                      // width: 200,
                      child: SfCircularChart(
                        borderWidth: 0,
                        enableMultiSelection: true,
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: _chartData,
                            xValueMapper: (ChartData data, _) => data.text,
                            yValueMapper: (ChartData data, _) => data.textnum,
                            pointColorMapper: (ChartData data, _) => data.color,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle:
                                    TextStyle(color: AppColor.mainbackground)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 220,
                      // color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 10),
                          WalletBalanceText(
                            title: "Bitcoin",
                            textleft: "0.4412 BTC",
                            textright: " = \$ 4025.32",
                            dotcolor: AppColor.background,
                          ),
                          WalletBalanceText(
                            title: "Ethereum",
                            textleft: "4.5701 ETH",
                            textright: " = \$ 1123.64",
                            dotcolor: AppColor.selecteColor,
                          ),
                          WalletBalanceText(
                            title: "Litecoin",
                            textleft: "35.3811 LTC",
                            textright: " = \$ 2263.09",
                            dotcolor: AppColor.darkblue,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 209,
                      width: 227,
                      child: SfCircularChart(
                        enableMultiSelection: true,
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: _chartData,
                            xValueMapper: (ChartData data, _) => data.text,
                            yValueMapper: (ChartData data, _) => data.textnum,
                            pointColorMapper: (ChartData data, _) => data.color,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle:
                                    TextStyle(color: AppColor.mainbackground)),
                          )
                        ],
                      ),
                    ),
                    Container(height: 30),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WalletBalanceText(
                            title: "Bitcoin",
                            textleft: "0.4412 BTC",
                            textright: " = \$ 4025.32",
                            dotcolor: AppColor.background,
                          ),
                          WalletBalanceText(
                            title: "Ethereum",
                            textleft: "4.5701 ETH",
                            textright: " = \$ 1123.64",
                            dotcolor: AppColor.selecteColor,
                          ),
                          WalletBalanceText(
                            title: "Litecoin",
                            textleft: "35.3811 LTC",
                            textright: " = \$ 2263.09",
                            dotcolor: AppColor.darkblue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget buildOptionButton(int option, String label, Color color) {
    const selectedColor = Colors.red;
    const unselectedColor = Colors.yellow;
    final buttonColor =
        selectedOption == option ? selectedColor : unselectedColor;
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOption = option;
          });
        },
        child: Container(
          height: 28,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: buttonColor == selectedColor
                ? color
                : AppColor.lightgrey.withOpacity(.08),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: buttonColor == selectedColor
                      ? AppColor.mainbackground
                      : AppColor.lightgrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}

List<ChartData> getChartData() {
  final List<ChartData> chartData = [
    ChartData("Litecoin", 18, Color(0xFFA8AADA)),
    ChartData("Ethereum", 30, Color(0xFF777ACA)),
    ChartData("Bitcoin", 60, Color(0xFF5156BE)),
  ];
  return chartData;
}

class ChartData {
  ChartData(this.text, this.textnum, this.color);
  final String text;
  final dynamic textnum;
  final Color color;
}

class MarketOverview extends StatefulWidget {
  const MarketOverview({
    super.key,
  });

  @override
  State<MarketOverview> createState() => _MarketOverviewState();
}

class _MarketOverviewState extends State<MarketOverview> {
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: width,
      height: width < 300
          ? 1000
          : width < 322
              ? 950
              : width < 381
                  ? 900
                  : width < 751
                      ? 865
                      : width > 600
                          ? 450
                          : width > 400
                              ? 750
                              : 500,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Market Overview",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15.44,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                ),
                Spacer(),
                buildOptionButton(0, 'ALL', AppColor.selecteColor),
                buildOptionButton(1, '1M', AppColor.lightgrey),
                buildOptionButton(2, '6M', AppColor.lightgrey),
                buildOptionButton(3, '1Y', AppColor.lightgrey),
              ],
            ),
          ),
          Container(height: 30),
          if (width > 750)
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 20),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: width > 600 ? 330 : 350,
                    child: VerticalChart(),
                  ),
                ),
                // Spacer(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      MarketText(),
                      Row(
                        children: [
                          Container(width: 30),
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
                                    text: "See All Balances ->",
                                    size: 14,
                                    color: AppColor.mainbackground,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          Container(width: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15),
                  child: Container(
                    width: width,
                    height: 400,
                    child: VerticalChart(),
                  ),
                ),
                // Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MarketText(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          height: 38,
                          width: width,
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
                              text: "See All Balances ->",
                              size: 14,
                              color: AppColor.mainbackground,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          Container(height: 30),
        ],
      ),
    );
  }

  Widget buildOptionButton(int option, String label, Color color) {
    const selectedColor = Colors.red;
    const unselectedColor = Colors.yellow;
    final buttonColor =
        selectedOption == option ? selectedColor : unselectedColor;
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOption = option;
          });
        },
        child: Container(
          height: 28,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: buttonColor == selectedColor
                ? color
                : AppColor.lightgrey.withOpacity(.08),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: buttonColor == selectedColor
                      ? AppColor.mainbackground
                      : AppColor.lightgrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    String selectedMonth = 'Today';
    final List<String> months = [
      'Today',
      'Yesterday',
      'Last Week',
      'Last Month',
    ];
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: width,
      height: width < 400 ? 500 : 457,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 14, bottom: 10, right: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Recent Activity",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15.44,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 28,
                  width: 108,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.dark,
                      width: .20,
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    decoration: InputDecoration.collapsed(hintText: ''),
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          Container(height: 2, color: AppColor.boxborder),
          Container(height: 20),
          Container(
            height: 360,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      AppIcons(
                        iconup: 'assets/svg/dashboard/btc.svg',
                        // icondown: 'assets/svg/dashboard/eth.svg',
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "+0.5 BTC",
                        price: " \$178.53",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppIcons(
                        iconup: 'assets/svg/dashboard/eth.svg',
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "-20.5 ETH",
                        price: " \$3541.45",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppIcons(
                        iconup: 'assets/svg/dashboard/btc.svg',
                        // icondown: 'assets/svg/dashboard/eth.svg',
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "+0.5 BTC",
                        price: " \$5791.45",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppIcons(
                        iconup: 'assets/svg/dashboard/ltc.svg',
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "-1.5 LTC",
                        price: " \$5791.45",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppIcons(
                        iconup: 'assets/svg/dashboard/btc.svg',
                        // icondown: 'assets/svg/dashboard/ltc.svg',
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "+.55 LTC",
                        price: " \$91.45",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                                  'assets/svg/dashboard/ltc.svg'),
                            ),
                          ],
                        ),
                      ),
                      IconsText(
                        date: "24/05/2021, 18:24:56",
                        mixs:
                            "0xb77ad0099e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1e21d4fc1",
                        btctext: "+0.5 BTC",
                        price: " \$178.53",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconsText extends StatelessWidget {
  final String date;
  final String mixs;
  final String btctext;
  final String price;
  const IconsText({
    super.key,
    required this.date,
    required this.mixs,
    required this.btctext,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 6,
      child: Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mixs,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.lightdark,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(width: width < 300 ? 1 : 20),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        btctext,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.more_vert_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppIcons extends StatelessWidget {
  final String iconup;

  const AppIcons({
    super.key,
    required this.iconup,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            child: SvgPicture.asset(iconup),
          ),
          Dash(
            direction: Axis.vertical,
            length: 35,
            dashLength: 5,
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class LeftTimeline extends StatelessWidget {
  final String picture;
  final String title;
  final String description;
  const LeftTimeline({
    super.key,
    required this.picture,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Location extends StatelessWidget {
  const Location({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width > 600 ? 230 : 350,
      child: Maps(),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "USA",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text("75%"),
                ],
              )),
          Container(height: 10),
          LinearPercentIndicator(
            barRadius: Radius.circular(4),
            width: width > 1400
                ? width / 3 - 150
                : width > 1200
                    ? width / 4 - 50
                    : width > 983
                        ? width - 350
                        : width - 100,
            lineHeight: 5.0,
            addAutomaticKeepAlive: true,
            percent: 0.75,
            progressColor: AppColor.selecteColor,
          ),
          Container(height: 16),
          Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                children: [
                  Text(
                    "Russia",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text("55%"),
                ],
              )),
          Container(height: 10),
          LinearPercentIndicator(
            barRadius: Radius.circular(4),
            width: width > 1400
                ? width / 3 - 150
                : width > 1200
                    ? width / 4 - 50
                    : width > 983
                        ? width - 350
                        : width - 100,
            lineHeight: 5.0,
            percent: 0.55,
            progressColor: AppColor.selecteColor,
          ),
          Container(height: 16),
          Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                children: [
                  Text(
                    "Australia",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text("85%"),
                ],
              )),
          Container(height: 10),
          LinearPercentIndicator(
            barRadius: Radius.circular(4),
            width: width > 1400
                ? width / 3 - 150
                : width > 1200
                    ? width / 4 - 50
                    : width > 983
                        ? width - 350
                        : width - 100,
            lineHeight: 5.0,
            percent: .85,
            progressColor: AppColor.selecteColor,
          )
        ],
      ),
    );
  }
}

class InvestedOverview extends StatefulWidget {
  const InvestedOverview({
    super.key,
  });

  @override
  State<InvestedOverview> createState() => _InvestedOverviewState();
}

class _InvestedOverviewState extends State<InvestedOverview> {
  String selectedMonth = 'May';
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: width,
      height: width < 336
          ? 550
          : width < 601
              ? 480
              : width < 1275
                  ? 350
                  : 307,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                  child: Text(
                    "Invested Overview",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 15.44,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  height: 28,
                  width: 105,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.dark,
                      width: .20,
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    decoration: InputDecoration.collapsed(hintText: ''),
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 30),
          width > 600
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // color: Colors.amber,
                      height: width < 1201
                          ? 250
                          : width < 1470
                              ? 150
                              : width < 1485
                                  ? 200
                                  : 180,
                      width: width < 1201
                          ? 250
                          : width < 1470
                              ? 150
                              : width < 1485
                                  ? 200
                                  : 180,
                      child: RadialChart(),
                    ),
                    Container(
                      width: width < 1340
                          ? 180
                          : width < 1554
                              ? 200
                              : 250,
                      child: InvestedAmount(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: 172,
                      width: 172,
                      child: RadialChart(),
                    ),
                    // Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: InvestedAmount(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class WalletBalanceText extends StatelessWidget {
  final String title;
  final String textleft;
  final String textright;
  final Color dotcolor;

  const WalletBalanceText({
    super.key,
    required this.title,
    required this.textleft,
    required this.textright,
    required this.dotcolor,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Container(
      height: 60,
      // color: AppColor.darkGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: dotcolor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Container(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: AppColor.dark,
                ),
              )
            ],
          ),
          Container(height: 9),
          Row(
            children: [
              Text(
                textleft,
                style: TextStyle(
                  fontSize: 14,
                  height: .18,
                  color: AppColor.dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                textright,
                style: TextStyle(
                  fontSize: 14,
                  height: .18,
                  color: AppColor.lightgrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(height: 20),
        ],
      ),
    );
  }
}

class MarketText extends StatelessWidget {
  const MarketText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowChartTexts(
          image: "assets/svg/wallets/Badge_3.svg",
          num: '1',
          text: 'Coinmarketcap',
        ),
        Container(height: 20),
        RowChartTexts(
          image: "assets/svg/wallets/Badge_5.svg",
          num: '2',
          text: 'Binance',
        ),
        Container(height: 20),
        RowChartTexts(
          image: "assets/svg/wallets/Badge_2.svg",
          num: '3',
          text: 'Coinbase',
        ),
        Container(height: 20),
        RowChartTexts(
          image: "assets/svg/wallets/Badge_4.svg",
          num: '4',
          text: 'Yobit',
        ),
        Container(height: 20),
        RowChartTexts(
          image: "assets/svg/wallets/Badge_1.svg",
          num: '5',
          text: 'Bitfinex',
        ),
        Container(height: 20),
      ],
    );
  }
}

class RowChartTexts extends StatelessWidget {
  final String text;
  final String num;
  final String image;

  const RowChartTexts({
    super.key,
    required this.text,
    required this.num,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: width < 751
          ? EdgeInsets.only(left: 20, right: 20)
          : EdgeInsets.all(0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width < 1365
                ? 5
                : width < 1452
                    ? 15
                    : width < 1495
                        ? 20
                        : 30,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColor.boxborder.withOpacity(.40),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Center(
                child: Text(
                  num,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.dark,
                  ),
                ),
              )
            ],
          ),
          Container(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              text,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.dark,
              ),
            ),
          ),
          Spacer(flex: 1),
          SvgPicture.asset(
            image,
          ),
          Container(
            width: width < 1365
                ? 5
                : width < 1452
                    ? 15
                    : width < 1495
                        ? 20
                        : 30,
          ),
        ],
      ),
    );
  }
}

class InvestedAmount extends StatelessWidget {
  const InvestedAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Invested Amount",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.lightdark,
          ),
        ),
        Container(height: 5),
        Text(
          "\$ 6134.39",
          style: TextStyle(
            fontSize: 21,
            color: AppColor.dark,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 8),
        Row(
          children: [
            Text(
              "+ 0.0012.23(0.2 %)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.lightdark,
              ),
            ),
            Container(width: 5),
            Icon(
              Icons.arrow_upward,
              size: 18,
              color: AppColor.background,
            )
          ],
        ),
        Container(height: 27),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INCOME",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColor.lightdark,
                  ),
                ),
                Container(height: 9),
                Text(
                  "\$ 2632.46",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "EXPENSES",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColor.lightdark,
                  ),
                ),
                Container(height: 9),
                Text(
                  "-\$ 924.38",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(height: 15),
        Container(
          width: 96,
          height: 29,
          decoration: BoxDecoration(
              color: AppColor.selecteColor,
              borderRadius: BorderRadius.circular(3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "View more",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.mainbackground,
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 12,
                color: AppColor.mainbackground,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (width > 1200)
            ? 4
            : (width > 900)
                ? 2
                : 1,
        crossAxisSpacing: 20,
        childAspectRatio: 18 / 8,
        mainAxisExtent: 130,
        mainAxisSpacing: (width > 1200)
            ? 0
            : (width > 900)
                ? 20
                : 20,
      ),
      children: [
        wallets(
          width: width,
          text: "My Wallet",
          amounts: "\$865.2k",
          profiteimage: "assets/svg/wallets/1_badge.svg",
          data: [
            0.0,
            1.0,
            -1.0,
            1.0,
            0.0,
            1.0,
            1.5,
            2.0,
            0.0,
            0.0,
            -0.5,
            -1.0,
            -0.5,
            0.0,
            0.0
          ],
        ),
        wallets(
          width: width,
          text: "Number of Trades",
          amounts: "6258",
          profiteimage: "assets/svg/wallets/2_badge.svg",
          data: [
            0.0,
            0.0,
            -0.5,
            -1.0,
            -0.5,
            0.0,
            0.0,
            1.0,
            -1.0,
            1.0,
            0.0,
            1.0,
            1.5,
            2.0,
          ],
        ),
        wallets(
          width: width,
          text: "Invested Amount",
          amounts: "\$4.32M",
          profiteimage: "assets/svg/wallets/3_badge.svg",
          data: [
            -0.5,
            -1.0,
            -0.5,
            0.0,
            0.0,
            1.0,
            1.5,
            2.0,
            0.0,
            1.0,
            -1.0,
            1.0,
            0.0,
            0.0,
            0.0
          ],
        ),
        wallets(
          width: width,
          text: "Profit Ration",
          amounts: "12.57%",
          profiteimage: "assets/svg/wallets/4_badge.svg",
          data: [
            1.0,
            -0.5,
            0.0,
            0.0,
            0.0,
            0.0,
            1.0,
            -1.0,
            1.0,
            -0.5,
            -1.0,
            1.5,
            2.0,
            0.0,
            0.0
          ],
        ),
      ],
    );
  }
}
