import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ButtonSelected extends StatelessWidget {
  ButtonSelected({
    super.key,
    this.title,
    this.background,
    this.text,
  });
  final String? title;
  Color? background;
  Color? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              title ?? "Thông tin",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(
                15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
