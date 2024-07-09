import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class MepharTextfield extends StatefulWidget {
  MepharTextfield({
    super.key,
    this.controller,
    required this.hintText,
    this.icon,
    this.havesuffix = false,
    this.maxLines,
    this.isPassword = false,
    this.keyboardType,
    this.nextFocusNode,
    this.onFieldSubmitted,
    this.obscureText = true,
    this.isBorder = false,
    this.colorBorder,
    this.onChanged,
    this.align,
    this.vert,
    this.axis,
    this.formatter,
    this.errText,
    this.readOnly,
    this.initValue,
    this.labelText,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? icon;
  final bool havesuffix;
  final int? maxLines;
  final bool isPassword;
  final Function(String)? onChanged;
  bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? nextFocusNode;
  final bool? isBorder;
  final Color? colorBorder;
  final void Function(String)? onFieldSubmitted;
  final TextAlign? align;
  final TextAlignVertical? vert;
  final TextDirection? axis;
  final List<TextInputFormatter>? formatter;
  final String? errText;
  final String? labelText;
  final bool? readOnly;
  final String? initValue;

  @override
  State<MepharTextfield> createState() => _MepharTextfieldState();
}

class _MepharTextfieldState extends State<MepharTextfield> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.nextFocusNode ?? FocusNode();
    
  }

  @override
  void dispose() {
    if (widget.nextFocusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initValue,
      inputFormatters: widget.formatter,
      textDirection: widget.axis,
      textAlignVertical: widget.vert,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? widget.obscureText : false,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      focusNode: _focusNode,
      readOnly: widget.readOnly == true ? true : false,
      onFieldSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }

        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(value);
        }
      },
      decoration: InputDecoration(
        errorText: widget.errText,
        border: InputBorder.none,
        hintText: widget.labelText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.colorBorder ?? AppThemes.red0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.colorBorder ?? AppThemes.light1),
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 16,
                  bottom: 16,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    child: Image.asset(
                      !widget.obscureText ? AppImages.iconEye : AppImages.iconEyeClose,
                      width: 18,
                      height: 16,
                      fit: BoxFit.fitWidth,
                      color: const Color(0xff1F1F39),
                    )),
              )
            : (widget.havesuffix)
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      widget.icon ?? AppImages.iconCalendar,
                      height: 15,
                      width: 15,
                    ),
                  )
                : const SizedBox.shrink(),
        suffixIconConstraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
        label: RichText(
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
                      style: AppFonts.normalBold(
                        12,
                        AppThemes.gray,
                      ),
                      text: widget.hintText.substring(0, widget.hintText.indexOf('*')),
                    ),
                    const TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppThemes.red0,
                      ),
                    ),
                    TextSpan(
                      text: widget.hintText.substring(widget.hintText.indexOf('*') + 1),
                      style: AppFonts.normalBold(
                        12,
                        AppThemes.gray,
                      ).copyWith(height: 14 / 18),
                    ),
                  ]
                : [
                    TextSpan(
                      text: widget.hintText,
                      style: AppFonts.normalBold(
                        12,
                        AppThemes.gray,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
