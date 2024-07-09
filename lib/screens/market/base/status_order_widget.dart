import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class StatusOrderWidget extends StatelessWidget {
  final String code;
  final int status;
  final String price;
  final String timeOrder;
  final String? timeDone;
  final String? timeCancel;
  final String? timeFalse;
  final String? timePay;
  final String seller;
  final String shipping;
  final int countProduct;

  const StatusOrderWidget({
    super.key,
    required this.code,
    required this.status,
    required this.timeOrder,
    required this.price,
    required this.countProduct,
    required this.seller,
    required this.shipping,
    this.timeDone,
    this.timeCancel,
    this.timeFalse,
    this.timePay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TouchableWidget(
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.orderDetails);
        },
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      code,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff000000)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _getColor(status).backgroundColor,
                        border: Border.all(width: 1, color: _getColor(status).textColor)),
                    child: Text(
                      StatusColor.mapStatus[status] ?? "",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _getColor(status).textColor),
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
                      Expanded(
                        child: Text(
                          "$countProduct sản phẩm",
                          style: const TextStyle(
                              fontFamily: AppFonts.laTo,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000)),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: 'Tổng: ',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppThemes.dark1)),
                        TextSpan(
                            text: price,
                            style: const TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffEE0033)))
                      ])),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Người bán: $seller",
                    style: const TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: AppThemes.dark0),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ĐVVC: $shipping",
                    style: const TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: AppThemes.dark0),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getColor(status).textNote ?? "",
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
    ]);
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

class StatusColor {
  Color backgroundColor;
  Color textColor;
  String? textNote;

  static Map<int, String> mapStatus = {
    0: 'Chờ xác nhận',
    1: 'Đã xác nhận',
    2: 'Đã Giao cho ĐVCC',
    3: 'Đang giao hàng',
    4: 'Thành công',
    5: 'Đã huỷ',
    6: 'Giao hàng thất bại',
    7: 'Đã thanh toán',
  };

  StatusColor({required this.backgroundColor, required this.textColor, this.textNote});
}
