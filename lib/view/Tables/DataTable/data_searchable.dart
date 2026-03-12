// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';

class Searchable extends StatefulWidget {
  const Searchable({super.key});

  @override
  State<Searchable> createState() => _SearchableState();
}

class _SearchableState extends State<Searchable> {
  List<dynamic> data = [
    {
      "Id": "1",
      "Name": "Tiger Nixon",
      "Role": "Senior Supervisor",
      "Salary": "20000",
    },
    {
      "Id": "2",
      "Name": "Garrett Winters",
      "Role": "Developer",
      "Salary": "30000",
    },
    {
      "Id": "3",
      "Name": "Ashton Cox",
      "Role": "Manager",
      "Salary": "25000",
    },
    {
      "Id": "4",
      "Name": "Cedric Kelly",
      "Role": "Manager",
      "Salary": "15000",
    },
    {
      "Id": "5",
      "Name": "Airi Satou",
      "Role": "Developer",
      "Salary": "45000",
    },
    {
      "Id": "6",
      "Name": "Brielle Williams",
      "Role": "Developer",
      "Salary": "49000",
    },
    {
      "Id": "7",
      "Name": "Herrod Chandler",
      "Role": "Administrator",
      "Salary": "35000",
    },
    {
      "Id": "8",
      "Name": "Rhona Davidson",
      "Role": "Manager",
      "Salary": "47000",
    },
    {
      "Id": "9",
      "Name": "Colleen Hurst",
      "Role": "Developer",
      "Salary": "55000",
    },
    {
      "Id": "10",
      "Name": "Sonya Frost",
      "Role": "Manager",
      "Salary": "18000",
    },
  ];

  List<dynamic> filteredData = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    filteredData = data;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item['Id'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Name'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Role'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Salary'].toLowerCase().contains(text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder(
                          verticalInside: BorderSide(color: AppColor.dark),
                          horizontalInside: BorderSide(color: AppColor.dark)),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Id'),
                          numeric: true,
                        ),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Role'),
                        ),
                        DataColumn(
                          label: Text('Salary'),
                          numeric: true,
                        ),
                      ],
                      rows: List.generate(filteredData.length, (index) {
                        final item = filteredData[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(item['Id'].toString())),
                            DataCell(Text(item['Name'])),
                            DataCell(Text(item['Role'])),
                            DataCell(Text(item['Salary'].toString())),
                          ],
                        );
                      }),
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
