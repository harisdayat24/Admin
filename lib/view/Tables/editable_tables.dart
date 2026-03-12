// ignore_for_file: prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';

class EditableTable extends StatefulWidget {
  const EditableTable({super.key});

  @override
  _EditableTableState createState() => _EditableTableState();
}

class _EditableTableState extends State<EditableTable> {
  List<List<String>> _data = [
    ['1', 'David McHenry', '24', 'Male'],
    ['2', 'Frank Kirk', '22', 'Male'],
    ['3', 'Rafael Morales', '26', 'Male'],
    ['4', 'Mark Ellison', '32', 'Male'],
    ['5', 'Minnie Walter', '27', 'Female'],
  ];

  List<bool> _isEditingList = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width < 1301
                ? 1200
                : width > 570
                    ? width - (width > 983 ? 290 : 0)
                    : 900,
            child: Column(
              children: [
                width > 600
                    ? RowTitel(
                        textL: "Editable Tables",
                        texti: "Tables",
                        textii: "Editable Tables",
                      )
                    : ColumnTitel(
                        textL: "Editable Tables",
                        texti: "Tables",
                        textii: "Editable Tables",
                      ),
              ],
            ),
          ),
          Container(height: 20.0),
          Container(
            width: width < 1301
                ? 1200
                : width > 570
                    ? width - (width > 983 ? 290 : 0)
                    : 900,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.boxborder),
                left: BorderSide(color: AppColor.boxborder),
                right: BorderSide(color: AppColor.boxborder),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 21.0, bottom: 8),
                  child: Text(
                    "Table Edit",
                    style: TextStyle(
                      fontSize: 15.4,
                      fontWeight: FontWeight.w600,
                      color: AppColor.dark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 22.0),
                  child: Text(
                    "Table Edits is a lightweight jQuery plugin for making table rows editable.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightdark,
                    ),
                  ),
                ),
                Container(
                  width: width < 1301
                      ? 1200
                      : width > 570
                          ? width - (width > 983 ? 290 : 0)
                          : 900,
                  child: DataTable(
                    columnSpacing: 0.0,
                    border: TableBorder.symmetric(
                        outside: BorderSide(color: AppColor.boxborder)),
                    columns: [
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Age',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                    ],
                    rows: _data.map((row) {
                      int index = _data.indexOf(row);
                      return DataRow(
                        cells: [
                          DataCell(
                            _isEditingList[index]
                                ? Container(
                                    width: 200,
                                    child: EditableField(
                                      hintText: "",
                                      initialValue: row[0],
                                      obscure: false,
                                      onChanged: (value) {
                                        setState(() {
                                          _data[index][0] = value;
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(4.0),
                                    width: 200,
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(row[0],
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                          ),
                          DataCell(
                            _isEditingList[index]
                                ? Container(
                                    width: 200,
                                    child: EditableField(
                                      hintText: "",
                                      initialValue: row[1],
                                      obscure: false,
                                      onChanged: (value) {
                                        setState(() {
                                          _data[index][1] = value;
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(4.0),
                                    width: 300,
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(row[1],
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                          ),
                          DataCell(
                            _isEditingList[index]
                                ? Container(
                                    width: 200,
                                    child: EditableField(
                                      hintText: "",
                                      initialValue: row[2],
                                      obscure: false,
                                      onChanged: (value) {
                                        setState(() {
                                          _data[index][2] = value;
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(4.0),
                                    width: 150,
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(row[2],
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                          ),
                          DataCell(
                            _isEditingList[index]
                                ? Container(
                                    width: 100,
                                    child: EditableField(
                                      hintText: "",
                                      initialValue: row[3],
                                      obscure: false,
                                      onChanged: (value) {
                                        setState(() {
                                          _data[index][3] = value;
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(4.0),
                                    width: 100,
                                    height: 100,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(row[3],
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                          ),
                          DataCell(
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isEditingList[index] =
                                      !_isEditingList[index];
                                });
                              },
                              child: Container(
                                height: 28,
                                width: 30,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.lightgrey),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(
                                  _isEditingList[index]
                                      ? Icons.save
                                      : Icons.edit,
                                  color: AppColor.lightgrey,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 370),
        ],
      ),
    );
  }
}

class EditableField extends StatelessWidget {
  final String? initialValue;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final Function(String)? onChanged;

  const EditableField({
    super.key,
    this.initialValue,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 35,
            child: TextFormField(
              autofocus: true,
              onChanged: onChanged,
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                isDense: true,
                fillColor: AppColor.mainbackground,
                hintText: hintText,
                // hintStyle: TextStyle(color: AppColor.black),
                // filled: true,
                // fillColor: AppColor.lightwhite.withOpacity(.25),
                contentPadding:
                    const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                // contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: AppColor.boxborder),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
