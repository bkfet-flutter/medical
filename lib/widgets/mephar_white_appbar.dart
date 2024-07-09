import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/dimens_scale.dart';
import 'package:mephar_app/widgets/header_button.dart';

class MepharWhiteAppbar extends StatelessWidget {
  const MepharWhiteAppbar({
    super.key,
    this.title,
    this.body,
    this.backgroundColor,
    this.isCheck = false,
    this.onTapCheck,
    this.elevation,
    this.ontapBack,
  });
  final String? title;
  final Widget? body;
  final Color? backgroundColor;
  final bool isCheck;

  final Function()? onTapCheck;
  final double? elevation;
  final Function()? ontapBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: elevation ?? 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: HeaderButton(
                  iconColor: AppThemes.dark1,
                  icon: AppImages.iconArrowLeft,
                  onPressed: ontapBack ??
                      () {
                        Navigator.pop(context);
                      },
                  iconHeight:
                      DimensScale.getInstance(context)?.verticalScale(18),
                  iconWidth: DimensScale.getInstance(context)?.scale(9),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title ?? "Sản phẩm",
                  textAlign: TextAlign.center,
                  style: AppFonts.normalBold(
                    18,
                    AppThemes.dark1,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: isCheck
                    ? InkWell(
                        onTap: onTapCheck,
                        child: Image.asset(
                          AppImages.iconTick,
                          width: 15,
                          height: 12,
                          fit: BoxFit.fitHeight,
                          color: AppThemes.dark1,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}
