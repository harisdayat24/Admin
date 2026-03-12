// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/view/Tables/DataTable/data_paging.dart';
import 'package:minia_web_project/view/Tables/DataTable/data_sorting.dart';
import '../../../comman/widgets.dart';
import 'data_show_page.dart';

class DataTableMain extends StatefulWidget {
  const DataTableMain({super.key});

  @override
  State<DataTableMain> createState() => _DataTableMainState();
}

class _DataTableMainState extends State<DataTableMain> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? RowTitel(
                textL: "DataTables",
                texti: "Tables",
                textii: "DataTables",
              )
            : ColumnTitel(
                textL: "DataTables",
                texti: "Tables",
                textii: "DataTables",
              ),
        Container(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  "Default Datatable",
                  style: TextStyle(
                    fontSize: 15.4,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  "DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: \$().DataTable();.",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.lightgrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(color: AppColor.boxborder, thickness: 1),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15.0),
                child: Text(
                  "Data Shorting table",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  height: 485,
                  width: width,
                  child: DataSorting(),
                ),
              ),
            ],
          ),
        ),
        Container(height: 25),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  "Default Datatable",
                  style: TextStyle(
                    fontSize: 15.4,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  "DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: \$().DataTable();.",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.lightgrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(color: AppColor.boxborder, thickness: 1),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15.0),
                child: Text(
                  "Pagination table",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  height: 550,
                  width: width,
                  child: Pagination(),
                ),
              ),
            ],
          ),
        ),
        Container(height: 25),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  "Default Datatable",
                  style: TextStyle(
                    fontSize: 15.4,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  "DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function: \$().DataTable();.",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.lightgrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(color: AppColor.boxborder, thickness: 1),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15.0),
                child: Text(
                  "Page Selector",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  height: 550,
                  width: width,
                  child: PageSelecter(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
