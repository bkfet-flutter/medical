import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class StepperOrder extends StatefulWidget {
  final String time;
  final int status;
  final String text;

  const StepperOrder({super.key, required this.time, required this.status, required this.text});

  @override
  State<StepperOrder> createState() => _StepperOrderState();
}

class _StepperOrderState extends State<StepperOrder> {
  final GlobalKey _textKey = GlobalKey();
  double _dashHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textHeight = _textKey.currentContext!.size!.height;
      setState(() {
        _dashHeight = textHeight - 16;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: (widget.status == 3) ? const Color(0xffEE0033) : const Color(0xffFDD9E1),
              backgroundImage: (widget.status == 3) ? const AssetImage(AppImages.iconCheck) : null,
            ),
            Container(
              width: 4,
              height: (widget.status == 0) ? 0 : _dashHeight,
              color: const Color(0xffFDD9E1),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Padding(
            key: _textKey,
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.time,
                    style: const TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: AppThemes.dark1)),
                const SizedBox(height: 4),
                Text(widget.text,
                    style: TextStyle(
                        fontFamily: AppFonts.laTo,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _getTextColor(widget.status),
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Color _getTextColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xff8F90A6);
      case 1:
        return const Color(0xffFF8800);
      case 2:
        return const Color(0xff3E7BFA);
      case 3:
        return const Color(0xff05A660);
      case 4:
        return const Color(0xffFF3B3B);
    }
    return const Color(0xff8F90A6);
  }
}
