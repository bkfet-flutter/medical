import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/price_setting_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_widget/text_form_filed.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:provider/provider.dart';

import 'mephar_checkbox.dart';

class PriceAdjustmentWidget extends StatelessWidget {
  const PriceAdjustmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceSettingProvider>(builder: (context, setting, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(
              text: "Giá mới",
              style: TextStyle(
                  fontFamily: AppFonts.laTo, fontWeight: FontWeight.w600, fontSize: 14, color: AppThemes.dark1),
            ),
            TextSpan(
              text: " [${setting.newPrice}] ",
              style: const TextStyle(
                  fontFamily: AppFonts.laTo, fontWeight: FontWeight.w600, fontSize: 14, color: AppThemes.green0),
            ),
            const TextSpan(
              text: "=",
              style: TextStyle(
                  fontFamily: AppFonts.laTo, fontWeight: FontWeight.w600, fontSize: 14, color: AppThemes.dark1),
            ),
          ])),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomInputFiled(
                  readOnly: true,
                  controller: setting.basePriceController,
                ),
              ),
              CustomSwitch(
                  options: const ["+", "-"],
                  value: setting.math == Math.plus,
                  onTapOption1: () => setting.setMath(Math.plus),
                  onTapOption2: () => setting.setMath(Math.minus)),
              Expanded(
                child: CustomInputFiled(
                  onChanged: (value) => setting.changePrice(),
                  controller: setting.discountController,
                ),
              ),
              CustomSwitch(
                options: const ["VND", "%"],
                value: setting.unit == Unit.vnd,
                onTapOption1: () => setting.setUnit(Unit.vnd),
                onTapOption2: () => setting.setUnit(Unit.percent),
              ),
            ].addBetween(const SizedBox(width: 8)),
          ),
          MepharCheckbox(
            onTap: () => setting.setApply(),
            isCheckBoxRight: false,
            text: "Áp dụng công thức cho tất cả sản phẩm trong bảng giá",
            isChecked: setting.isApplyForAll,
          )
        ].addBetween(
            const SizedBox(
              height: 20,
            ),
            bound: true),
      );
    });
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final List<String> options;
  final void Function() onTapOption1;
  final void Function() onTapOption2;

  const CustomSwitch(
      {super.key, required this.value, required this.onTapOption1, required this.onTapOption2, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppThemes.light2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTapOption1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: value ? AppThemes.kPrimary : AppThemes.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
              child: Text(
                options[0],
                style: AppFonts.normalBold(12, value ? Colors.white : AppThemes.kPrimary),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapOption2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: value ? AppThemes.white : AppThemes.kPrimary,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
              child: Text(
                options[1],
                style: AppFonts.normalBold(12, value ? AppThemes.kPrimary : AppThemes.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum Math { plus, minus }

enum Unit { percent, vnd }
