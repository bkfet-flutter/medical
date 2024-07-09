import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class BoxStore extends StatelessWidget {
  final bool? noMargin;
  const BoxStore({super.key, this.noMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal:noMargin == true  ? 0 : 16),
      padding:  EdgeInsets.symmetric(vertical:noMargin == true  ? 16 : 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffDDDDDD)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppThemes.light0,
                child: CircleAvatar(
                  radius: 29,
                  backgroundColor: AppThemes.white,
                  backgroundImage: AssetImage(AppImages.avatarStore),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TIM Care Diamond",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Chi nhánh Hà Nội",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: AppFonts.laTo,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.4)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TouchableWidget(
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.storeProfilePage);
                },
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xffEE0033))),
                child: const Text(
                  "Xem cửa hàng",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xffEE0033)),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Text(
                "Tổng: 100 sản phẩm",
                style: TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff333333)),
              ),
              SizedBox(width: 16),
              Text(
                "Đã bán: 2.4k",
                style: TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff333333)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
