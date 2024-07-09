import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/medicine_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class MedicineCategoryScreen extends BaseScreen {
  const MedicineCategoryScreen({super.key});

  @override
  MedicineCategoryScreenState createState() => MedicineCategoryScreenState();
}

class MedicineCategoryScreenState extends BaseState<MedicineCategoryScreen>
    with BaseScreenMixin {
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  int selectedPage = 1;
  bool isCheck = false;
  String handel = "chon all";
  List<bool> check = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  TextEditingController controllerSearch = TextEditingController();
  final NumberPaginatorController _controller = NumberPaginatorController();

  callApi() async {
    showLoading();
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
    String getDataMedicine =
        await Provider.of<MedicineProvider>(context, listen: false)
            .getDataMedicine("", 20, selectedPage);
    if (getDataMedicine == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataMedicine,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  callApiRefresh() async {
    showLoading();
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
    controllerSearch.clear();
    String getDataMedicine =
        await Provider.of<MedicineProvider>(context, listen: false)
            .getDataMedicine("", 20, 1);
    if (getDataMedicine == "success" && context.mounted) {
      hideLoading();
      _controller.navigateToPage(0);
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataMedicine,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    callApi();
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<MedicineProvider>(
      builder: (context, medicine, child) {
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) {
              if (value.isEmpty == true) {
                callApiRefresh();
              }
            },
            onFieldSubmitted: (String? keyword) async {
              showLoading();
              String getDataMedicine =
                  await Provider.of<MedicineProvider>(context, listen: false)
                      .getDataMedicine(keyword, 20, 1);
              if (getDataMedicine == "success" && context.mounted) {
                hideLoading();
                // _controller.navigateToPage(0);
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(
                    context,
                    getDataMedicine,
                    textButton: "Đóng",
                    title: "Thông báo lỗi",
                  );
                }
              }
            },
            haveSuffixSearch: false,
            title: "Danh mục thuốc",
            body: Column(
              children: [
                Expanded(
                  child: medicine.listMedicine.isNotEmpty
                      ? Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    right: 40, left: 40, top: 20, bottom: 17),
                                child: SizedBox()
                                //  MepharCheckbox(
                                //   onTap: () {
                                //     AppFunction.hideKeyboard(context);
                                //     setState(() {
                                //       handel = "chon all";
                                //       isCheck = !isCheck;
                                //     });
                                //   },
                                //   isChecked: isCheck,
                                //   text: "Danh mục thuốc",
                                //   isCheckBoxRight: true,
                                // ),
                                ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: medicine.listMedicine.length,
                                      itemBuilder: (context, index) {
                                        return CardProductCheck(
                                            noCheckBox: true,
                                            isCheck: handel == "chon all"
                                                ? isCheck
                                                : check[index],
                                            onTapCheckBox: () {
                                              AppFunction.hideKeyboard(context);
                                              if (isCheck == true) {
                                                setState(() {
                                                  handel = "chon tung cai";
                                                  check[index] = false;
                                                  for (int i = 0;
                                                      i < check.length;
                                                      i++) {
                                                    if (i != index) {
                                                      check[i] = true;
                                                    }
                                                  }
                                                  isCheck = false;
                                                });
                                              } else {
                                                setState(() {
                                                  handel = "chon tung cai";
                                                  check[index] = !check[index];
                                                  isCheck = false;
                                                });
                                              }
                                              isCheck = check.every(
                                                  (value) => value == true);
                                            },
                                            numberCard: index,
                                            listData: [
                                              {
                                                "titleLeft": "Mã thuốc",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .code ??
                                                    "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft": "Tên thuốc",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .name ??
                                                    "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft": "Số đăng ký",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .registerNumber ??
                                                    "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft": "Hoạt chất",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .activeElement ??
                                                    "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft": "Hàm lượng",
                                                "titleRight": medicine
                                                            .listMedicine[index]
                                                            .content ==
                                                        ""
                                                    ? "Đang cập nhật"
                                                    : medicine
                                                        .listMedicine[index]
                                                        .content,
                                              },
                                              {
                                                "titleLeft": "Hãng sản xuất",
                                                "titleRight": medicine
                                                            .listMedicine[index]
                                                            .manufacture ==
                                                        null
                                                    ? medicine
                                                        .listMedicine[index]
                                                        .manufacture
                                                    : "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft": "Nước sản xuất",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .country
                                                        ?.name ??
                                                    "Đang cập nhật",
                                              },
                                              {
                                                "titleLeft":
                                                    "Quy cách đóng gói",
                                                "titleRight": medicine
                                                        .listMedicine[index]
                                                        .packingSpecification ??
                                                    "Đang cập nhật",
                                                "isFinal": true,
                                              },
                                            ],
                                            onPressed: () {
                                              AppFunction.hideKeyboard(context);
                                            });
                                      }),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const BlankPage(
                          title: "Không tìm thấy sản phẩm nào!",
                          content: "Hãy thử tìm những sản phẩm tương tự",
                        ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spaceMedium,
                    vertical: AppDimens.spaceXSmall,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: NormalText(
                          "Tổng: ${medicine.total}",
                          style: AppFonts.regular(14, AppThemes.dark2),
                          minFontSize: 8,
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: AppNumberPaging(
                          currentPage: medicine.currentPage,
                          totalPage: ((medicine.total / 5).ceil() > 0)
                              ? (medicine.total / 5).ceil()
                              : 1,
                          onTap: (value) {
                            AppFunction.hideKeyboard(context);
                            setState(() {
                              selectedPage = value;
                            });
                            medicine.updatePage(value);

                            callApi();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
