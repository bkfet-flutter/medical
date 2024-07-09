import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class ButtonArrowBack extends StatelessWidget {
  const ButtonArrowBack({super.key, this.onTap, this.color});
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
      child: Image.asset(
        AppImages.iconArrowLeft,
        height: 16,
        width: 7,
        fit: BoxFit.fill,
        color: color ?? Colors.white,
      ),
    );
  }
}
