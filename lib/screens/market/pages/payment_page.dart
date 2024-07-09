import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/order_widget.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Thanh toán',
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TouchableWidget(
                      onPressed: (){
                        Navigator.pushNamed(context, AppRoutes.deliveryAddressPage);
                      },
                      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.iconLocationRed,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Địa chỉ nhận hàng",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemes.dark1,
                                    fontFamily: AppFonts.laTo),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Chu Dung | (+84)0868666888",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemes.dark1,
                                    fontFamily: AppFonts.laTo),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "9, 89 Mễ Trì Thượng, Quận Nam Từ Liêm, Hà Nội",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemes.dark1,
                                    fontFamily: AppFonts.laTo),
                              )
                            ],
                          )),
                          const SizedBox(width: 4),
                          HeaderButton(
                            onPressed: () {},
                            mini: true,
                            icon: AppImages.iconArrowNext,
                            iconWidth: 16,
                            iconHeight: 16,
                          ),
                        ],
                      ),
                    ),
                    const OrderWidget(),
                    Container(
                      height: 8,
                      decoration:
                          BoxDecoration(color: const Color(0xffF2F2F2), border: Border.all(color: const Color(0xffECECEC))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.iconNoteOrange,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                'Chi tiết thanh toán',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1, fontFamily: AppFonts.laTo),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tổng tiền hàng',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark2, fontFamily: AppFonts.laTo),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '980.000đ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1, fontFamily: AppFonts.laTo),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tổng tiền phí vận chuyển',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark2, fontFamily: AppFonts.laTo),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '21.000đ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1, fontFamily: AppFonts.laTo),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tổng thanh toán',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500, color: AppThemes.dark1, fontFamily: AppFonts.laTo),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '1.000.000đ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xffEE0033), fontFamily: AppFonts.laTo),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: Offset(0, -8), blurRadius: 24, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.08))
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Tổng thanh toán",
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff28293D)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "1.000.000đ",
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffEE0033)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TouchableWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.purchasePage);
                    },
                    height: MediaQuery.of(context).size.height * 56 / 812,
                    width: MediaQuery.of(context).size.width * 0.32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      color: Color(0xffEE0033),
                    ),
                    child: const Text(
                      "Đặt hàng",
                      style: TextStyle(
                          fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xffFFFFFF)),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
