import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class MultiSelect extends StatefulWidget {
  final List<String?> options;
  final List<String> selectedOptions;
  final Function()? onSubmit;
  final String labelText;
  final String hintText;
  final bool? isArea;
  final bool? haveBorder;

  const MultiSelect(
      {super.key,
      required this.options,
      required this.selectedOptions,
      required this.labelText,
      required this.hintText,
      this.onSubmit,
      this.isArea,
      this.haveBorder});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            widget.labelText,
            style: AppFonts.normalBold(12, const Color(0xff8C8C8C)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: (widget.haveBorder == true) ? BorderRadius.circular(12) : null,
              border: (widget.haveBorder == true)
                  ? Border.all(
                      width: 1,
                      color: const Color(0xffC7C9D9),
                    )
                  : const Border(bottom: BorderSide(width: 1, color: Color(0xffEBEBF0)))),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              title: widget.selectedOptions.isNotEmpty
                  ? Wrap(
                      spacing: 4,
                      children: List.generate(
                          widget.selectedOptions.length,
                          (index) => Chip(
                                label: Text(widget.selectedOptions[index]),
                                onDeleted: () {
                                  widget.selectedOptions.removeAt(index);
                                  setState(() {});
                                },
                              )),
                    )
                  : Text(
                      widget.hintText,
                      style: (widget.isArea == true)
                          ? AppFonts.regular(14, const Color(0xffC7C9D9))
                          : AppFonts.light(16, const Color(0xff333333)),
                    ),
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.options.length,
                    itemBuilder: (context, subIndex) {
                      final subOption = widget.options[subIndex];
                      return CheckboxListTile(
                        shape: const OutlineInputBorder(borderSide: BorderSide.none),
                        checkColor: Colors.blue,
                        activeColor: Colors.white,
                        side: BorderSide.none,
                        title: Text(subOption ?? ""),
                        value: widget.selectedOptions.contains(subOption),
                        onChanged: (bool? value) {
                          if (value == true) {
                            widget.selectedOptions.add(subOption ?? "");
                          } else {
                            widget.selectedOptions.remove(subOption);
                          }
                          widget.onSubmit?.call();
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
