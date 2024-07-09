import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/order_widget.dart';
import 'package:mephar_app/screens/market/base/status_order_widget.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
class OrderDetailsPage extends StatelessWidget {
  final String? code;
  final int? status = 0;
  final String? price;
  final String? timeOrder = '10:33, 12/06/2023';
  final String? timeDone;
  final String? timeCancel;
  final String? timeFalse;
  final String? timePay;
  final String? seller;
  final String? shipping;
  final int? countProduct;
  const OrderDetailsPage({super.key,  this.code,  this.price, this.timeDone, this.timeCancel, this.timeFalse, this.timePay,  this.seller,  this.shipping,  this.countProduct});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Chi tiết đơn mua',
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'ĐH 13225',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff000000)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _getColor(status ?? 0).backgroundColor,
                                      border: Border.all(width: 1, color: _getColor(status ?? 0).textColor)),
                                  child: Text(
                                    StatusColor.mapStatus[status ?? 0] ?? "",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _getColor(status ?? 0).textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            color: const Color(0xffEBEBF0),
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Thông tin vận chuyển",
                                        style: TextStyle(
                                            fontFamily: AppFonts.laTo,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff000000)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, AppRoutes.orderHistory);
                                      },
                                      child: const Text(
                                        "Lịch sử đơn hàng",
                                        style: TextStyle(
                                            fontFamily: AppFonts.laTo,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            color: Color(0xff3E7BFA)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Giao hàng tiết kiệm",
                                  style: TextStyle(
                                      fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: AppThemes.dark0),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "TK19563258",
                                  style: TextStyle(
                                      fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: AppThemes.dark0),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _getColor(status ?? 0).textNote ?? "",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: AppFonts.laTo,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (status == 6 || status == 5) ? const Color(0xffFF3B3B) : const Color(0xff05A660)),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(color: const Color(0xffF2F2F2), border: Border.all(color: const Color(0xffECECEC))),
                    ),
                    Padding(
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
                    const OrderWidget(
                      hideBottom: true,
                    ),
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
                child: MepharButton(
                  isButtonWhite: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  titleButton: "Hủy đơn",
                ))
          ],
        ));
  }

  StatusColor _getColor(int status) {
    switch (status) {
      case 0:
        return StatusColor(
            backgroundColor: const Color.fromRGBO(255, 126, 53, 0.10),
            textColor: const Color(0xffFF8800),
            textNote: 'Đơn hàng được đặt vào ngày $timeOrder');
      case 1:
        return StatusColor(
            backgroundColor: const Color(0xffE5F0FF),
            textColor: const Color(0xff0063F7),
            textNote: 'Đơn hàng được đặt vào ngày $timeOrder');
      case 2:
        return StatusColor(
            backgroundColor: const Color(0xffE5F0FF),
            textColor: const Color(0xff0063F7),
            textNote: 'Đơn hàng đã được giao cho $shipping');
      case 3:
        return StatusColor(
            backgroundColor: const Color(0xffE5F0FF),
            textColor: const Color(0xff0063F7),
            textNote: 'Đơn hàng đang được giao');
      case 4:
        return StatusColor(
            backgroundColor: const Color(0xffE3FFF1),
            textColor: const Color(0xff05A660),
            textNote: 'Đơn hàng được giao thành công ngày ${timeDone ?? ""}');
      case 5:
        return StatusColor(
            backgroundColor: const Color(0xffFFE5E5),
            textColor: const Color(0xffFF3B3B),
            textNote: 'Đơn hàng đã bị huỷ bởi người mua ngày ${timeCancel ?? ""}');
      case 6:
        return StatusColor(
            backgroundColor: const Color(0xffFFE5E5),
            textColor: const Color(0xffFF3B3B),
            textNote: 'Giao hàng thất bại ngày ${timeFalse ?? ""}');
      case 7:
        return StatusColor(
            backgroundColor: const Color(0xffE5FFFF),
            textColor: const Color(0xff00B7C4),
            textNote: 'Đon hàng được thanh toán ngày ${timePay ?? ""}');
    }
    return StatusColor(
        backgroundColor: const Color.fromRGBO(255, 126, 53, 0.10),
        textColor: const Color(0xffFF8800),
        textNote: 'Đơn hàng được đặt vào ngày $timeOrder');
  }
}
