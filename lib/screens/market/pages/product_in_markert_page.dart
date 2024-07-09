import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ProductInMarketPage extends StatelessWidget {
  const ProductInMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Danh sách sản phẩm trên chợ',
        hintSearch: 'Mã, Tên, Trạng thái, Sổ lượng,...',
        iconRight: AppImages.iconAddRed,
        onTapIconRight: () {
          Navigator.pushNamed(context, AppRoutes.addNewProductMarket);
        },
        haveSearchbar: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildProduct(context, 'Thuốc kháng sinh 123', 1000, 200, 335000, null, 1),
              _buildProduct(context, 'Thuốc kháng sinh 123', 1000, 200, 335000, 20000, 1),
              _buildProduct(context, 'Thuốc kháng sinh 123', 1000, 200, 15000, 20000, 0),
              _buildProduct(context, 'Thuốc kháng sinh 123', 1000, 200, 335000, 20000, 2),
            ],
          ),
        ));
  }

  Widget _buildProduct(
      BuildContext context, String name, int inventoryQuantity, int sold, int price, int? promo, int status) {
    return TouchableWidget(
      onPressed: () async {
        final result = await Navigator.pushNamed(context, AppRoutes.productDetailsInMarket) as bool?;
        if (result == true) {
          if (context.mounted) {
            AppFunction.showDialogAlert(context,
                customImage: Image.asset(
                  AppImages.notiSuccess,
                  width: 116,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                noDivider: true,
                showBtnClose: true,
                hideBtnBottom: true, onPressedClose: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
                styleTitle: AppFonts.normalBoldInter(
                  20,
                  AppThemes.green0,
                ),
                title: "Thành công",
                styleDescription: AppFonts.light(
                  16,
                  AppThemes.dark1,
                ),
                imageClose: AppImages.closeNormal,
                description: "Đã xóa thành công");
          }
        }
      },
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration:
          const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xffDDDDDD)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tồn: $inventoryQuantity",
                        style: const TextStyle(
                          fontFamily: AppFonts.laTo,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppThemes.dark0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Đã bán: $sold",
                        style: const TextStyle(
                          fontFamily: AppFonts.laTo,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppThemes.dark0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: status == 1 ? const Color(0xffE3FFF1) : const Color(0xffF2F2F5),
                      border: Border.all(color: status == 1 ? const Color(0xff05A660) : const Color(0xff8F90A6))),
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    status == 1
                        ? "Đang áp dụng"
                        : status == 0
                            ? "Không áp dụng"
                            : status == 2
                                ? "Hết hàng"
                                : "",
                    style: TextStyle(
                      fontFamily: AppFonts.laTo,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: status == 1 ? const Color(0xff05A660) : const Color(0xff8F90A6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '$priceđ',
                style: const TextStyle(
                  fontFamily: AppFonts.laTo,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffEE0033),
                ),
              ),
              const SizedBox(width: 16),
              (promo == null)
                  ? const SizedBox.shrink()
                  : Text(
                      "$promođ",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontFamily: AppFonts.laTo,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.4)),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
