import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class BoxProduct extends StatelessWidget {
  final String? urlImage;
  final String? name;
  final bool? extraDiscount;
  final int? soldNumber;

  const BoxProduct({super.key, this.urlImage, this.name, this.extraDiscount, this.soldNumber});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productDetails);
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: (MediaQuery.of(context).size.width - 36) * 0.5,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width : 1 ,color: AppThemes.light1)),
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                    aspectRatio: 10 / 7,
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(12),
                      child: Image.asset(
                        urlImage ?? AppImages.imageOTIV,
                        fit: BoxFit.cover,
                      ),
                    )),
                (extraDiscount == true)
                    ? Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration:
                              BoxDecoration(color: const Color(0xff2F80ED), borderRadius: BorderRadius.circular(30)),
                          child: const Text(
                            'Extra discount',
                            style: TextStyle(
                              fontFamily: AppFonts.laTo,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: AppThemes.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      name ?? 'Otiv – Viên Uống Hỗ Trợ Não Bộ Chính Hãng Của Mỹ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(

                          fontFamily: AppFonts.laTo, fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '330.000đ',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xffEE0033)),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '330.000đ',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hanoi',
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xff333333)),
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Đã bán: ${(soldNumber ?? 24).toString()}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xff333333)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TouchableWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.cartPage);
                    },
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEE0033)), borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(
                          fontFamily: AppFonts.laTo,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 20 / 12,
                          color: Color(0xffEE0033)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
