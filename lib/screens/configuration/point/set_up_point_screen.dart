import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/widgets/button_dropdown.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class SetUpPointScreen extends BaseScreen {
  const SetUpPointScreen({super.key});

  @override
  SetUpPointScreenState createState() => SetUpPointScreenState();
}

class SetUpPointScreenState extends BaseState<SetUpPointScreen>
    with BaseScreenMixin {
  String selected = "";
  String selected2 = "";
  @override
  String setTitle() {
    return "Thiết lập tích điểm";
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: MepharRadioButton(
                              title: "Hóa đơn",
                              isSelected: selected == "Hóa đơn",
                              onSelected: (value) {
                                setState(() {
                                  selected = value;
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Flexible(
                          child: MepharRadioButton(
                              title: "Hàng hóa",
                              isSelected: selected == "Hàng hóa",
                              onSelected: (value) {
                                setState(() {
                                  selected = value;
                                });
                              }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            "Tỉ lệ quy đổi  ",
                            style: AppFonts.regular(14, AppThemes.dark1),
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: MepharTextfield(hintText: ""),
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Container(
                            color: AppThemes.kPrimary,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              child: AutoSizeText(
                                "VND",
                                style: AppFonts.regular(12, Colors.white),
                                textAlign: TextAlign.center,
                                minFontSize: 9,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            "= 1 điểm thưởng",
                            style: AppFonts.regular(14, AppThemes.dark1),
                          ),
                        ),
                      ],
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text: "Cho phép thanh toán bằng điểm",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: MepharTextfield(hintText: ""),
                                  )),
                              const SizedBox(
                                width: 2,
                              ),
                              Flexible(
                                child: Container(
                                  color: AppThemes.orange0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: AutoSizeText(
                                      "Điểm",
                                      style: AppFonts.regular(12, Colors.white),
                                      textAlign: TextAlign.center,
                                      minFontSize: 9,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "=",
                          style: AppFonts.normalBold(
                            16,
                            AppThemes.dark1,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: MepharTextfield(hintText: ""),
                                  )),
                              const SizedBox(
                                width: 2,
                              ),
                              Flexible(
                                child: Container(
                                  color: AppThemes.kPrimary,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: AutoSizeText(
                                      "VND",
                                      style: AppFonts.regular(12, Colors.white),
                                      textAlign: TextAlign.center,
                                      minFontSize: 9,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Thanh toán bằng điểm sau   ",
                          style: AppFonts.regular(14, AppThemes.dark1),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: 45,
                          padding: const EdgeInsets.only(bottom: 30),
                          child: MepharTextfield(hintText: ""),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "lần mua",
                          style: AppFonts.regular(14, AppThemes.dark1),
                        ),
                      ],
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text: "Không tích điểm cho sản phẩm giảm giá",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text: "Không tích điểm cho hóa đơn giảm giá",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text:
                          "Không tích điểm cho hóa đơn thanh toán bằng điểm thưởng",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text:
                          "Không tích điểm cho hóa đơn thanh toán bằng voucher",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    MepharRadioButton(
                        title: "Toàn bộ khách hàng",
                        isSelected: selected2 == "Toàn bộ khách hàng",
                        onSelected: (value) {
                          setState(() {
                            selected2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: MepharRadioButton(
                            title: "Nhóm khách hàng",
                            isSelected: selected2 == "Nhóm khách hàng",
                            onSelected: (value) {
                              setState(() {
                                selected2 = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          flex: 2,
                          child: ButtonDropdown(
                            onChanged: (value) {},
                            listItem: const ["Trần Mạnh Huy"],
                            hint: Text(
                              "Chọn nhóm khách hàng",
                              style: AppFonts.regular(
                                14,
                                AppThemes.dark4,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      color: AppThemes.light2,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    MepharCheckbox(
                      isChecked: false,
                      text: "Khởi tạo với toàn bộ hàng hóa",
                      textStyle: AppFonts.regular(14, AppThemes.dark1),
                      isCheckBoxRight: false,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
              child: MepharButton(
                titleButton: "Lưu",
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
