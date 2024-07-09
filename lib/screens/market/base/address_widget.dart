import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class AddressWidget extends StatelessWidget {
  final String name;
  final String number;
  final String address;
  final bool? isDefault;
  final void Function()? onTapPen;

  const AddressWidget(
      {Key? key, required this.name, required this.number, required this.address, this.isDefault, this.onTapPen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$name | (+84)${number.substring(1).trim()}',
                    style: const TextStyle(fontSize: 14, fontFamily: AppFonts.laTo, color: Color(0xff555770))),
                const SizedBox(
                  height: 5,
                ),
                Text(address,
                    style: const TextStyle(fontSize: 14, fontFamily: AppFonts.laTo, color: Color(0xff555770))),
                const SizedBox(
                  height: 5,
                ),
                isDefault == true
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4), color: const Color(0xffEE0033).withOpacity(0.15)),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: const Text(
                          'Địa chỉ mặc định',
                          style: TextStyle(fontSize: 12, fontFamily: AppFonts.laTo, color: Color(0xffEE0033)),
                        ))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
              onTap: onTapPen,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AppImages.iconPen,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain
                ),
              ))
        ],
      ),
    );
  }
}
