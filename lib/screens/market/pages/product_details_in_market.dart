import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class ProductDetailsInMarket extends StatelessWidget {
  const ProductDetailsInMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Chi tiết sản phẩm lên chợ',
        rightWidget: const Text(
          'Sửa',
          style:
              TextStyle(fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: AppThemes.dark2),
        ),
        onTapIconRight: () {
          Navigator.pushNamed(context, AppRoutes.editProductMarket);
        },
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xffF3FAFF),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Thuốc kháng sinh 123',
                                style: TextStyle(
                                    fontFamily: AppFonts.laTo,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xffE3FFF1),
                                  border: Border.all(color: const Color(0xff05A660))),
                              padding: const EdgeInsets.all(4),
                              child: const Text(
                                "Đang áp dụng",
                                style: TextStyle(
                                  fontFamily: AppFonts.laTo,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff05A660),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRowInfo('Nhóm sản phẩm:', "Nhóm kháng sinh"),
                          _buildRowInfo('Sản phẩm:', "Thuốc kháng sinh 123"),
                          _buildRowInfo('Số lượng tồn:', "1.000 "),
                          _buildRowInfo('Số lượng đã bán:', "200"),
                          _buildRowInfo('Giá bán:', "100.000đ"),
                          _buildRowInfo('Giá bán khuyến mại:', "90.000đ"),
                          _buildRowInfo('Mô tả:',
                              "Sản phẩm được BYT cấp phép vào năm 2013, đã bán hàng triệu sản phẩm trên thị trường và được KH tin dùng"),
                          const Text(
                            "Hình ảnh minh họa",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff232325)),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: (MediaQuery.of(context).size.width - 24 - 40) / 4,
                                  height: (MediaQuery.of(context).size.width - 24 - 40) / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: const Color(0xffE4E4EB))),
                                  child: Image.asset(
                                    AppImages.imageOTIV,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
                child: MepharButton(
                  titleButton: 'Xoá sản phẩm',
                  onPressed: () {
                    AppFunction.showDialogAlert(context,
                        title: "Xóa sản phẩm",
                        styleTitle: AppFonts.bold(20, AppThemes.dark0),
                        showBtnClose: true,
                        widgetDescription: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Image.asset(
                              AppImages.boyQuestion,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Bạn có chắc chắn muốn xóa sản phẩm?",
                                    style: AppFonts.light(
                                      16,
                                      AppThemes.dark2,
                                    ),
                                  ),
                                ])),
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        ),
                        text1stButton: "Hủy",
                        isTwoButton: true,
                        onPress1stButton: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        text2ndButton: "Xóa",
                        onPress2ndButton: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pop(context, true);
                        });
                  },
                ))
          ],
        ));
  }

  Widget _buildRowInfo(String? header, String? content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              header ?? "",
              style: const TextStyle(
                  fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: AppThemes.dark3),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              content ?? "",
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: AppThemes.dark1),
            ),
          ),
        ],
      ),
    );
  }
}
