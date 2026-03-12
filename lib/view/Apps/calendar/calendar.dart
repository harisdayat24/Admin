// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, unused_field, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';
import '../../Forms/basic_elements_container/textaual.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

CalendarView calendarView = CalendarView.month;
CalendarController calendarController = CalendarController();

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        if (width > 600)
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RowTitel(
                textL: "Calendar",
                texti: "Apps",
                textii: "Calender",
              ))
        else
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ColumnTitel(
              textL: "Calendar",
              texti: "Apps",
              textii: "Calender",
            ),
          ),
        if (width > 1000)
          StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return Container(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.boxborder,
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 5, right: 5),
                                child: ColumnEvents(width, context),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CalendarPhoto(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(width: 20),
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.boxborder,
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FullCalendar(
                              height: height,
                              width: width,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
        else
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.boxborder,
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ColumnEvents(width, context),
                  Container(height: 50),
                  CalendarPhoto(),
                  FullCalendar(
                    width: width > 600 ? 1000 : 500,
                    height: width > 600 ? 700 : 500,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Padding ColumnEvents(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      child: Column(
        children: [
          NewEvent(width, context),
          Container(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child:
                  Text(" Drag and drop your event or click in the calendar")),
          Container(height: 10),
          EventList(
            backgorund: AppColor.darkGreen.withOpacity(.39),
            textanddot: AppColor.darkGreen,
            text: 'New Event Planning',
          ),
          Container(height: 5),
          EventList(
            backgorund: AppColor.darkblue.withOpacity(0.39),
            textanddot: AppColor.darkblue,
            text: 'Meeting',
          ),
          Container(height: 5),
          EventList(
            backgorund: AppColor.darkyellow.withOpacity(.39),
            textanddot: AppColor.darkyellow,
            text: 'Generating Report',
          ),
          Container(height: 5),
          EventList(
            backgorund: AppColor.darkred.withOpacity(.39),
            textanddot: AppColor.darkred,
            text: 'Create New theme',
          ),
          Container(height: 5),
          EventList(
            backgorund: AppColor.darkblack.withOpacity(.39),
            textanddot: AppColor.darkblack,
            text: 'Team Meeting',
          ),
        ],
      ),
    );
  }

  Container NewEvent(double width, BuildContext context) {
    return Container(
      height: 38,
      width: width,
      child: ElevatedButton(
          onPressed: () {
            PopUpBox(context);
          },
          style: ElevatedButton.styleFrom(
            // shadowColor: AppColor.lightdark,
            // elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            backgroundColor: AppColor.selecteColor,
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: AppColor.mainbackground,
                    size: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Create New Event",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 13,
                      color: AppColor.mainbackground,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<dynamic> PopUpBox(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // final formKey = GlobalKey<FormState>();
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
            content: width > 365
                ? bigscreenContent(context)
                : smallscreenContent(context));
      },
    );
  }

  Container smallscreenContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: width > 400 ? 600 : 10,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Add Event",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.black,
                  ),
                ),
              ],
            ),
            Container(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Event Name",
                style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: BasicTextFieldonly(
                hintText: "Insert Event Name",
                initialValue: "",
                obscure: false,
              ),
            ),
            Container(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Category",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 15),
              ),
            ),
            CategorySelect(),
            Container(height: 15),
            Row(
              children: [
                deletebutton(context),
                Spacer(),
                Column(
                  children: [
                    closebutton(context),
                    savebutton(context),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Container bigscreenContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: width > 400 ? 600 : 10,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Add Event",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.black,
                  ),
                ),
              ],
            ),
            Container(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Event Name",
                style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: BasicTextFieldonly(
                hintText: "Insert Event Name",
                initialValue: "",
                obscure: false,
              ),
            ),
            Container(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Category",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 15),
              ),
            ),
            CategorySelect(),
            Container(height: 15),
            width > 500
                ? Row(
                    children: [
                      deletebutton(context),
                      Spacer(),
                      closebutton(context),
                      Container(width: 5),
                      savebutton(context),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 2, child: deletebutton(context)),
                      Spacer(flex: 1),
                      Expanded(flex: 2, child: closebutton(context)),
                      Container(width: 5),
                      Expanded(flex: 2, child: savebutton(context)),
                    ],
                  ),
          ],
        ));
  }

  Container deletebutton(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 35,
      width: width < 365 ? 40 : 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          shadowColor: AppColor.darkred,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: AppColor.darkred,
        ),
        child: Text(
          "Delete",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.mainbackground,
          ),
        ),
      ),
    );
  }

  Container savebutton(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          //                   _events?.appointments!.add(app);
          // _events?.notifyListeners(
          //     CalendarDataSourceAction.add, <Appointment>[app]);
        },
        style: ElevatedButton.styleFrom(
          shadowColor: AppColor.background,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: AppColor.background,
        ),
        child: Text(
          "Save",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.mainbackground,
          ),
        ),
      ),
    );
  }

  Container closebutton(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          // shadowColor: AppColor.lightdark,
          // elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: Color.fromARGB(255, 216, 216, 222),
        ),
        child: Text(
          "Close",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  String? _dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: 42,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColor.mainbackground,
            borderRadius: BorderRadius.circular(0.0),
            border: Border.all(
                color: AppColor.boxborder, style: BorderStyle.solid, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: _dropDownValue == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('- - select - -',
                          style: TextStyle(
                              color: AppColor.dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _dropDownValue!,
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(
                  color: AppColor.dark,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              items: [
                '- - select - -',
                'Danger',
                'Success',
                'Primary',
                'Info',
                'Dark',
                'Warning'
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val,
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropDownValue = val!;
                  },
                );
              },
            ),
          )),
    );
  }
}

