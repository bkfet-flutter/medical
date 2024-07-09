import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MarketTextFiled extends StatelessWidget {
  final String hintText;
  final bool? hintBlack;
  final TextInputType? keyboardType;

  const MarketTextFiled({super.key, required this.hintText, this.keyboardType, this.hintBlack});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style:
          const TextStyle(fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: AppThemes.dark2),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        label: hintBlack == true
            ? Text(
                hintText,
                style: const TextStyle(
                    fontSize: 16, color: Color(0xff333333), fontFamily: AppFonts.laTo, fontWeight: FontWeight.w400),
              )
            : RichText(
                maxLines: 1,
                text: TextSpan(
                  text: '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  children: hintText.contains('*')
                      ? [
                          TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff8C8C8C),
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600),
                            text: hintText.substring(0, hintText.indexOf('*')),
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
                            text: hintText.substring(hintText.indexOf('*') + 1),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff8C8C8C),
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600),
                          ),
                        ]
                      : [
                          TextSpan(
                            text: hintText,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff8C8C8C),
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                ),
              ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEBEBF0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEE0033)),
        ),
      ),
    );
  }
}
