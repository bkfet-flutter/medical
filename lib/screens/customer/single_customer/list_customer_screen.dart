import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/debt_customer_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/provider/purchase_history_provider.dart';
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

class ListCustomerScreen extends BaseScreen {
  const ListCustomerScreen({super.key});

  @override
  ListCustomerScreenState createState() => ListCustomerScreenState();
}

class ListCustomerScreenState extends BaseState<ListCustomerScreen> with BaseScreenMixin {
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

  callApi() async {
    showLoading();
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
    Provider.of<CustomerProvider>(context, listen: false).listAllCustomer.clear();
    String getDataCustomer =
        await Provider.of<CustomerProvider>(context, listen: false).getDataCustomer("", 10, selectedPage);
    if (getDataCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataCustomer, textButton: "Đóng", title: "Thông báo lỗi");
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
    String getDataCustomer = await Provider.of<CustomerProvider>(context, listen: false).getDataCustomer("", 10, 1);
    if (getDataCustomer == "success" && context.mounted) {
      hideLoading();
      // _controller.navigateToPage(0);
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataCustomer, textButton: "Đóng", title: "Thông báo lỗi");
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
    return Consumer5<CustomerProvider, GroupCustomerProvider, PurchaseHistoryProvider, BranchProvider,
        DebtCustomerProvider>(
      builder: (context, customer, groupcustomer, purchase, branch, debt, child) {
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) async {
              // if (value.isEmpty == true) {
              showLoading();

              String getDataCustomer = await customer.getDataCustomer(value, 10, selectedPage);
              if (getDataCustomer == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getDataCustomer, textButton: "Đóng", title: "Thông báo lỗi");
                }
              }
              // }
            },
            // onFieldSubmitted: (String? keyword) async {
            //   // showLoading()

            //   String getDataCustomer =
            //       await customer.getDataCustomer(keyword, 10, 1);

            //   if (getDataCustomer == "success" && context.mounted) {
            //     // hideLoading();
            //     // _controller.navigateToPage(0);
            //   } else {
            //     if (context.mounted) {
            //       hideLoading();
            //       AppFunction.showDialogError(
            //         context,
            //         getDataCustomer,
            //         textButton: "Đóng",
            //         title: "Thông báo lỗi",
            //       );
            //     }
            //   }
            // },
            haveOneIcon: true,
            haveIconNearSearch: true,
            haveSuffixSearch: false,
            icon: AppImages.iconMoreVertical,
            title: "Khách hàng",
            body: customer.listAllCustomer.isEmpty
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
                : Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: customer.listAllCustomer.isNotEmpty
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 40, left: 40, top: 20, bottom: 17),
                                        child: MepharCheckbox(
                                          onTap: () {
                                            AppFunction.hideKeyboard(context);
                                            setState(() {
                                              handel = "chon all";
                                              isCheck = !isCheck;
                                            });
                                          },
                                          isChecked: isCheck,
                                          text: "Khách hàng",
                                          isCheckBoxRight: true,
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: customer.listAllCustomer.length,
                                                itemBuilder: (context, index) {
                                                  return CardProductCheck(
                                                      isCheck: handel == "chon all" ? isCheck : check[index],
                                                      onTapCheckBox: () {
                                                        AppFunction.hideKeyboard(context);
                                                        if (isCheck == true) {
                                                          setState(() {
                                                            handel = "chon tung cai";
                                                            check[index] = false;
                                                            for (int i = 0; i < check.length; i++) {
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
                                                        isCheck = check.every((value) => value == true);
                                                      },
                                                      numberCard: index,
                                                      listData: [
                                                        {
                                                          "titleLeft": "Mã khách hàng",
                                                          "titleRight": customer.listAllCustomer[index].code,
                                                          "isTextBlue": true,
                                                        },
                                                        {
                                                          "titleLeft": "Tên khách hàng",
                                                          "titleRight": customer.listAllCustomer[index].fullName,
                                                        },
                                                        {
                                                          "titleLeft": "Số điện thoại",
                                                          "titleRight": customer.listAllCustomer[index].phone,
                                                        },
                                                        {
                                                          "titleLeft": "Nợ hiện tại",
                                                          "titleRight": AppFunction.formatNum(
                                                                  customer.listAllCustomer[index].totalDebt)
                                                              .toString(),
                                                        },
                                                        {
                                                          "titleLeft": "Tổng bán",
                                                          "titleRight": AppFunction.formatNum(
                                                              customer.listAllCustomer[index].totalOrderPay),
                                                        },
                                                        {
                                                          "titleLeft": "Trạng thái",
                                                          "titleRight":
                                                              customer.listAllCustomer[index].status == "active"
                                                                  ? "Đang hoạt động"
                                                                  : "Ngưng hoạt động",
                                                          "isStatus": customer.listAllCustomer[index].status == "active"
                                                              ? true
                                                              : false,
                                                          "isFinal": true,
                                                        },
                                                      ],
                                                      onPressed: () async {
                                                        await customer
                                                            .getDetailCustomer(customer.listAllCustomer[index].id ?? 1);
                                                        await purchase.getListPurchaseHistory(
                                                          branchId: branch.defaultBranch?.id,
                                                          customerId: customer.listAllCustomer[index].id ?? 1,
                                                          page: 1,
                                                          limit: 20,
                                                        );
                                                        await debt.getListDebt(
                                                          branchId: branch.defaultBranch?.id,
                                                          id: customer.listAllCustomer[index].id ?? 1,
                                                          page: 1,
                                                          limit: 20,
                                                        );

                                                        Navigator.pushNamed(
                                                          context,
                                                          AppRoutes.customerDetailScreen,
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
                              horizontal: 24,
                              vertical: AppDimens.spaceXSmall,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(
                                  "Tổng: ${customer.total}",
                                  style: AppFonts.regular(14, AppThemes.dark2),
                                  minFontSize: 8,
                                  maxLines: 1,
                                ),
                                AppNumberPaging(
                                  currentPage: customer.currentPage,
                                  totalPage: ((customer.total! / 10).ceil() > 0) ? (customer.total! / 10).ceil() : 1,
                                  onTap: (value) {
                                    AppFunction.hideKeyboard(context);
                                    setState(() {
                                      selectedPage = value;
                                    });
                                    customer.updatePage(value);

                                    callApi();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      customer.listAllCustomer.isNotEmpty
                          ? Positioned(
                              bottom: 60,
                              right: 20,
                              child: MepharFloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.addCustomerScreen,
                                  );
                                },
                                heroTag: 'add customer',
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
          ),
        );
      },
    );
  }
}
