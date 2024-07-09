import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ShippingWidget extends StatelessWidget {
  final String? name;
  final String? price;
  final String? time;

  const ShippingWidget({super.key, this.name, this.price, this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name ?? "",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.laTo,
                  color: AppThemes.dark1,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 4,
          ),
          Text(price ?? "",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.laTo,
                  color: Color(0xffEE0033),
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 4,
          ),
          Text(time ?? "",
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.laTo,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
