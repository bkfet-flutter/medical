import 'package:flutter/material.dart';
import 'package:mephar_app/provider/purchase_history_provider.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:provider/provider.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseHistoryProvider>(
        builder: (context, purchase, child) {
      return Container(
        color: const Color(0xffF3FAFF),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: purchase.listPurchaseHistory.length,
            itemBuilder: (context, int index) {
              return CardProductCheck(
                listData: [
                  {
                    "titleLeft": "Mã phiếu",
                    "titleRight": purchase.listPurchaseHistory[index].code,
                  },
                  {
                    "titleLeft": "Thời gian",
                    "titleRight":
                        purchase.listPurchaseHistory[index].createdAt,
                  },
                  {
                    "titleLeft": "Tổng tiền",
                    "titleRight": purchase
                        .listPurchaseHistory[index].totalPrice
                        .toString(),
                  },
                  {
                    "titleLeft": "Khách trả",
                    "titleRight": purchase
                        .listPurchaseHistory[index].cashOfCustomer
                        .toString(),
                  },
                  {
                    "titleLeft": "Trả lại",
                    "titleRight":
                        purchase.listPurchaseHistory[index].refund.toString(),
                  },
                  {
                    "titleLeft": "Trạng thái",
                    "titleRight":
                        purchase.listPurchaseHistory[index].status ==
                                "SUCCEED"
                            ? "Đơn hàng thành công"
                            : "Đang cập nhật",
                    // "isStatus": true,
                    // "isStatus": purchase.listPurchaseHistory[index].status,
                    // "SUCCEED",
                    // ? true
                    // : false,
                    "isFinal": true,
                    "isTextBlue": true
                  },
                ],
                numberCard: index,
                onPressed: () {},
              );
            },
          ),
        ),
      );
    });
  }
}
