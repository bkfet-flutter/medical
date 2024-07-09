import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ButtonDialog extends StatelessWidget {
  const ButtonDialog(
      {super.key,
      this.onTap,
      this.child,
      this.title,
      this.isButtonWhite = false,
      this.haveIcon = false,
      this.icon,
      this.padding});

  final Function()? onTap;
  final Widget? child;
  final String? title;
  final bool? isButtonWhite;
  final bool? haveIcon;
  final String? icon;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: onTap,
        child: child ??
            Container(
              alignment: Alignment.center,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: AppThemes.red0, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: !isButtonWhite! ? AppThemes.red0 : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: padding ?? 16),
                child: !haveIcon!
                    ? Text(title ?? "",
                        textAlign: TextAlign.center,
                        style: AppFonts.bold(16,
                                isButtonWhite! ? AppThemes.red0 : Colors.white)
                            .copyWith(height: 1))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            icon!,
                            height: 17,
                            width: 17,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            title ?? "",
                            textAlign: TextAlign.center,
                            style: AppFonts.bold(
                                    16,
                                    isButtonWhite!
                                        ? AppThemes.red0
                                        : Colors.white)
                                .copyWith(height: 1),
                          )
                        ],
                      ),
              ),
            ));
  }
}
