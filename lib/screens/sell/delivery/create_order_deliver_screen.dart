import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_order.dart';
import 'package:mephar_app/widgets/item_quantity_order.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class CreateOrderDeliverScreen extends StatelessWidget {
  const CreateOrderDeliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MepharBigAppbar(
      haveSuffixSearch: false,
      title: "Tạo đơn và giao hàng",
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Container(
      //               alignment: Alignment.center,
      //               color: Colors.white,
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 20),
      //                 child: Column(
      //                   children: [
      //                     const SizedBox(
      //                       height: 24,
      //                     ),
      //                     Image.asset(
      //                       AppImages.imageAddToCart,
      //                       height: 143,
      //                       width: 123,
      //                       fit: BoxFit.cover,
      //                     ),
      //                     const SizedBox(
      //                       height: 26,
      //                     ),
      //                     Text(
      //                       "Đơn hàng của bạn chưa có sản phẩm nào!",
      //                       style: AppFonts.normalBold(16, AppThemes.dark3),
      //                     ),
      //                     const SizedBox(
      //                       height: 12,
      //                     ),
      //                     Text(
      //                       "Chọn sản phẩm",
      //                       style: AppFonts.bold(16, AppThemes.dark0),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             Container(
      //               color: Colors.white,
      //               child: Column(
      //                 children: [
      //                   const ItemOrder(),
      //                   Container(
      //                     height: 1,
      //                     width: width,
      //                     color: AppThemes.light0,
      //                   ),
      //                   const ItemQuantityOrder(),
      //                   const ItemQuantityOrder(title: "Tổng tiền hàng"),
      //                   const ItemQuantityOrder(
      //                     title: "Chiết khấu",
      //                     isBlueText: true,
      //                   ),
      //                   const ItemQuantityOrder(
      //                     title: "Phí giao hàng",
      //                     isBlueText: true,
      //                   ),
      //                   const SizedBox(
      //                     height: 20,
      //                   )
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             Container(
      //               color: Colors.white,
      //               child: Padding(
      //                 padding: const EdgeInsets.only(top: 12),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 20),
      //                       child: Text(
      //                         "Khách hàng",
      //                         style: AppFonts.normalBold(14, AppThemes.dark1),
      //                       ),
      //                     ),
      //                     const ItemOrder(
      //                       icon: AppImages.iconAddUserBlue,
      //                       title: "Thêm khách hàng",
      //                       isArrow: true,
      //                     ),
      //                     Container(
      //                       height: 1,
      //                       width: width - 40,
      //                       color: AppThemes.light0,
      //                     ),
      //                     const ItemOrder(
      //                       icon: AppImages.iconTagBlue,
      //                       title: "Giá bán lẻ",
      //                       isArrow: true,
      //                     ),
      //                     const SizedBox(
      //                       height: 7,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             Container(
      //               color: Colors.white,
      //               child: const Padding(
      //                 padding: EdgeInsets.only(bottom: 8),
      //                 child: ItemOrder(
      //                   icon: AppImages.iconCard,
      //                   title: "Chọn phương thức thanh toán",
      //                   isBlueText: false,
      //                   isArrow: true,
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             Container(
      //               color: Colors.white,
      //               child: const Padding(
      //                 padding: EdgeInsets.only(bottom: 8),
      //                 child: ItemOrder(
      //                   icon: AppImages.iconPenBlue,
      //                   title: "Thêm ghi chú",
      //                   isBlueText: false,
      //                   isArrow: true,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.white,
      //       child: Padding(
      //         padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
      //         child: Row(
      //           children: [
      //             Expanded(
      //                 flex: 7,
      //                 child: MepharButton(
      //                   onPressed: () {},
      //                 )),
      //             const SizedBox(
      //               width: 8,
      //             ),
      //             Expanded(
      //               child: Container(
      //                 height: 45,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8),
      //                   color: AppThemes.light1,
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(9),
      //                   child: Center(
      //                     child: Image.asset(
      //                       AppImages.iconMore,
      //                       height: 24,
      //                       width: 24,
      //                       fit: BoxFit.fill,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Đang cập nhật",
          style: AppFonts.normalBold(
            18,
            Colors.black,
          ),
        ),
      ),
    );
  }
}
