import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MarketDropdown extends StatelessWidget {
  final String? label;
  final String? hint;

  const MarketDropdown({
    super.key,
    this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppThemes.light1))),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: const TextStyle(
                fontFamily: AppFonts.laTo,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff8C8C8C)),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                hint ?? "",
                style: const TextStyle(
                    fontFamily: AppFonts.laTo,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff333333)),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              value: "",
              items: [],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
