import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/market/base/cart_widget.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
      title: 'Giỏ hàng',
      rightWidget: const Text(
        'Sửa',
        style: TextStyle(fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: AppThemes.dark2),
      ),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CartWidget(),
                  CartWidget(
                    nameStore: 'Thaivu Drug Store',
                  ),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MepharCheckbox(
                          isChecked: false,
                          onlyCheckBox: true,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "Tất cả (6)",
                          style: TextStyle(
                              fontFamily: AppFonts.laTo,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff28293D)),
                        ),
                        const Expanded(
                          child: Column(
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                TouchableWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.payment);
                  },
                  height: MediaQuery.of(context).size.height * 56 / 812,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    color: Color(0xffEE0033),
                  ),
                  child: const Text(
                    "Mua hàng",
                    style: TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xffFFFFFF)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
