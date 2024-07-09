import 'package:flutter/material.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';

class ReportStaffScreen extends StatelessWidget {
  const ReportStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MepharBigAppbar(
      title: "Báo cáo nhân viên",
      haveIconNearSearch: true,
      haveOneIcon: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardDetailProduct(listData: const [
              {
                "titleLeft": "SL Khách hàng",
                "titleRight": "20",
              },
              {
                "titleLeft": "Tổng tiền hàng",
                "titleRight": "36060",
              },
              {
                "titleLeft": "Giảm giá HĐ",
                "titleRight": "0",
              },
              {
                "titleLeft": "Doanh thu",
                "titleRight": "36060",
              },
              {
                "titleLeft": "Giá trị trả",
                "titleRight": "0",
              },
              {
                "titleLeft": "Doanh thu thuần",
                "titleRight": "36060",
              },
              {
                "titleLeft": "Tổng giá vốn",
                "titleRight": "10000",
              },
              {
                "titleLeft": "Lợi nhuận gộp",
                "titleRight": "26060",
                "isFinal": true,
              },
            ], onPressed: () {}),
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CardDetailProduct(
                    listData: const [
                      {
                        "titleLeft": "Khách hàng",
                        "titleRight": "Bùi Quang Thắng",
                      },
                      {
                        "titleLeft": "Tổng tiền hàng",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Giảm giá HĐ",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Doanh thu",
                        "titleRight": "36060",
                      },
                      {
                        "titleLeft": "Giá trị trả",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Doanh thu thuần",
                        "titleRight": "36060",
                      },
                      {
                        "titleLeft": "Tổng giá vốn",
                        "titleRight": "10000",
                      },
                      {
                        "titleLeft": "Lợi nhuận gộp",
                        "titleRight": "26060",
                        "isFinal": true,
                      },
                    ],
                    onPressed: () {},
                    haveBorder: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CardDetailProduct(
                    listData: const [
                      {
                        "titleLeft": "Khách hàng",
                        "titleRight": "Bùi Quang Thắng",
                      },
                      {
                        "titleLeft": "Tổng tiền hàng",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Giảm giá HĐ",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Doanh thu",
                        "titleRight": "36060",
                      },
                      {
                        "titleLeft": "Giá trị trả",
                        "titleRight": "0",
                      },
                      {
                        "titleLeft": "Doanh thu thuần",
                        "titleRight": "36060",
                      },
                      {
                        "titleLeft": "Tổng giá vốn",
                        "titleRight": "10000",
                      },
                      {
                        "titleLeft": "Lợi nhuận gộp",
                        "titleRight": "26060",
                        "isFinal": true,
                      },
                    ],
                    onPressed: () {},
                    haveBorder: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
