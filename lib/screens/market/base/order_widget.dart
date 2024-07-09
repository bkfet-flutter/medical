import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class OrderWidget extends StatelessWidget {
  final String? nameStore;
  final bool? hideBottom;

  const OrderWidget({super.key, this.nameStore, this.hideBottom});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(color: const Color(0xffF2F2F2), border: Border.all(color: const Color(0xffECECEC))),
        ),
        Container(
          color: AppThemes.white,
          padding: const EdgeInsets.all(16),
          child: Text(
            nameStore ?? "TIM Care Diamond",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff333333)),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color(0xffFAFAFC), border: Border(top: BorderSide(color: Color(0xffC7C9D9)))),
            child: Column(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: EdgeInsets.only(bottom: index == 2 ? 0 : 8),
                        child: const OrderItem(),
                      )),
            )),
        (hideBottom == true) ?  SizedBox.shrink() : TouchableWidget(
          onPressed: (){
            Navigator.pushNamed(context, AppRoutes.shippingMethod);
          },
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
              color: Color(0xffE5FFFF), border: Border(bottom: BorderSide(color: Color(0xff00CFDE)))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Phương thức vận chuyển",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff00B7C4)),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: const Color(0xff00CFDE),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Nhanh",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1),
                    ),
                  ),
                  const Text(
                    "20.000đ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    AppImages.iconArrowNext,
                    width: 12,
                    height: 12,
                  )
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Nhận hàng vào 3 Th07 - 5 th07",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark3),
              ),
            ],
          ),
        ),
        Container(
          color: AppThemes.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Tin nhắn:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Lưu ý cho Người bán...',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: TextStyle(
                              fontFamily: AppFonts.laTo,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppThemes.dark4)),
                    ),
                  )
                ],
              ),
              Container(
                height: 1,
                color: const Color(0xffEBEBF0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Tổng số tiền (3sp)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: AppFonts.laTo, fontSize: 12, fontWeight: FontWeight.w500, color: AppThemes.dark1),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "1.000.000đ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xffEE0033)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  final String? name;

  const OrderItem({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.imgDemo2,
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name ?? "Otiv – Viên Uống Hỗ Trợ Não Bộ Chính Hãng Của Mỹ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff333333)),
            ),
            const SizedBox(height: 8),
            const Text(
              "52.000đ/ hộp",
              style: TextStyle(
                  fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: AppThemes.dark3),
            ),
          ],
        )),
        const SizedBox(width: 8),
        const Text(
          "x12",
          style:
              TextStyle(fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: AppThemes.dark3),
        ),
      ],
    );
  }
}
