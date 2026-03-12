// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minia_web_project/comman/colors.dart';
import '../../../comman/widgets.dart';
import '../blog/blog_view.dart';
import '../chats/chat.dart';
import '../chats/inbox_chat.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
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
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);

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
    return SingleChildScrollView(
      child: Column(
        children: [
          width > 600
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: RowTitel(
                    textL: "Profile",
                    texti: "Contacts",
                    textii: "Profile",
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ColumnTitel(
                    textL: "Profile",
                    texti: "Contacts",
                    textii: "Profile",
                  ),
                ),
          width > 983
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: Profile_left(context)),
                    Container(width: 20),
                    Expanded(flex: 1, child: Profile_right()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Profile_left(context),
                    Container(height: 20),
                    Profile_right(),
                  ],
                ),
        ],
      ),
    );
  }

  List<String> tags = [
    "Photoshop",
    "illustrator",
    "HTML",
    "CSS",
    "Javascript",
    "Php",
    "Python",
  ];

  Column Profile_right() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxborder),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 15, top: 20),
                      child: Text(
                        "Skills",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: List.generate(
                          tags.length,
                          (index) => TagsWidget(
                            file: tags[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 25, top: 20),
                child: Text(
                  "Portfolio",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/internet.svg",
                        fit: BoxFit.contain),
                    Container(width: 5),
                    Text("Website"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/blog.svg",
                        fit: BoxFit.contain),
                    Container(width: 5),
                    Text("Blog"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Similar Profiles",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15, left: 25),
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
        ),
      ],
    );
  }

  Column Profile_left(context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: width < 461
                    ? EdgeInsets.only(left: 20.0, right: 25)
                    : EdgeInsets.zero,
                child: Row(
                  children: [
                    width < 461
                        ? Container(
                            height: 50,
                          )
                        : Container(),
                    Spacer(),
                    width < 461
                        ? Row(
                            children: [
                              Text("Message"),
                              Container(width: 30),
                              Icon(
                                Icons.more_horiz,
                                color: AppColor.black,
                                size: 15,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  bottom: 28.0,
                  right: width > 310 ? 25 : 0,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 0),
                      child: Image.asset(
                        "assets/image/avatar.png",
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phyllis Gatlin",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(height: 7),
                        Text(
                          "Full Stack Developer",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColor.dark,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(height: 18),
                        Row(
                          children: [
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                  color: AppColor.darkGreen,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Container(width: 10),
                            Text("Development"),
                            Container(width: 10),
                            width > 1022
                                ? Row(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            color: AppColor.darkGreen,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Container(width: 10),
                                      Text("phyllisgatlin@minia.com")
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                        Container(height: 10),
                        width < 1023
                            ? Row(
                                children: [
                                  width < 356
                                      ? Container()
                                      : Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: AppColor.darkGreen,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                  Container(width: 10),
                                  width < 356
                                      ? Container()
                                      : Text("phyllisgatlin@minia.com")
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    Spacer(),
                    width > 460
                        ? Row(
                            children: [
                              Text("Message"),
                              Container(width: 30),
                              Icon(
                                Icons.more_horiz,
                                color: AppColor.black,
                                size: 15,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Row(
                  children: [
                    width > 355
                        ? Container()
                        : Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: AppColor.darkGreen,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                    Container(width: 10),
                    width > 355 ? Container() : Text("phyllisgatlin@minia.com"),
                  ],
                ),
              ),
              Divider(
                color: AppColor.boxborder,
                thickness: 1.0,
              ),
              SizedBox(
                height: 55,
                child: TabBar(
                  isScrollable: true,
                  indicatorWeight: 1,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding:
                      EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  controller: tabController,
                  // overlayColor: MaterialStatePropertyAll(Colors.amber),
                  indicatorColor: AppColor.searchbackground,
                  tabs: [
                    Tab(
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: currentTabIndex == 0
                              ? AppColor.searchbackground
                              : AppColor.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "About",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: currentTabIndex == 1
                              ? AppColor.searchbackground
                              : AppColor.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: currentTabIndex == 2
                              ? AppColor.searchbackground
                              : AppColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(height: 20),
        Container(
          height: 700,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    height: 690, child: TabbView(tabController: tabController)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TabbView extends StatefulWidget {
  final dynamic tabController;

  const TabbView({super.key, required this.tabController});
  @override
  // ignore: library_private_types_in_public_api
  _TabbViewState createState() => _TabbViewState();
}

class _TabbViewState extends State<TabbView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      // viewportFraction: 1.0,
      controller: widget.tabController,
      // dragStartBehavior: DragStartBehavior.down,
      children: [
        overview(),
        about(),
        post(context),
      ],
    );
  }

  SingleChildScrollView post(context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 15),
            child: Text(
              "Post",
              style: TextStyle(
                // height: 4,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
          ),
          Divider(color: AppColor.boxborder),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Project discussion with team",
                          overflow: TextOverflow.clip,
                        )),
                    Spacer(flex: 1),
                    Icon(Icons.more_horiz)
                  ],
                ),
                Container(height: 10),
                Text("24 Mar, 2020"),
                Container(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/tag.svg",
                      height: 20,
                      width: 20,
                      color: AppColor.black,
                    ),
                    Container(width: 8),
                    Text("Development"),
                    Container(width: 20),
                    width > 340
                        ? Row(
                            children: [
                              Icon(
                                Icons.message_outlined,
                                color: AppColor.black.withOpacity(.50),
                                size: 20,
                              ),
                              Container(width: 8),
                              Text("08 Comments")
                            ],
                          )
                        : Container(),
                  ],
                ),
                width < 341
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.message_outlined,
                              color: AppColor.black.withOpacity(.50),
                              size: 20,
                            ),
                            Container(width: 8),
                            Text("08 Comments")
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView overview() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
            child: Text(
              "About",
              style: TextStyle(
                // height: 4,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
          ),
          Divider(color: AppColor.boxborder),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 12, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Bio :",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Container(height: 10),
                Text(
                  "Hi I'm Phyllis Gatlin, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages ",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 15),
                Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at it has a more-or-less normal distribution of letters",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 40),
                Text(
                  "Experience :",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Container(height: 8),
                Text(
                  "If several languages coalesce, the grammar of the resulting language is more simple and regular than that of the individual languages. The new common language will be more simple and regular than the existing European languages. It will be as simple as Occidental; in fact, it will be Occidental. To an English person, it will seem like simplified English, as a skeptical Cambridge friend of mine told me what Occidental is. The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 20),
                ExperienceDot(
                  text: "Donec vitae sapien ut libero venenatis faucibus",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Quisque rutrum aenean imperdiet",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Integer ante a consectetuer eget",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Phasellus nec sem in justo pellentesque",
                ),
                Container(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView about() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
            child: Text(
              "About",
              style: TextStyle(
                // height: 4,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
          ),
          Divider(color: AppColor.boxborder),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 12, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bio :",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Container(height: 10),
                Text(
                  "Hi I'm Phyllis Gatlin, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages ",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 15),
                Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at it has a more-or-less normal distribution of letters",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 15),
                Text(
                  "It will be as simple as Occidental; in fact, it will be Occidental. To an English person, it will seem like simplified English, as a skeptical Cambridge friend of mine told me what Occidental is. The European languages are members of the same family. Their separate existence is a myth.",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 30),
                ExperienceDot(
                  text: "Donec vitae sapien ut libero venenatis faucibus",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Quisque rutrum aenean imperdiet",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Integer ante a consectetuer eget",
                ),
                Container(height: 20),
                Text(
                  "Experience :",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Container(height: 5),
                Text(
                  "If several languages coalesce, the grammar of the resulting language is more simple and regular than that of the individual languages. The new common language will be more simple and regular than the existing European languages. It will be as simple as Occidental; in fact, it will be Occidental. To an English person, it will seem like simplified English, as a skeptical Cambridge friend of mine told me what Occidental is. The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc",
                  style: TextStyle(height: 2 - .40),
                ),
                Container(height: 20),
                ExperienceDot(
                  text: "Donec vitae sapien ut libero venenatis faucibus",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Quisque rutrum aenean imperdiet",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Integer ante a consectetuer eget",
                ),
                Container(height: 10),
                ExperienceDot(
                  text: "Phasellus nec sem in justo pellentesque",
                ),
                Container(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceDot extends StatelessWidget {
  final String text;
  const ExperienceDot({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
              color: AppColor.darkGreen,
              borderRadius: BorderRadius.circular(5)),
        ),
        Container(width: 10),
        Expanded(
            child: Text(
          text,
          overflow: TextOverflow.clip,
        ))
      ],
    );
  }
}
