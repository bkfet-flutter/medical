import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';

class ButtonAddMethod extends StatelessWidget {
  final void Function()? onTap;

  const ButtonAddMethod({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppThemes.red0, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.add,
                  color: AppThemes.red0,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "Thêm điều kiện",
                  style: AppFonts.normalBold(14, AppThemes.red0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
