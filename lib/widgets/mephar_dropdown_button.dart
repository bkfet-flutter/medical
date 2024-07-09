import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MepharDropDownButton extends StatefulWidget {
  final List<String?> items;
  final Function(String) onChanged;
  final String hintText;
  final bool haveBorder;
  final bool haveHintText;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final bool isNormal;
  final Widget? hint;
  final bool isValue;
  final bool? isExpanded;
  final bool? isDense;
  final String? value;

  const MepharDropDownButton(
      {Key? key,
      required this.hintText,
      required this.items,
      required this.onChanged,
      this.haveHintText = true,
      this.haveBorder = true,
      this.height,
      this.padding,
      this.width,
      this.isNormal = false,
      this.hint,
      this.isValue = true,
      this.value, this.isExpanded, this.isDense})
      : super(key: key);

  @override
  _MepharDropDownButtonState createState() => _MepharDropDownButtonState();
}

class _MepharDropDownButtonState extends State<MepharDropDownButton> {
  String? selectedValue;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    List<String?> distinctItems = widget.items.toSet().toList();
    return Container(
      height: widget.height ?? 67,
      alignment: Alignment.center,
      width: widget.width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: widget.haveBorder ? BorderRadius.circular(12) : null,
        border: widget.isNormal
            ? null
            : widget.haveBorder
                ? const Border.fromBorderSide(
                    BorderSide(
                        width: 1,
                        color: Color(0xffC7C9D9),
                        style: BorderStyle.solid),
                  )
                : const Border(
                    bottom: BorderSide(
                        width: 1,
                        color: Color(0xffC7C9D9),
                        style: BorderStyle.solid),
                  ),
      ),
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: DropdownButtonFormField<String>(
        hint: widget.hint,
        isDense: widget.isDense ?? true,
        iconDisabledColor: Colors.transparent,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          label: widget.haveHintText
              ? RichText(
                  maxLines: 1,
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    children: widget.hintText.contains('*')
                        ? [
                            TextSpan(
                              style: AppFonts.normalBold(12, AppThemes.gray)
                                  .copyWith(height: 16 / 12),
                              text: widget.hintText
                                  .substring(0, widget.hintText.indexOf('*')),
                            ),
                            const TextSpan(
                              text: '*',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: widget.hintText
                                  .substring(widget.hintText.indexOf('*') + 1),
                              style: AppFonts.normalBold(12, AppThemes.gray)
                                  .copyWith(height: 16 / 12),
                            ),
                          ]
                        : [
                            TextSpan(
                              text: widget.hintText,
                              style: AppFonts.normalBold(12, AppThemes.gray)
                                  .copyWith(height: 16 / 12),
                            ),
                          ],
                  ),
                )
              : null,
          border: InputBorder.none,
        ),
        value: widget.value ??
            (widget.isValue
                ? (widget.items.isEmpty ? selectedValue : widget.items.first)
                : null),
        elevation: 16,
        isExpanded: widget.isExpanded ?? true,
        style: AppFonts.light(14, const Color(0xff333333)),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
            selectedIndex = widget.items.indexOf(newValue!);
          });
          widget.onChanged(newValue!);
        },
        items: distinctItems.map((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value!,
                style: AppFonts.light(14, const Color(0xff333333))),
          );
        }).toList(),
      ),
    );
  }
}
