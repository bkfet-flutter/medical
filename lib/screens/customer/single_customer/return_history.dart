import 'package:flutter/material.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';

class ReturnHistory extends StatelessWidget {
  const ReturnHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xffF3FAFF),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CardDetailProduct(
                  haveBorder: true,
                  listData: const [
                    {
                      "titleLeft": "Mã hóa đơn",
                      "titleRight": "TTHD2210281093833",
                    },
                    {
                      "titleLeft": "Thời gian",
                      "titleRight": "08/10/2022 09:38",
                    },
                    {
                      "titleLeft": "Số lượng",
                      "titleRight": "2",
                    },
                    {
                      "titleLeft": "Số lượng trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Số lượng mua",
                      "titleRight": "15,000",
                    },
                    {
                      "titleLeft": "Tổng tiền",
                      "titleRight": "12,020",
                    },
                    {
                      "titleLeft": "Khách trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Trả lại",
                      "titleRight": "0",
                      "isFinal": true,
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
                      "titleLeft": "Mã hóa đơn",
                      "titleRight": "TTHD2210281093833",
                    },
                    {
                      "titleLeft": "Thời gian",
                      "titleRight": "08/10/2022 09:38",
                    },
                    {
                      "titleLeft": "Số lượng",
                      "titleRight": "2",
                    },
                    {
                      "titleLeft": "Số lượng trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Số lượng mua",
                      "titleRight": "15,000",
                    },
                    {
                      "titleLeft": "Tổng tiền",
                      "titleRight": "12,020",
                    },
                    {
                      "titleLeft": "Khách trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Trả lại",
                      "titleRight": "0",
                      "isFinal": true,
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
                      "titleLeft": "Mã hóa đơn",
                      "titleRight": "TTHD2210281093833",
                    },
                    {
                      "titleLeft": "Thời gian",
                      "titleRight": "08/10/2022 09:38",
                    },
                    {
                      "titleLeft": "Số lượng",
                      "titleRight": "2",
                    },
                    {
                      "titleLeft": "Số lượng trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Số lượng mua",
                      "titleRight": "15,000",
                    },
                    {
                      "titleLeft": "Tổng tiền",
                      "titleRight": "12,020",
                    },
                    {
                      "titleLeft": "Khách trả",
                      "titleRight": "0",
                    },
                    {
                      "titleLeft": "Trả lại",
                      "titleRight": "0",
                      "isFinal": true,
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
    );
  }
}
