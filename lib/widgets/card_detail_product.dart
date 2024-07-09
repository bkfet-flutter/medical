import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/row_in_card_product.dart';

class CardDetailProduct extends StatelessWidget {
  const CardDetailProduct({
    super.key,
    required this.listData,
    this.haveBorder = false,
    this.onPressed,
    this.haveTwoIcon = false,
    this.onTapEdit,
    this.onTapDelete,
    this.cross,
  });
  final List<Map> listData;
  final bool haveBorder;
  final Function()? onPressed;
  final bool haveTwoIcon;
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  final CrossAxisAlignment? cross;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: haveBorder ? BorderRadius.circular(16) : null,
        boxShadow: haveBorder
            ? [
                BoxShadow(
                  offset: const Offset(0, 16),
                  blurRadius: 24,
                  spreadRadius: 0,
                  color: const Color(0xff606170).withOpacity(0.16),
                ),
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                  color: const Color(0xff28293D).withOpacity(0.04),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          InkWell(
            highlightColor: const Color.fromRGBO(204, 223, 242, 0.2),
            splashColor: const Color.fromRGBO(204, 223, 242, 0.4),
            onTap: onPressed,
            child: Column(
              children: listData
                  .map((e) => RowInCardProduct(
                        titleLeft: e["titleLeft"] ?? "---",
                        titleRight: e["titleRight"] ?? "---",
                        isFinal: e["isFinal"] ?? false,
                        isStatus: e["isStatus"] ?? false,
                        maxLines: e["maxLines"],
                        isTextBlue: e["isTextBlue"] ?? false,
                        isTextRed: e["isTextRed"] ?? false,
                        isWidget: e["isWidget"] ?? false,
                        widgetRight:
                            e["widgetRight"] ?? const SizedBox.shrink(),
                        cross: cross,
                      ))
                  .toList(),
            ),
          ),
          haveTwoIcon
              ? Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                    top: 24,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onTapEdit,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppThemes.blue4,
                          ),
                          child: Center(
                              child: Image.asset(
                            AppImages.iconPenRed,
                            height: 24,
                            width: 24,
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      GestureDetector(
                        onTap: onTapDelete,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppThemes.blue4,
                          ),
                          child: Center(
                              child: Image.asset(
                            AppImages.iconTrashGrey,
                            height: 24,
                            width: 24,
                            color: AppThemes.red0,
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
