import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MarketDropdownStar extends StatelessWidget {
  final String hint;

  const MarketDropdownStar({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppThemes.light1))),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.symmetric(vertical: 8),
          isExpanded: true,
          hint: RichText(
            maxLines: 1,
            text: TextSpan(
              text: '',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              children: hint.contains('*')
                  ? [
                      TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8C8C8C),
                            fontFamily: AppFonts.laTo,
                            fontWeight: FontWeight.w600),
                        text: hint.substring(0, hint.indexOf('*')),
                      ),
                      const TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffEE0033),
                            fontFamily: AppFonts.laTo,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: hint.substring(hint.indexOf('*') + 1),
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8C8C8C),
                            fontFamily: AppFonts.laTo,
                            fontWeight: FontWeight.w600),
                      ),
                    ]
                  : [
                      TextSpan(
                        text: hint,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8C8C8C),
                            fontFamily: AppFonts.laTo,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          value: "",
          items: [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
