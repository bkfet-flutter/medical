import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MepharRadioButton extends StatelessWidget {
  const MepharRadioButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });
  final String title;
  final bool isSelected;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              onSelected(title);
            },
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffffffff),
                border: Border.fromBorderSide(
                  BorderSide(
                      width: isSelected ? 2 : 1,
                      color: isSelected ? AppThemes.red0 : AppThemes.dark4,
                      style: BorderStyle.solid),
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppThemes.red0 : const Color(0xffffffff),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              title,
              textAlign: TextAlign.left,
              style: AppFonts.light(16, const Color(0xff333333)),
              maxLines: 2,
              minFontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
