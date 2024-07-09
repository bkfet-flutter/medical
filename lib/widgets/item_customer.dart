import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ItemCustomer extends StatelessWidget {
  const ItemCustomer({
    super.key,
    this.name,
    this.phone,
    this.isFinal = false, this.onTap,
  });

  final String? name;
  final String? phone;
  final bool isFinal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            name ?? "",
            style: AppFonts.bold(
              14,
              AppThemes.dark1,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            phone ?? "",
            style: AppFonts.regular(
              14,
              AppThemes.dark2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          isFinal
              ? const SizedBox.shrink()
              : Container(
                  height: 1,
                  color: AppThemes.light0,
                  width: MediaQuery.of(context).size.width,
                )
        ],
      ),
    );
  }
}
