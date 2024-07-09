// import 'package:flutter/material.dart';
// import 'package:mephar_app/app/app_routes.dart';
// import 'package:mephar_app/app/app_theme.dart';
// import 'package:mephar_app/provider/user_provider.dart';
// import 'package:mephar_app/resource/fonts/app_fonts.dart';
// import 'package:mephar_app/resource/images/app_images.dart';
// import 'package:mephar_app/screens/base_screen/base_screen.dart';
// import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
// import 'package:mephar_app/utils/app_function.dart';
// import 'package:mephar_app/utils/dimens_scale.dart';
// import 'package:mephar_app/widgets/header_button.dart';
// import 'package:mephar_app/widgets/item_product.dart';
// import 'package:provider/provider.dart';
//
// class ForwardDetailProductScreen extends BaseScreen {
//   const ForwardDetailProductScreen({super.key});
//
//   @override
//   ForwardDetailProductScreenState createState() =>
//       ForwardDetailProductScreenState();
// }
//
// class ForwardDetailProductScreenState
//     extends BaseState<ForwardDetailProductScreen> with BaseScreenMixin {
//   @override
//   String setTitle() {
//     return "Chi tiết sản phẩm";
//   }
//
//   @override
//   Color? setHeaderBackgroundColor() {
//     return Colors.white;
//   }
//
//   @override
//   Widget? buildLeftWidget() {
//     return HeaderButton(
//       iconColor: AppThemes.dark1,
//       icon: AppImages.iconArrowLeft,
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//       iconHeight: DimensScale.getInstance(context)?.verticalScale(18),
//       iconWidth: DimensScale.getInstance(context)?.scale(9),
//     );
//   }
//
//   @override
//   TextStyle? setTextStyleTitle() {
//     return AppFonts.normalBold(18, AppThemes.dark1);
//   }
//
//
//   @override
//   void afterFirstLayout(BuildContext context) {
//     final user = Provider.of<UserProvider>(context, listen: false);
//     final id = ModalRoute.of(context)!.settings.arguments as String;
//    // callApi(id, user.branch);
//   }
//
//   @override
//   Widget buildBody(BuildContext context) {
//     final user = Provider.of<UserProvider>(context, listen: false);
//     final id = ModalRoute.of(context)!.settings.arguments as String;
//     return Consumer<NewProductProvider>(
//       builder: (context, product, child) {
//         return Scaffold(
//             backgroundColor: Colors.white,
//             body: Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   color: AppThemes.blue4,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 12, bottom: 12, left: 20, right: 20),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             product.detailProductModel.name ?? "",
//                             textAlign: TextAlign.left,
//                             style: AppFonts.normalBold(14, AppThemes.dark0)
//                                 .copyWith(height: 18 / 14),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "${product.numberProduct} sản phẩm",
//                             textAlign: TextAlign.right,
//                             style: AppFonts.regular(14, AppThemes.dark3)
//                                 .copyWith(height: 18 / 14),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                     child: MediaQuery.removePadding(
//                   context: context,
//                   removeTop: true,
//                   child: ListView.builder(
//                       itemCount:
//                           product.detailProductModel.listProduct?.length,
//                       itemBuilder: (context, index) {
//                         return ItemProduct(
//                           onTap: () async {
//                             // final check = await Navigator.pushNamed(
//                             //     context, AppRoutes.detailListProductScreen,
//                             //     arguments: {
//                             //       "nameParent": product
//                             //           .detailProductModel.productParent?.name,
//                             //       "idChild": product.detailProductModel
//                             //           .listProduct?[index].id
//                             //     }) as Map;
//                             // print("my new check ${check["checkGo1"]}");
//                             // if (check["checkReset"] == true) {
//                             //   //callApi(id, user.branch);
//                             // } else if (check["checkDelete"] == true) {
//                             //   Navigator.pop(context, true);
//                             // }
//                           },
//                           name:
//                               " ${product.detailProductModel.productParent?.name} - ${product.detailProductModel.listProduct?[index].name}",
//                           price: product
//                               .detailProductModel.listProduct?[index].price
//                               .toString(),
//                           code: product.detailProductModel.listProduct?[index]
//                               .productCode,
//                           inventory: product.detailProductModel
//                               .listProduct?[index].inventory
//                               .toString(),
//                         );
//                       }),
//                 ))
//               ],
//             ));
//       },
//     );
//   }
// }
