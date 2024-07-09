import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/market/address_model.dart';
import 'package:mephar_app/model/market/shipping_method_model.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/address_widget.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/shipping_widget.dart';

class ShippingMethodPage extends StatefulWidget {
  const ShippingMethodPage({super.key});

  @override
  State<ShippingMethodPage> createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethodPage> {
  List<ShippingMethodModel> listMethod = [
    ShippingMethodModel('Giao hàng tiết kiệm', "20.000đ", "Dự kiến nhận hàng vào 3 Th07 - 5 th07"),
    ShippingMethodModel('Giao hàng nhanh', "35.000đ", "Dự kiến nhận hàng vào 3 Th07 - 5 th07"),
    ShippingMethodModel('VNPost', "40.000đ", "Dự kiến nhận hàng vào 3 Th07 - 5 th07"),
  ];
  ShippingMethodModel? currentMethod;

  void getData() {
    if (listMethod.isNotEmpty) {
      currentMethod = listMethod.first;
    }
    setState(() {
      currentMethod;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Phương thức vận chuyển',
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                "Lưu ý: Dưới đây là phí vận chuyển dự tính. Phí thực tế có thể chênh lệch theo Đơn vị vận chuyển quy định",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFF3B3B),
                    fontFamily: AppFonts.laTo,
                    fontStyle: FontStyle.italic),
              ),
              Container(
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration:
                    BoxDecoration(color: const Color(0xffF2F2F2), border: Border.all(color: const Color(0xffECECEC))),
              ),
              ...List.generate(
                  listMethod.length,
                  (index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            border:
                                Border(top: BorderSide(color: index == 0 ? AppThemes.transparent : AppThemes.light1))),
                        child: RadioListTile(
                          value: listMethod[index],
                          activeColor: const Color(0xffEE0033),
                          contentPadding: const EdgeInsets.only(right: 12),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          groupValue: currentMethod,
                          onChanged: (value) {
                            setState(() {
                              currentMethod = value;
                            });
                          },
                          title: ShippingWidget(
                            name: listMethod[index].name,
                            price: listMethod[index].price,
                            time: listMethod[index].time,
                          ),
                        ),
                      ))
            ],
          ),
        ));
  }
}
