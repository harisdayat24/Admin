// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:minia_web_project/comman/widgets.dart';
import '../../../comman/colors.dart';
import 'css_switch.dart';

class AdvancedPlug extends StatefulWidget {
  const AdvancedPlug({super.key});

  @override
  State<AdvancedPlug> createState() => _AdvancedPlugState();
}

ColorSwatch? _tempMainColor;
ColorSwatch? _mainColor = Colors.lightBlue;

class _AdvancedPlugState extends State<AdvancedPlug> {
  Color selecteColor = AppColor.selecteColor;
  Color _selectedColor = Colors.blue;

  TimeOfDay? _selectedTime;

  Future<void> _selectTimeonly(BuildContext context) async {
    final TimeOfDay? pickedTimeonly = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTimeonly != null) {
      setState(() {
        _selectedTime = pickedTimeonly;
      });
    }
  }

  DateTime selectedDateDis = DateTime.now();

  Future<void> _selectDatedis(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateDis,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      selectableDayPredicate: (DateTime date) {
        // Disable specific dates here
        return date.day % 2 == 1; // Disable even-numbered days
      },
    );

    if (picked != null && picked != selectedDateDis) {
      setState(() {
        selectedDateDis = picked;
      });
    }
  }

  DateTime selectedDateTime = DateTime.now();

  void changeColor(Color color) {
    setState(() => selecteColor = color);
  }

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  DateTime selectedDatelimit = DateTime.now();
  final int minDay = 10;
  final int maxDay = 30;

  Future<void> _selectDatelimit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDatelimit,
      firstDate:
          DateTime(selectedDatelimit.year, selectedDatelimit.month, minDay),
      lastDate:
          DateTime(selectedDatelimit.year, selectedDatelimit.month, maxDay),
    );

    if (picked != null && picked != selectedDatelimit) {
      setState(() {
        selectedDatelimit = picked;
      });
    }
  }

  DateTime selectedDatename = DateTime.now();

  Future<void> _selectDatename(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDatename,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal, // Customize the header background color
            hintColor: Colors.teal, // Customize the selection color
            colorScheme: ColorScheme.light(
              primary: Colors.teal, // Customize the text color
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
      selectableDayPredicate: (DateTime date) {
        // Disable weekends (Saturday and Sunday)
        return date.weekday != 6 && date.weekday != 7;
      },
    );

    if (picked != null && picked != selectedDatename) {
      setState(() {
        selectedDatename = picked;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        width > 600
            ? RowTitel(
                textL: "Forms Advanced Plugins",
                texti: "Forms",
                textii: "Forms Advanced Plugins",
              )
            : ColumnTitel(
                textL: "Forms Advanced Plugins",
                texti: "Forms",
                textii: "Forms Advanced Plugins",
              ),
        Container(height: 20),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Css Switch",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark),
                      ),
                      Container(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Here are a few types of switches.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.lightdark,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              // height: 400,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.boxborder)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20),
                  CssSwitch(),
                ],
              ),
            ),
          ],
        ),
        Container(height: 20),
        // Choices //
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choices",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark),
                      ),
                      Container(height: 10),
                      RichText(
                        text: TextSpan(
                          text:
                              'Choices.js is a lightweight, configurable select box/text input plugin.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.lightdark,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: width,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                width > 1000
                    ? Row(
                        children: [
                          Expanded(child: single_Input()),
                          Container(width: 20),
                          // Expanded(child: multiple_input()),
                          // Container(width: 20),
                          Expanded(child: option_no_search()),
                        ],
                      )
                    : Column(
                        children: [
                          single_Input(),
                          Container(height: 20),
                          // multiple_input(),
                          // Container(height: 20),
                          option_no_search(),
                        ],
                      ),
              ],
            ),
          ),
        ),
        Container(height: 20),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color picker",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark),
                      ),
                      Container(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Flat, Simple, Hackable Color-Picker.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.lightdark,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(height: 30),
                  Text(
                    "Monolith Demo",
                    style: TextStyle(
                        color: AppColor.dark,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: 10),
                  InkWell(
                    onTap: _openFullMaterialColorPicker,
                    child: Container(
                      color: _selectedColor,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
              Column(
                children: [
                  Container(height: 30),
                  Text(
                    "Nano Demo",
                    style: TextStyle(
                        color: AppColor.dark,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              // color: AppColor.darkGreen,
                              child: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: selecteColor,
                                  onColorChanged: changeColor,
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.5,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: selecteColor,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
            ],
          ),
        ),

        Container(height: 20),
        // Date pickers //
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Datepicker",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.dark),
                      ),
                      Container(height: 10),
                      RichText(
                        text: TextSpan(
                          text:
                              'flatpickr is a lightweight and powerful datetime picker.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.lightdark,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.boxborder)),
                child: width > 1000
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                DatePicker(context, width),
                                DateTimePicker(context, width),
                                DatePickername(context, width),
                                DateRange(context, width),
                                Datedisable(context, width),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TimePicker(context, width),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          DatePicker(context, width),
                          DateTimePicker(context, width),
                          DatePickername(context, width),
                          DateRange(context, width),
                          Datedisable(context, width),
                          TimePicker(context, width),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget option_no_search() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Options added via config with no search",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.dark),
        ),
        Container(height: 10),
        Container(
          height: 40,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: DropdownSearch(
            mode: Mode.form,
            /* dialogMaxWidth: 200,
            maxHeight: 200,*/
            items: (filter, infiniteScrollProps) =>
                ["Brazil", "France", "Tunisia", "Canada"],
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                border: InputBorder.none,
              ),
            ),
            onChanged: print,
            selectedItem: "Tunisia",
            validator: (String? item) {
              if (item == null) {
                return "Required field";
              } else if (item == "Brazil") {
                return "Invalid item";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget multiple_input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple select input',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.dark),
        ),
        Container(height: 10),
        Container(
          height: 40,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: DropdownSearch<String>.multiSelection(
            mode: Mode.form,
            suffixProps:
                DropdownSuffixProps(clearButtonProps: ClearButtonProps()),
            //showSelectedItem: true,
            items: (filter, infiniteScrollProps) => [
              "Brazil",
              "Italia (Disabled)",
              "Tunisia",
              'Canada',
              "New York"
            ],
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                border: InputBorder.none,
              ),
            ),
            //popupItemDisabled: isItemDisabled,
            onChanged: print,
            selectedItems: const [
              "Brazil",
            ],
          ),
        ),
      ],
    );
  }

  Widget single_Input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Single select input Example",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.dark),
        ),
        Container(height: 10),
        Container(
          height: 40,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          child: DropdownButtonHideUnderline(
            child: DropdownSearch<String>(
              mode: Mode.form,
              //showSelectedItems: true,
              items: (filter, infiniteScrollProps) => [
                "Brazil",
                "Italia (Disabled)",
                "Tunisia",
                "Canada",
                "New York",
              ],
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  border: InputBorder.none,
                ),
              ),
              //popupItemDisabled: isItemDisabled,
              onChanged: itemSelectionChanged,
              //selectedItem: "",
              popupProps: PopupPropsMultiSelection.bottomSheet(
                showSearchBox: true,
              ),
              //selectionListViewProps: SelectionListViewProps(shrinkWrap: true),
            ),
          ),
        ),
      ],
    );
  }

  Padding TimePicker(BuildContext context, double width) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, top: 21, right: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timepicker",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectTimeonly(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _selectedTime?.format(context) ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding Datedisable(BuildContext context, double width) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, top: 21, bottom: 0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Disabling dates",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectDatedis(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedDateDis.toString().split(' ')[0],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding DateRange(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 21, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MinDate and MaxDate",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectDatelimit(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedDatelimit.toString().split(' ')[0],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding DatePickername(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 21, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Human-friendly Dates",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectDatename(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DateFormat('MMMM d, yyyy').format(selectedDatename),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding DateTimePicker(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 21, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DateTime",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectDateTime(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedDateTime.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding DatePicker(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 21, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.dark,
            ),
          ),
          Container(height: 10),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedDate.toString().split(' ')[0],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text('CANCEL'),
            ),
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(
                  () => _mainColor = _tempMainColor,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick a Color'),
            content: SingleChildScrollView(
              child: MaterialColorPicker(
                onColorChange: (Color color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                selectedColor: _selectedColor,
              ),
            ),
            actions: [
              TextButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  // void _openFullMaterialColorPicker() async {
  //   _openDialog(
  //     "",
  //     SizedBox(
  //       width: 300,
  //       height: 250,
  //       child: MaterialColorPicker(
  //         circleSize: 50,
  //         colors: fullMaterialColors,
  //         selectedColor: _mainColor,
  //         onMainColorChange: (color) => setState(
  //           () => _tempMainColor = color,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    print(s);
  }
}

class DropDowns extends StatefulWidget {
  const DropDowns({super.key});

  @override
  State<DropDowns> createState() => _DropDownsState();
}

class _DropDownsState extends State<DropDowns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dropdown Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [],
        ),
      ),
    );
  }
}
