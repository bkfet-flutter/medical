import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemSettingAccount extends StatefulWidget {
  ItemSettingAccount({
    super.key,
    this.icon,
    this.title,
    this.isFinall = false,
    required this.onPressed,
    this.isArrow = false,
    this.onTapArrow,
    this.isAdd = false,
    this.widgetAdd,
    this.isShow = false,
    this.isTextRed = false,
  });
  final String? icon;
  final String? title;
  bool isFinall;
  final Function() onPressed;
  final Function()? onTapArrow;
  bool isAdd;
  final bool isShow;
  final bool isArrow;
  final Widget? widgetAdd;
  final bool isTextRed;
  @override
  State<ItemSettingAccount> createState() => _ItemSettingAccountState();
}

class _ItemSettingAccountState extends State<ItemSettingAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TouchableWidget(
          padding: const EdgeInsets.all(0),
          onPressed: widget.isShow
              ? () {
                  setState(() {
                    widget.isAdd = !widget.isAdd;
                  });
                }
              : widget.onPressed,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      widget.icon ?? AppImages.iconRefresh,
                      height: 17,
                      width: 17,
                      fit: BoxFit.fill,
                    ),
                  )),
                  Expanded(
                      flex: 8,
                      child: Text(
                        widget.title ?? "Reset dữ liệu cửa hàng",
                        textAlign: TextAlign.left,
                        style: AppFonts.regular(
                            16,
                            widget.isTextRed
                                ? AppThemes.red0
                                : AppThemes.dark1),
                      )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: widget.isArrow
                        ? !widget.isAdd
                            ? Image.asset(
                                AppImages.iconArrowRight,
                                height: 13,
                                width: 6,
                                fit: BoxFit.fill,
                                color: AppThemes.dark3,
                              )
                            : Image.asset(
                                AppImages.iconArrowUp,
                                height: 15,
                                width: 20,
                                fit: BoxFit.fill,
                                color: AppThemes.dark3,
                              )
                        : const SizedBox.shrink(),
                  )),
                ],
              ),
              widget.isFinall
                  ? const SizedBox(
                      height: 16,
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 1,
                      width: MediaQuery.of(context).size.width - 40,
                      color: const Color(0xffEBEBF0),
                    ),
            ],
          ),
        ),
        widget.isAdd
            ? widget.widgetAdd ?? const SizedBox.shrink()
            : const SizedBox.shrink(),
      ],
    );
  }
}
