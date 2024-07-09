import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class HotProduct extends StatelessWidget {
  const HotProduct({super.key, this.color, this.product});
  final Color? color;
  final String? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: color ?? const Color(0xff5A3FFF),
              ),
            ),
          ),
          const SizedBox(
            width: 9,
          ),
          Flexible(
              flex: 5,
              child: Text(
                product ?? "Levothyroxine",
                style: AppFonts.regular(12, AppThemes.dark2),
              ))
        ],
      ),
    );
  }
}
