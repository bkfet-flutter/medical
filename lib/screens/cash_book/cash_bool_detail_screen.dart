import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';

class CashBookDetailScreen extends StatelessWidget {
  const CashBookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cashBook = ModalRoute.of(context)!.settings.arguments as List<Map>;
    return MepharWhiteAppbar(
      elevation: 3,
      title: cashBook[0]["titleRight"],
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardDetailProduct(listData: const [
              {
                "titleLeft": "Mã phiếu",
                "titleRight": "TTHD230419081826",
              },
              {
                "titleLeft": "Thời gian",
                "titleRight": "19-04-2023 08:18",
              },
              {
                "titleLeft": "Giá trị",
                "titleRight": "36,060",
              },
              {
                "titleLeft": "Chi nhánh",
                "titleRight": "Nhánh nhà thuốc số 2",
              },
              {
                "titleLeft": "Loại thu chi",
                "titleRight": "Thu tiền từ khách hàng",
              },
              {
                "titleLeft": "Người nộp",
                "titleRight": "Nguyễn Văn A",
              },
              {
                "titleLeft": "Số điện thoại",
                "titleRight": "0948556321",
              },
              {
                "titleLeft": "Địa chỉ",
                "titleRight": "Hà Nội",
              },
              {
                "titleLeft": "Người nộp",
                "titleRight": "Nguyễn Văn A",
              },
              {
                "titleLeft": "Người dùng tạo",
                "titleRight": "Admin",
              },
              {
                "titleLeft": "Đối tượng nộp",
                "titleRight": "Khách hàng",
              },
              {
                "titleLeft": "Trạng thái",
                "titleRight": "Hoàn thành",
                "isStatus": true,
              },
              {
                "titleLeft": "Ghi chú",
                "titleRight": "---",
              },
            ], onPressed: () {}),
            const SizedBox(
              height: 160,
            ),
            Row(
              children: [
                Expanded(
                    child: ItemActivityCard(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.editInformationCustomer,
                    );
                  },
                  title: "Chỉnh sửa",
                  icon: AppImages.iconOpenNote,
                )),
                Expanded(
                    child: ItemActivityCard(
                  onPressed: () {},
                  title: "In số",
                  icon: AppImages.iconPrinter,
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
