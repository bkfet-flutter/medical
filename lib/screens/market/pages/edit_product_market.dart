import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_dropdown_star.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/market_text_form_filed.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class EditProductMarket extends StatelessWidget {
  const EditProductMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Cập nhật sản phẩm lên chợ',
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const MarketDropdownStar(hint: 'Nhóm sản phẩm*'),
                    const MarketDropdownStar(hint: 'Sản phẩm*'),
                    const MarketTextFiled(
                      hintText: 'Số lượng tồn',
                      keyboardType: TextInputType.number,
                    ),
                    const MarketTextFiled(
                      hintText: 'Giá bán*',
                      keyboardType: TextInputType.number,
                    ),
                    const MarketTextFiled(
                      hintText: 'Giá khuyến mại',
                      keyboardType: TextInputType.number,
                    ),
                    const MarketTextFiled(
                      hintText: 'Mô tả',
                      keyboardType: TextInputType.text,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 8),
                            blurRadius: 13,
                            spreadRadius: -3,
                            color: Color.fromRGBO(0, 0, 0, 0.07))
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hình ảnh minh họa",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff232325)),
                          ),
                          const SizedBox(height: 8),
                          // TouchableWidget(
                          //   padding: const EdgeInsets.all(0),
                          //   onPressed: () {
                          //     AppFunction.pickImages();
                          //   },
                          //   child: Image.asset(
                          //     AppImages.exportImage,
                          //     fit: BoxFit.contain,
                          //   ),
                          // ),
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ...List.generate(
                                5,
                                (index) => Stack(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: const Color(0xffE4E4EB))),
                                      child: Image.asset(
                                        AppImages.imageOTIV,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Image.asset(
                                          AppImages.iconCloseCircle2,
                                          width: 24,
                                          height: 24,
                                        ))
                                  ],
                                ),
                              ),
                              TouchableWidget(
                                  width: 24,
                                  height: 24,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    AppFunction.pickImages();
                                  },
                                  child: Image.asset(
                                    AppImages.iconAddCircleGrey,
                                    color: Color(0xffEE0033),
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.contain,
                                  ))
                            ],
                          )
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
                child: MepharButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  titleButton: "Lưu",
                ))
          ],
        ));
  }
}
