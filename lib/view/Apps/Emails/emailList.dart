// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minia_web_project/comman/colors.dart';

class EmailConversionList extends StatefulWidget {
  final String name;
  final String subtext;
  final bool isMessageRead;
  final String time;

  EmailConversionList({
    required this.name,
    required this.time,
    required this.subtext,
    required this.isMessageRead,
  });
  @override
  _EmailConversionListState createState() => _EmailConversionListState();
}

class _EmailConversionListState extends State<EmailConversionList> {
  bool isselect = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
      child: Row(
        children: [
          Container(width: 20),
          InkWell(
            onTap: () {
              setState(() {
                isselect = !isselect;
              });
            },
            child: isselect
                ? SvgPicture.asset("assets/svg/check_box.svg")
                : SvgPicture.asset("assets/svg/checked_box2.svg"),
          ),
          Container(width: 15),
          SvgPicture.asset("assets/svg/star.svg"),
          Container(width: width < 415 ? 10 : 40),
          Expanded(
            flex: 1,
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: 14,
                color:
                    widget.isMessageRead ? AppColor.black : AppColor.lightgrey,
                fontWeight:
                    widget.isMessageRead ? FontWeight.bold : FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              // maxLines: 1,
              // softWrap: true,
            ),
          ),
          Container(width: 10),
          width > 650
              ? Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.subtext,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isMessageRead
                            ? AppColor.black
                            : AppColor.lightgrey,
                        fontWeight: widget.isMessageRead
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                      // maxLines: 1,
                      // softWrap: false,
                    ),
                  ),
                )
              : Container(),
          // Spacer(),
          Container(width: 10),
          Text(
            widget.time,
            style: TextStyle(
              fontSize: 14,
              color: widget.isMessageRead ? AppColor.black : AppColor.dark,
              fontWeight:
                  widget.isMessageRead ? FontWeight.bold : FontWeight.w400,
              // fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
