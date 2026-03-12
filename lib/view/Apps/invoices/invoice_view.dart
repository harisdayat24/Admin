// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/controller/dashboard_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../comman/text_style.dart';
import '../../../comman/widgets.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({super.key});

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  late EmployeeData _employeeDataSource;

  List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeData(employees: _employees);
  }

  DateTimeRange? selectedDateRange;

  Future<void> chooseDateRangePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      // keyboardType: TextInputType.numberWithOptions(),

      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
        start: DateTime.now(),
      ),
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // color: Colors.amber,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500.0,
                    maxHeight: 450.0,
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      // height: height,
      // width: width,

      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (width > 600)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RowTitel(
                  textL: "Invoice List",
                  texti: "Invoices",
                  textii: "Invoice List",
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ColumnTitel(
                  textL: "Invoice List",
                  texti: "Invoices",
                  textii: "Invoice List",
                ),
              ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: .99,
                                    offset: Offset(1, 1),
                                    color: AppColor.boxborder),
                              ],
                              color: AppColor.boxborder,
                              borderRadius: BorderRadius.circular(4)),
                          height: 38,
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "+   Add Invoice",
                                  style: TextStyle(
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        width > 576
                            ? Row(
                                children: [
                                  Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                          color: AppColor.lightblue,
                                          border: Border.all(
                                              color: AppColor.boxborder)),
                                      child: (selectedDateRange != null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    selectedDateRange!.start
                                                        .toString()
                                                        .split(' ')[0],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Container(width: 5),
                                                  Text(
                                                    "to",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Container(width: 5),
                                                  Text(
                                                    selectedDateRange!.end
                                                        .toString()
                                                        .split(' ')[0],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(width: 150)),
                                  InkWell(
                                    onTap: () {
                                      chooseDateRangePicker(context);
                                    },
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                          color: AppColor.lightblue,
                                          border: Border.all(
                                              color: AppColor.boxborder)),
                                      child: Icon(
                                        Icons.calendar_month_rounded,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    Container(height: 20),
                    /////
                    width > 576
                        ? Text("Show")
                        : selectedDateRange != null
                            ? ColumnInvoice(
                                ontap: () {
                                  chooseDateRangePicker(context);
                                },
                                textstart: selectedDateRange!.start
                                    .toString()
                                    .split(' ')[0],
                                textend: selectedDateRange!.end
                                    .toString()
                                    .split(' ')[0],
                              )
                            : Container(
                                width: 575,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: AppColor.lightblue,
                                    border:
                                        Border.all(color: AppColor.boxborder)),
                                child: InkWell(
                                  onTap: () {
                                    chooseDateRangePicker(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          height: 38,
                                          width: 38,
                                          decoration: BoxDecoration(
                                              color: AppColor.lightblue,
                                              border: Border.all(
                                                color: AppColor.boxborder,
                                              )),
                                          child: Icon(
                                            Icons.calendar_month_rounded,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                    Container(height: 20),
                    Container(
                      height: 800,
                      child: SfDataGrid(
                        onQueryRowHeight: (details) {
                          // Set the row height as 70.0 to the column header row.
                          return 60;
                        },
                        // gridLinesVisibility: GridLinesVisibility.horizontal,
                        // headerGridLinesVisibility:
                        //     GridLinesVisibility.horizontal,
                        columnWidthMode: ColumnWidthMode.fill,

                        source: _employeeDataSource,
                        showCheckboxColumn: true,

                        checkboxColumnSettings: DataGridCheckboxColumnSettings(
                          width: 100,
                        ),
                        selectionMode: SelectionMode.multiple,
                        columns: [
                          GridColumn(
                              minimumWidth: 100,
                              columnName: 'id',
                              label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ID',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dark,
                                    ),
                                  ))),
                          GridColumn(
                              minimumWidth: 100,
                              columnName: 'date',
                              label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Date',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dark,
                                    ),
                                  ))),
                          GridColumn(
                              minimumWidth: 100,
                              columnName: 'name',
                              label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Name',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dark,
                                    ),
                                  ))),
                          GridColumn(
                              minimumWidth: 100,
                              columnName: 'designation',
                              label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Designation',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dark,
                                    ),
                                  ))),
                          GridColumn(
                              minimumWidth: 100,
                              columnName: 'salary',
                              label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Salary',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.dark,
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('#MN0204', "01 Oct,2020", 'James', 'Project Lead', 20000),
      Employee('#MN0205', "02 Oct,2020", 'Kathryn', 'Manager', 30000),
      Employee('#MN0206', "03 Oct,2020", 'Lara', 'Developer', 15000),
      Employee('#MN0207', "04 Oct,2020", 'Michael', 'Designer', 15000),
      Employee('#MN0208', "05 Oct,2020", 'Martin', 'Developer', 15000),
      Employee('#MN0209', "06 Oct,2020", 'Newberry', 'Developer', 15000),
      Employee('#MN0210', "07 Oct,2020", 'Balnc', 'Developer', 15000),
      Employee('#MN0211', "08 Oct,2020", 'Perry', 'Developer', 15000),
      Employee('#MN0212', "09 Oct,2020", 'Gable', 'Developer', 15000),
      Employee('#MN0213', "10 Oct,2020", 'Grimes', 'Developer', 15000),
      Employee('#MN0214', "11 Oct,2020", 'Gable', 'Developer', 15000),
      Employee('#MN0215', "12 Oct,2020", 'Grimes', 'Developer', 15000),
    ];
  }
}

class ColumnInvoice extends StatelessWidget {
  final dynamic ontap;
  final String textstart;
  final String textend;
  const ColumnInvoice({
    super.key,
    this.ontap,
    required this.textstart,
    required this.textend,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: AppColor.lightblue,
                      border: Border.all(color: AppColor.boxborder)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            textstart,
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(width: 5),
                          Text(
                            "to",
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(width: 5),
                          Text(
                            textend,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                ontap();
              },
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                    color: AppColor.lightblue,
                    border: Border.all(color: AppColor.boxborder)),
                child: Icon(Icons.calendar_month_rounded, size: 15),
              ),
            ),
          ],
        ),
        Row(
          children: [
            TitelText(
              color: AppColor.dark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text: '',
            ),
            Container(width: 2),
            Icon(Icons.chevron_right),
            TitelText(
              color: AppColor.lightdark,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text: "",
            ),
          ],
        ),
      ],
    );
  }
}

// chooseDateRangePicker(context) async {
//     DateTimeRange? picked = await showDateRangePicker(
//         context: context,
//         firstDate: DateTime(DateTime.now().year - 5),
//         lastDate: DateTime(DateTime.now().year + 5),
//         initialDateRange: DateTimeRange(
//           end: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 13),
//           start: DateTime.now(),
//         ),
//         builder: (context, child) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxWidth: 500.0,
//                   maxHeight: 450.0,
//                 ),
//                 child: child,
//               )
//             ],
//           );
//         });
//         if (picked != null && picked != selectedDateRange) {
//       setState(() {
//         selectedDateRange = picked;
//       });
//     }

//     print(picked);
//   }

class Employee {
  Employee(this.id, this.date, this.name, this.designation, this.salary);
  final String id;
  final String date;
  final String name;
  final String designation;
  final int salary;
}

class EmployeeData extends DataGridSource {
  EmployeeData({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'date', value: dataGridRow.date),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
            alignment: (dataGridCell.columnName == 'id' ||
                    dataGridCell.columnName == 'salary')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ));
      }).toList(),
    );
  }
}
