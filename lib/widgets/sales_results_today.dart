import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class SalesResultsToday extends StatelessWidget {
  const SalesResultsToday({
    super.key,
    this.icon,
    this.number,
    this.title,
    this.colorText,
    this.percent,
  });

  final String? icon;
  final int? number;
  final String? title;
  final Color? colorText;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon ?? AppImages.iconBoxNew,
          height: 24,
          width: 24,
        ),
        const SizedBox(
          height: 4,
        ),
        percent != null
            ? Text(
                percent! >= 0
                    ? "+" "${(percent! * 100).toStringAsFixed(2)}%"
                    : "${(percent! * 100).toStringAsFixed(2)}%",
                style: AppFonts.bold(16, percent! >= 0 ? AppThemes.green0 : AppThemes.red0),
              )
            : Text(
                number.toString() ?? "62",
                style: AppFonts.bold(16, colorText ?? AppThemes.dark0),
              ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title ?? "Đơn hàng mới",
          style: AppFonts.light(13, AppThemes.dark3),
        )
      ],
    );
  }
}
