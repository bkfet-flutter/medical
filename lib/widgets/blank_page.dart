import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

import 'package:mephar_app/widgets/mephar_button.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({
    super.key,
    this.image,
    this.title,
    this.content,
    this.onTap,
    this.titleButton,
  });
  final String? image;
  final String? title;
  final String? content;
  final Function()? onTap;
  final String? titleButton;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 52),
        child: Column(
          children: [
            const SizedBox(
              height: 93,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  image ?? AppImages.imageAddProduct,
                  width: 165,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                titleButton != null
                    ? Positioned(
                        bottom: 0,
                        right: -20,
                        child: Image.asset(
                          AppImages.buttonAddRed,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 52,
            ),
            Text(
              title ?? "Chưa có sản phẩm nào!",
              textAlign: TextAlign.center,
              style:
                  AppFonts.bold(16, AppThemes.dark0).copyWith(height: 20 / 16),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              content ??
                  "Thêm sản phẩm đầu tiên vào danh sách sản phẩm ngay nào",
              textAlign: TextAlign.center,
              style:
                  AppFonts.bold(16, AppThemes.dark3).copyWith(height: 20 / 16),
            ),
            const SizedBox(
              height: 60,
            ),
            titleButton != null
                ? MepharButton(
                    titleButton: titleButton ?? "Thêm sản phẩm",
                    onPressed: onTap ?? () {},
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
