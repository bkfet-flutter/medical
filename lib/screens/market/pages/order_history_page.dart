import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/stepper_order.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Lịch sử đơn hàng',
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "ĐH 13225",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff000000)),
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffEBEBF0),
                margin: EdgeInsets.symmetric(vertical: 8),
              ),
              StepperOrder(time: '12/06/2023, 12:30', status: 3, text: 'Đã giao hàng thành công'),
              StepperOrder(time: '12/06/2023, 12:30', status: 2, text: 'Đơn hàng đã đến kho ABC'),
              StepperOrder(time: '12/06/2023, 12:30', status: 2, text: 'Đơn hàng đã đến kho Thanh Xuân'),
              StepperOrder(time: '12/06/2023, 12:30', status: 2, text: 'Đã giao cho đơn vị vận chuyển'),
              StepperOrder(time: '12/06/2023, 10:30', status: 1, text: 'Đã xác nhận đơn'),
              StepperOrder(time: '12/06/2023, 10:30', status: 0, text: 'Đã đặt đơn'),
            ],
          ),
        ));
  }
}
