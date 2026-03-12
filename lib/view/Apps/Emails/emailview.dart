// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable, null_check_always_fails, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:minia_web_project/view/Apps/Emails/emailList.dart';
import 'package:minia_web_project/view/Apps/Emails/model.dart';
import '../chats/chat.dart';
import '../chats/inbox_chat.dart';
import 'read_mail.dart';

List<Emails> emailLists = [
  Emails(
    name: "Peter, me (3)",
    time: "May 6",
    subtext:
        "Hello - Trip home from Colombo has been arranged, then Jenna will come get me from Stockholm. :)",
  ),
  Emails(
    name: "me, Susanna (7)",
    time: "May 6",
    subtext:
        "Since you asked... and i'm inconceivably bored at the train station – Alright thanks. I'll have to re-book that somehow, i'll get back to you.)",
  ),
  Emails(
    name: "Web Support Dennis",
    time: "May 7",
    subtext: "Re: New mail settings – Will you answer him asap?)",
  ),
  Emails(
    name: "me, Peter (2)",
    time: "May 4",
    subtext:
        "Off on Thursday - Eff that place, you might as well stay here with us instead! Sent from my iPhone 4  4 mar 2014 at 5:55 pm)",
  ),
  Emails(
    name: "Medium",
    time: "Feb 28",
    subtext:
        "This Week's Top Stories - Our top pick for you on Medium this week The Man Who Destroyed America’s Ego",
  ),
  Emails(
    name: "Death to Stock",
    time: "Feb 28",
    subtext:
        "Montly High-Res Photos - To create this month's pack, we hosted a party with local musician Jared Mahone here in Columbus, Ohio.",
  ),
  Emails(
    name: "Randy, me (5)",
    time: "5:01 am",
    subtext:
        "Last pic over my village  - Yeah i'd like that! Do you remember the video you showed me of your train ride between Colombo and Kandy? ",
  ),
  Emails(
    name: "Andrew Zimmer",
    time: "Mar 8",
    subtext:
        "Mochila Beta: Subscription Confirmed - You've been confirmed! Welcome to the ruling class of the inbox. For your records, here is a copy of the... ",
  ),
  Emails(
    name: "Infinity HR",
    time: "Feb 27",
    subtext:
        """Sveriges Hetaste sommarjobb – Hej Nicklas Sandell! Vi vill bjuda in dig till "First tour 2014", ett rekryteringsevent som erbjuder jobb på 16...""",
  ),
  Emails(
    name: "Randy, me (5)",
    time: "5:01 am",
    subtext:
        "Last pic over my village  - Yeah i'd like that! Do you remember the video you showed me of your train ride between Colombo and Kandy? ",
  ),
  Emails(
    name: "Andrew Zimmer",
    time: "Mar 8",
    subtext:
        "Mochila Beta: Subscription Confirmed - You've been confirmed! Welcome to the ruling class of the inbox. For your records, here is a copy of the... ",
  ),
  Emails(
    name: "Infinity HR",
    time: "Feb 27",
    subtext:
        """Sveriges Hetaste sommarjobb – Hej Nicklas Sandell! Vi vill bjuda in dig till "First tour 2014", ett rekryteringsevent som erbjuder jobb på 16...""",
  ),
  Emails(
    name: "Randy, me (5)",
    time: "5:01 am",
    subtext:
        "Last pic over my village  - Yeah i'd like that! Do you remember the video you showed me of your train ride between Colombo and Kandy? ",
  ),
  Emails(
    name: "Andrew Zimmer",
    time: "Mar 8",
    subtext:
        "Mochila Beta: Subscription Confirmed - You've been confirmed! Welcome to the ruling class of the inbox. For your records, here is a copy of the... ",
  ),
  Emails(
    name: "Infinity HR",
    time: "Feb 27",
    subtext:
        """Sveriges Hetaste sommarjobb – Hej Nicklas Sandell! Vi vill bjuda in dig till "First tour 2014", ett rekryteringsevent som erbjuder jobb på 16...""",
  ),
  Emails(
    name: "Randy, me (5)",
    time: "5:01 am",
    subtext:
        "Last pic over my village  - Yeah i'd like that! Do you remember the video you showed me of your train ride between Colombo and Kandy? ",
  ),
  Emails(
    name: "Andrew Zimmer",
    time: "Mar 8",
    subtext:
        "Mochila Beta: Subscription Confirmed - You've been confirmed! Welcome to the ruling class of the inbox. For your records, here is a copy of the... ",
  ),
  Emails(
    name: "Infinity HR",
    time: "Feb 27",
    subtext:
        """Sveriges Hetaste sommarjobb – Hej Nicklas Sandell! Vi vill bjuda in dig till "First tour 2014", ett rekryteringsevent som erbjuder jobb på 16...""",
  )
];

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  List<bool> checkBoxValues = [];
  SideBarController controller = Get.find();

  @override
  void initState() {
    super.initState();
    checkBoxValues = List.generate(emailLists.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return width > 780 ? emailsrow(width, height) : emailsColumn(width, height);
  }

  Column emailsrow(double width, double double) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: controller.index.value == 3
                    ? RowTitel(
                        textL: "Email Inbox",
                        texti: "Email",
                        textii: "Email Inbox",
                      )
                    : RowTitel(
                        textL: "Read Email",
                        texti: "Email",
                        textii: "Read Email",
                      ),
              )
            : controller.index.value == 3
                ? RowTitel(
                    textL: "Email Inbox",
                    texti: "Email",
                    textii: "Email Inbox",
                  )
                : RowTitel(
                    textL: "Read Email",
                    texti: "Email",
                    textii: "Read Email",
                  ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inbox_labels(width),
            Container(width: 20),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    if (controller.index.value == 3) listview_of_mails(),
                    if (controller.index.value == 4) Readmail(),
                    if (controller.index.value == 3) page_number(),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  Column emailsColumn(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        width > 600
            ? controller.index.value == 3
                ? ColumnTitel(
                    textL: "Email Inbox",
                    texti: "Email",
                    textii: "Email Inbox",
                  )
                : ColumnTitel(
                    textL: "Read Email",
                    texti: "Email",
                    textii: "Read Email",
                  )
            : controller.index.value == 3
                ? ColumnTitel(
                    textL: "Email Inbox",
                    texti: "Email",
                    textii: "Email Inbox",
                  )
                : ColumnTitel(
                    textL: "Read Email",
                    texti: "Email",
                    textii: "Read Email",
                  ),
        Container(height: 20),
        inbox_labels(width),
        Container(height: 20),
        if (controller.index.value == 3) listview_of_mails(),
        if (controller.index.value == 4) Readmail(),
        // Readmail(),
        // emails(width),

        page_number(),
      ],
    );
  }

  Container listview_of_mails() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Emailbuttons(),
            ),
          ),
          ListView.builder(
            itemCount: emailLists.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return EmailConversionList(
                name: emailLists[index].name,
                time: emailLists[index].time,
                subtext: emailLists[index].subtext,
                isMessageRead: (index == 4 || index == 8) ? true : false,
              );
            },
          ),
        ],
      ),
    );
  }

  Padding page_number() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text("Showing 1-20 of 1,524"),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: .99,
                      offset: Offset(1, 1),
                      color: AppColor.darkGreen),
                ],
                color: AppColor.darkGreen,
                borderRadius: BorderRadius.circular(5)),
            height: 30,
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: AppColor.mainbackground,
                      size: 20,
                    )),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColor.mainbackground,
                      size: 20,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container inbox_labels(double width) {
    return Container(
      height: 880,
      width: width > 780 ? 250 : width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: width,
                  child: ComposeButton(),
                ),
                Container(height: 40),
                Row(
                  children: [
                    Container(width: 12),
                    Icon(Icons.mail, size: 16, color: AppColor.darkred),
                    Container(width: 8),
                    Text(
                      "Inbox",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.darkred,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '(18)',
                      style: TextStyle(color: AppColor.darkred),
                    )
                  ],
                ),
                Container(height: 20),
                EmailLists(icon: Icons.star_border, text: "Starred"),
                Container(height: 20),
                EmailLists(icon: Icons.diamond_outlined, text: "Important"),
                Container(height: 20),
                EmailLists(icon: Icons.contact_page_outlined, text: "Draft"),
                Container(height: 20),
                EmailLists(
                    icon: Icons.mark_email_read_outlined, text: "Sent Mail"),
                Container(height: 20),
                EmailLists(icon: Icons.delete_forever_outlined, text: "Trash"),
                Container(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Labels",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
                Container(height: 20),
                LabelsList(color: AppColor.darkblue, text: "Them Support"),
                Container(height: 20),
                LabelsList(color: AppColor.darkyellow, text: "Freelance"),
                Container(height: 20),
                LabelsList(color: AppColor.searchbackground, text: "Social"),
                Container(height: 20),
                LabelsList(color: AppColor.darkred, text: "Friends"),
                Container(height: 20),
                LabelsList(color: AppColor.darkGreen, text: "Family"),
                Container(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: 260,
                  child: ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InboxChat(
                        name: chatUsers[index].name,
                        messageText: chatUsers[index].messageText,
                        imageUrl: chatUsers[index].imageURL,
                        time: "",
                        // time: chatUsers[index].time,
                        isMessageRead: (index == null) ? false : false,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ComposeButton extends StatelessWidget {
  const ComposeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shadowColor: AppColor.darkred,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: AppColor.darkred,
      ),
      child: Text(
        "Compose",
        style: TextStyle(
          fontSize: 13,
          color: AppColor.mainbackground,
        ),
      ),
    );
  }
}

class EmailLists extends StatelessWidget {
  final IconData icon;
  final String text;

  const EmailLists({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12),
        Icon(
          icon,
          color: AppColor.lightgrey,
          size: 16,
        ),
        Container(width: 8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.lightgrey,
            ),
          ),
        ),
      ],
    );
  }
}

