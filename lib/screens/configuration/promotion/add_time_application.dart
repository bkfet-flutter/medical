import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';

class AddTimeApplication extends BaseScreen {

  const AddTimeApplication({super.key});

  @override
  AddTimeApplicationState createState() => AddTimeApplicationState();
}

class AddTimeApplicationState extends BaseState<AddTimeApplication> with BaseScreenMixin {
  bool isCheck1 = true;
  bool isCheck2 = false;
  bool isApply = false;

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MepharPickerDatetime(
                    icon: AppImages.iconCalendar,
                    labelText: "Từ ngày",
                    onDateTimeChanged: (value) {},
                  ),
                  MepharPickerDatetime(
                    icon: AppImages.iconCalendar,
                    labelText: "Từ ngày",
                    onDateTimeChanged: (value) {},
                  ),
                  MepharDropDownButton(
                      haveBorder: false, hintText: "Theo tháng", items: const [], onChanged: (value) {}),
                  MepharDropDownButton(
                      haveBorder: false, hintText: "Theo ngày", items: const [], onChanged: (value) {}),
                  MepharDropDownButton(haveBorder: false, hintText: "Theo thứ", items: const [], onChanged: (value) {}),
                  MepharDropDownButton(haveBorder: false, hintText: "Theo giờ", items: const [], onChanged: (value) {}),
                  MepharCheckbox(
                    isChecked: false,
                    text: "",
                    isWidget: true,
                    widget: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MepharDropDownButton(
                        height: 50,
                        width: 140,
                        hintText: "",
                        items: const ["Cảnh báo", "Chặn"],
                        onChanged: (valeu) {},
                        haveHintText: false,
                        haveBorder: false,
                      ),
                    ),
                    isCheckBoxRight: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "(Nếu khách hàng đã được hưởng khuyến mại này)",
                    style: AppFonts.regular(
                      12,
                      AppThemes.dark3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: Wrap(
                spacing: 0,
                runSpacing: 0,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 0),
                    child: Checkbox(
                        activeColor: AppThemes.red0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        value: isApply,
                        onChanged: (value) {
                          setState(() {
                            isApply = value!;
                          });
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "Áp dụng vào",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                  MepharDropDownButton(
                    width: 90,
                    height: 50,
                    hintText: "",
                    items: const ["Ngày", "Tháng"],
                    onChanged: (valeu) {},
                    haveHintText: false,
                    haveBorder: false,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "sinh ",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "nhật ",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "của ",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "khách ",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      "hàng.",
                      style: AppFonts.regular(
                        14,
                        AppThemes.dark2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
