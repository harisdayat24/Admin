// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_const_constructors_in_immutables, unused_local_variable, deprecated_member_use, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:minia_web_project/view/Forms/basic_elements_container/textaual.dart';
import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';

class BlogView extends StatefulWidget {
  BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  var selecte = "first";

  final SideBarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? controller.index.value == 10
                ? RowTitel(
                    textL: "Blog Grid",
                    texti: "Blog",
                    textii: "Blog Grid",
                  )
                : RowTitel(
                    textL: "Blog List",
                    texti: "Blog",
                    textii: "Blog List",
                  )
            : controller.index.value == 10
                ? ColumnTitel(
                    textL: "Blog Grid",
                    texti: "Blog",
                    textii: "Blog Grid",
                  )
                : ColumnTitel(
                    textL: "Blog List",
                    texti: "Blog",
                    textii: "Blog List",
                  ),

        Container(height: 20),
        Row(
          children: [
            Text(
              "Blog List ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColor.dark),
            ),
            Text(
              "(535)",
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

        // 2 PAGES **** //
        controller.index.value == 10 || selecte == "sec"
            ? blogGrid(width)
            : selecte == "sec" || controller.index.value == 11
                ? list(width)
                : Container(),
      ],
    );
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

  Widget list(width) {
    return width > 1150
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    // height: 500,

                    child: blogList(width),
                  )),
              Container(width: 20.0),
              Expanded(
                flex: 2,
                child: upcomingpost(width),
              ),
            ],
          )
        : Column(
            children: [
              blogList(width),
              upcomingpost(width),
            ],
          );
  }

  Container upcomingpost(width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColor.boxborder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 20, bottom: 15),
            child: Text(
              "Search",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.dark,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.search, size: 18, color: AppColor.dark),
                  fillColor: AppColor.lightgrey.withOpacity(.10),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.boxborder),
                  ),
                ),
              ),
            ),
          ),
          Container(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
            child: Text(
              "Catagories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.dark,
              ),
            ),
          ),
          Categorieslist(cataname: "Design", catanum: "02"),
          Categorieslist(cataname: "Development", catanum: "04"),
          Categorieslist(cataname: "Business", catanum: "12"),
          Categorieslist(cataname: "Project", catanum: "08"),
          Categorieslist(cataname: "Travel", catanum: "10"),
          Container(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              "Upcoming Post",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.dark,
              ),
            ),
          ),
          post(),
          divider(),
          post(),
          divider(),
          post(),
          divider(),
          post(),
          Container(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 7),
            child: Text(
              "Popular Post",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.dark,
              ),
            ),
          ),
          popularPost(),
          divider(),
          popularPost(),
          divider(),
          popularPost(),
          Container(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              "Tag Clouds",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
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
          Container(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              "Instagram Post",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 5.0,
              runSpacing: 5.0,
              children: List.generate(
                instapost.length,
                (index) => InstaWidget(
                  file: instapost[index],
                ),
              ),
            ),
          ),
          Container(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              "Email Newsletter",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
            child: Container(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColor.dark,
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  fillColor: AppColor.mainbackground,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.boxborder, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.boxborder),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: AppColor.boxborder)),
                        ),
                        child:
                            Icon(Icons.send, color: AppColor.dark, size: 15)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  List<String> instapost = [
    "assets/image/coming/bg1.jpg",
    "assets/image/coming/bg2.jpg",
    "assets/image/coming/bg3.jpg",
    "assets/image/image1.jpg",
    "assets/image/image2.jpg",
    "assets/image/error/img.png"
  ];

  List<String> tags = [
    "Design",
    "Developer",
    "Wordpress",
    "HTML",
    "Project",
    "Business",
    "Travel",
    "Photography",
  ];

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Divider(),
    );
  }

  Widget popularPost() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  "assets/image/tree.jpg",
                  fit: BoxFit.cover,
                  height: 54,
                  width: 78,
                ),
              ),
              Container(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Beautiful Day with Friends",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                      ),
                    ),
                    Container(height: 8),
                    Text(
                      "10 Apr,2022",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget post() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 12, bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              "assets/image/image1.jpg",
              fit: BoxFit.cover,
              height: 45,
              width: 65,
            ),
          ),
          Container(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Beautiful Day with Friends",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Container(height: 8),
                Text(
                  "20 August,2022 / 05:00 AM",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColor.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.calendar_month_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column BlogDetailText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.black.withOpacity(.40)),
        Container(height: 15),
        Text(
          "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam enim ad minima veniam quis",
        ),
        Container(height: 20),
        Text(
          "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt",
        ),
        Container(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: SvgPicture.asset(
                  "assets/svg/double_quote.svg",
                  fit: BoxFit.cover,
                  height: 25,
                  width: 25,
                  color: AppColor.black,
                ),
              ),
              Container(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium deleniti atque corrupti quos dolores et quas molestias excepturi sint quidem rerum facilis est",
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(height: 20),
        Text(
          "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Sed ut perspiciatis unde omnis iste natus error sit",
        ),
        Container(height: 20),
        Text(
          "Title:",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 20),
        TitleOfBlog(title: "Donec sodales sagittis"),
        TitleOfBlog(title: "Sed consequat leo eget"),
        TitleOfBlog(title: "Aliquam lorem ante"),
        
        TitleOfBlog(title: "Aenean ligula eget"),
        TitleOfBlog(title: "Cum sociis natoque"),
        Comments(),
        Container(height: 10),
        Divider(),
        LeaveAReply(),
      ],
    );
  }

  Column LeaveAReply() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 30),
        Text(
          "Leave a Reply:",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Container(height: 15),
        BasicTextFields(
          title: "Name",
          obscure: false,
          hintText: "Enter name",
        ),
        BasicTextFields(
          title: "Email",
          obscure: false,
          hintText: "Enter email",
        ),
        BasicTextFields(
          title: "Message",
          obscure: false,
          hintText: "Your message",
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.selecteColor,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.selecteColor,
                    blurRadius: 2.0,
                  )
                ]),
            height: 35,
            width: 100,
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(color: AppColor.mainbackground),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column Comments() {
    return Column(
      children: [
        Container(height: 25),
        Divider(color: AppColor.black.withOpacity(.40)),
        Container(height: 40),
        Row(
          children: [
            Icon(Icons.message,
                size: 15, color: AppColor.black.withOpacity(.70)),
            Container(width: 5),
            Text("Comments :",
                style: TextStyle(
                    color: AppColor.black, fontWeight: FontWeight.w600))
          ],
        ),
        Container(height: 20),
        CommentsChat(
          name: "Delores Williams",
          time: "1 hrs Ago",
          message:
              "If several languages coalesce, the grammar of the resulting language is more simple and regular than that of the individual",
        ),
        Container(height: 10),
        Divider(),
        Container(height: 10),
        CommentsChat(
          name: "Clarence Smith",
          time: "2 hrs Ago",
          message:
              "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet",
        ),
        Container(height: 20),
        Row(
          children: [
            Container(width: 40),
            Expanded(
              child: Column(
                children: [
                  CommentsChat(
                    name: "Silvia Martinez",
                    time: "2 hrs Ago",
                    message:
                        "To take a trivial example, which of us ever undertakes laborious physical exercise",
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(height: 10),
        Divider(),
        Container(height: 10),
        CommentsChat(
          name: "Keith McCoy",
          time: "12 Aug",
          message:
              "Donec posuere vulputate arcu. phasellus accumsan cursus velit",
        ),
      ],
    );
  }

  Column categoriesNamesColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Project",
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 30),
        Text(
          "Date",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "20 June, 2022",
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 30),
        Text(
          "Post by",
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Gilbert Smith",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Row categoriesNamesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Categories",
              style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Project",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Date",
              style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "20 June, 2022",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Post by",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Gilbert Smith",
              style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListView blogList(double width) {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxborder),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "${dataList[index]['image']}",
                    fit: BoxFit.fill,
                    width: width > 1150 ? 1200 : width,
                    // width: 1000,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20),
                        Text(
                          "${dataList[index]['date']}",
                          style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          height: width > 1100
                              ? 8
                              : width > 580
                                  ? 2
                                  : width > 500
                                      ? 8
                                      : 8,
                        ),
                        Text(
                          "${dataList[index]['heading']}",
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          height: width > 1100
                              ? 8
                              : width > 580
                                  ? 2
                                  : width > 500
                                      ? 8
                                      : 8,
                        ),
                        Text(
                          "${dataList[index]['description']}",
                          style: TextStyle(
                            color: AppColor.lightgrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: width > 1100
                              ? 8
                              : width > 580
                                  ? 2
                                  : width > 500
                                      ? 8
                                      : 8,
                        ),
                        Text(
                          "Read more >",
                          style: TextStyle(
                            color: AppColor.searchbackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Map<String, String>> dataList = [
    {
      'date': '12 june, 2022',
      'heading': 'Project discussion with team',
      'description':
          'Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words.',
      'image': 'assets/image/blog/img_1.jpg',
    },
    {
      'date': '24 May, 2022',
      'heading': 'Drawing a sketch',
      'description':
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      'image': 'assets/image/blog/img_2.jpg',
    },
    {
      'date': '10 Apr, 2022',
      'heading': 'Beautiful Day with Friends',
      'description':
          'Contrary to popular belief, Lorem Ipsum is not simply random text,a Latin professor at Hampden-Sydney College in Virginia.',
      'image': 'assets/image/blog/img_3.jpg',
    },
    {
      'date': '10 July, 2022',
      'heading': 'Morning with Photoshoot',
      'description':
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      'image': 'assets/image/blog/img_4.jpg',
    },
    {
      'date': '22 May, 2022',
      'heading': 'Working day with our new ideas',
      'description':
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour.',
      'image': 'assets/image/blog/img_5.jpg',
    },
    {
      'date': '10 July, 2022',
      'heading': 'Morning with Photoshoot',
      'description':
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
      'image': 'assets/image/blog/img_6.jpg',
    },

    // Add more data items as needed
  ];

  GridView blogGrid(double width) {
    return GridView.builder(
      itemCount: dataList.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 1100
            ? 3
            : width > 580
                ? 2
                : 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.boxborder),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  '${dataList[index]['image']}',
                  fit: BoxFit.fill,
                  width: width > 1150 ? 1200 : width,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 20),
                      Text(
                        '${dataList[index]['date']}',
                        style: TextStyle(
                          color: AppColor.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: width > 1100
                            ? 8
                            : width > 580
                                ? 2
                                : width > 500
                                    ? 8
                                    : 8,
                      ),
                      Text(
                        '${dataList[index]['heading']}',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        height: width > 1100
                            ? 8
                            : width > 580
                                ? 2
                                : width > 500
                                    ? 8
                                    : 8,
                      ),
                      Text(
                        '${dataList[index]['description']}',
                        style: TextStyle(
                          color: AppColor.lightgrey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(height: 15),
                      Text(
                        "Read more >",
                        style: TextStyle(
                          color: AppColor.searchbackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CommentsChat extends StatelessWidget {
  final String name;
  final String time;
  final String message;

  const CommentsChat({
    super.key,
    required this.name,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.selecteColor.withOpacity(.10)),
              child: Icon(Icons.person, size: 18, color: AppColor.selecteColor),
            ),
            Container(width: 15),
            Expanded(
              child: Text(
                name,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: AppColor.black, fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(),
            Text(
              time,
              style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          children: [
            Container(
              width: 33,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColor.dark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(height: 15),
        Row(
          children: [
            Container(width: 33),
            Icon(
              Icons.reply,
              size: 15,
              color: AppColor.darkGreen,
            ),
            Text(
              " Reply",
              style: TextStyle(color: AppColor.darkGreen),
            ),
          ],
        ),
      ],
    );
  }
}

class TitleOfBlog extends StatelessWidget {
  final String title;
  const TitleOfBlog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppColor.black),
              height: 6,
              width: 6,
            ),
            Container(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        Container(height: 10),
      ],
    );
  }
}

class TagsWidget extends StatelessWidget {
  final String file;
  const TagsWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.selecteColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 5.0, right: 5.0),
      child: Text(
        file,
        style: TextStyle(
          color: AppColor.searchbackground,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InstaWidget extends StatelessWidget {
  final String file;
  const InstaWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(file, fit: BoxFit.cover, height: 80, width: 80),
    );
  }
}

class Categorieslist extends StatelessWidget {
  final String cataname;
  final String catanum;
  const Categorieslist({
    super.key,
    required this.cataname,
    required this.catanum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 8),
        Row(
          children: [
            Container(width: 25),
            Text(
              cataname,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Container(
              width: 22,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.selecteColor.withOpacity(.20),
              ),
              child: Center(
                child: Text(
                  catanum,
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColor.selecteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(width: 25),
          ],
        ),
        Container(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Divider(),
        )
      ],
    );
  }
}
