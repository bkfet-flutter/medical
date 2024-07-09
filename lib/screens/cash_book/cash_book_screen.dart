import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/item_header_cash_book.dart';
import 'package:mephar_app/widgets/item_make_cash_book.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';

class CashBookScreen extends BaseScreen {
  const CashBookScreen({super.key});

  @override
  CashBookScreenState createState() => CashBookScreenState();
}

class CashBookScreenState extends BaseState<CashBookScreen> with BaseScreenMixin {
  List<Map> listData = const [
    {
      "titleRight": "TTHD230419081826",
      "titleLeft": "Mã phiếu",
      "isTextBlue": true,
    },
    {
      "titleRight": "19-04-2023 08:18",
      "titleLeft": "Thời gian",
    },
    {
      "titleRight": "Thu tiền từ khách hàng",
      "titleLeft": "Loại thu phiếu",
    },
    {
      "titleRight": "Nguyễn Văn A",
      "titleLeft": "Người nộp/nhận",
    },
    {
      "titleRight": "36060",
      "titleLeft": "Giá trị",
      "isFinal": true,
    },
  ];

  @override
  String setTitle() {
    return "Sổ quỹ";
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
        haveIconNearSearch: true,
        haveOneIcon: true,
        title: "Sổ quỹ",
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Expanded(child: ItemHeaderCashBook()),
                        Expanded(
                            child: ItemHeaderCashBook(
                          title: "Tổng thu",
                          quantity: "19181214",
                          color: AppThemes.green0,
                        )),
                        Expanded(
                            child: ItemHeaderCashBook(
                          title: "Tổng chi",
                          quantity: "762600",
                          color: AppThemes.red0,
                        )),
                        Expanded(
                            child: ItemHeaderCashBook(
                          title: "Tồn quỹ",
                          quantity: "3294789",
                          color: AppThemes.blue0,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 1,
                      color: AppThemes.light0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(child: ItemMakeCashBook(onPressed: () {
                          AppFunction.showDialogAlert(context,
                              hideBtnBottom: true,
                              styleTitle: AppFonts.normalBold(
                                18,
                                AppThemes.dark1,
                              ),
                              widgetDescription: Column(
                                children: [
                                  MepharTextfield(hintText: "Mã phiếu"),
                                  MepharPickerDatetime(
                                      icon: AppImages.iconCalendar,
                                      labelText: "Thời gian",
                                      onDateTimeChanged: (value) {}),
                                  MepharTextfield(hintText: "Giá trị*"),
                                  MepharDropDownButton(
                                      haveBorder: false,
                                      hintText: "Đối tượng nộp*",
                                      items: const ["Lựa chọn"],
                                      onChanged: (value) {}),
                                  MepharDropDownButton(
                                      haveBorder: false,
                                      hintText: "Tên người nộp*",
                                      items: const ["Lựa chọn"],
                                      onChanged: (value) {}),
                                  MepharTextfield(hintText: "Thêm ghi chú"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharCheckbox(
                                      isCheckBoxRight: false,
                                      textStyle: AppFonts.light(
                                        16,
                                        const Color(0xff333333),
                                      ),
                                      isChecked: false,
                                      text: "Thanh toán hóa đơn nợ"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: SizedBox.shrink()),
                                      Expanded(
                                        child: InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppThemes.red0,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.centerRight,
                                                        child: Image.asset(
                                                          AppImages.iconReceiptAdd,
                                                          height: 24,
                                                          width: 24,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: AutoSizeText(
                                                        "Lập phiếu thu",
                                                        overflow: TextOverflow.ellipsis,
                                                        minFontSize: 8,
                                                        maxLines: 1,
                                                        style: AppFonts.normalBold(14, Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              showBtnClose: true,
                              title: "Tạo phiếu thu (Tiền mặt)");
                        })),
                        Container(
                          height: 24,
                          width: 1,
                          color: AppThemes.dark4,
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: ItemMakeCashBook(
                                    image: AppImages.iconReceiptMinus,
                                    title: "Lập phiếu chi",
                                    onPressed: () {
                                      AppFunction.showDialogAlert(context,
                                          hideBtnBottom: true,
                                          styleTitle: AppFonts.normalBold(
                                            18,
                                            AppThemes.dark1,
                                          ),
                                          widgetDescription: Column(
                                            children: [
                                              MepharTextfield(hintText: "Mã phiếu"),
                                              MepharPickerDatetime(
                                                  icon: AppImages.iconCalendar,
                                                  labelText: "Thời gian",
                                                  onDateTimeChanged: (value) {}),
                                              MepharTextfield(hintText: "Giá trị*"),
                                              MepharDropDownButton(
                                                  haveBorder: false,
                                                  hintText: "Đối tượng nộp*",
                                                  items: const ["Lựa chọn"],
                                                  onChanged: (value) {}),
                                              MepharDropDownButton(
                                                  haveBorder: false,
                                                  hintText: "Tên người nộp*",
                                                  items: const ["Lựa chọn"],
                                                  onChanged: (value) {}),
                                              MepharTextfield(hintText: "Thêm ghi chú"),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              MepharCheckbox(
                                                  isCheckBoxRight: false,
                                                  textStyle: AppFonts.light(
                                                    16,
                                                    const Color(0xff333333),
                                                  ),
                                                  isChecked: false,
                                                  text: "Thanh toán hóa đơn nợ"),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(child: SizedBox.shrink()),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: AppThemes.red0,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.centerRight,
                                                                    child: Image.asset(
                                                                      AppImages.iconReceiptAdd,
                                                                      height: 24,
                                                                      width: 24,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: AutoSizeText(
                                                                    "Lập phiếu chi",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    minFontSize: 8,
                                                                    maxLines: 1,
                                                                    style: AppFonts.normalBold(14, Colors.white),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          showBtnClose: true,
                                          title: "Tạo phiếu chi (Tiền mặt)");
                                    }))),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 36),
                    child: Text(
                      "Danh sách sổ quỹ",
                      style: AppFonts.bold(
                        18,
                        AppThemes.dark1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CardProductCheck(
                      numberCard: 1,
                      noCheckBox: true,
                      listData: listData,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.cashBookDetailScreen,
                          arguments: listData,
                        );
                      }),
                  CardProductCheck(
                      numberCard: 2,
                      noCheckBox: true,
                      listData: const [
                        {
                          "titleRight": "TTHD230419081826",
                          "titleLeft": "Mã phiếu",
                          "isTextBlue": true,
                        },
                        {
                          "titleRight": "19-04-2023 08:18",
                          "titleLeft": "Thời gian",
                        },
                        {
                          "titleRight": "Thu tiền từ khách hàng",
                          "titleLeft": "Loại thu phiếu",
                        },
                        {
                          "titleRight": "Nguyễn Văn A",
                          "titleLeft": "Người nộp/nhận",
                        },
                        {
                          "titleRight": "36060",
                          "titleLeft": "Giá trị",
                          "isFinal": true,
                        },
                      ],
                      onPressed: () {}),
                  CardProductCheck(
                      numberCard: 3,
                      noCheckBox: true,
                      listData: const [
                        {
                          "titleRight": "TTHD230419081826",
                          "titleLeft": "Mã phiếu",
                          "isTextBlue": true,
                        },
                        {
                          "titleRight": "19-04-2023 08:18",
                          "titleLeft": "Thời gian",
                        },
                        {
                          "titleRight": "Thu tiền từ khách hàng",
                          "titleLeft": "Loại thu phiếu",
                        },
                        {
                          "titleRight": "Nguyễn Văn A",
                          "titleLeft": "Người nộp/nhận",
                        },
                        {
                          "titleRight": "36060",
                          "titleLeft": "Giá trị",
                          "isFinal": true,
                        },
                      ],
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ));
  }
}
