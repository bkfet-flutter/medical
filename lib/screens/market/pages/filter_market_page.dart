import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_dropdown.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/market_text_form_filed.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class FilterMarketPage extends StatelessWidget {
  const FilterMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Bộ lọc tìm kiếm',
        iconLeft: AppImages.iconClose,
        body: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarketDropdown(
                      label: 'Loại sản phẩm',
                      hint: 'Chọn loại',
                    ),
                    SizedBox(height: 16),
                    MarketDropdown(
                      label: 'Khu vực',
                      hint: 'Chọn khu vực',
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Khoảng giá', style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppFonts.laTo,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8C8C8C)
                      ),),
                    ),
                    Row(
                      children: [
                        Expanded(child: MarketTextFiled(hintText: 'Từ', hintBlack: true,keyboardType: TextInputType.number,)),
                        SizedBox(width: 12),
                        Expanded(child: MarketTextFiled(hintText: 'Đến', hintBlack: true,keyboardType: TextInputType.number)),
                      ],
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
                        onPressed: () {},
                        titleButton: "Đặt lại",
                        isButtonWhite: true,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MepharButton(
                        onPressed: () {},
                        titleButton: "Lọc",
                      ),
                    ),
                  ],
                ))
          ],
        )
    );
  }
}
