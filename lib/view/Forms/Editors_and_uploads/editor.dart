// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// import 'package:flutter/material.dart';
// import 'package:minia_web_project/comman/colors.dart';
// import 'package:minia_web_project/comman/widgets.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';

// class Editors extends StatefulWidget {
//   const Editors({super.key});

//   @override
//   State<Editors> createState() => _EditorsState();
// }

// class _EditorsState extends State<Editors> {
//   ///[controller] create a QuillEditorController to access the editor methods
//   late QuillEditorController controller;

//   ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

//   final customToolBarList = [
//     ToolBarStyle.bold,
//     ToolBarStyle.italic,
//     ToolBarStyle.align,
//     ToolBarStyle.color,
//   ];

//   final _toolbarColor = AppColor.boxborder.withOpacity(.75);
//   final _backgroundColor = Colors.white70;
//   final _toolbarIconColor = Colors.black87;
//   final _editorTextStyle = const TextStyle(
//       fontSize: 15, color: AppColor.dark, fontWeight: FontWeight.w500);
//   final _hintTextStyle = const TextStyle(
//       fontSize: 18, color: Colors.teal, fontWeight: FontWeight.normal);

//   @override
//   void initState() {
//     controller = QuillEditorController();
//     controller.onTextChanged((text) {
//       // debugPrint('listening to');
//     });
//     super.initState();
//   }

//   bool _hasFocus = false;
//   @override
//   void dispose() {
//     /// please do not forget to dispose the controller
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return SizedBox(
//       height: height - 209,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           width > 600
//               ? RowTitel(
//                   textL: "Form Editor",
//                   texti: "Forms",
//                   textii: "Form Editor",
//                 )
//               : ColumnTitel(
//                   textL: "Form Editor",
//                   texti: "Forms",
//                   textii: "Form Editor",
//                 ),
//           Container(height: 20),
//           Container(
//             width: width,
//             decoration:
//                 BoxDecoration(border: Border.all(color: AppColor.boxborder)),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0, top: 21, bottom: 22),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Ckeditor Classic editor",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Container(height: 10),
//                   RichText(
//                     text: TextSpan(
//                       text: 'Example of Ckeditor Classic editor',
//                       style: TextStyle(
//                         color: AppColor.black,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             decoration:
//                 BoxDecoration(border: Border.all(color: AppColor.boxborder)),
//             height: height - 370,
//             width: width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: width,
//                   height: 50,
//                   child: ToolBar.scroll(
//                     toolBarColor: _toolbarColor,
//                     padding: const EdgeInsets.all(8),
//                     iconSize: 25,
//                     iconColor: _toolbarIconColor,
//                     activeIconColor: Colors.greenAccent.shade400,
//                     controller: controller,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     direction: Axis.horizontal,
//                     customButtons: [
//                       Container(
//                         width: 25,
//                         height: 25,
//                         decoration: BoxDecoration(
//                             color: _hasFocus ? Colors.green : Colors.grey,
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                       InkWell(
//                           onTap: () => unFocusEditor(),
//                           child: const Icon(
//                             Icons.favorite,
//                             color: Colors.black,
//                           )),
//                       InkWell(
//                           onTap: () async {
//                             var selectedText =
//                                 await controller.getSelectedText();
//                             debugPrint('selectedText $selectedText');
//                             var selectedHtmlText =
//                                 await controller.getSelectedHtmlText();
//                             debugPrint('selectedHtmlText $selectedHtmlText');
//                           },
//                           child: const Icon(
//                             Icons.add_circle,
//                             color: Colors.black,
//                           )),
//                     ],
//                   ),
//                 ),
//                 // Container(height: 200, width: 50, color: Colors.amber),
//                 Flexible(
//                   fit: FlexFit.tight,
//                   child: QuillHtmlEditor(
//                     text: "ggg",
//                     hintText: 'hhh',
//                     controller: controller,
//                     isEnabled: true,
//                     // ensureVisible: false,
//                     minHeight: 200,
//                     textStyle: _editorTextStyle,
//                     hintTextStyle: _hintTextStyle,
//                     hintTextAlign: TextAlign.start,
//                     padding: const EdgeInsets.only(left: 10, top: 10),
//                     hintTextPadding: const EdgeInsets.only(left: 20),
//                     backgroundColor: _backgroundColor,
//                     onFocusChanged: (focus) {
//                       debugPrint('has focus $focus');
//                       setState(() {
//                         _hasFocus = focus;
//                       });
//                     },
//                     onTextChanged: (text) =>
//                         debugPrint('widget text change $text'),
//                     onEditorCreated: () {
//                       debugPrint('Editor has been loaded');
//                       // setHtmlText('Testing text on load');
//                     },
//                     onEditorResized: (height) =>
//                         debugPrint('Editor resized $height'),
//                     onSelectionChanged: (sel) =>
//                         debugPrint('index ${sel.index}, range ${sel.length}'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void unFocusEditor() => controller.unFocus();
// }
