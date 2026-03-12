// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:minia_web_project/comman/colors.dart';
import 'package:minia_web_project/comman/widgets.dart';
import 'Models/chatMessageModel.dart';
import 'Models/chatlist.dart';
import 'conversationList.dart';

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
];

List<ChatUsers> chatUsers = [
  ChatUsers(
      text: "Jane Russel",
      secondaryText: "Awesome Setup",
      imageURL: "assets/image/avatar.png",
      time: "02 min",
      messageText: "Hey! there I'm available",
      name: 'Jane Russel'),
  ChatUsers(
      text: "Glady's Murphy",
      secondaryText: "That's Great",
      imageURL: "assets/image/avatar2.png",
      time: "Yesterday",
      messageText: "I've finished it! See you so",
      name: "Glady's Murphy"),
  ChatUsers(
      text: "Jorge Henry",
      secondaryText: "Hey where are you?",
      imageURL: "assets/image/avatar3.png",
      time: "31 Mar",
      messageText: "This theme is awesome!",
      name: 'Jorge Henry'),
  ChatUsers(
      text: "Philip Fox",
      secondaryText: "Busy! Call me in 20 mins",
      time: "28 Mar",
      imageURL: 'assets/image/avatar4.png',
      messageText: "Nice to meet you",
      name: 'Philip Fox'),
  ChatUsers(
      text: "Debra Hawkins",
      secondaryText: "Thankyou, It's awesome",
      imageURL: "assets/image/avatar.png",
      time: "23 Mar",
      messageText: "Wow that's great",
      name: 'Debra Hawkins'),
  ChatUsers(
      text: "Jacob Pena",
      secondaryText: "will update you in evening",
      imageURL: "assets/image/avatar2.png",
      time: "17 Mar",
      messageText: "Nice to meet you",
      name: 'Jacob Pena'),
  ChatUsers(
      text: "Andrey Jones",
      secondaryText: "Can you please share the file?",
      imageURL: "assets/image/avatar3.png",
      time: "24 Feb",
      messageText: "Hey! there I'm available",
      name: 'Andrey Jones'),
  ChatUsers(
      text: "John Wick",
      secondaryText: "How are you?",
      imageURL: "assets/image/avatar4.png",
      time: "18 Feb",
      messageText: "Wow that's great",
      name: 'John Wick'),
];

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return width > 850 ? rowChat(width, height) : columnChat(width, height);
  }

  Column columnChat(double width, double height) {
    return Column(
      children: [
        if (width > 600)
          RowTitel(
            textL: "Chat",
            texti: "Apps",
            textii: "Chat",
          )
        else
          ColumnTitel(
            textL: "Chat",
            texti: "Apps",
            textii: "Chat",
          ),
        Container(height: 20),
        ChatStartProfile(width, height),
        Container(height: 21),
        ChatScreens(width, height),
        TextFieldChats(),
        Container(height: 10)
      ],
    );
  }

// ChatText

  Column rowChat(double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (width > 600)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: RowTitel(
              textL: "Chat",
              texti: "Apps",
              textii: "Chat",
            ),
          )
        else
          ColumnTitel(
            textL: "Chat",
            texti: "Apps",
            textii: "Chat",
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 400, child: ChatStartProfile(width, height)),
            Container(width: 4.0),
            Expanded(
              flex: 3,
              child: Container(
                height: 750,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChatScreens(width, height),
                    TextFieldChats(),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Container TextFieldChats() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.boxborder),
        borderRadius: BorderRadius.circular(0),
        color: AppColor.mainbackground,
      ),
      padding: EdgeInsets.only(bottom: 12, top: 12),
      height: 60,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            width: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
                color: AppColor.lightblue,
              ),
              child: TextFormField(
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: "Enter Message...",
                hintStyle: TextStyle(fontSize: 14, color: AppColor.black),
                fillColor: AppColor.textfiledcolor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              )),
            ),
          ),
          Container(
            width: 15,
          ),
          Container(
            height: 50, width: 38,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
              color: AppColor.searchbackground,
            ),
