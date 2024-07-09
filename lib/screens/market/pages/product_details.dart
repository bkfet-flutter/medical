import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/box_store.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ScrollController scrollController = ScrollController();

 @override
  void dispose() {
   scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.white,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 375 / 260,
                          child: Image.asset(
                            AppImages.imageOTIV,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                10,
                                (index) => Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 83,
                                      height: 83,
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: AssetImage(AppImages.imageOTIV), fit: BoxFit.contain),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: AppThemes.light0)),
                                    )),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BOtiv – Viên Uống Hỗ Trợ Não Bộ Chính Hãng Của Mỹ",
                                style: TextStyle(
                                    fontFamily: AppFonts.laTo,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppThemes.dark1),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                " 2.6K đã bán",
                                style: TextStyle(
                                    fontFamily: AppFonts.laTo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemes.dark1),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Orange leaves, chicken, tempeh, sambal, singkong, egg, crackers.",
                                style: TextStyle(
                                    fontFamily: AppFonts.laTo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppThemes.dark2),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Text(
                                    '330.000đ',
                                    style: TextStyle(
                                        fontFamily: AppFonts.laTo,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color(0xffEE0033)),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '330.000đ',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontFamily: AppFonts.laTo,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.4)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Text(
                                    'Số lượng:',
                                    style: TextStyle(
                                        fontFamily: AppFonts.laTo,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: AppThemes.dark1),
                                  ),
                                  const SizedBox(width: 24),
                                  Image.asset(
                                    AppImages.iconMinus,
                                    width: 32,
                                    height: 32,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0xff333333)),
                                    ),
                                  ),
                                  Image.asset(
                                    AppImages.iconPlus,
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(width: 24),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color.fromRGBO(63, 105, 255, 0.10)),
                                    child: const Text(
                                      'Còn hàng',
                                      style: TextStyle(
                                          fontFamily: AppFonts.laTo,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xff3E7BFA)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              Container(
                                height: 1,
                                color: const Color(0xffDDDDDD),
                              ),
                              const BoxStore(
                                noMargin: true,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Mã: P198354",
                                style: TextStyle(
                                    fontFamily: AppFonts.laTo,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppThemes.dark1),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color.fromRGBO(24, 85, 242, 0.11)),
                                child: const Text(
                                  'Thực phẩm chống lão hóa',
                                  style: TextStyle(
                                      fontFamily: AppFonts.laTo,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppThemes.dark1),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8), color: const Color(0xffFAFAFA)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8), color: const Color(0xffEE0033)),
                                        child: const Text(
                                          'Chi tiết sản phẩm',
                                          style: TextStyle(
                                              fontFamily: AppFonts.laTo,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: AppThemes.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8), color: AppThemes.transparent),
                                        child: const Text(
                                          'Thương hiệu',
                                          style: TextStyle(
                                              fontFamily: AppFonts.laTo,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: AppThemes.dark1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildDescription(1, 'Công dụng',
                                  'OTiV chứa các hoạt chất sinh học quý được tinh chiết từ Blueberry Giúp cải thiện tình trạng thiếu máu não, mất ngủ, đau nửa đầu; giảm nguy cơ tai biến mạch máu não. Giúp cải thiện tình trạng sa sút trí tuệ, suy giảm trí nhớ; giảm stress; cải thiện thính giác và thị giác. Hỗ trợ chống oxy hóa, trung hòa gốc tự do, bảo vệ và chống lão hóa tế bào thần kinh.'),
                              _buildDescription(2, 'Thành Phần',
                                  "Blueberry Extract (4:1)	100 mg GinkgoPure (Ginkgo Biloba Extract)	80 mg Gelatin, Maltodextrin & Magnesium stearate")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
                    child: Row(
                      children: [
                        Expanded(
                          child: MepharButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.cartPage);
                            },
                            titleButton: "Thêm vào giỏ hàng",
                            isButtonWhite: true,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: MepharButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.payment);
                            },
                            titleButton: "Đặt hàng",
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    mini: true,
                    icon: AppImages.iconArrowBack,
                    iconWidth: 24,
                    iconHeight: 24,
                    iconColor: AppThemes.white,
                    backgroundColor: Colors.grey,
                  ),
                  HeaderButton(
                    onPressed: () {
                      //Navigator.pop(context);
                    },
                    mini: true,
                    icon: AppImages.iconCart,
                    iconWidth: 24,
                    iconHeight: 24,
                    iconColor: AppThemes.white,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildDescription(int index, String header, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. $header".toUpperCase(),
            style: const TextStyle(
                fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w700, color: AppThemes.dark1),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: const TextStyle(
                fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w400, color: AppThemes.dark2),
          ),
        ],
      ),
    );
  }
}
