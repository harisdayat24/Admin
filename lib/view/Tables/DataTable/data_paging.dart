// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

late EmployeeDataSource _employeeDataSource;
List<EmployeePagi> _employees = <EmployeePagi>[];

class _PaginationState extends State<Pagination> {
  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 480,
          child: SfDataGrid(
            onQueryRowHeight: (details) {
              // Set the row height as 70.0 to the column header row.
              return details.rowIndex == 0 ? 45.0 : 42.0;
            },
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            columnWidthMode: ColumnWidthMode.fill,
            source: _employeeDataSource,
            allowSorting: true,
            allowMultiColumnSorting: true,
            allowTriStateSorting: true,
            columns: [
              GridColumn(
                   minimumWidth: 100,
                columnName: 'id',
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ID',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              GridColumn(
                   minimumWidth: 100,
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                   minimumWidth: 100,
                  columnName: 'city',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'City',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                   minimumWidth: 100,
                  columnName: 'salary',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'salary',
                        overflow: TextOverflow.ellipsis,
                      ))),
            ],
          ),
        ),
        SfDataPagerTheme(
          data: SfDataPagerThemeData(
            itemBorderWidth: 0.5,
            itemBorderColor: Colors.grey.shade400,
            itemBorderRadius: BorderRadius.circular(0),
            selectedItemColor: Colors.indigo.shade500,
            itemTextStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.selecteColor,
            ),
            selectedItemTextStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.mainbackground,
            ),
            disabledItemTextStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.selecteColor,
            ),
          ),
          child: SfDataPager(
            itemWidth: 35.0,
            itemHeight: 40.0,
            itemPadding: EdgeInsets.zero,
            firstPageItemVisible: false,
            lastPageItemVisible: false,
            pageCount: 5,
            visibleItemsCount: 10,
            delegate: _employeeDataSource,
            navigationItemHeight: 40.0,
            navigationItemWidth: 80,
            pageItemBuilder: (String itemName) {
              if (itemName == 'Next') {
                return Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: AppColor.dark, fontWeight: FontWeight.w400),
                  ),
                );
              }
              if (itemName == 'Previous') {
                return Center(
                  child: Text(
                    'Previous',
                    style: TextStyle(
                        color: AppColor.dark, fontWeight: FontWeight.w400),
                  ),
                );
              }
              return null;
            },

            // itemPadding: EdgeInsets.all(8.0),
          ),
        ),
      ],
    ));
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<EmployeePagi> employees}) {
    dataGridRows = employees
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'id',
                value: dataGridRow.id,
              ),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(columnName: 'salary', value: dataGridRow.salary)
            ],
          ),
        )
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
          ));
    }).toList());
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (sortColumn.name == 'name') {
      final String? value1 = a
          ?.getCells()
          .firstWhereOrNull((element) => element.columnName == sortColumn.name)
          ?.value
          .toString();
      final String? value2 = b
          ?.getCells()
          .firstWhereOrNull((element) => element.columnName == sortColumn.name)
          ?.value
          .toString();

      if (value1 == null || value2 == null) {
        return 0;
      }

      if (sortColumn.sortDirection == DataGridSortDirection.ascending) {
        return value1.toLowerCase().compareTo(value2.toLowerCase());
      } else {
        return value2.toLowerCase().compareTo(value1.toLowerCase());
      }
    }

    return super.compare(a, b, sortColumn);
  }
}

class EmployeePagi {
  EmployeePagi(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<EmployeePagi> getEmployeeData() {
  return [
    EmployeePagi(1, "Tiger Nixon", 'Project Lead', 20000),
    EmployeePagi(2, "Garrett Winters", 'Manager', 30000),
    EmployeePagi(3, "Ashton Cox", 'Manager', 15000),
    EmployeePagi(4, "Cedric Kelly", 'Designer', 15000),
    EmployeePagi(5, "Airi Satou", 'Developer', 15000),
    EmployeePagi(6, 'Brielle Williams', 'Developer', 15000),
    EmployeePagi(7, "Herrod Chandler", 'Manager', 15000),
    EmployeePagi(8, "Rhona Davidson", 'Developer', 15000),
    EmployeePagi(9, "Colleen Hurst", 'Manager', 15000),
    EmployeePagi(10, "Sonya Frost", 'Developer', 15000),

    ////////Pagi
    EmployeePagi(11, "Jena Gaines", 'Project Lead', 20000),
    EmployeePagi(12, "Quinn Flynn", 'Manager', 30000),
    EmployeePagi(13, "Charde Marshall", 'Manager', 15000),
    EmployeePagi(14, "Haley Kennedy", 'Designer', 15000),
    EmployeePagi(15, "Tatyana Fitzpat", 'Developer', 15000),
    EmployeePagi(16, "Michael Silva", 'Manager', 15000),
    EmployeePagi(17, "Paul Byrd", 'Developer', 15000),
    EmployeePagi(18, "Gloria Little", 'Manager', 15000),
    EmployeePagi(19, "Bradley Greer", 'Designer', 15000),
    EmployeePagi(20, "Dai Rios", 'Developer', 15000),

    //////Pagi
    EmployeePagi(21, "JenetteCaldwell", 'Project Lead', 20000),
    EmployeePagi(22, "Yuri Berry", 'Manager', 30000),
    EmployeePagi(23, "Caesar Vance", 'Developer', 15000),
    EmployeePagi(24, "Doris Wilder", 'Manager', 15000),
    EmployeePagi(25, "Angelica Ramos", 'Developer', 15000),
    EmployeePagi(26, "Gavin Joyce", 'Developer', 15000),
    EmployeePagi(27, "Jennifer Chang", 'Manager', 15000),
    EmployeePagi(28, "Brenden Wagner", 'Designer', 15000),
    EmployeePagi(29, "Fiona Green", 'Manager', 15000),
    EmployeePagi(30, "Shou Itou", 'Developer', 15000),

    ///////Pagi

    EmployeePagi(31, "Michelle House", 'Project Lead', 20000),
    EmployeePagi(32, "Suki Burks", 'Manager', 30000),
    EmployeePagi(33, "Prescott Bartlet", 'Developer', 15000),
    EmployeePagi(34, "Gavin Cortez", 'Manager', 15000),
    EmployeePagi(35, "Martena Mccray", 'Developer', 15000),
    EmployeePagi(36, "Unity Butler", 'Project Lead', 15000),
    EmployeePagi(37, "Howard Hatfield", 'Designer', 15000),
    EmployeePagi(38, "Hope Fuentes", 'Developer', 15000),
    EmployeePagi(39, "Vivian Harrell", 'Manager', 15000),
    EmployeePagi(40, "Timothy Mooney", 'Designer', 15000),

    ///////Pagi
    EmployeePagi(41, "Uichelle House", 'Project Lead', 20000),
    EmployeePagi(42, "Euki Burks", 'Manager', 30000),
    EmployeePagi(43, "Irescott Bartlet", 'Developer', 15000),
    EmployeePagi(44, "Kavin Cortez", 'Manager', 15000),
    EmployeePagi(45, "Lartena Mccray", 'Developer', 15000),
    EmployeePagi(46, "Jnity Butler", 'Project Lead', 15000),
    EmployeePagi(47, "Foward Hatfield", 'Designer', 15000),
    EmployeePagi(48, "Oope Fuentes", 'Developer', 15000),
    EmployeePagi(49, "Livian Harrell", 'Manager', 15000),
    EmployeePagi(50, "Nimothy Mooney", 'Designer', 15000),
  ];
}
