import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/market_text_filed.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
      title: 'Thêm mới địa chỉ',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  MarketInputFiled(title: 'Tên', controller: TextEditingController()),
                  SizedBox(height: 16),
                  MarketInputFiled(title: 'Số điện thoại', controller: TextEditingController()),
                  SizedBox(height: 16),
                  MarketInputFiled(title: 'Tỉnh/Thành phố', controller: TextEditingController()),
                  SizedBox(height: 16),
                  MarketInputFiled(title: 'Quận/Huyện', controller: TextEditingController()),
                  SizedBox(height: 16),
                  MarketInputFiled(title: 'Phường/Xã', controller: TextEditingController()),
                  SizedBox(height: 16),
                  MarketInputFiled(title: 'Đại chỉ chi tiết', controller: TextEditingController()),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Đặt làm địa chỉ mặc định',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: AppFonts.laTo,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.dark2),
                        ),
                      ),
                      SizedBox(width: 8),
                      Switch(
                          activeColor: Color(0xffEE0033),
                          activeTrackColor: const Color(0xffFEE6EB),
                          value: true,
                          onChanged: (value) {})
                    ],
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
      ),
    );
  }
}
