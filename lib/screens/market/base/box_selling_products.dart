import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class BoxSellingProducts extends StatelessWidget {
  const BoxSellingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xffEEEEEE)))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "V.rohto Vitamin",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Thuốc nhỏ mắt V.rohto Vitamin hỗ trợ cải thiện tình trạng giảm thị lực, mắt mờ (13ml)",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff757575)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "52.000đ/ chai",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xffEE0033)),
                ),
                const SizedBox(height: 8),
                TouchableWidget(
                  onPressed: () {
                    // Navigator.pushNamed(context, AppRoutes.storeProfilePage);
                  },
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xffEE0033))),
                  child: const Text(
                    "Thêm",
                    style: TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xffEE0033)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
              width: 4 / 15 * MediaQuery.of(context).size.width,
              height: 4 / 15 * MediaQuery.of(context).size.width,
              child: Image.asset(
                AppImages.imgPlace,
              ))
        ],
      ),
    );
  }
}
