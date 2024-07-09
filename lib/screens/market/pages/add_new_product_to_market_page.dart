import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_dropdown_star.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/market_text_form_filed.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class AddNewProductMarketPage extends StatelessWidget {
  const AddNewProductMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Thêm mới sản phẩm lên chợ',
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    MarketDropdownStar(hint: 'Nhóm sản phẩm*'),
                    const MarketDropdownStar(hint: 'Sản phẩm*'),
                    MarketTextFiled(
                      hintText: 'Số lượng tồn',
                      keyboardType: TextInputType.number,
                    ),
                    MarketTextFiled(
                      hintText: 'Giá bán*',
                      keyboardType: TextInputType.number,
                    ),
                    MarketTextFiled(
                      hintText: 'Giá khuyến mại',
                      keyboardType: TextInputType.number,
                    ),
                    MarketTextFiled(
                      hintText: 'Mô tả',
                      keyboardType: TextInputType.text,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 8), blurRadius: 13, spreadRadius: -3, color: Color.fromRGBO(0, 0, 0, 0.07))
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hình ảnh minh họa",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff232325)),
                          ),
                          SizedBox(height: 8),
                          TouchableWidget(
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              AppFunction.pickImages();
                            },
                            child: Image.asset(
                              AppImages.exportImage,
                              fit: BoxFit.contain,
                            ),
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
