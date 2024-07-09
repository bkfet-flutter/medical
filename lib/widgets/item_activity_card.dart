import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemActivityCard extends StatelessWidget {
  const ItemActivityCard({
    super.key,
    this.icon,
    this.title,
    this.colorIcon,
    required this.onPressed,
  });
  final String? icon;
  final String? title;
  final Color? colorIcon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
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
              icon ?? AppImages.iconPrinter,
              height: 24,
              width: 24,
              fit: BoxFit.fill,
              color: colorIcon,
            )),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title ?? "In mã vạch",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppFonts.regular(14, AppThemes.dark1).copyWith(
              height: 16 / 14,
            ),
          )
        ],
      ),
    );
  }
}