// backgroundColor: Colors.blue,
            child: Icon(
              Icons.send,
              color: AppColor.mainbackground,
              size: 13,
            ),
          ),
          Container(
            width: 15,
          ),
        ],
      ),
    );
  }

  Container ChatScreens(double width, double height) {
    return Container(
      decoration: BoxDecoration(
// color: Colors.amber,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColor.boxborder)),
      height: 690,
      width: width,
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Jennie Sherlock",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text("Online"),
                ],
              ),
              Spacer(),
              Icon(
                Icons.search,
                size: 20,
                color: AppColor.black.withOpacity(.80),
              ),
              SizedBox(width: 25),
              Icon(Icons.more_horiz),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: AppColor.boxborder,
          ),
          SizedBox(
// color: Colors.green,
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppColor.boxborder,
                      )),
                      SizedBox(width: 10),
                      Text('Today'),
                      SizedBox(width: 10),
                      Expanded(
                          child: Divider(
                        color: AppColor.boxborder,
                      )),
                    ],
                  ),
                  ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  messages[index].messageType == "receiver"
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                              color: (messages[index].messageType == "receiver"
                                  ? AppColor.selecteColor
                                  : AppColor.boxborder.withOpacity(.50)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index].messageType == "receiver"
                                      ? "Jennis Sherlock"
                                      : "Shawn",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: messages[index].messageType ==
                                              "receiver"
                                          ? AppColor.lightwhite.withOpacity(.55)
                                          : AppColor.black),
                                ),
                                SizedBox(height: 05),
                                Text(
                                  messages[index].messageContent,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: messages[index].messageType ==
                                              "receiver"
                                          ? AppColor.mainbackground
                                          : AppColor.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ChatStartProfile(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColor.boxborder),
      ),
      width: width,
      height: 751,
      child: Column(
        children: [
          Container(height: 20),
          Row(
            children: [
              Container(width: 20),
              Image.asset(
                "assets/image/profile.png",
                fit: BoxFit.contain,
                height: 32,
                width: 32,
              ),
              Container(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Shawn",
                        style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.dark,
                        ),
                      ),
                      Container(width: 5),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Text("Available"),
                ],
              ),
              Spacer(),
              Icon(Icons.more_horiz),
              Container(width: 10),
            ],
          ),
          Container(height: 10),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 14, top: 8.0, bottom: 13, right: 14),
                  child: Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.search, size: 18, color: AppColor.dark),
                        fillColor: AppColor.mainbackground,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.dark,
                          fontWeight: FontWeight.w400,
                        ),
                        isDense: true,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.boxborder, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.boxborder),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 45,
            color: AppColor.selecteColor.withOpacity(.05),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.only(top: 2.5),
              unselectedLabelColor: Colors.grey,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Container(
                  height: 35,
                  width: width,
                  color: currentTabIndex == 0
                      ? AppColor.mainbackground
                      : Colors.transparent,
                  child: Tab(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTabIndex == 0
                            ? AppColor.selecteColor
                            : AppColor.darkblack,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: 35,
                  color: currentTabIndex == 1
                      ? AppColor.mainbackground
                      : Colors.transparent,
                  child: Tab(
                    child: Text(
                      "Groups",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTabIndex == 1
                            ? AppColor.selecteColor
                            : AppColor.darkblack,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: 35,
                  color: currentTabIndex == 2
                      ? AppColor.mainbackground
                      : Colors.transparent,
                  child: Tab(
                    child: Text(
                      "Contacts",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentTabIndex == 2
                            ? AppColor.selecteColor
                            : AppColor.darkblack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 550,
            // color: Colors.green,
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 15.0,
                        ),
                        child: Text(
                          "Recent",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      Container(
                        // color: Colors.amber,
                        height: 560,
                        child: ListView.builder(
                          itemCount: chatUsers.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 16),
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ConversationList(
                              name: chatUsers[index].name,
                              messageText: chatUsers[index].messageText,
                              imageUrl: chatUsers[index].imageURL,
                              time: chatUsers[index].time,
                              isMessageRead:
                                  (index == 0 || index == 3) ? true : false,
                              color: index == 0
                                  ? AppColor.selecteColor.withOpacity(.08)
                                  : AppColor.mainbackground,
                              statuscolor:
                                  (index == 0 || index == 1 || index == 4)
                                      ? AppColor.darkGreen
                                      : (index == 2 || index == 5)
                                          ? AppColor.darkyellow
                                          : AppColor.hintcolor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Groups",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      Divider(),
                      Chats(dp: 'G', name: 'General'),
                      Divider(),
                      Chats(dp: 'R', name: 'Reporting'),
                      Divider(),
                      Chats(dp: 'M', name: 'Meeting'),
                      Divider(),
                      Chats(dp: 'A', name: 'Project A'),
                      Divider(),
                      Chats(dp: 'B', name: 'Project B'),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Contacts",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.dark),
                        ),
                      ),
                      conteactChat(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column conteactChat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactLatter(name: 'A'),
        Divider(),
        ContactName(name: 'Adam Miller'),
        Divider(),
        ContactName(name: 'Alfonso Fisher'),
        Container(height: 20),
        ContactLatter(name: 'B'),
        Divider(),
        ContactName(name: 'Bomnnie Harney'),
        Container(height: 20),
        ContactLatter(name: 'C'),
        Divider(),
        ContactName(name: 'Charles Brown'),
        Divider(),
        ContactName(name: 'Camells Jones'),
        Divider(),
        ContactName(name: 'Charles Willians'),
      ],
    );
  }

  Row personChat() {
    return Row(
      children: [
        Container(width: 15),
        CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.person),
        ),
        Container(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Jennie Sherlock"),
            Text("Hey! there I'm available"),
          ],
        ),
        Spacer(),
        Text(
          "02 min",
          style: TextStyle(
            color: Color(0xFFC3C3C3),
            fontSize: 12,
          ),
        ),
        Container(width: 10),
      ],
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(this, onChanged);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTRB(
        rect.left,
        rect.bottom -
            4, // Adjust this value to control the indicator's position
        rect.right,
        rect.bottom,
      ),
      paint,
    );
  }
}

class ContactName extends StatelessWidget {
  final String name;
  const ContactName({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 6, bottom: 6),
      child: Text(
        name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ContactLatter extends StatelessWidget {
  final String name;
  const ContactLatter({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 6, bottom: 6),
      child: Text(
        name,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  final String dp;
  final String name;
  const Chats({
    super.key,
    required this.dp,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 5),
        Row(
          children: [
            Container(width: 15),
            CircleAvatar(
              radius: 18.0,
              backgroundColor: AppColor.selecteColor.withOpacity(.40),
              child: Text(
                dp,
                style: TextStyle(color: AppColor.selecteColor, fontSize: 15),
              ),
            ),
            Container(width: 15),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(height: 5),
      ],
    );
  }
}
