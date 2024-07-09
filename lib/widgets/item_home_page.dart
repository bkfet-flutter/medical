import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemHomePage extends StatelessWidget {
  const ItemHomePage({
    super.key,
    this.image,
    this.title,
    required this.onPressed,
  });

  final String? image;
  final String? title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Column(
        children: [
          Image.asset(
            image ?? AppImages.iconSell,
            height: 45,
            width: 45,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppFonts.normalBold(14, AppThemes.dark2).copyWith(height: 24 / 14),
          )
        ],
      ),
    );
  }
}
