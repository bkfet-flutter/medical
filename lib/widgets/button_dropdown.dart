import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';

class ButtonDropdown extends StatefulWidget {
  const ButtonDropdown({
    Key? key,
    required this.listItem,
    this.hint,
    this.noUnderLine = false,
    this.textStyle,
    required this.onChanged,
  }) : super(key: key);

  final List<String?> listItem;
  final Widget? hint;
  final bool noUnderLine;
  final TextStyle? textStyle;
  final Function(String) onChanged;

  @override
  State<ButtonDropdown> createState() => _ButtonDropdownState();
}

class _ButtonDropdownState extends State<ButtonDropdown> {
  String? _selected;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: DropdownButton<String?>(
        isExpanded: true,
        underline: widget.noUnderLine
            ? Container()
            : Container(
                color: AppThemes.dark4,
                height: 1,
              ),
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.black,
        // icon: const Icon(
        //   Icons.keyboard_arrow_down,
        //   color: AppThemes.dark3,
        // ),

        hint: widget.hint,
        value: widget.listItem.isNotEmpty
            ? (_selected ?? widget.listItem.first)
            : null,
        items: widget.listItem.map((String? e) {
          return DropdownMenuItem<String?>(
            value: e,
            child: Text(
              e!,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (widget.listItem.isNotEmpty) {
            setState(() {
              _selected = newValue!;
              selectedIndex = widget.listItem.indexOf(newValue);
            });
            widget.onChanged(newValue!);
          }
        },
      ),
    );
  }
}
