import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class MepharButton extends StatelessWidget {
  const MepharButton({
    super.key,
    this.titleButton,
    this.color,
    required this.onPressed,
    this.haveIcon = false,
    this.isButtonWhite = false,
    this.width,
    this.colorTitle,
    this.colorButton,
  });

  final String? titleButton;
  final Color? color;
  final Color? colorTitle;
  final Color? colorButton;
  final Function() onPressed;
  final bool haveIcon;
  final bool isButtonWhite;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: colorButton ??
                (isButtonWhite
                    ? Colors.white
                    : haveIcon
                        ? Colors.white
                        : color ?? AppThemes.red0),
            border: colorButton == null
                ? (isButtonWhite
                    ? Border.all(width: 1, color: AppThemes.red0)
                    : haveIcon
                        ? Border.all(width: 1, color: AppThemes.red0)
                        : Border.all(width: 2.5, color: AppThemes.red0))
                : Border.all(width: 2, color: colorButton!),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: !haveIcon
              ? Text(
                  titleButton ?? "Tạo đơn và giao hàng",
                  textAlign: TextAlign.center,
                  style: AppFonts.bold(
                    14,
                    colorTitle ?? (isButtonWhite ? AppThemes.red0 : color ?? Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image.asset(
                        AppImages.iconSave,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        titleButton ?? "Lưu tạm",
                        textAlign: TextAlign.center,
                        style: AppFonts.bold(
                          14,
                          AppThemes.red0,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
