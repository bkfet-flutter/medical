import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';

class SupplierHistory extends StatelessWidget {
  const SupplierHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3FAFF),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CardDetailProduct(
                        haveBorder: true,
                        listData: const [
                          {
                            "titleLeft": "Mã phếu",
                            "titleRight": "TTHD2210281093833",
                            "isTextBlue": true,
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Người tạo",
                            "titleRight": "admin",
                          },
                          {
                            "titleLeft": "Tổng cộng",
                            "titleRight": "45,000",
                          },
                          {
                            "titleLeft": "Trạng thái",
                            "titleRight": "Hoàn thành",
                            "isFinal": true,
                            "isStatus": true,
                          },
                        ],
                        onPressed: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                    CardDetailProduct(
                        haveBorder: true,
                        listData: const [
                          {
                            "titleLeft": "Mã phếu",
                            "titleRight": "TTHD2210281093833",
                            "isTextBlue": true,
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Người tạo",
                            "titleRight": "admin",
                          },
                          {
                            "titleLeft": "Tổng cộng",
                            "titleRight": "45,000",
                          },
                          {
                            "titleLeft": "Trạng thái",
                            "titleRight": "Hoàn thành",
                            "isFinal": true,
                            "isStatus": true,
                          },
                        ],
                        onPressed: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                    CardDetailProduct(
                        haveBorder: true,
                        listData: const [
                          {
                            "titleLeft": "Mã phếu",
                            "titleRight": "TTHD2210281093833",
                            "isTextBlue": true,
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Người tạo",
                            "titleRight": "admin",
                          },
                          {
                            "titleLeft": "Tổng cộng",
                            "titleRight": "45,000",
                          },
                          {
                            "titleLeft": "Trạng thái",
                            "titleRight": "Hoàn thành",
                            "isFinal": true,
                            "isStatus": true,
                          },
                        ],
                        onPressed: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.editInformationCustomer,
                      );
                    },
                    title: "Chỉnh sửa",
                    icon: AppImages.iconPenRed,
                  )),
                  Expanded(
                      child: ItemActivityCard(
                    onPressed: () {},
                    title: "Cho phép hoạt động",
                    icon: AppImages.iconShieldGreen,
                  )),
                  Expanded(
                      child: ItemActivityCard(
                    onPressed: () {},
                    title: "Xóa",
                    colorIcon: AppThemes.red0,
                    icon: AppImages.iconTrashGrey,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
