import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';

class InventoryControlScreen extends StatelessWidget {
  const InventoryControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> listData1 = [
      {
        "titleLeft": "Mã nhập hàng",
        "titleRight": "PN220930105557",
        "isTextBlue": true,
      },
      {
        "titleLeft": "Thời gian",
        "titleRight": "30/09/2022 10:55:04",
      },
      {
        "titleLeft": "Ngày cân bằng",
        "titleRight": "03/04/2023 19:16:10",
      },
      {
        "titleLeft": "Tổng thực tế",
        "titleRight": "5",
      },
      {
        "titleLeft": "Tổng chênh lệch",
        "titleRight": "1",
      },
      {
        "titleLeft": "Số lệch tăng",
        "titleRight": "1",
      },
      {
        "titleLeft": "Số lệch giảm",
        "titleRight": "1",
      },
      {
        "titleLeft": "Ghi chú",
        "titleRight": "hongco",
        "isFinal": true,
      },
    ];
    List<Map> listData2 = [
      {
        "titleLeft": "Mã nhập hàng",
        "titleRight": "PN220930105557",
        "isTextBlue": true,
      },
      {
        "titleLeft": "Thời gian",
        "titleRight": "30/09/2022 10:55:04",
      },
      {
        "titleLeft": "Ngày cân bằng",
        "titleRight": "03/04/2023 19:16:10",
      },
      {
        "titleLeft": "Tổng thực tế",
        "titleRight": "5",
      },
      {
        "titleLeft": "Tổng chênh lệch",
        "titleRight": "1",
      },
      {
        "titleLeft": "Số lệch tăng",
        "titleRight": "1",
      },
      {
        "titleLeft": "Số lệch giảm",
        "titleRight": "1",
      },
      {
        "titleLeft": "Ghi chú",
        "titleRight": "hongco",
        "isFinal": true,
      },
    ];
    return MepharBigAppbar(
        haveIconNearSearch: true,
        haveOneIcon: true,
        title: "Kiểm kho",
        floatingActionButton: MepharFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.inventoryControlAddScreen,
            );
          }, heroTag: 'add inventory',
        ),
        haveSuffixSearch: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MepharCheckbox(
                    isChecked: false,
                    text: "Kiểm kho",
                    isCheckBoxRight: true,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                CardProductCheck(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.inventoryControlDetailScreen,
                        arguments: listData1,
                      );
                    },
                    listData: listData1, numberCard: 1,),
                const SizedBox(
                  height: 12,
                ),
                CardProductCheck(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.inventoryControlDetailScreen,
                        arguments: listData2,
                      );
                    },
                    numberCard: 2,
                    listData: listData2),
              ],
            ),
          ),
        ));
  }
}
