// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';
import 'contact_model.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

final List<ContactList> contactlist = [
  ContactList(
    name: "Phyllis Gatlin",
    position: "UI/UX Designer",
    email: "phyllisgatlin@minia.com",
    tages: "photoshop",
    image: 'assets/image/avatar.png',
  ),
  ContactList(
    name: "James Nix",
    position: "Frontend Developer",
    email: "jamesnix@minia.com",
    tages: "html",
    image: 'assets/image/avatar2.png',
  ),
  ContactList(
    name: "Darlene Smith",
    position: "Backend Developer",
    email: "darlenesmith@minia.com",
    tages: "Java",
    image: 'assets/image/avatar3.png',
  ),
  ContactList(
    name: "William Swift",
    position: "Full Stack Developer",
    email: "williamswift@minia.com",
    tages: "Ruby",
    image: 'assets/image/avatar4.png',
  ),
  ContactList(
    name: "Paul Sanchez",
    position: "Angular Developer",
    email: "paulsanchez@minia.com",
    tages: "php",
    image: 'assets/image/avatar4.png',
  ),
  ContactList(
    name: "Diana Owens",
    position: "Graphic Designer",
    email: "dianaowens@minia.com",
    tages: "photoshop",
    image: 'assets/image/avatar3.png',
  ),
  ContactList(
    name: "Tommy Hayes",
    position: "UI/UX Designer",
    email: "tommyhayes@minia.com",
    tages: "illustrator",
    image: 'assets/image/avatar2.png',
  ),
  ContactList(
    name: "Kevin West",
    position: "Frontend Developer",
    email: "kevinwest@minia.com",
    tages: "Css",
    image: 'assets/image/avatar.png',
  ),
  ContactList(
    name: "Peter Dryer",
    position: "Web Designer",
    email: "peterdryer@minia.com",
    tages: "Html",
    image: 'assets/image/avatar.png',
  ),
];

late EmployeeData _employeeDataSource;

List<Employee> _employees = <Employee>[];

class _ContactViewState extends State<ContactView> {
  var selecte = "first";

