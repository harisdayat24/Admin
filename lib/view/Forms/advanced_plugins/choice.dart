// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:super_tag_editor/tag_editor.dart';
import 'package:super_tag_editor/widgets/rich_text_widget.dart';

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  // String dropdownvalue = 'Choice1';
  // var items1 = [
  //   'Audi',
  //   'BMW',
  //   'Ford',
  //   'Ferrari',
  // ];

  String dropdownvalue1 = "This is a placeholder";
  // late String value2 = "Choose a city";
  bool focusTagEnabled = false;
  final List<String> _values = [];

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  static const mockResults = [
    'dat@gmail.com',
    'dab246@gmail.com',
    'kaka@gmail.com',
    'datvu@gmail.com'
  ];
  var litsitem = [
    "Choice1",
    "Choice2",
    "Choice3",
    "Choice4",
    "This is a placeholder",
  ];
  // final group = ["CA", "La", "london", "paris", "Berlin"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Default(),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                TagEditor(
                  length: _values.length,
                  tagBuilder: (context, index) => Container(
                    color: focusTagEnabled && index == _values.length - 1
                        ? Colors.redAccent
                        : Colors.white,
                    child: _Chip(
                      index: index,
                      label: _values[index],
                      onDeleted: _onDelete,
                    ),
                  ),
                  onTagChanged: (newValue) {
                    setState(() {
                      _values.add(newValue);
                    });
                  },
                  suggestionBuilder: (context, state, data, index, length,
                      highlight, suggestionValid) {
                    var borderRadius =
                        const BorderRadius.all(Radius.circular(20));
                    if (index == 0) {
                      borderRadius = const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      );
                    } else if (index == length - 1) {
                      borderRadius = const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _values.add("data");
                        });
                        state.resetTextField();
                        state.closeSuggestionBox();
                      },
                      child: Container(
                          decoration: highlight
                              ? BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  borderRadius: borderRadius)
                              : null,
                          padding: const EdgeInsets.all(16),
                          child: RichTextWidget(
                            wordSearched: suggestionValid ?? '',
                            textOrigin: "data",
                          )),
                    );
                  },
                  findSuggestions: (String query) {
                    if (query.isNotEmpty) {
                      var lowercaseQuery = query.toLowerCase();
                      return mockResults.where((profile) {
                        return profile
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            profile.toLowerCase().contains(query.toLowerCase());
                      }).toList(growable: false)
                        ..sort((a, b) => a
                            .toLowerCase()
                            .indexOf(lowercaseQuery)
                            .compareTo(
                                b.toLowerCase().indexOf(lowercaseQuery)));
                    }
                    return [];
                  },
                ),
              ],
            ),
            // Optiongroups(),
          ],
        ),
      ),
    );
  }

  // Defaulf //
  Column Default() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Single select input Example",
          style: TextStyle(
            fontSize: 15,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder),
                    borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      iconSize: 30,
                      focusColor: Colors.transparent,
                      //value: dropdownvalue1,
                      onChanged: (String? selectedValue) => setState(() {
                        dropdownvalue1 = selectedValue!;
                      }),
                      items: litsitem.map(buildMenuItem).toList(),

                      // style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(height: 20),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  // Column Optiongroups() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Single select input Example",
  //         style: TextStyle(
  //           fontSize: 15,
  //           color: AppColor.black,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       Container(height: 10),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               height: 40,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: AppColor.boxborder),
  //                   borderRadius: BorderRadius.circular(4)),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: DropdownButtonHideUnderline(
  //                   child: DropdownButton(
  //                     isExpanded: true,
  //                     iconSize: 30,
  //                     focusColor: Colors.transparent,
  //                     value: value2,
  //                     onChanged: (value2) =>
  //                         setState(() => this.value2 = value2!),
  //                     items: group.map(buildMenu).toList(),
  //                     // style: TextStyle(fontSize: 10),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Container(height: 20),
  //     ],
  //   );
  // }

  // DropdownMenuItem<String> buildMenu(String item2) => DropdownMenuItem(
  //       value: value2,
  //       child: Text(
  //         item2,
  //         style: TextStyle(
  //           fontSize: 15,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     );
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColor.searchbackground,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(
        label,
        style: TextStyle(color: AppColor.mainbackground),
      ),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
