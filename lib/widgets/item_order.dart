import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder(
      {super.key,
      this.icon,
      this.title,
      this.isArrow = false,
      this.isBlueText = true,
      this.maxLines,
      this.iconClose,
      this.onTapClose, this.onTap});

  final String? icon;
  final String? title;
  final bool isArrow;
  final bool? iconClose;
  final bool isBlueText;
  final int? maxLines;
  final void Function()? onTapClose;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Flexible(
                  child: Image.asset(
                    icon ?? AppImages.iconGift,
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  flex: 5,
                  child: Text(
                    title ?? "Áp dụng khuyến mại",
                    maxLines: maxLines,
                    style: AppFonts.regular(
                      16,
                      isBlueText ? AppThemes.kPrimary : AppThemes.dark1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: isArrow
                ? iconClose == true
                    ? TouchableWidget(
                        onPressed: onTapClose,
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          AppImages.iconClose,
                          fit: BoxFit.cover,
                          width: 16,
                          height: 16,
                          color: AppThemes.blue0,
                        ),
                      )
                    : Image.asset(
                        AppImages.iconArrowRight,
                        width: 6,
                        height: 13,
                        fit: BoxFit.fill,
                      )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
