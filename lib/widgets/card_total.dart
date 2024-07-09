import 'package:flutter/material.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/line_separator.dart';

class CardTotal extends StatelessWidget {
  const CardTotal({
    super.key,
    this.widgetTop,
    required this.dataTotal,
    required this.heightBottom,
  });
  final Widget? widgetTop;
  final List<Map> dataTotal;
  final double heightBottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xffE3E3E3), width: 1),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                widgetTop ?? const SizedBox.shrink(),
                const SizedBox(
                  height: 26,
                ),
                const LineSeparator(
                  color: Color(0xffE3E3E3),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: heightBottom,
                  child:
                      CardDetailProduct(onPressed: () {}, listData: dataTotal),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: heightBottom + 16,
          left: 10,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffF3FAFF),
              border: Border.all(color: const Color(0xffE3E3E3), width: 1),
            ),
          ),
        ),
        Positioned(
          bottom: heightBottom + 16,
          right: 10,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffF3FAFF),
              border: Border.all(color: const Color(0xffE3E3E3), width: 1),
            ),
          ),
        ),
        Positioned(
          bottom: heightBottom + 16,
          left: 0,
          child: Container(
            height: heightBottom,
            width: 20,
            color: const Color(0xffF3FAFF),
          ),
        ),
        Positioned(
          bottom: heightBottom + 16,
          right: 0,
          child: Container(
            height: heightBottom,
            width: 20,
            color: const Color(0xffF3FAFF),
          ),
        ),
      ],
    );
  }
}
