import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MarketInputFiled extends StatelessWidget {
  const MarketInputFiled({
    super.key,
    required this.title,
    required this.controller,
    this.keyboardType,
  });

  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: const TextStyle(
          color: Color(0xff333333), fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          fillColor: Colors.red,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xffebebf0)), //<-- SEE HERE
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xffEE0033)), //<-- SEE HERE
            borderRadius: BorderRadius.circular(16.0),
          ),
          labelText: title,
          labelStyle: const TextStyle(
              color: Color(0xff8C8C8C), fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600),
          contentPadding: const EdgeInsets.all(16)),
    );
  }
}
