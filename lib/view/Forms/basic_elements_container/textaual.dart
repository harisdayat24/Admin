// Textual //
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, unused_element, use_build_context_synchronously, sized_box_for_whitespace

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/view/Forms/basic_elements_container/color_picker.dart';

// Textual //
Column RightTextualinputs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DatePicker(
        title: "Date",
      ),
      MothPicker(
        title: "Month",
      ),
      // WeekPicker(
      //   title: "Week",
      // ),
      TimePicker(
        title: "Time",
      ),
      Container(height: 8),
      ColorPickernew(),
      Container(height: 20),
      CustomDropDown(),
      Container(height: 20),
    ],
  );
}

// Textual //

class LeftTextualinputs extends StatefulWidget {
  const LeftTextualinputs({
    super.key,
  });

  @override
  State<LeftTextualinputs> createState() => _LeftTextualinputsState();
}

class _LeftTextualinputsState extends State<LeftTextualinputs> {
  DateTime selectedDateTime = DateTime.now();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicTextFields(
          obscure: false,
          title: 'Text',
          initialValue: 'Artisanal kale',
        ),
        BasicTextFields(
          obscure: false,
          title: 'Search',
          initialValue: 'How do I shoot web',
        ),
        BasicTextFields(
          obscure: false,
          title: 'Email',
          initialValue: 'bootstrap@example.com',
        ),
        BasicTextFields(
          obscure: false,
          title: 'URL',
          initialValue: 'https://getbootstrap.com',
        ),
        BasicTextFields(
          title: 'Telephone',
          initialValue: '1-(555)-555-5555',
          obscure: false,
        ),
        BasicTextFields(
          title: 'Password',
          initialValue: 'ddedededededded',
          obscure: true,
        ),
        NumTextFields(
          title: "title",
          allowDecimal: false,
          initialValue: "42",
          obscure: false,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date and time",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.dark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(height: 5),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: AppColor.lightwhite.withOpacity(.25),
                    border: Border.all(color: AppColor.boxborder)),
                child: Row(
                  children: [
                    Container(width: 10),
                    Expanded(
                      flex: 4,
                      child: Text(
                        selectedDateTime.toString(),
                      ),
                    ),
                    Spacer(flex: 1),
                    InkWell(
                        onTap: () => _selectDateTime(context),
                        child: Icon(Icons.calendar_today,
                            color: AppColor.lightdark)),
                    Container(width: 10),
                  ],
                ),

                // child: TextFormField(

                //   style: TextStyle(
                //     fontSize: 14,
                //     color: AppColor.dark,
                //     fontWeight: FontWeight.w400,
                //   ),
                //   decoration: InputDecoration(
                //     hintText: selectedDateTime.toString(),
                //     suffixIcon: InkWell(
                //       onTap: () => _selectDateTime(context),
                //       child: Icon(Icons.calendar_today),
                //     ),
                //     filled: true,
                //     fillColor: AppColor.lightwhite.withOpacity(.25),
                //     contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //       borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //       borderSide: BorderSide(
                //           color: AppColor.searchbackground.withOpacity(.50)),
                //     ),
                //   ),
                // ),
              ),
              Container(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class DateTimePicker extends StatefulWidget {
  // final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const DateTimePicker({
    super.key,
    // this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

DateTime dateTime = DateTime(2022, 12, 24, 5, 30);

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(height: 5),
          // Container(
          //   height: 40,
          //   child: TextFormField(
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: AppColor.dark,
          //       fontWeight: FontWeight.w400,
          //     ),
          //     decoration: InputDecoration(
          //       suffixIcon: InkWell(
          //         onTap: () => _selectDateTime(context),
          //         child: Icon(Icons.calendar_today),
          //       ),
          //       filled: true,
          //       fillColor: AppColor.lightwhite.withOpacity(.25),
          //       contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //         borderSide: BorderSide(color: AppColor.boxborder, width: 1),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //         borderSide: BorderSide(
          //             color: AppColor.searchbackground.withOpacity(.50)),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Future pickDateTime() async {
  //   DateTime? date = await pickDate();
  //   if (date == null) return;

  //   TimeOfDay? time = await pickTime();
  //   if (time == null) return;

  //   final dateTime = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     time.hour,
  //     time.minute,
  //   );

  //   setState(() => dateTime);
  // }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );
}

class WeekPicker extends StatefulWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const WeekPicker({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 7, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: AppColor.lightwhite.withOpacity(.25),
                  border: Border.all(color: AppColor.boxborder)),
              child: Row(
                children: [
                  Container(width: 10),
                  Expanded(
                    flex: 4,
                    child: Text(selectedDate.toString()),
                  ),
                  Spacer(flex: 1),
                  InkWell(
                      onTap: () {
                        // showDatePicker(
                        //   context: context,
                        //   initialDate: selectedDate,
                        //   firstDate: DateTime(2000),
                        //   lastDate: DateTime(2100),
                        //   selectableDayPredicate: (DateTime val) {
                        //     return val.weekday == DateTime.monday;
                        //   },
                        //   initialDatePickerMode: DatePickerMode.day,
                        //   builder: (context, child) {
                        //     return Theme(
                        //       data: ThemeData.light().copyWith(
                        //         primaryColor: Colors
                        //             .blue, // Set your desired primary color
                        //         hintColor: Colors
                        //             .blue, // Set your desired accent color
                        //         colorScheme:
                        //             ColorScheme.light(primary: Colors.blue),
                        //         buttonTheme: ButtonThemeData(
                        //           textTheme: ButtonTextTheme.primary,
                        //         ),
                        //       ),
                        //       child: child!,
                        //     );
                        //   },
                        // ).then((pickedDate) {
                        //   if (pickedDate != null) {
                        //     setState(() {
                        //       selectedDate = pickedDate;
                        //     });
                        //   }
                        // });
                      },
                      child: Icon(
                        Icons.calendar_today,
                        color: AppColor.lightdark,
                      )),
                  Container(width: 10),
                ],
              )),
          Container(height: 10),
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
      selectableDayPredicate: (DateTime date) {
        // Disable day selection
        return false;
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class MothPicker extends StatefulWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const MothPicker({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  State<MothPicker> createState() => _MothPickerState();
}

class _MothPickerState extends State<MothPicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 7, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: AppColor.lightwhite.withOpacity(.25),
                  border: Border.all(color: AppColor.boxborder)),
              child: Row(
                children: [
                  Container(width: 10),
                  Expanded(
                    flex: 4,
                    child: Text('${selectedDate.month}'),
                  ),
                  Spacer(flex: 1),
                  InkWell(
                      onTap: () => _selectMonth(context),
                      child: Icon(
                        Icons.calendar_today,
                        color: AppColor.lightdark,
                      )),
                  Container(width: 10),
                ],
              )),
          Container(height: 10),
        ],
      ),
    );
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.year,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: AppColor.selecteColor, // Customize the color if desired
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month);
      });
    }
  }
}

