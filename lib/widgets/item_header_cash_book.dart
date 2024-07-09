import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ItemHeaderCashBook extends StatelessWidget {
  const ItemHeaderCashBook({
    super.key,
    this.title,
    this.quantity,
    this.color,
  });
  final String? title;
  final String? quantity;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? "Quỹ đầu kỳ",
          style: AppFonts.normalBold(
            12,
            AppThemes.dark3,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          quantity ?? "2764669",
          textAlign: TextAlign.center,
          style: AppFonts.bold(
            16,
            color ?? AppThemes.kPrimary,
          ),
        )
      ],
    );
  }
}
