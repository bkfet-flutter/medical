import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class MepharSearch extends StatelessWidget {
  const MepharSearch({
    super.key,
    this.hintText,
    this.haveSuffix = true,
    this.color,
    this.onFieldSubmitted,
    this.controllerSearch, this.onChanged,
  });
  final String? hintText;

  final bool haveSuffix;
  final Color? color;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controllerSearch;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: color ?? Colors.white),
      child: TextFormField(
        onChanged: onChanged,
        controller: controllerSearch,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Tìm tên sản phẩm, tên đơn, mã,...",
            hintStyle: AppFonts.normalBold(12, AppThemes.dark3),
            icon: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: Image.asset(
                AppImages.iconSearch,
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
            ),
            suffixIcon: haveSuffix
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.qrCodePayCounter,
                      );
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: 18, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const VerticalDivider(
                                color: AppThemes.dark4,
                                thickness: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                AppImages.iconSearchVoice,
                                height: 12,
                                width: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 40, maxWidth: 50),
            contentPadding: const EdgeInsets.symmetric(vertical: 8)),
      ),
    );
  }
}
