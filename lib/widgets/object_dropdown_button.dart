import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ObjectDropdownButton extends StatelessWidget {
  final List<ProvinceModel> listItems;
  final void Function(ProvinceModel?) onChange;
  final ProvinceModel? value;
  final bool? mini;
  final String? initValue;
  final bool? haveBorder;
  final bool? havePadding;
  final String? hinText;
  final String? labelText;
  final bool? paddingText;

  const ObjectDropdownButton({
    Key? key,
    required this.listItems,
    required this.onChange,
    this.value,
    this.mini,
    this.hinText,
    this.labelText,
    this.initValue,
    this.haveBorder,
    this.havePadding,
    this.paddingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProvinceModel>(
      isExpanded: true,
      value: value,
      hint: Padding(
        padding: EdgeInsets.only(left: havePadding == false ? 16 : 0),
        child: Text(
          overflow: TextOverflow.fade,
          softWrap: false,
          maxLines: 1,
          hinText ?? initValue ?? "",
          style: const TextStyle(
              fontFamily: AppFonts.laTo,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppThemes.gray700),
        ),
      ),
      elevation: 0,
      style: const TextStyle(
          fontFamily: AppFonts.laTo,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppThemes.gray700),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: havePadding == true ? 16 : 0),
        focusedBorder: haveBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppThemes.red0),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(color: AppThemes.red0),
              ),
        enabledBorder: haveBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xffB8B8D2)),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(color: AppThemes.light1),
              ),
        border: InputBorder.none,
        label: labelText != null
            ? RichText(
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
                text: TextSpan(
                  text: '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: labelText!.contains('*')
                      ? [
                          TextSpan(
                            style: AppFonts.normalBold(12, AppThemes.gray)
                                .copyWith(height: 16 / 12),
                            text: labelText!
                                .substring(0, labelText!.indexOf('*')),
                          ),
                          const TextSpan(
                            text: '*',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: labelText!
                                .substring(labelText!.indexOf('*') + 1),
                            style: AppFonts.normalBold(12, AppThemes.gray)
                                .copyWith(height: 16 / 12),
                          ),
                        ]
                      : [
                          TextSpan(
                            text: labelText,
                            style: AppFonts.normalBold(12, AppThemes.gray)
                                .copyWith(height: 16 / 12),
                          ),
                        ],
                ),
              )
            : null,
      ),
      dropdownColor: AppThemes.white,
      items: (listItems).map((ProvinceModel item) {
        return DropdownMenuItem<ProvinceModel>(
          value: item,
          child: Padding(
            padding: EdgeInsets.only(left: havePadding == true ? 0 : 16),
            child: Text(
              item.name ?? "",
              overflow: TextOverflow.fade,
              softWrap: false,
              maxLines: 1,
            ),
          ),
        );
      }).toList(),
      onChanged: (data) => onChange(data),
    );
  }
}
