import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';

class MepharPickerDatetime extends StatefulWidget {
  const MepharPickerDatetime({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.onDateTimeChanged,
    this.dateTimeByText,
    this.bgColor,
    this.minTime,
    this.dateTime,
  }) : super(key: key);
  final String icon;
  final String labelText;
  final String? dateTimeByText;
  final ValueChanged<DateTime> onDateTimeChanged;
  final Color? bgColor;
  final DateTime? minTime;
  final String? dateTime;

  @override
  State<MepharPickerDatetime> createState() => _MepharPickerDatetimeState();
}

class _MepharPickerDatetimeState extends State<MepharPickerDatetime> {
  DateTime dateTimeText = DateTime.now();

  Future<void> _showDatePicker({DateTime? minTime}) async {
    DateTime pickedDate =
        await AppFunction.pickDate(context, dateTimeText, minTime: minTime);
    setState(() {
      dateTimeText = pickedDate;
      widget.onDateTimeChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.icon == AppImages.iconCalendar) {
          _showDatePicker(minTime: widget.minTime);
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: widget.bgColor ?? Colors.white,
            border: const Border(
                bottom: BorderSide(
              color: Colors.black26,
            ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: RichText(
                        maxLines: 1,
                        text: TextSpan(
                          text: '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          children: widget.labelText.contains('*')
                              ? [
                                  TextSpan(
                                    style:
                                        AppFonts.normalBold(12, AppThemes.gray),
                                    text: widget.labelText.substring(
                                        0, widget.labelText.indexOf('*')),
                                  ),
                                  const TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppThemes.red0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.labelText.substring(
                                        widget.labelText.indexOf('*') + 1),
                                    style:
                                        AppFonts.normalBold(12, AppThemes.gray),
                                  ),
                                ]
                              : [
                                  TextSpan(
                                    text: widget.labelText,
                                    style:
                                        AppFonts.normalBold(12, AppThemes.gray),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                          widget.dateTimeByText ??
                              getDateTimeText(widget.icon, dateTimeText),
                          style: AppFonts.light(16, const Color(0xff333333))),
                    )
                  ],
                ),
              ),
              FractionallySizedBox(
                heightFactor: 2 / 5,
                child: Image.asset(widget.icon),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getDateTimeText(String icon, DateTime? dateTime) {
    if (dateTime == null && icon == AppImages.iconCalendar) {
      return 'dd/mm/yy';
    }
    if (icon == AppImages.iconCalendar) {
      return '${dateTime!.day}/${dateTime.month}/${dateTime.year}';
    } else {
      return '';
    }
  }
}
