import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ItemIngredientProduct extends StatelessWidget {
  const ItemIngredientProduct({
    super.key,
    this.numberItem,
    this.productId,
    this.productName,
    this.quantity,
  });
  final int? numberItem;
  final String? productId;
  final String? productName;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 16),
                blurRadius: 24,
                spreadRadius: 0,
                color: const Color(0xff606170).withOpacity(0.17)),
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
                color: const Color(0xff28293D).withOpacity(0.04))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$numberItem",
              style: AppFonts.normalBold(14, AppThemes.dark1),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "Mã hàng:",
                      textAlign: TextAlign.left,
                      style: AppFonts.regular(14, AppThemes.dark3),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      productId ?? "---",
                      textAlign: TextAlign.right,
                      style: AppFonts.light(14, AppThemes.dark1),
                    )),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "Tên thành phần:",
                      style: AppFonts.regular(14, AppThemes.dark3),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      productName ?? "---",
                      textAlign: TextAlign.right,
                      style: AppFonts.light(14, AppThemes.dark1),
                    )),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "Số lượng:",
                      style: AppFonts.regular(14, AppThemes.dark3),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "$quantity",
                      textAlign: TextAlign.right,
                      style: AppFonts.light(14, AppThemes.dark1),
                    )),
              ],
            ),
            const SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}
