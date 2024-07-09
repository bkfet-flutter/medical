import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/normal_text.dart';

class PageItem extends StatelessWidget {
  final int pageNumber;
  final int currentPage;
  final Function(int) onPageSelected;

  const PageItem({
    super.key,
    required this.pageNumber,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = pageNumber == currentPage;
    final textStyle = AppFonts.normalBold(16, isSelected ? const Color(0xffEE0033) : const Color(0xff232325));
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onPageSelected(pageNumber),
      child: Container(
        width: width * 0.1,
        height: width * 0.1,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Color(0xffE0E2E7)),
            bottom: BorderSide(width: 1, color: Color(0xffE0E2E7)),
            left: BorderSide(width: 1, color: Color(0xffE0E2E7)),
          ),
        ),
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: NormalText(
            pageNumber.toString(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
