import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class BackbillScreen extends BaseScreen {
  const BackbillScreen({super.key});

  @override
  BackbillScreenState createState() => BackbillScreenState();
}

class BackbillScreenState extends BaseState<BackbillScreen>
    with BaseScreenMixin {
  String? search;
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
    Provider.of<PayCustomerProvider>(context, listen: false)
        .listPayCustomer
        .clear();
    String getDataPayCustomer =
        await Provider.of<PayCustomerProvider>(context, listen: false)
            .getListPayCustomer("", selectedPage, 5, "SUCCEED", 10);
    if (getDataPayCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataPayCustomer,
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
    String getDataCustomer =
        await Provider.of<CustomerProvider>(context, listen: false)
            .getDataCustomer("", 5, 1);
    if (getDataCustomer == "success" && context.mounted) {
      hideLoading();
      _controller.navigateToPage(0);
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataCustomer,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    callApi();
    // isCheck = false;
    // for (var i = 0; i < check.length; i++) {
    //   check[i] = false;
    // }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<PayCustomerProvider>(
      builder: (context, pay, child) {
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) async {
              // if (value.isEmpty == true) {
              //   showLoading();
              //   customer.listAllCustomer.clear();
              //   String getDataCustomer =
              //       await customer.getDataCustomer("", 10, selectedPage);
              //   if (getDataCustomer == "success" && context.mounted) {
              //     hideLoading();
              //   } else {
              //     if (context.mounted) {
              //       hideLoading();
              //       AppFunction.showDialogError(context, getDataCustomer,
              //           textButton: "Đóng", title: "Thông báo lỗi");
              //     }
              //   }
              // }
            },
            onFieldSubmitted: (String? keyword) async {
              // showLoading();

              // String getDataCustomer =
              //     await customer.getDataCustomer(keyword, 10, 1);

              // if (getDataCustomer == "success" && context.mounted) {
              //   // hideLoading();
              //   // _controller.navigateToPage(0);
              // } else {
              //   if (context.mounted) {
              //     hideLoading();
              //     AppFunction.showDialogError(
              //       context,
              //       getDataCustomer,
              //       textButton: "Đóng",
              //       title: "Thông báo lỗi",
              //     );
              //   }
              // }
            },
            haveOneIcon: true,
            haveIconNearSearch: true,
            haveSuffixSearch: false,
            onTapIconNearSearch: () {},
            floatingActionButton: pay.listPayCustomer.isNotEmpty
                ? MepharFloatingActionButton(onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addCustomerScreen,
                    );
                  }, heroTag: 'addCustomerScreen',)
                : const SizedBox.shrink(),
            icon: AppImages.iconMoreVertical,
            title: "Trả hàng",
            body: pay.listPayCustomer.isEmpty
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                AppImages.avatarBoy,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: MepharFloatingActionButton(
                                  onPressed: () {}, heroTag: '',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 43,
                          ),
                          Text(
                            "Chưa có khách hàng nào!",
                            textAlign: TextAlign.center,
                            style: AppFonts.bold(
                              16,
                              AppThemes.dark0,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Thêm khách hàng đầu tiên vào danh sách khách hàng ngay nào",
                            textAlign: TextAlign.center,
                            style: AppFonts.bold(
                              16,
                              AppThemes.dark3,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          MepharButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.addCustomerScreen,
                              );
                            },
                            titleButton: "Tạo khách hàng",
                          )
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: pay.listPayCustomer.isNotEmpty
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 40,
                                      left: 40,
                                      top: 20,
                                      bottom: 17,
                                    ),
                                    child: MepharCheckbox(
                                      onTap: () {
                                        AppFunction.hideKeyboard(context);
                                        setState(() {
                                          handel = "chon all";
                                          isCheck = !isCheck;
                                        });
                                      },
                                      isChecked: isCheck,
                                      text: "Trả hàng",
                                      isCheckBoxRight: true,
                                    ),
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
                                            itemCount:
                                                pay.listPayCustomer.length,
                                            itemBuilder: (context, index) {
                                              return CardProductCheck(
                                                  isCheck: handel == "chon all"
                                                      ? isCheck
                                                      : check[index],
                                                  onTapCheckBox: () {
                                                    AppFunction.hideKeyboard(
                                                        context);
                                                    if (isCheck == true) {
                                                      setState(() {
                                                        handel =
                                                            "chon tung cai";
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
                                                        handel =
                                                            "chon tung cai";
                                                        check[index] =
                                                            !check[index];
                                                        isCheck = false;
                                                      });
                                                    }
                                                    isCheck = check.every(
                                                        (value) =>
                                                            value == true);
                                                  },
                                                  numberCard: index + 1,
                                                  listData: [
                                                    {
                                                      "titleLeft":
                                                          "Mã khách hàng",
                                                      "titleRight": pay
                                                          .listPayCustomer[
                                                              index]
                                                          .code,
                                                      "isTextBlue": true,
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Tên khách hàng",
                                                      "titleRight": pay
                                                          .listPayCustomer[
                                                              index]
                                                          .customer
                                                          ?.fullName,
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Tổng tiền hàng",
                                                      "titleRight": pay
                                                          .listPayCustomer[
                                                              index]
                                                          .totalPrice
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft": "Giảm giá",
                                                      "titleRight": pay
                                                          .listPayCustomer[
                                                              index]
                                                          .discount
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Khách đã trả",
                                                      "titleRight": pay
                                                          .listPayCustomer[
                                                              index]
                                                          .cashOfCustomer
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft": "Trạng thái",
                                                      "titleRight": pay
                                                                  .listPayCustomer[
                                                                      index]
                                                                  .status ==
                                                              "SUCCEED"
                                                          ? "Đơn hàng thành công"
                                                          : "Đơn hàng không thành công",
                                                      "isStatus": true,
                                                      "isFinal": true,
                                                    },
                                                  ],
                                                  onPressed: () async {
                                                    // await customer
                                                    //     .getDetailCustomer(customer
                                                    //             .listAllCustomer[
                                                    //                 index]
                                                    //             .id ??
                                                    //         1);
                                                    // await customer.getCustomerId(
                                                    //     context,
                                                    //     customer
                                                    //             .listAllCustomer[
                                                    //                 index]
                                                    //             .id ??
                                                    //         1);
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .customerDetailScreen,
                                                      // arguments: customer
                                                      //         .listAllCustomer[
                                                      //     index],
                                                    );
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
                                "Tổng: ${pay.total}",
                                style: AppFonts.regular(14, AppThemes.dark2),
                                minFontSize: 8,
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: AppNumberPaging(
                                currentPage: pay.currentPage,
                                totalPage: ((pay.total / 5).ceil() > 0)
                                    ? (pay.total / 5).ceil()
                                    : 1,
                                onTap: (value) {
                                  AppFunction.hideKeyboard(context);
                                  setState(() {
                                    selectedPage = value;
                                  });
                                  pay.updatePage(value);

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
