// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minia_web_project/comman/widgets.dart';
import '../../../comman/colors.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key? key});

  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  List<DroppedFile> files = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width > 600
            ? RowTitel(
                textL: "File Upload",
                texti: "Forms",
                textii: "File Upload",
              )
            : ColumnTitel(
                textL: "File Upload",
                texti: "Forms",
                textii: "File Upload",
              ),
        Container(height: 20),
        Container(
          height: 795,
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.boxborder)),
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 21),
                  child: Text(
                    "Dropzone",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22, left: 20.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'DropzoneJS is an open source library that provides drag’n’drop file uploads with image previews.',
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColor.borders),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                  child: Container(
                    height: 250,
                    child: DropzoneWidget(
                      onDroppedFile: (file) => setState(() => files.add(file)),
                    ),
                  ),
                ),
                Container(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 30.0,
                    runSpacing: 30.0,
                    children: List.generate(
                      files.length,
                      (index) => DroppedFileWidget(
                        file: files[index],
                      ),
                    ),
                  ),
                ),

                // Wrap(
                //   children: [
                //     Expanded(
                //       child: GridView.builder(
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 10,
                //           crossAxisSpacing: 30,
                //           mainAxisSpacing: 30,
                //           mainAxisExtent: 130,
                //         ),
                //         itemCount: files.length,
                //         itemBuilder: (context, index) {
                //           return Container(
                //               height: 130,
                //               width: 130,
                //               child: DroppedFileWidget(file: files[index]));
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: List.generate(
                //     files.length,
                //     (index) => DroppedFileWidget(file: files[index]),
                //   ),
                // ),
                 Container(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    if (file == null) return buildEmptyFile('No File');

    if (file!.mime.startsWith('image/')) {
      return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              file!.url,
              fit: BoxFit.cover,
            ),
          ));
    } else if (file!.mime.startsWith('video/')) {
      return VideoPlayerWidget(file: file!);
    } else if (file!.mime.endsWith('svg/')) {
      return Container(
        child: Text("SVG IMAGE"),
      );
    } else {
      return buildEmptyFile('Unsupported File');
    }
  }

  Widget buildEmptyFile(String text) {
    return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));

    // Container(
    //   width: 120,
    //   height: 120,
    //   color: Colors.blue.shade300,
    //   child: Center(
    //     child: Text(
    //       text,
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final DroppedFile file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.black,
      child: Center(
        child: Text(
          'Video File',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    // Add your video player implementation here
  }
}

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;
  const DropzoneWidget({super.key, required this.onDroppedFile});

  @override
  State<DropzoneWidget> createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColor.borders,
      strokeWidth: 1,
      dashPattern: const [3, 0, 3],
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      child: InkWell(
        onTap: () async {
          final events = await controller.pickFiles();
          if (events.isEmpty) return;
          acceptFile(events.first);
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: [
              DropzoneView(
                onDrop: acceptFile,
                onCreated: (controller) => this.controller = controller,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/cloud_upload.svg",
                      fit: BoxFit.cover,
                      color: AppColor.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Drop files here or click to upload.",
                        style: TextStyle(
                          color: AppColor.dark,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(height: 10),
                    // ElevatedButton.icon(
                    //   icon: Icon(Icons.search, size: 32),
                    //   label: Text(
                    //     "Choose Files",
                    //     style: TextStyle(color: Colors.white, fontSize: 20),
                    //   ),
                    //   onPressed: () async {
                    //     final events = await controller.pickFiles();
                    //     if (events.isEmpty) return;
                    //     acceptFile(events.first);
                    //   },
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    print("Name: $name");
    print("MIME: $mime");
    print("Bytes: $bytes");
    print("URL: $url");

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
  }
}

class DroppedFile {
  final String url;
  final String name;
  final String mime;
  final int bytes;

  DroppedFile({
    required this.url,
    required this.name,
    required this.mime,
    required this.bytes,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1 ? '${mb.toStringAsFixed(2)}MB' : '${kb.toStringAsFixed(2)}KB';
  }
}

// class DroppedFileWidget extends StatelessWidget {
//   final DroppedFile file;
//   const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       height: 120,
//       color: Colors.blue.shade300,
//       child: file.url.isNotEmpty
//           ? Image.network(
//               file.url,
//               width: 120,
//               height: 120,
//               fit: BoxFit.cover,
//             )
//           : Center(
//               child: Text(
//                 'No File',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//     );
//   }
// }
