// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../comman/colors.dart';
import '../../../comman/widgets.dart';
import '../../../controller/sidebar_controller.dart';
import 'blog_view.dart';

class BlogDetailMain extends StatefulWidget {
  const BlogDetailMain({super.key});

  @override
  State<BlogDetailMain> createState() => _BlogDetailMainState();
}

class _BlogDetailMainState extends State<BlogDetailMain> {
  SideBarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? RowTitel(
                textL: "Blog Details",
                texti: "Blog",
                textii: "Blog Details",
              )
            : ColumnTitel(
                textL: "Blog Details",
                texti: "Blog",
                textii: "Blog Details",
              ),
        Container(height: 20),
        if (controller.index.value == 12) blogDetails(width),
      ],
    );
  }

  Widget blogDetails(width) {
    return width > 1150
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  // height: 500,
                  // color: AppColor.darkGreen,
                  child: BlogDetailsleft(width),
                ),
              ),
              Container(width: 20),
              Expanded(
                flex: 2,
                child: upcomingpost(width),
              ),
            ],
          )
        : Column(
            children: [
              BlogDetailsleft(width),
              upcomingpost(width),
            ],
          );
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

    // Add more data items as needed
  ];

  ListView BlogDetailsleft(double width) {
    return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.boxborder),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Beautiful Day with Friends",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    // margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColor.boxborder)),
                    child: Image.asset(
                      "assets/image/image2.jpg",
                      fit: BoxFit.fill,
                      width: width > 1150 ? 758 : width,
                      // width: 1000,
                    ),
                  ),
                  //
                  Container(height: 20),
                  width > 578 ? categoriesNamesRow() : categoriesNamesColumn(),
                  Container(height: 15),
                  BlogDetailText()
                ],
              ),
            ),
          );
        });
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
        LeaveAReply(context),
      ],
    );
  }

  Column LeaveAReply(context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 30),
        Text(
          "Leave a Reply:",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Container(height: 15),
        width > 770
            ? Row(
                children: [
                  Expanded(
                    child: BlogTextFields(
                      title: "Name",
                      obscure: false,
                      hintText: "Enter name",
                      height: 40,
                      maxleines: 1,
                    ),
                  ),
                  Expanded(
                    child: BlogTextFields(
                      title: "Email",
                      obscure: false,
                      hintText: "Enter email",
                      height: 40,
                      maxleines: 1,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  BlogTextFields(
                    title: "Name",
                    obscure: false,
                    hintText: "Enter name",
                    height: 40,
                    maxleines: 1,
                  ),
                  BlogTextFields(
                    title: "Email",
                    obscure: false,
                    hintText: "Enter email",
                    height: 40,
                    maxleines: 1,
                  ),
                ],
              ),
        BlogTextFields(
          title: "Message",
          obscure: false,
          hintText: "Your message",
          height: 150,
          maxleines: 4,
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
            color: AppColor.dark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 10),
        Text(
          "Project",
          style: TextStyle(
            color: AppColor.lightdark,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(height: 30),
        Text(
          "Date",
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(height: 10),
        Text(
          "20 June, 2022",
          style: TextStyle(
            color: AppColor.lightdark,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(height: 30),
        Text(
          "Post by",
          style: TextStyle(
            color: AppColor.lightdark,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(height: 10),
        Text(
          "Gilbert Smith",
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Row categoriesNamesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              "Categories",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(height: 10),
            Text(
              "Project",
              style: TextStyle(
                color: AppColor.lightdark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Date",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(height: 10),
            Text(
              "20 June, 2022",
              style: TextStyle(
                color: AppColor.lightdark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Post by",
              style: TextStyle(
                color: AppColor.lightdark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(height: 10),
            Text(
              "Gilbert Smith",
              style: TextStyle(
                color: AppColor.dark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
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

  List<String> instapost = [
    "assets/image/coming/bg1.jpg",
    "assets/image/coming/bg2.jpg",
    "assets/image/coming/bg3.jpg",
    "assets/image/image1.jpg",
    "assets/image/image2.jpg",
    "assets/image/error/img.png"
  ];

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
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
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
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
}

class BlogTextFields extends StatelessWidget {
  final String? initialValue;
  final String title;
  final bool? obscure;
  final bool allowDecimal;
  final String? hintText;
  final double height;
  final int? maxleines;

  const BlogTextFields({
    super.key,
    this.initialValue,
    required this.title,
    this.obscure,
    this.allowDecimal = false,
    this.hintText,
    required this.height,
    this.maxleines,
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
            height: height,
            child: TextFormField(
              maxLines: maxleines,
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
                // hintStyle: TextStyle(color: AppColor.black),
                filled: true,
                fillColor: AppColor.lightwhite.withOpacity(.25),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
