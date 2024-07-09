import 'package:flutter/material.dart';
import 'package:mephar_app/model/search_customer_model.dart';
import 'package:mephar_app/model/search_supplier_model.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';

class AddScopeApplication extends BaseScreen {
  const AddScopeApplication({super.key});

  @override
  AddScopeApplicationState createState() => AddScopeApplicationState();
}

class AddScopeApplicationState extends BaseState<AddScopeApplication> with BaseScreenMixin {
  String selected1 = "";
  String selected2 = "";
  String selected3 = "";
  List<SearchCustomerModel> list = [];
  List<SearchSupplierModel> list2 = [];

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           MepharRadioButton(
          //               title: "Toàn hệ thống",
          //               isSelected: selected1 == "Toàn hệ thống",
          //               onSelected: (value) {
          //                 setState(() {
          //                   selected1 = value;
          //                 });
          //               }),
          //           const SizedBox(
          //             height: 18,
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               MepharRadioButton(
          //                 title: "Chi nhánh",
          //                 isSelected: selected1 == "Chi nhánh",
          //                 onSelected: (value) {
          //                   setState(() {
          //                     selected1 = value;
          //                   });
          //                 },
          //               ),
          //               const SizedBox(
          //                 width: 8,
          //               ),
          //               Expanded(
          //                   child: (selected1 == "Chi nhánh")
          //                       ? MultiSelect(
          //                           haveBorder: true,
          //                           options: context.watch<BranchProvider>().listStringBranch,
          //                           selectedOptions: [],
          //                           isArea: true,
          //                           labelText: '',
          //                           hintText: 'Chọn chi nhánh áp dụng',
          //                         )
          //                       : const SizedBox.shrink()),
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 5,
          //             width: MediaQuery.of(context).size.width,
          //             color: AppThemes.light2,
          //           ),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           MepharRadioButton(
          //               title: "Toàn bộ khách hàng",
          //               isSelected: selected2 == "Toàn bộ khách hàng",
          //               onSelected: (value) {
          //                 setState(() {
          //                   selected2 = value;
          //                 });
          //               }),
          //           const SizedBox(
          //             height: 18,
          //           ),
          //           Row(
          //             children: [
          //               MepharRadioButton(
          //                 title: "Nhóm khách hàng",
          //                 isSelected: selected2 == "Nhóm khách hàng",
          //                 onSelected: (value) {
          //                   setState(() {
          //                     selected2 = value;
          //                   });
          //                 },
          //               ),
          //               const SizedBox(
          //                 width: 8,
          //               ),
          //               Expanded(
          //                   child: MultiSearch(
          //                 listSelected: list,
          //               ))
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           Container(
          //             height: 5,
          //             width: MediaQuery.of(context).size.width,
          //             color: AppThemes.light2,
          //           ),
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           MepharRadioButton(
          //               title: "Toàn bộ người bán",
          //               isSelected: selected3 == "Toàn bộ người bán",
          //               onSelected: (value) {
          //                 setState(() {
          //                   selected3 = value;
          //                 });
          //               }),
          //           const SizedBox(
          //             height: 18,
          //           ),
          //           Row(
          //             children: [
          //               MepharRadioButton(
          //                 title: "Người bán",
          //                 isSelected: selected3 == "Người bán",
          //                 onSelected: (value) {
          //                   setState(() {
          //                     selected3 = value;
          //                   });
          //                 },
          //               ),
          //               const SizedBox(
          //                 width: 8,
          //               ),
          //               Expanded(
          //                 child: SearchSupplierMulti(
          //                   listSelectedSupplier: list2,
          //                 ),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
