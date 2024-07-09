import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/item_order.dart';

import 'package:mephar_app/widgets/mephar_dropdown_button.dart';

class InventoryControlDetailScreen extends BaseScreen {
  const InventoryControlDetailScreen({super.key});

  @override
  InventoryControlDetailScreenState createState() =>
      InventoryControlDetailScreenState();
}

class InventoryControlDetailScreenState
    extends BaseState<InventoryControlDetailScreen> with BaseScreenMixin {
  @override
  String setTitle() {
    final listProduct = ModalRoute.of(context)!.settings.arguments as List<Map>;

    return listProduct[0]["titleRight"];
  }

  @override
  TextStyle? setTextStyleTitle() {
    // TODO: implement setTextStyleTitle
    return AppFonts.normalBold(18, AppThemes.dark1);
  }

  @override
  Color? setHeaderBackgroundColor() {
    return Colors.white;
  }

  @override
  Color? setColorLeftWiget() {
    return AppThemes.dark1;
  }

  @override
  Widget buildBody(BuildContext context) {
    final listProduct = ModalRoute.of(context)!.settings.arguments as List<Map>;
    return Scaffold(
      backgroundColor: const Color(0xffF3FAFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  CardDetailProduct(
                    onPressed: () {},
                    listData: listProduct,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MepharDropDownButton(
                      hintText: "Người trả",
                      items: const ["Admin", "Người dùng"],
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const ItemOrder(
                    icon: AppImages.iconPenBlue,
                    title: "Thêm ghi chú",
                    isBlueText: false,
                  ),
                  Container(
                    color: const Color(0xffF3FAFF),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CardTotal(
                heightBottom: 240,
                widgetTop: CardProductCheck(onPressed: () {}, listData: const [
                  {
                    "titleLeft": "Mã hàng",
                    "titleRight": "PN220930105557",
                    "isTextBlue": true,
                  },
                  {
                    "titleLeft": "Tên hàng",
                    "titleRight": "Panactol Codein plus",
                  },
                  {
                    "titleLeft": "Số lượng",
                    "titleRight": "50",
                  },
                  {
                    "titleLeft": "Đơn giá",
                    "titleRight": "2,000",
                  },
                  {
                    "titleLeft": "Giảm giá",
                    "titleRight": "0",
                  },
                  {
                    "titleLeft": "Giá nhập",
                    "titleRight": "2,000",
                  },
                  {
                    "titleLeft": "Thành tiền",
                    "titleRight": "100,000",
                    "isFinal": true,
                  },
                ], numberCard: 1,),
                dataTotal: const [
                  {
                    "titleLeft": "Tổng số lượng",
                    "titleRight": "150",
                    "maxLines": 1,
                  },
                  {
                    "titleLeft": "Tổng số mặt hàng",
                    "titleRight": "2",
                    "maxLines": 1,
                  },
                  {
                    "titleLeft": "Tổng tiền hàng",
                    "titleRight": "1,302,000",
                    "maxLines": 1,
                  },
                  {
                    "titleLeft": "Giảm giá",
                    "titleRight": "2,000",
                    "maxLines": 1,
                  },
                  {
                    "titleLeft": "Tổng cộng",
                    "titleRight": "1,300,000",
                    "maxLines": 1,
                    "isTextRed": true,
                  },
                  {
                    "titleLeft": "Tiền đã trả NCC",
                    "titleRight": "0",
                    "maxLines": 1,
                  },
                ]),
            const SizedBox(
              height: 18,
            ),
            Container(
              color: const Color(0xffF3FAFF),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.spaceMediumLarge,
                  bottom: AppDimens.spaceXSmall10,
                  right: AppDimens.spaceXSmall10,
                  left: AppDimens.spaceXSmall10,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "In",
                      icon: AppImages.iconPrinter,
                    )),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Lưu",
                      icon: AppImages.iconSaveFile,
                    )),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Hủy",
                      colorIcon: AppThemes.red0,
                      icon: AppImages.iconCloseCircle,
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
