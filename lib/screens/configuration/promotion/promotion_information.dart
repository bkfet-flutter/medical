import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/promotion_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:provider/provider.dart';

class PromotionInformation extends StatelessWidget {
  const PromotionInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3FAFF),
      body: Consumer<PromotionProvider>(builder: (context, promotion, child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardDetailProduct(
                      onPressed: () {},
                      listData: [
                        {
                          "titleLeft": "Mã chương trình",
                          "titleRight": promotion.promotionDetail.code,
                        },
                        {
                          "titleLeft": "Tên chương trình",
                          "titleRight": promotion.promotionDetail.name,
                        },
                        {
                          "titleLeft": "Thời gian",
                          "titleRight":
                              '${promotion.promotionDetail.startTime ?? ""} - ${promotion.promotionDetail.endTime ?? ""}',
                        },
                        {
                          "titleLeft": "Theo tháng",
                          "titleRight": promotion.promotionDetail.listMonths,
                        },
                        {
                          "titleLeft": "Theo ngày",
                          "titleRight": promotion.promotionDetail.listDays,
                        },
                        {
                          "titleLeft": "Theo thứ",
                          "titleRight": AppFunction.getDayOfWeekFromApi(promotion.promotionDetail.listDayOfWeek),
                        },
                        {
                          "titleLeft": "Theo giờ",
                          "titleRight": promotion.promotionDetail.listHours,
                        },
                        {
                          "titleLeft": "Trạng thái",
                          "titleRight": AppFunction.getStatus(promotion.promotionDetail.status),
                          "isStatus": true,
                        },
                        {
                          "titleLeft": "Ghi chú",
                          "titleRight": promotion.promotionDetail.note,
                          "isFinal": true,
                        },
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    (promotion.promotionDetail.isBirthdayPromotion == true)
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 36),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "Áp dụng vào Tuần sinh nhật khách hàng",
                                    style: AppFonts.regular(
                                      14,
                                      AppThemes.dark3,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        AppImages.iconCheckGreen,
                                        height: 12,
                                        width: 16,
                                        fit: BoxFit.cover,
                                      )),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