class TimePicker extends StatefulWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const TimePicker({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 7, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: AppColor.lightwhite.withOpacity(.25),
                  border: Border.all(color: AppColor.boxborder)),
              child: Row(
                children: [
                  Container(width: 10),
                  Expanded(
                    flex: 4,
                    child: Text(
                      _selectedTime?.format(context) ?? '',
                    ),
                  ),
                  Spacer(flex: 1),
                  InkWell(
                      onTap: () => _selectTimeonly(context),
                      child: Icon(
                        Icons.access_time,
                        color: AppColor.lightdark,
                      )),
                  Container(width: 10),
                ],
              )),
          Container(height: 10),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const DatePicker({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  final hours = dateTime.hour.toString().padLeft(2, '0');
  final minutes = dateTime.minute.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 7, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: AppColor.lightwhite.withOpacity(.25),
                  border: Border.all(color: AppColor.boxborder)),
              child: Row(
                children: [
                  Container(width: 10),
                  Expanded(
                    flex: 4,
                    child: Text(
                      selectedDate.toString().split(' ')[0],
                    ),
                  ),
                  Spacer(flex: 1),
                  InkWell(
                      onTap: () => _selectDate(context),
                      child: Icon(
                        Icons.calendar_today,
                        color: AppColor.lightdark,
                      )),
                  Container(width: 10),
                ],
              )),
          Container(height: 10),
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
}

class BasicTextFields extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const BasicTextFields({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              obscureText: obscure!,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppColor.black),
                filled: true,
                fillColor: AppColor.lightwhite.withOpacity(.25),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                      color: AppColor.searchbackground.withOpacity(.50)),
                ),
              ),
            ),
          ),
          Container(height: 10),
        ],
      ),
    );
  }
}

class BasicTextFieldonly extends StatelessWidget {
  final String? initialValue;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final Function(String)? onChanged;

  const BasicTextFieldonly({
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
        SizedBox(
          height: 40,
          child: TextFormField(
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
              filled: true,
              // fillColor: AppColor.lightwhite.withOpacity(.25),
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
      ],
    );
  }
}

class BasicTextFieldonly2 extends StatelessWidget {
  final String? initialValue;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;

  const BasicTextFieldonly2({
    super.key,
    this.initialValue,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
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
              filled: true,
              // fillColor: AppColor.lightwhite.withOpacity(.25),
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
      ],
    );
  }
}

class NumTextFields extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;

  const NumTextFields({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          Container(
            height: 40,
            child: TextFormField(
              initialValue: initialValue,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.dark,
                fontWeight: FontWeight.w400,
              ),
              // keyboardType:
              //     TextInputType.numberWithOptions(decimal: allowDecimal),
              obscureText: obscure!,
              autocorrect: true,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
              //   TextInputFormatter.withFunction(
              //     (oldValue, newValue) => newValue.copyWith(
              //       text: newValue.text.replaceAll('.', ','),
              //     ),
              //   ),
              // ],
              decoration: InputDecoration(
                // hintText: 'Enter Text Here...',
                // hintStyle: TextStyle(color: AppColor.black),
                filled: true,
                fillColor: AppColor.lightwhite.withOpacity(.25),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                      color: AppColor.searchbackground.withOpacity(.50)),
                ),
              ),
            ),
          ),
          Container(height: 10),
        ],
      ),
    );
  }

  String _getRegexString() =>
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> items = ['Item1', 'Item2', 'Item3', 'Item4'];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // ThemeData theme = Theme.of(context);
    // TextTheme textTheme = theme.textTheme;
    // ColorScheme colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.dark,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 5),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text(
                'Item1',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.only(left: 15, right: 15),
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.lightwhite.withOpacity(.25),
                  borderRadius: BorderRadius.circular(1),
                  border: Border.all(
                    color: AppColor.boxborder,
                  ),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 35,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: const EdgeInsets.only(left: 15, right: 15),
                width: width > 1000 ? width / 2 : width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
