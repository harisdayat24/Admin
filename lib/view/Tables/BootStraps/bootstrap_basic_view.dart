// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minia_web_project/view/Tables/BootStraps/hoverable_and_small.dart';
import 'package:minia_web_project/view/Tables/BootStraps/responsive.dart';
import 'package:minia_web_project/view/Tables/BootStraps/table_and_striped.dart';
import 'package:minia_web_project/view/Tables/BootStraps/table_and_table.dart';
import 'package:minia_web_project/view/Tables/BootStraps/vertical_and_nesting.dart';
import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';
import 'basic_and_dark.dart';
import 'border_and_borderless.dart';
import 'contextual_and_caption.dart';

class BootstrapBasic extends StatefulWidget {
  const BootstrapBasic({super.key});

  @override
  State<BootstrapBasic> createState() => _BootstrapBasicState();
}

class _BootstrapBasicState extends State<BootstrapBasic> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? RowTitel(
                  textL: "Bootstrap Basic Tables",
                  texti: "Tables",
                  textii: "Bootstrap Basic Tables",
                )
              : ColumnTitel(
                  textL: "Bootstrap Basic Tables",
                  texti: "Tables",
                  textii: "Bootstrap Basic Tables",
                ),
          Container(height: 20),
          // Text("$width"),
          // Basic Example & dark table //
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: BasicAndDark(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: Darktable(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: BasicAndDark(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: Darktable(),
                    ),
                  ],
                ),
          Container(height: 20),

          // Tables head & striped rows //
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: TableHead(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: StripedRows(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: TableHead(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: StripedRows(),
                    ),
                  ],
                ),
          Container(height: 20),

          // Bordered table & Borderless table //
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: Borderedtable(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: Borderless(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: Borderedtable(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: Borderless(),
                    ),
                  ],
                ),
          Container(height: 20),

          // table border color
          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: TableBorderColor(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: TableBorderColor(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: TableBorderColor(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: TableBorderColor(),
                    ),
                  ],
                ),
          Container(height: 20),

          // Vertical and Nesting

          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: VerticalA(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: NestingView(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: VerticalA(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: NestingView(),
                    ),
                  ],
                ),
          Container(height: 20),

          // hoverable & Small table

          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: HoverableRows(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: SmallTable(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: HoverableRows(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: SmallTable(),
                    ),
                  ],
                ),
          Container(height: 20),

          // Contextual classes & Captions

          width > 1000
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: ContextualClasses(),
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.boxborder)),
                        child: Caption(),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: ContextualClasses(),
                    ),
                    Container(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boxborder)),
                      child: Caption(),
                    ),
                  ],
                ),
          Container(height: 20),

          // Responsive table

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.boxborder)),
                  child: Responsivetable(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
