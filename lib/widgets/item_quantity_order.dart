import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ItemQuantityOrder extends StatelessWidget {
  const ItemQuantityOrder(
      {super.key, this.title, this.number, this.isBlueText = false, this.maxLine,  this.overflow});
  final String? title;
  final String? number;
  final bool isBlueText;
  final int? maxLine;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title ?? "Tổng số lượng",
            textAlign: TextAlign.left,
            style: AppFonts.regular(
              14,
              isBlueText ? AppThemes.kPrimary : AppThemes.dark1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            number ?? "0",
            maxLines: maxLine,
            overflow: overflow,
            textAlign: TextAlign.right,
            style: AppFonts.regular(14, AppThemes.dark1),
          ),
        )
      ],
    );
  }
}
