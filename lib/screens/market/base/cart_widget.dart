import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';

class CartWidget extends StatelessWidget {
  final String? nameStore;

  const CartWidget({super.key, this.nameStore});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 8,
        decoration: BoxDecoration(color: const Color(0xffF2F2F2), border: Border.all(color: const Color(0xffECECEC))),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            MepharCheckbox(isChecked: true, onlyCheckBox: true),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                nameStore ?? "TIM Care Diamond",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff333333)),
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(
              AppImages.iconArrowRight,
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
      ...List.generate(3, (index) => CartItem())
    ]);
  }
}

class CartItem extends StatelessWidget {
  final String? name;

  const CartItem({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xffEEEEEE)))),
      child: Row(
        children: [
          MepharCheckbox(isChecked: true, onlyCheckBox: true),
          const SizedBox(width: 12),
          Image.asset(
            AppImages.imgDemo2,
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "Otiv – Viên Uống Hỗ Trợ Não Bộ Chính Hãng Của Mỹ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff333333)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "52.000đ/ chai",
                  style: TextStyle(
                      fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xffEE0033)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      AppImages.iconMinus,
                      width: 32,
                      height: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '1',
                        style: TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff333333)),
                      ),
                    ),
                    Image.asset(
                      AppImages.iconPlus,
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            AppImages.iconTrashGrey,
            width: 20,
            height: 20,
          )
        ],
      ),
    );
  }
}
