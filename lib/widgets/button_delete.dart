import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class ButtonDelete extends StatelessWidget {
  final void Function()? onTap;
  const ButtonDelete({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerRight,
        color: const Color(0xffF3FAFF),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppDimens.spaceMediumLarge,
            bottom: AppDimens.spaceXSmall10,
            right: AppDimens.spaceLarge48,
          ),
          child: Column(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppThemes.blue4,
                ),
                child: Center(
                    child: Image.asset(
                  AppImages.iconTrashGrey,
                  height: 24,
                  width: 24,
                  fit: BoxFit.fill,
                  color: AppThemes.red0,
                )),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Xóa",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppFonts.regular(14, AppThemes.dark1).copyWith(
                  height: 16 / 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
