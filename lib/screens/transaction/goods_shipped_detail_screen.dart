import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';

class GoodsShippedDetailScreen extends StatelessWidget {
  const GoodsShippedDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goods = ModalRoute.of(context)!.settings.arguments as List<Map>;
    return MepharWhiteAppbar(
      title: goods[0]["titleRight"],
      body: Container(
        color: const Color(0xffF3FAFF),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardDetailProduct(listData: const [
                      {
                        "titleLeft": "Mã chuyển hàng",
                        "titleRight": "THD_202210274_093636",
                        "isTextBlue": true,
                      },
                      {
                        "titleLeft": "Từ",
                        "titleRight": "Nhánh nhà thuốc số 1",
                      },
                      {
                        "titleLeft": "Đến",
                        "titleRight": "Nhánh nhà thuốc số 2",
                      },
                      {
                        "titleLeft": "Người tạo",
                        "titleRight": "Admin",
                      },
                      {
                        "titleLeft": "Ngày chuyển",
                        "titleRight": "7/04/232023 17:45",
                      },
                      {
                        "titleLeft": "Người nhận",
                        "titleRight": "Admin",
                      },
                      {
                        "titleLeft": "Ngày nhận",
                        "titleRight": "---",
                      },
                      {
                        "titleLeft": "Trạng thái",
                        "titleRight": "Đang vẫn chuyển",
                        "isStatus": true,
                      },
                      {
                        "titleLeft": "Ghi chú",
                        "titleRight": "---",
                        "isFinal": true,
                      },
                    ], onPressed: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                    CardTotal(
                        widgetTop: CardDetailProduct(
                            haveBorder: true,
                            onPressed: () {},
                            listData: const [
                              {
                                "titleLeft": "Mã hàng",
                                "titleRight": "HH220919222634",
                              },
                              {
                                "titleLeft": "Tên hàng",
                                "titleRight": "12-cao",
                              },
                              {
                                "titleLeft": "Số lượng chuyển",
                                "titleRight": "1",
                              },
                              {
                                "titleLeft": "Số lượng nhận",
                                "titleRight": "12,020",
                                "isFinal": true,
                              },
                            ]),
                        heightBottom: 84,
                        dataTotal: const [
                          {
                            "titleLeft": "Tổng số mặt hàng:",
                            "titleRight": "2",
                            "maxLengths": 1,
                          },
                          {
                            "titleLeft": "Tổng số mặt hàng:",
                            "titleRight": "2",
                            "maxLengths": 1,
                          },
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(AppDimens.spaceMediumLarge),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: AppThemes.blue4,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        AppImages.iconPrinter,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      flex: 5,
                      child: MepharButton(
                        onPressed: () {},
                        titleButton: "Nhận hàng",
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
