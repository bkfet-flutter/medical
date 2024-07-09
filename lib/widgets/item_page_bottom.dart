import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/normal_text.dart';

class ItemPageBottom extends StatelessWidget {
  const ItemPageBottom({super.key, this.numberPage});
  final String? numberPage;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xffE0E2E7))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: NormalText(
            numberPage ?? "1",
            style: AppFonts.normalBold(16, const Color(0xff232325)),
          ),
        ));
  }
}