class EventList extends StatelessWidget {
  final Color backgorund;
  final Color textanddot;
  final String text;

  const EventList({
    super.key,
    required this.backgorund,
    required this.textanddot,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgorund,
      height: 30,
      child: Row(
        children: [
          Container(width: 15),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: textanddot,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                overflow: TextOverflow.clip,
                color: textanddot,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CalendarPhoto extends StatelessWidget {
  const CalendarPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/svg/calendar.svg");
  }
}

class FullCalendar extends StatelessWidget {
  FullCalendar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (width > 600) RowCalendarButtons() else ColumnCalendarButton(),
        Container(
          height: height,
          width: width,
          child: SfCalendar(
            onTap: (CalendarTapDetails details) {
              DialogBox(context);
            },
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(getAppointment()),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
            // allowAppointmentResize: true,
            view: calendarView,
            controller: calendarController,
            // todayHighlightColor: Colors.blue,
            // timeSlotViewSettings: TimeSlotViewSettings(
            //   startHour: 0,
            //   endHour: 24,
            //   timeRulerSize: 30,
            //   allDayPanelColor: Colors.blueAccent,

            //   // numberOfDaysInView: -1,
            //   nonWorkingDays: <int>[DateTime.friday],
          ),
        ),
      ],
    );
  }

  Future<dynamic> DialogBox(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
            content: width > 365
                ? bigscreenContent(formKey, context)
                : smallscreenContent(formKey, context));
      },
    );
  }

  Container smallscreenContent(
      GlobalKey<FormState> formKey, BuildContext context) {
    return Container(
        width: width > 400 ? 600 : 10,
        color: Colors.transparent,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Add Event",
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              Container(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Event Name",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: BasicTextFieldonly(
                  hintText: "Insert Event Name",
                  initialValue: "",
                  obscure: false,
                ),
              ),
              Container(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                      fontSize: 15),
                ),
              ),
              CategorySelect(),
              Container(height: 15),
              Row(
                children: [
                  deletebutton(context),
                  Spacer(),
                  Column(
                    children: [
                      closebutton(context),
                      savebutton(context),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Container bigscreenContent(
      GlobalKey<FormState> formKey, BuildContext context) {
    return Container(
        width: width > 400 ? 600 : 10,
        color: Colors.transparent,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Add Event",
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              Container(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Event Name",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: BasicTextFieldonly(
                  hintText: "Insert Event Name",
                  initialValue: "",
                  obscure: false,
                ),
              ),
              Container(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                      fontSize: 15),
                ),
              ),
              CategorySelect(),
              Container(height: 15),
              width > 500
                  ? Row(
                      children: [
                        deletebutton(context),
                        Spacer(),
                        closebutton(context),
                        Container(width: 5),
                        savebutton(context),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(flex: 2, child: deletebutton(context)),
                        Spacer(flex: 1),
                        Expanded(flex: 2, child: closebutton(context)),
                        Container(width: 5),
                        Expanded(flex: 2, child: savebutton(context)),
                      ],
                    ),
            ],
          ),
        ));
  }

  Container deletebutton(BuildContext context) {
    return Container(
      height: 35,
      width: width < 365 ? 40 : 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          shadowColor: AppColor.darkred,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: AppColor.darkred,
        ),
        child: Text(
          "Delete",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.mainbackground,
          ),
        ),
      ),
    );
  }

  Container savebutton(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          //                   _events?.appointments!.add(app);
          // _events?.notifyListeners(
          //     CalendarDataSourceAction.add, <Appointment>[app]);
        },
        style: ElevatedButton.styleFrom(
          shadowColor: AppColor.background,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: AppColor.background,
        ),
        child: Text(
          "Save",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.mainbackground,
          ),
        ),
      ),
    );
  }

  Container closebutton(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          // shadowColor: AppColor.lightdark,
          // elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          backgroundColor: Color.fromARGB(255, 216, 216, 222),
        ),
        child: Text(
          "Close",
          style: TextStyle(
            fontSize: 13,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}

List<Appointment> getAppointment() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(
    today.year,
    today.month,
    today.day,
  );
  final DateTime endTime = startTime.add(Duration(hours: 23));

  meetings.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: "Conference",
      color: Colors.blue,
      // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    ),
  );

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class RowCalendarButtons extends StatefulWidget {
  const RowCalendarButtons({
    super.key,
  });

  @override
  State<RowCalendarButtons> createState() => _RowCalendarButtonsState();
}

