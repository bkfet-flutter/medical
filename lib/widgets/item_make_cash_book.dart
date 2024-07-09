import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemMakeCashBook extends StatelessWidget {
  const ItemMakeCashBook(
      {super.key, required this.onPressed, this.image, this.title});
  final Function() onPressed;
  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                image ?? AppImages.iconReceiptAdd,
                height: 24,
                width: 24,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 5,
              child: Text(
                title ?? "Lập phiếu thu",
                style: AppFonts.normalBold(
                  16,
                  AppThemes.red0,
                ),
              ),
            )
          ],
        ));
  }
}
