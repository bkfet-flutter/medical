import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class SupplierDebts extends StatelessWidget {
  const SupplierDebts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF3FAFF),
      child: Column(
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
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Loại",
                            "titleRight": "Thanh toán",
                          },
                          {
                            "titleLeft": "Giá trị",
                            "titleRight": "-112,020",
                          },
                          {
                            "titleLeft": "Nợ cần trả NCC",
                            "titleRight": "-518,000",
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
                            "titleLeft": "Mã phếu",
                            "titleRight": "TTHD2210281093833",
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Loại",
                            "titleRight": "Thanh toán",
                          },
                          {
                            "titleLeft": "Giá trị",
                            "titleRight": "-112,020",
                          },
                          {
                            "titleLeft": "Nợ cần trả NCC",
                            "titleRight": "-518,000",
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
                            "titleLeft": "Mã phếu",
                            "titleRight": "TTHD2210281093833",
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": "08/10/2022 09:38",
                          },
                          {
                            "titleLeft": "Loại",
                            "titleRight": "Thanh toán",
                          },
                          {
                            "titleLeft": "Giá trị",
                            "titleRight": "-112,020",
                          },
                          {
                            "titleLeft": "Nợ cần trả NCC",
                            "titleRight": "-518,000",
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
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spaceXSmall10),
              child: MepharButton(
                titleButton: "Thanh toán",
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
