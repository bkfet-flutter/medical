import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/oder_provider.dart';
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
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class OderCustomerScreen extends BaseScreen {
  const OderCustomerScreen({super.key});

  @override
  OderCustomerScreenState createState() => OderCustomerScreenState();
}

class OderCustomerScreenState extends BaseState<OderCustomerScreen>
    with BaseScreenMixin {
  String? search;

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  int selectedPage = 1;
  bool isCheck = false;
  String handel = "chon all";
  bool selection1 = true;
  bool selection2 = false;
  bool selection3 = false;
  bool selection4 = false;
  bool selection5 = false;
  bool selection6 = false;
  bool selection7 = false;
  bool selection8 = false;

  void resetSelection() {
    selection1 = false;
    selection2 = false;
    selection3 = false;
    selection4 = false;
    selection5 = false;
    selection6 = false;
    selection7 = false;
    selection8 = false;
  }

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
  int? branchId;

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
    Provider.of<OderCustomerProvider>(context, listen: false)
        .listOderCustomer
        .clear();
    String getDataPayCustomer =
        await Provider.of<OderCustomerProvider>(context, listen: false)
            .getListOderCustomer("", selectedPage, 5, branchId!);
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
    return Consumer<OderCustomerProvider>(
      builder: (context, oder, child) {
        // double height = MediaQuery.of(context).size.height;
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) async {
              showLoading();
              String getData = await oder.getListOderCustomer(
                  value, selectedPage, 10, branchId!);
              if (getData == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getData,
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
            haveOneIcon: true,
            // haveIconNearSearch: true,
            haveSuffixSearch: false,
            onTapIconNearSearch: () {
              AppFunction.customBottomSheet(
                context: context,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Trạng thái đơn hàng",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      MepharRadioButton(
                        title: "Đơn hàng đã huỷ",
                        isSelected: selection1,
                        onSelected: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                          print(selectedOption);
                        },
                      ),
                      MepharRadioButton(
                        title: "Đơn hàng hoàn trả",
                        isSelected: selectedOption == "Đơn hàng hoàn trả",
                        onSelected: (value) {
                          setState(() {
                            selectedOption = "PAID";
                          });
                        },
                      ),
                      // MepharRadioButton(
                      //   title: "Đơn hàng DELIVERING",
                      //   isSelected: selectedOption == "Đơn hàng DELIVERING",
                      //   onSelected: (value) {
                      //     setState(() {
                      //       selectedOption = "DELIVERING";
                      //     });
                      //     print(selectedOption);
                      //   },
                      // ),
                      // MepharRadioButton(
                      //   title: "Đơn hàng đang giao",
                      //   isSelected: selectedOption == "Đơn hàng đang giao",
                      //   onSelected: (value) {
                      //     setState(() {
                      //       selectedOption = "SHIPPING";
                      //     });
                      //     print(selectedOption);
                      //   },
                      // ),
                      // MepharRadioButton(
                      //   title: "Đơn hàng xác nhận",
                      //   isSelected: selectedOption == "Đơn hàng xác nhận",
                      //   onSelected: (value) {
                      //     setState(() {
                      //       selectedOption = "CONFIRMING";
                      //     });
                      //     print(selectedOption);
                      //   },
                      // ),
                      // MepharRadioButton(
                      //   title: "Đơn hàng tạm dừng",
                      //   isSelected: selectedOption == "Đơn hàng tạm dừng",
                      //   onSelected: (value) {
                      //     setState(() {
                      //       selectedOption = "PENDING";
                      //     });
                      //     print(selectedOption);
                      //   },
                      // ),
                      // MepharRadioButton(
                      //   title: "Đơn hàng rác",
                      //   isSelected: selectedOption == "Đơn hàng rác",
                      //   onSelected: (value) {
                      //     setState(() {
                      //       selectedOption = "DRAFT";
                      //     });
                      //     print(selectedOption);
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            },
            floatingActionButton: oder.listOderCustomer.isNotEmpty
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
            title: "Đơn hàng",
            body: oder.listOderCustomer.isEmpty
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
                            "Chưa có đơn hàng nào nào!",
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
                            "Thêm đơn hàng đầu tiên vào danh sách ngay nào",
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
                                AppRoutes.createOrderCounterScreen,
                              );
                            },
                            titleButton: "Tạo đơn hàng",
                          )
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: oder.listOderCustomer.isNotEmpty
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40,
                                        left: 40,
                                        top: 20,
                                        bottom: 17),
                                    child: MepharCheckbox(
                                      onTap: () {
                                        AppFunction.hideKeyboard(context);
                                        setState(() {
                                          handel = "chon all";
                                          isCheck = !isCheck;
                                        });
                                      },
                                      isChecked: isCheck,
                                      text: "Đơn hàng",
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
                                                oder.listOderCustomer.length,
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
                                                  numberCard: index,
                                                  listData: [
                                                    {
                                                      "titleLeft":
                                                          "Mã khách hàng",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .code,
                                                      "isTextBlue": true,
                                                    },
                                                    {
                                                      "titleLeft": "Người mua",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .customer
                                                          ?.fullName,
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Tổng số sản phẩm",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .totalProducts
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Tổng tiền thanh toán",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .totalPrice
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft": "Thời gian",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .createdAt,
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Khách đã trả",
                                                      "titleRight": oder
                                                          .listOderCustomer[
                                                              index]
                                                          .cashOfCustomer
                                                          .toString(),
                                                    },
                                                    {
                                                      "titleLeft": "Trạng thái",
                                                      "titleRight": oder
                                                                  .listOderCustomer[
                                                                      index]
                                                                  .status ==
                                                              "SUCCEED"
                                                          ? "Đơn hàng thành công"
                                                          : "Đơn hàng không thành công",
                                                      // "isStatus": true,
                                                      "isFinal": true,
                                                      "isTextBlue": true,
                                                    },
                                                  ],
                                                  onPressed: () async {
                                                    await oder
                                                        .getDetailOderCustomer(oder
                                                                .listOderCustomer[
                                                                    index]
                                                                .id ??
                                                            1);

                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .oderInformationCustomerScreen,
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
                                "Tổng: ${oder.total}",
                                style: AppFonts.regular(14, AppThemes.dark2),
                                minFontSize: 8,
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: AppNumberPaging(
                                currentPage: oder.currentPage,
                                totalPage: ((oder.total / 5).ceil() > 0)
                                    ? (oder.total / 5).ceil()
                                    : 1,
                                onTap: (value) {
                                  AppFunction.hideKeyboard(context);
                                  setState(() {
                                    selectedPage = value;
                                  });
                                  oder.updatePage(value);

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