  SideBarController controller = Get.find();
  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeData(employees: _employees);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? controller.index.value == 7
                  ? RowTitel(
                      textL: "User Grid",
                      texti: "Contacts",
                      textii: "User Grid",
                    )
                  : RowTitel(
                      textL: "User List",
                      texti: "Contacts",
                      textii: "User List",
                    )
              : controller.index.value == 7
                  ? ColumnTitel(
                      textL: "User Grid",
                      texti: "Contacts",
                      textii: "User Grid",
                    )
                  : ColumnTitel(
                      textL: "User List",
                      texti: "Contacts",
                      textii: "User List",
                    ),
          Container(height: 20),
          Row(
            children: [
              Text(
                "Contact List ",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.dark),
              ),
              Text(
                "(834)",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.lightdark),
              ),
              Spacer(),
              width > 765 ? gidbuttons(width) : Container(),
            ],
          ),
          width > 765 ? Container() : Container(height: 15),
          Row(
            children: [
              Spacer(),
              width > 765 ? Container() : gidbuttons(width),
            ],
          ),
          Container(height: 15),
          (selecte == "sec" || controller.index.value == 7)
              ? userGrideView(width)
              : controller.index.value == 8
                  ? userListView(width)
                  : Container(),

          // selecte == "sec"
          // ? userGrideView(width)
          // : userListView(width),
        ],
      ),
    );
  }

  Widget userListView(width) {
    return Container(
      height: 800,
      child: SfDataGrid(
        onQueryRowHeight: (details) {
          // Set the row height as 70.0 to the column header row.
          return 60;
        },
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
            columnName: 'image',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Image',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.dark,
                ),
              ),
            ),
          ),
          GridColumn(
              minimumWidth: 200,
              columnName: 'name',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
              minimumWidth: 200,
              columnName: 'poistion',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Position',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.dark,
                    ),
                  ))),
          GridColumn(
              minimumWidth: 300,
              columnName: 'Email',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Email',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.dark,
                    ),
                  ))),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('assets/image/avatar.png', "Phyllis Gatlin", "UI/UX Designer",
          'phyllisgatlin@minia.com'),
      Employee('assets/image/avatar2.png', "James Nix", 'Frontend Developer',
          'jamesnix@minia.com'),
      Employee('assets/image/avatar3.png', "Darlene Smith", "Backend Developer",
          'darlenesmith@minia.com'),
      Employee('assets/image/avatar4.png', "William Swift",
          "Full Stack Developer", 'williamswift@minia.com'),
      Employee('assets/image/avatar5.png', "Kevin West", "Frontend Developer",
          'kevinwest@minia.com'),
      Employee('assets/image/avatar.png', "Tommy Hayes", "UI/UX Designer",
          'tommyhayes@minia.com'),
      Employee('assets/image/avatar2.png', "Diana Owens", "Angular Developer",
          'dianaowens@minia.com'),
      Employee('assets/image/avatar3.png', "Paul Sanchez", "Web Designer",
          'paulsanchez@minia.com'),
      Employee('assets/image/avatar4.png', "Peter Dryer", "Backend Developer",
          'peterdryer@minia.com'),
      Employee('assets/image/avatar5.png', "Gerald Moyer", "Graphic Designer",
          'dianaowens@minia.com'),
      Employee('assets/image/avatar4.png', "Kevin West", "Frontend Developer",
          'geraldmoyer@minia.com'),
      Employee('assets/image/avatar2.png', "Paul Sanchez", "Backend Developer",
          'paulsanchez@minia.com'),
    ];
  }

  Row gidbuttons(width) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selecte = "first";
            });
          },
          child: Container(
            height: 38,
            width: 46,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: selecte == "first"
                  ? AppColor.searchbackground
                  : AppColor.mainbackground,
            ),
            child: SvgPicture.asset(
              "assets/svg/menu1.svg",
              // fit: BoxFit.fill,
              color:
                  selecte == "first" ? AppColor.mainbackground : AppColor.dark,
            ),
          ),
        ),
        Container(width: 10),
        InkWell(
          onTap: () {
            setState(() {
              selecte = "sec";
            });
          },
          child: Container(
            height: 38,
            width: 46,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: selecte == "sec"
                  ? AppColor.searchbackground
                  : AppColor.mainbackground,
            ),
            child: SvgPicture.asset(
              "assets/svg/menu_box.svg",
              fit: BoxFit.contain,
              height: 10,
              width: 10,
              color: selecte == "sec" ? AppColor.mainbackground : AppColor.dark,
            ),
          ),
        ),
        Container(width: 10),
        Container(
          height: 38,
          width: 104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColor.boxborder,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "+ Add New",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: width > 310 ? 15.0 : 0.0),
          child: Icon(Icons.more_horiz, color: AppColor.dark, size: 15),
        )
      ],
    );
  }

  GridView userGrideView(double width) {
    return GridView.builder(
      itemCount: 8,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 1100
            ? 4
            : width > 580
                ? 2
                : 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 260,
      ),
      itemBuilder: (context, index) {
        var list = contactlist[index];
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.boxborder),
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(height: 15),
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.more_horiz),
                  Container(width: 15)
                ],
              ),
              Container(height: 5),
              Container(
                padding: EdgeInsets.all(5),
                // margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder),
                    borderRadius: BorderRadius.circular(50)),
                child: Image.asset(list.image),
              ),
              // Container(height: 22),
              Spacer(),
              Text(
                list.name,
                style: TextStyle(
                  color: AppColor.darkblack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(height: 4),
              Text(
                list.position,
                style: TextStyle(
                  color: AppColor.lightgrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Container(height: 37),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.boxborder,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.boxborder,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Message",
                          style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Employee {
  Employee(this.image, this.name, this.position, this.email);
  final String image;
  final String name;
  final String position;
  final String email;
}

class EmployeeData extends DataGridSource {
  EmployeeData({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'image', value: dataGridRow.image),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'position', value: dataGridRow.position),
              DataGridCell<String>(
                  columnName: 'email', value: dataGridRow.email),
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
            // alignment: (dataGridCell.columnName == 'id' ||
            //         dataGridCell.columnName == 'salary')
            //     ? Alignment.centerRight
            //     : Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: dataGridCell.columnName == 'image'
                  ? Image.asset(
                      dataGridCell.value,
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    )
                  : Text(
                      dataGridCell.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
            ));
      }).toList(),
    );
  }
}
