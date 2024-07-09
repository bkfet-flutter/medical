import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/provider/payment_history_provider.dart';
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

class CustomerPayScreen extends BaseScreen {
  const CustomerPayScreen({super.key});

  @override
  CustomerPayScreenState createState() => CustomerPayScreenState();
}

class CustomerPayScreenState extends BaseState<CustomerPayScreen>
    with BaseScreenMixin {
  String? search;
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  int selectedPage = 1;
  bool isCheck = false;
  String handel = "chon all";
  String? statusOder;
  int? branchId;

  Map<String, String>? statusMap;

  var items = [
    "DRAFT",
    "PENDING",
    "CONFIRMING",
    "SHIPPING",
    "DELIVERING",
    "PAID",
    "CANCELLED",
    "SUCCEED"
  ];
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
  String? selectedOption;
  Future<void> showOptions(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          content: DropdownButton(
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) async {
              statusOder = value!;

              print(statusOder);
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
                      .getListPayCustomer("", selectedPage, 5, statusOder!, 10);
              if (getDataPayCustomer == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getDataPayCustomer,
                      textButton: "Đóng", title: "Thông báo lỗi");
                }
              }
              setState(() {});
              Navigator.pop(context);
              print(statusOder); // Đóng AlertDialog sau khi chọn mục
            },
          ),
        );
      },
    );
  }

  initData() {
    setState(() {});
    print(branchId);
  }

  callApi() async {
    showLoading();
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;
    branchId = branch?.id;
    setState(() {});
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
    Provider.of<PayCustomerProvider>(context, listen: false)
        .listPayCustomer
        .clear();
    String getDataPayCustomer =
        await Provider.of<PayCustomerProvider>(context, listen: false)
            .getListPayCustomer("", selectedPage, 5, "SUCCEED", branchId!);
    // String getDataPayHistory =
    //     await Provider.of<PaymentHistoryProvider>(context, listen: false)
    //         .getListPaymentHistory(id:);
    if (getDataPayCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        // ignore: use_build_context_synchronously
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
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<PayCustomerProvider, PaymentHistoryProvider>(
      builder: (context, pay, payHistory, child) {
        // double height = MediaQuery.of(context).size.height;
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) async {
              pay.listPayCustomer.clear();
              String getListPay = await pay.getListPayCustomer(
                  value, selectedPage, 10, "", branchId!);
              if (getListPay == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getListPay,
                      textButton: "Đóng", title: "Thông báo lỗi");
                }
              }
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
            // haveOneIcon: true,
            // haveIconNearSearch: true,
            haveSuffixSearch: false,
            onTapIconNearSearch: () {
              showOptions(context);
            },
            floatingActionButton: pay.listPayCustomer.isNotEmpty
                ? MepharFloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.createOrderCounterScreen,
                      );
                    },
                    heroTag: 'addCustomerScreen',
                  )
                : const SizedBox.shrink(),
            icon: AppImages.iconMoreVertical,
            title: "Hoá đơn",
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
                                  onPressed: () {},
                                  heroTag: '',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 43,
                          ),
                          Text(
                            "Chưa có khách hoá đơn nào!",
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
                            "Thêm hoá đơn đầu tiên vào danh sách ngay nào",
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
                            titleButton: "Tạo hoá đơn",
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
                                          bottom: 17),
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
                                      //   text: "Hoá đơn",
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
                                            itemCount:
                                                pay.listPayCustomer.length,
                                            itemBuilder: (context, index) {
                                              return CardProductCheck(
                                                  noCheckBox: true,
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
                                                  numberCard: index,
                                                  listData: [
                                                    {
                                                      "titleLeft": "Mã hoá đơn",
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
                                                      // "isStatus": pay
                                                      //             .listPayCustomer[
                                                      //                 index]
                                                      //             .status ==
                                                      //         "SUCCEED"
                                                      //     ? true
                                                      //     : false,
                                                      "isFinal": true,
                                                      "isTextBlue": true,
                                                    },
                                                  ],
                                                  onPressed: () async {
                                                    await pay
                                                        .getDetailPayCustomer(pay
                                                                .listPayCustomer[
                                                                    index]
                                                                .id ??
                                                            1);
                                                    await payHistory
                                                        .getListPaymentHistory(
                                                      id: pay
                                                              .listPayCustomer[
                                                                  index]
                                                              .id ??
                                                          1,
                                                      page: 1,
                                                      limit: 20,
                                                    );
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .informationCustomerPayScreen,
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