class LabelsList extends StatelessWidget {
  final Color color;
  final String text;
  const LabelsList({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12),
        Text(
          text,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 14,
            color: AppColor.lightgrey,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_circle_right_rounded,
          color: color,
          size: 16,
        ),
      ],
    );
  }
}

class Emailbuttons extends StatefulWidget {
  const Emailbuttons({super.key});

  @override
  State<Emailbuttons> createState() => _EmailbuttonsState();
}

final List labels = [
  "Theme Support",
  "Freelance",
  "Social",
  "Friends",
  "Family"
];

String? _dropDownValue;
String? _dropDownValue2;
String? _dropDownValue3;

class _EmailbuttonsState extends State<Emailbuttons> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(height: 15),
        width < 290
            ? Row4()
            : width < 360
                ? Row3()
                : width < 450
                    ? Row2()
                    : Row1(),
      ],
    );
  }

  Column Row4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [first(), Container(width: 5)],
        ),
        Row(
          children: [mail(), Container(width: 5), tag()],
        ),
        Row(
          children: [more()],
        )
      ],
    );
  }

  Column Row3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [first(), Container(width: 5), mail()],
        ),
        Row(
          children: [tag(), Container(width: 5), more()],
        )
      ],
    );
  }

  Column Row2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            first(),
            Container(width: 5),
            mail(),
            Container(width: 5),
            tag(),
          ],
        ),
        more(),
      ],
    );
  }

  Row Row1() {
    return Row(
      children: [
        first(),
        Container(width: 5),
        mail(),
        Container(width: 5),
        tag(),
        Container(width: 5),
        more(),
      ],
    );
  }

  DropdownButtonHideUnderline more() {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 80,
        child: DropdownButton(
          hint: _dropDownValue3 == null
              ? Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .99,
                            offset: Offset(1, 1),
                            color: AppColor.searchbackground),
                      ],
                      color: AppColor.searchbackground,
                      borderRadius: BorderRadius.circular(5)),
                  height: 40,
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "More",
                          style: TextStyle(color: AppColor.mainbackground),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.more_vert_rounded,
                            color: AppColor.mainbackground,
                            size: 15,
                          )),
                    ],
                  ),
                )
              : Text(
                  _dropDownValue3!,
                ),
          isExpanded: true,
          iconSize: 0.0,
          // style: TextStyle(color: AppColor.boxborder),
          items: [
            'Mark as Unread',
            'Mark as Important',
            'Add to Tasks',
            "Add Star",
            "Mute",
          ].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            // setState(
            //   () {
            //     _dropDownValue = val!;
            //   },
            // );
          },
        ),
      ),
    );
  }

  DropdownButtonHideUnderline tag() {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 70,
        child: DropdownButton(
          hint: _dropDownValue == null
              ? Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .99,
                            offset: Offset(1, 1),
                            color: AppColor.searchbackground),
                      ],
                      color: AppColor.searchbackground,
                      borderRadius: BorderRadius.circular(5)),
                  height: 40,
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/svg/tag2.svg",
                            height: 15,
                            width: 15,
                          )),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColor.mainbackground,
                            size: 15,
                          )),
                    ],
                  ),
                )
              : Text(
                  _dropDownValue!,
                ),
          isExpanded: true,

          iconSize: 0.0,
          // style: TextStyle(color: AppColor.boxborder),
          items: ['Updates', 'Social', 'Team Manage'].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            // setState(
            //   () {
            //     _dropDownValue = val!;
            //   },
            // );
          },
        ),
      ),
    );
  }

  DropdownButtonHideUnderline mail() {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 70,
        child: DropdownButton(
          hint: _dropDownValue2 == null
              ? Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .99,
                            offset: Offset(1, 1),
                            color: AppColor.searchbackground),
                      ],
                      color: AppColor.searchbackground,
                      borderRadius: BorderRadius.circular(5)),
                  height: 40,
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/svg/mail.svg",
                            height: 15,
                            width: 15,
                          )),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColor.mainbackground,
                            size: 15,
                          )),
                    ],
                  ),
                )
              : Text(
                  _dropDownValue2!,
                ),
          isExpanded: true,

          iconSize: 0.0,
          // style: TextStyle(color: AppColor.boxborder),
          items: ['Updates', 'Social', 'Team Manage'].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            // setState(
            //   () {
            //     _dropDownValue = val!;
            //   },
            // );
          },
        ),
      ),
    );
  }

  Container first() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .99,
                offset: Offset(1, 1),
                color: AppColor.searchbackground),
          ],
          color: AppColor.searchbackground,
          borderRadius: BorderRadius.circular(5)),
      height: 40,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {}, child: SvgPicture.asset("assets/svg/inbox.svg")),
          GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/svg/exclamation.svg")),
          GestureDetector(
              onTap: () {}, child: SvgPicture.asset("assets/svg/trash.svg")),
        ],
      ),
    );
  }
}