class _RowCalendarButtonsState extends State<RowCalendarButtons> {
  final CalendarController _calendarController = CalendarController();

  @override
  initState() {
    _calendarController.displayDate = DateTime(2022, 02, 05);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.searchbackground,
              borderRadius: BorderRadius.circular(5)),
          height: 37,
          width: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  calendarController.backward!();
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: AppColor.mainbackground,
                ),
              ),
              InkWell(
                onTap: () {
                  calendarController.forward!();
                },
                child: Icon(
                  Icons.chevron_right_sharp,
                  color: AppColor.mainbackground,
                ),
              ),
            ],
          ),
        ),
        // Container(width: 15),
        // Container(
        //   height: 37,
        //   width: 80,
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(
        //         AppColor.searchbackground,
        //       ),
        //       shape: MaterialStateProperty.all(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(3.0),
        //         ),
        //       ),
        //     ),
        //     onPressed: () {},
        //     child: Text(
        //       "Today",
        //       style: TextStyle(color: AppColor.mainbackground),
        //     ),
        //   ),
        // ),
        Spacer(),
        // Text(
        //   "Today",
        // ),
        // Spacer(),
        Container(
          decoration: BoxDecoration(
              color: AppColor.searchbackground,
              borderRadius: BorderRadius.circular(5)),
          height: 37,
          width: 175,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.month;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.month
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Month",
                      style: TextStyle(color: AppColor.mainbackground),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.week;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.week
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Week",
                      style: TextStyle(color: AppColor.mainbackground),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.day;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.day
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Day",
                      style: TextStyle(color: AppColor.mainbackground),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnCalendarButton extends StatefulWidget {
  const ColumnCalendarButton({
    super.key,
  });

  @override
  State<ColumnCalendarButton> createState() => _ColumnCalendarButtonState();
}

class _ColumnCalendarButtonState extends State<ColumnCalendarButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.searchbackground,
              borderRadius: BorderRadius.circular(5)),
          height: 37,
          width: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  calendarController.backward!();
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: AppColor.mainbackground,
                ),
              ),
              InkWell(
                onTap: () {
                  calendarController.forward!();
                },
                child: Icon(
                  Icons.chevron_right_sharp,
                  color: AppColor.mainbackground,
                ),
              ),
            ],
          ),
        ),
        // Container(height: 15),
        // Text(
        //   "Today",
        // ),
        Container(height: 15),
        Container(
          decoration: BoxDecoration(
              color: AppColor.searchbackground,
              borderRadius: BorderRadius.circular(5)),
          height: 37,
          width: 175,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.month;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.month
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Month",
                      style: TextStyle(color: AppColor.mainbackground),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.week;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.week
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Week",
                      style: TextStyle(color: AppColor.mainbackground),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    calendarView = CalendarView.day;
                    calendarController.view = calendarView;
                  });
                },
                child: Container(
                  color: calendarView == CalendarView.day
                      ? AppColor.weekeds
                      : AppColor.searchbackground,
                  width: 58,
                  height: 37,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Day",
                      style: TextStyle(
                        color: AppColor.mainbackground,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
