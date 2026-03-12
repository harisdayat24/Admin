// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../comman/colors.dart';

class PageSelecter extends StatefulWidget {
  const PageSelecter({super.key});

  @override
  State<PageSelecter> createState() => _PageSelecterState();
}

int _rowsPerPage = 10;
List<EmployeeDemo> _employees = <EmployeeDemo>[];
late EmployeeSource employeeSource;
double datapagerHeight = 70.0;

class _PageSelecterState extends State<PageSelecter> {
  @override
  void initState() {
    super.initState();
    _employees = getEmployeeDemoData();
    employeeSource = EmployeeSource(employeeData: _employees);
    employeeSource.updateDataGriDataSource(); // Call the method here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Layout builder
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                // height:  _rowsPerPage == 20  ?  600 : 480 ,
                height: 480,
                child: SfDataGrid(
                  onQueryRowHeight: (details) {
                    // Set the row height as 70.0 to the column header row.
                    return details.rowIndex == 0 ? 45.0 : 42.0;
                  },
                  gridLinesVisibility: GridLinesVisibility.both,
                  source: employeeSource,
                  columnWidthMode: ColumnWidthMode.fill,
                  headerGridLinesVisibility: GridLinesVisibility.both,
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
                  visibleItemsCount: 10,
                  delegate: employeeSource,
                  availableRowsPerPage: const [10, 20, 30],
                  navigationItemHeight: 40.0,
                  navigationItemWidth: 80,
                  onRowsPerPageChanged: (int? rowsPerPage) {
                    setState(() {
                      _rowsPerPage = rowsPerPage!;
                      employeeSource.updateDataGriDataSource();
                    });
                  },
                  pageCount:
                      ((_employees.length / _rowsPerPage).ceil()).toDouble(),
                  pageItemBuilder: (String itemName) {
                    if (itemName == 'Next') {
                      return Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: AppColor.dark,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }
                    if (itemName == 'Previous') {
                      return Center(
                        child: Text(
                          'Previous',
                          style: TextStyle(
                            color: AppColor.dark,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EmployeeSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeSource({required List<EmployeeDemo> employeeData}) {
    _employeeData = employeeData;
    _paginatedRows = employeeData;
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _employeeGridRows = _paginatedRows
        .map<DataGridRow>((e) => DataGridRow(
              cells: [
                DataGridCell<int>(columnName: 'id', value: e.id),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'designation', value: e.designation),
                DataGridCell<int>(columnName: 'salary', value: e.salary),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _employeeGridRows = [];
  List<EmployeeDemo> _paginatedRows = [];
  List<EmployeeDemo> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
    final int _startIndex = newPageIndex * _rowsPerPage;
    int _endIndex = _startIndex + _rowsPerPage;
    if (_endIndex > _employeeData.length) {
      _endIndex = _employeeData.length;
    }

    /// Get particular range from the sorted collection.
    if (_startIndex < _employeeData.length &&
        _endIndex <= _employeeData.length) {
      _paginatedRows = _employeeData.getRange(_startIndex, _endIndex).toList();
    } else {
      _paginatedRows = <EmployeeDemo>[];
    }
    buildDataGridRow();
    notifyListeners();
    return Future<bool>.value(true);
  }

  void updateDataGriDataSource() {
    const int _startIndex = 0;
    int _endIndex = _startIndex + _rowsPerPage;
    if (_endIndex > _employeeData.length) {
      _endIndex = _employeeData.length;
    }

    /// Get particular range from the sorted collection.
    if (_startIndex < _employeeData.length &&
        _endIndex <= _employeeData.length) {
      _paginatedRows = _employeeData.getRange(_startIndex, _endIndex).toList();
    } else {
      _paginatedRows = <EmployeeDemo>[];
    }
    buildDataGridRow();
    notifyListeners();
  }
}

class EmployeeDemo {
  EmployeeDemo(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<EmployeeDemo> getEmployeeDemoData() {
  return [
    EmployeeDemo(1, "Tiger Nixon", 'Project Lead', 20000),
    EmployeeDemo(2, "Garrett Winters", 'Manager', 30000),
    EmployeeDemo(3, "Ashton Cox", 'Manager', 15000),
    EmployeeDemo(4, "Cedric Kelly", 'Designer', 15000),
    EmployeeDemo(5, "Airi Satou", 'Developer', 15000),
    EmployeeDemo(6, 'Brielle Williams', 'Developer', 15000),
    EmployeeDemo(7, "Herrod Chandler", 'Manager', 15000),
    EmployeeDemo(8, "Rhona Davidson", 'Developer', 15000),
    EmployeeDemo(9, "Colleen Hurst", 'Manager', 15000),
    EmployeeDemo(10, "Sonya Frost", 'Developer', 15000),

    //
    EmployeeDemo(11, "Jena Gaines", 'Project Lead', 20000),
    EmployeeDemo(12, "Quinn Flynn", 'Manager', 30000),
    EmployeeDemo(13, "Charde Marshall", 'Manager', 15000),
    EmployeeDemo(14, "Haley Kennedy", 'Designer', 15000),
    EmployeeDemo(15, "Tatyana Fitzpat", 'Developer', 15000),
    EmployeeDemo(16, "Michael Silva", 'Manager', 15000),
    EmployeeDemo(17, "Paul Byrd", 'Developer', 15000),
    EmployeeDemo(18, "Gloria Little", 'Manager', 15000),
    EmployeeDemo(19, "Bradley Greer", 'Designer', 15000),
    EmployeeDemo(20, "Dai Rios", 'Developer', 15000),

    //
    EmployeeDemo(21, "JenetteCaldwell", 'Project Lead', 20000),
    EmployeeDemo(22, "Yuri Berry", 'Manager', 30000),
    EmployeeDemo(23, "Caesar Vance", 'Developer', 15000),
    EmployeeDemo(24, "Doris Wilder", 'Manager', 15000),
    EmployeeDemo(25, "Angelica Ramos", 'Developer', 15000),
    EmployeeDemo(26, "Gavin Joyce", 'Developer', 15000),
    EmployeeDemo(27, "Jennifer Chang", 'Manager', 15000),
    EmployeeDemo(28, "Brenden Wagner", 'Designer', 15000),
    EmployeeDemo(29, "Fiona Green", 'Manager', 15000),
    EmployeeDemo(30, "Shou Itou", 'Developer', 15000),

    //

    EmployeeDemo(31, "Michelle House", 'Project Lead', 20000),
    EmployeeDemo(32, "Suki Burks", 'Manager', 30000),
    EmployeeDemo(33, "Prescott Bartlet", 'Developer', 15000),
    EmployeeDemo(34, "Gavin Cortez", 'Manager', 15000),
    EmployeeDemo(35, "Martena Mccray", 'Developer', 15000),
    EmployeeDemo(36, "Unity Butler", 'Project Lead', 15000),
    EmployeeDemo(37, "Howard Hatfield", 'Designer', 15000),
    EmployeeDemo(38, "Hope Fuentes", 'Developer', 15000),
    EmployeeDemo(39, "Vivian Harrell", 'Manager', 15000),
    EmployeeDemo(40, "Timothy Mooney", 'Designer', 15000),

    //
    EmployeeDemo(41, "Uichelle House", 'Project Lead', 20000),
    EmployeeDemo(42, "Euki Burks", 'Manager', 30000),
    EmployeeDemo(43, "Irescott Bartlet", 'Developer', 15000),
    EmployeeDemo(44, "Kavin Cortez", 'Manager', 15000),
    EmployeeDemo(45, "Lartena Mccray", 'Developer', 15000),
    EmployeeDemo(46, "Jnity Butler", 'Project Lead', 15000),
    EmployeeDemo(47, "Foward Hatfield", 'Designer', 15000),
    EmployeeDemo(48, "Oope Fuentes", 'Developer', 15000),
    EmployeeDemo(49, "Livian Harrell", 'Manager', 15000),
    EmployeeDemo(50, "Nimothy Mooney", 'Designer', 15000),
  ];
}
