// import 'package:flutter/material.dart';
// import 'package:mephar_app/app/app_dimens.dart';
// import 'package:mephar_app/app/app_theme.dart';
// import 'package:mephar_app/resource/fonts/app_fonts.dart';
// import 'package:mephar_app/resource/images/app_images.dart';
// import 'package:mephar_app/screens/base_screen/base_screen.dart';
// import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
// import 'package:mephar_app/widgets/mephar_button.dart';
// import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
// import 'package:mephar_app/widgets/mephar_radio_button.dart';
// import 'package:mephar_app/widgets/mephar_textfield.dart';
//
// class AddPromotionInformationScreen extends BaseScreen {
//   final TextEditingController code;
//   final String selected;
//
//   const AddPromotionInformationScreen({super.key, required this.code, required this.selected,});
//
//   @override
//   AddPromotionInformationScreenState createState() => AddPromotionInformationScreenState();
// }
//
// class AddPromotionInformationScreenState extends BaseState<AddPromotionInformationScreen> with BaseScreenMixin {
//   List<String> students = ["A", "b", "C"];
//
//   @override
//   Widget buildHeader() {
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget buildBody(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppThemes.blueBackground,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       "Thông tin",
//                       style: AppFonts.normalBold(
//                         16,
//                         AppThemes.dark1,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           MepharTextfield(hintText: "Mã chương trình", controller: widget.code),
//                           MepharTextfield(hintText: "Tên chương trình"),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Trạng thái",
//                                   style: AppFonts.normalBold(12, AppThemes.gray),
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: MepharRadioButton(
//                                           title: "Kích hoạt",
//                                           isSelected: widget.selected == "Kích hoạt",
//                                           onSelected: (value) {
//                                             setState(() {
//                                               widget.selected = value;
//                                             });
//                                           }),
//                                     ),
//                                     Expanded(
//                                       child: MepharRadioButton(
//                                           title: "Chưa áp dụng",
//                                           isSelected: selected == "Chưa áp dụng",
//                                           onSelected: (value) {
//                                             setState(() {
//                                               selected = value;
//                                             });
//                                           }),
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             color: AppThemes.gray,
//                             height: 1,
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                           MepharTextfield(hintText: "Thêm ghi chú"),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       "Hình thức khuyến mại",
//                       style: AppFonts.normalBold(16, AppThemes.dark1),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           MepharDropDownButton(
//                               haveBorder: false, hintText: "Khuyến mại", items: const [], onChanged: (value) {}),
//                           MepharDropDownButton(
//                               haveBorder: false, hintText: "Hình thức", items: const [], onChanged: (value) {}),
//                           Table(
//                             columnWidths: const {
//                               0: FlexColumnWidth(20),
//                               1: FlexColumnWidth(20),
//                               2: FlexColumnWidth(1),
//                             },
//                             border: const TableBorder(horizontalInside: BorderSide(color: Colors.white, width: 10.0)),
//                             children: [
//                               TableRow(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 10,
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Container(
//                                     color: AppThemes.blue4,
//                                     child: const Padding(
//                                       padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
//                                       child: Text(
//                                         "Tổng tiền hàng",
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 10,
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Container(
//                                     color: AppThemes.blue4,
//                                     child: const Padding(
//                                       padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
//                                       child: Text(
//                                         "Giá trị khuyến mại",
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const Text(
//                                   "",
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//                                 ),
//                               ]),
//                               TableRow(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(top: 20),
//                                           child: Text(
//                                             "Từ ",
//                                             style: AppFonts.regular(14, AppThemes.dark1),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                           flex: 6, child: SizedBox(height: 35, child: MepharTextfield(hintText: ""))),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(child: SizedBox(height: 35, child: MepharTextfield(hintText: ""))),
//                                       const SizedBox(
//                                         width: 2,
//                                       ),
//                                       Expanded(
//                                           child: Container(
//                                         margin: const EdgeInsets.only(top: 10),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.circular(4),
//                                           border: Border.all(width: 2, color: AppThemes.light2),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               flex: 3,
//                                               child: Container(
//                                                 decoration: const BoxDecoration(
//                                                     color: AppThemes.kPrimary,
//                                                     borderRadius: BorderRadius.only(
//                                                         topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
//                                                   child: Text(
//                                                     "VND",
//                                                     style: AppFonts.regular(12, Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Center(
//                                                 child: Text(
//                                                   "%",
//                                                   style: AppFonts.regular(12, AppThemes.kPrimary),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ))
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 12),
//                                   child: Image.asset(
//                                     AppImages.closeItem,
//                                     height: 24,
//                                     width: 24,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )
//                               ]),
//                               TableRow(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(top: 20),
//                                           child: Text(
//                                             "Từ ",
//                                             style: AppFonts.regular(14, AppThemes.dark1),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                           flex: 6, child: SizedBox(height: 35, child: MepharTextfield(hintText: ""))),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     bottom: 10,
//                                     right: 12,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(child: SizedBox(height: 35, child: MepharTextfield(hintText: ""))),
//                                       const SizedBox(
//                                         width: 2,
//                                       ),
//                                       Expanded(
//                                           child: Container(
//                                         margin: const EdgeInsets.only(top: 10),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.circular(4),
//                                           border: Border.all(width: 2, color: AppThemes.light2),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               flex: 3,
//                                               child: Container(
//                                                 decoration: const BoxDecoration(
//                                                     color: AppThemes.kPrimary,
//                                                     borderRadius: BorderRadius.only(
//                                                         topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
//                                                   child: Text(
//                                                     "VND",
//                                                     style: AppFonts.regular(12, Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Center(
//                                                 child: Text(
//                                                   "%",
//                                                   style: AppFonts.regular(12, AppThemes.kPrimary),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ))
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 12),
//                                   child: Image.asset(
//                                     AppImages.closeItem,
//                                     height: 24,
//                                     width: 24,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )
//                               ]),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 16,
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 2.5,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(color: AppThemes.red0, width: 1),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                                 child: Row(
//                                   children: [
//                                     const Expanded(
//                                       child: Icon(
//                                         Icons.add,
//                                         color: AppThemes.red0,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 4,
//                                     ),
//                                     Expanded(
//                                       flex: 5,
//                                       child: Text(
//                                         "Thêm điều kiện",
//                                         style: AppFonts.normalBold(14, AppThemes.red0),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
