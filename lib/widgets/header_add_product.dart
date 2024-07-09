import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class HeaderAddProduct extends StatelessWidget {
  const HeaderAddProduct({
    super.key,
    this.icon,
    this.title,
    this.haveButtonAdd = false,
    this.haveAddFunction,
    this.haveRemoveFunction,
  });
  final String? icon;
  final String? title;
  final Function()? haveAddFunction;
  final Function()? haveRemoveFunction;
  final bool haveButtonAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              icon ?? AppImages.iconInfo,
              height: 20,
              width: 20,
              color: AppThemes.dark3,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: InkWell(
            onTap: haveAddFunction,
            child: Text(
              title ?? "Thông tin thuốc",
              textAlign: TextAlign.left,
              style: AppFonts.normalBold(
                14,
                AppThemes.dark0,
              ),
            ),
          ),
        ),
        haveButtonAdd
            ? Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: haveRemoveFunction,
                    child: Image.asset(
                      AppImages.iconRemove,
                      height: 17,
                      width: 17,
                      fit: BoxFit.fill,
                      // color: AppThemes.red0,
                    ),
                  ),
                ),
              )
            : const Expanded(child: SizedBox.shrink())
      ],
    );
  }
}
