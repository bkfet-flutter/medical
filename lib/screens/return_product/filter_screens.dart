import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/market/base/market_dropdown.dart';
import 'package:mephar_app/screens/market/base/market_text_form_filed.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';

class FilterScreen extends BaseScreen {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends BaseState<FilterScreen> with BaseScreenMixin {
  @override
  String setTitle() => 'Bộ lọc trả hàng nhập';

  @override
  TextStyle? setTextStyleTitle() => AppFonts.normalBold(18, AppThemes.dark1);

  @override
  Color? setHeaderBackgroundColor() => Colors.white;

  @override
  Color? setColorLeftWidget() => AppThemes.dark1;

  @override
  Color setMainBackgroundColor() => AppThemes.white;

  DateTime? startTime;
  DateTime? endTime;

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
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
                  child: Text(
                    'Khoảng giá',
                    style: TextStyle(
                        fontSize: 12, fontFamily: AppFonts.laTo, fontWeight: FontWeight.w600, color: Color(0xff8C8C8C)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Từ ngày",
                        dateTimeByText: AppFunction.formatDateRange(startTime),
                        onDateTimeChanged: (value) {
                          startTime = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Đến ngày",
                        dateTimeByText: AppFunction.formatDateRange(endTime),
                        onDateTimeChanged: (value) {
                          endTime = value;
                          setState(() {});
                        },
                      ),
                    ),
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
                    onPressed: () {
                      startTime = null;
                      setState(() {});
                    },
                    titleButton: "Đặt lại",
                    isButtonWhite: true,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MepharButton(
                    onPressed: () {
                    if(startTime != null && endTime != null){
                      // DateTime startDate = DateTime(startTime!.year, startTime!.month, startTime!.day);
                      // // DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 0, 23, 59, 59);
                     print( AppFunction.formatDate(startTime!));
                     print( AppFunction.formatDate(endTime!));
                    }
                    },
                    titleButton: "Lọc",
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
