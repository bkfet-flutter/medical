import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class GroupCustomerScreen extends BaseScreen {
  const GroupCustomerScreen({super.key});

  @override
  GroupCustomerScreenState createState() => GroupCustomerScreenState();
}

class GroupCustomerScreenState extends BaseState<GroupCustomerScreen>
    with BaseScreenMixin {
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  TextEditingController controllerSearch = TextEditingController();
  String handel = "chon all";
  int selectedPage = 1;

  callApi(String? keyWord) async {
    AppFunction.hideKeyboard(context);
    showLoading();
    Provider.of<GroupCustomerProvider>(context, listen: false).changeChecked();
    Provider.of<GroupCustomerProvider>(context, listen: false).resetCheck();
    String getDataGroupCustomer =
        await Provider.of<GroupCustomerProvider>(context, listen: false)
            .getDataGroupCustomer(keyWord, selectedPage, 5);

    if (getDataGroupCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataGroupCustomer,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  callApiRefresh() async {
    showLoading();
    controllerSearch.clear();
    Provider.of<GroupCustomerProvider>(context, listen: false).changeChecked();
    Provider.of<GroupCustomerProvider>(context, listen: false).resetCheck();
    String getDataGroupCustomer =
        await Provider.of<GroupCustomerProvider>(context, listen: false)
            .getDataGroupCustomer("", 1, 5);

    if (getDataGroupCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataGroupCustomer,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  callApiDelete(String? id) async {
    showLoading();
    String getDeleteGroupCustomer =
        await Provider.of<GroupCustomerProvider>(context, listen: false)
            .deleteGroupCustomer(id);
    if (getDeleteGroupCustomer == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDeleteGroupCustomer,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    callApi(null);
    Provider.of<GroupCustomerProvider>(context, listen: false).changeChecked();
    Provider.of<GroupCustomerProvider>(context, listen: false).resetCheck();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<GroupCustomerProvider>(
      builder: (context, group, child) {
        return MepharBigAppbar(
          controllerSearch: controllerSearch,
          onChanged: (value) async {
            if (value.isEmpty == true) {
              showLoading();
              group.clearList();
              String getDataCustomer =
                  await group.getDataGroupCustomer("", 1, 5);
              if (getDataCustomer == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getDataCustomer,
                      textButton: "Đóng", title: "Thông báo lỗi");
                }
              }
            }
          },
          onFieldSubmitted: (String? search) async {
            String getDataGroupCustomer =
                await group.getDataGroupCustomer(search, 1, 5);

            if (getDataGroupCustomer == "success" && context.mounted) {
              // hideLoading();
              // _controller.navigateToPage(0);
            } else {
              if (context.mounted) {
                hideLoading();
                AppFunction.showDialogError(
                  context,
                  getDataGroupCustomer,
                  textButton: "Đóng",
                  title: "Thông báo lỗi",
                );
              }
            }
          },
          title: "Nhóm khách hàng",
          haveSuffixSearch: false,
          floatingActionButton: group.listGroupCustomer.isNotEmpty
              ? MepharFloatingActionButton(onPressed: () async {
                  AppFunction.hideKeyboard(context);
                  final reset = await Navigator.pushNamed(
                    context,
                    AppRoutes.addGroupCustomerScreen,
                  ) as bool;
                  print("reset $reset");
                  if (reset == true) {
                    callApi(null);
                    AppFunction.showDialogAlert(context,
                        customImage: Image.asset(
                          AppImages.notiSuccess,
                          width: 116,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        noDivider: true,
                        showBtnClose: true,
                        hideBtnBottom: true,
                        title: "Thành công",
                        styleTitle: AppFonts.normalBoldInter(
                          20,
                          AppThemes.green0,
                        ),
                        styleDescription: AppFonts.light(
                          16,
                          AppThemes.dark1,
                        ),
                        imageClose: AppImages.closeNormal,
                        description: "Thêm mới thành công");
                  }
                }, heroTag: '',)
              : const SizedBox.shrink(),
          body: group.listGroupCustomer.isEmpty
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
                                    onPressed: () {}, heroTag: '',))
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
                          onPressed: () async {
                            final reset = await Navigator.pushNamed(
                              context,
                              AppRoutes.addGroupCustomerScreen,
                            ) as bool;
                            if (reset == true) {
                              callApi(null);
                              AppFunction.showDialogAlert(context,
                                  customImage: Image.asset(
                                    AppImages.notiSuccess,
                                    width: 116,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  noDivider: true,
                                  showBtnClose: true,
                                  hideBtnBottom: true,
                                  title: "Thành công",
                                  styleTitle: AppFonts.normalBoldInter(
                                    20,
                                    AppThemes.green0,
                                  ),
                                  styleDescription: AppFonts.light(
                                    16,
                                    AppThemes.dark1,
                                  ),
                                  imageClose: AppImages.closeNormal,
                                  description: "Thêm mới thành công");
                            }
                          },
                          titleButton: "Tạo nhóm khách hàng",
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 40, left: 40, top: 20, bottom: 13),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: MepharCheckbox(
                              onTap: () {
                                AppFunction.hideKeyboard(context);
                                group.setChecked();
                                setState(() {
                                  handel = "chon all";
                                });
                              },
                              isChecked: group.isChecked,
                              text: "Khách hàng",
                              isCheckBoxRight: true,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  int count = 0;
                                  for (var i = 0; i < group.check.length; i++) {
                                    if (group.check[i] == true) {
                                      setState(() {
                                        count++;
                                      });
                                    }
                                  }
                                  if (count == 0 && group.isChecked == false) {
                                    AppFunction.showDialogAlert(context,
                                        customImage: Image.asset(
                                          AppImages.notiFail,
                                          width: 116,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                        noDivider: true,
                                        showBtnClose: true,
                                        hideBtnBottom: true,
                                        styleTitle: AppFonts.normalBoldInter(
                                          20,
                                          AppThemes.red0,
                                        ),
                                        title: "Thất bại",
                                        styleDescription: AppFonts.light(
                                          16,
                                          AppThemes.dark1,
                                        ),
                                        imageClose: AppImages.closeNormal,
                                        description:
                                            "Không có nhóm khách hàng nào để xóa, vui lòng chọn lại!");
                                  } else if (count == 0 ||
                                      group.isChecked == true) {
                                    AppFunction.showDialogAlert(context,
                                        title: "Xóa nhóm khách hàng",
                                        styleTitle:
                                            AppFonts.bold(20, AppThemes.dark0),
                                        showBtnClose: true,
                                        widgetDescription: Column(
                                          children: [
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Image.asset(
                                              AppImages.boyQuestion,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Text(
                                              "Bạn có chắc chắn muốn xóa sản tất cả nhóm khách hàng không?",
                                              style: AppFonts.light(
                                                16,
                                                AppThemes.dark2,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            )
                                          ],
                                        ),
                                        text1stButton: "Hủy",
                                        isTwoButton: true,
                                        onPress1stButton: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        text2ndButton: "Xóa",
                                        onPress2ndButton: () {
                                          // callApiDelete(group.listGroupCustomer[index].id.toString());

                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          AppFunction.showDialogAlert(context,
                                              customImage: Image.asset(
                                                AppImages.notiSuccess,
                                                width: 116,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ), onPressedClose: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            callApi(null);
                                          },
                                              noDivider: true,
                                              showBtnClose: true,
                                              hideBtnBottom: true,
                                              styleTitle:
                                                  AppFonts.normalBoldInter(
                                                20,
                                                AppThemes.green0,
                                              ),
                                              title: "Thành công",
                                              styleDescription: AppFonts.light(
                                                16,
                                                AppThemes.dark1,
                                              ),
                                              imageClose: AppImages.closeNormal,
                                              description: "Đã xóa thành công");
                                        });
                                  } else {
                                    AppFunction.showDialogAlert(context,
                                        title: "Xóa sản phẩm",
                                        styleTitle:
                                            AppFonts.bold(20, AppThemes.dark0),
                                        showBtnClose: true,
                                        widgetDescription: Column(
                                          children: [
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Image.asset(
                                              AppImages.boyQuestion,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text:
                                                        "Bạn có chắc chắn muốn xóa ",
                                                    style: AppFonts.light(
                                                      16,
                                                      AppThemes.dark2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: "$count",
                                                      style:
                                                          AppFonts.normalBold(
                                                        16,
                                                        AppThemes.dark1,
                                                      )),
                                                  TextSpan(
                                                    text: " nhóm khách hàng ?",
                                                    style: AppFonts.light(
                                                      16,
                                                      AppThemes.dark2,
                                                    ),
                                                  ),
                                                ])),
                                            const SizedBox(
                                              height: 24,
                                            )
                                          ],
                                        ),
                                        text1stButton: "Hủy",
                                        isTwoButton: true,
                                        onPress1stButton: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        text2ndButton: "Xóa",
                                        onPress2ndButton: () {
                                          // for (var i = 0; i < group.check.length; i++) {
                                          //   if (group.check[i] == true) {
                                          //     callApiDelete(group.listGroupCustomer[i].id);
                                          //   }
                                          // }
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          AppFunction.showDialogAlert(context,
                                              customImage: Image.asset(
                                                AppImages.notiSuccess,
                                                width: 116,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                              noDivider: true,
                                              showBtnClose: true,
                                              hideBtnBottom: true,
                                              onPressedClose: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            callApi(null);
                                          },
                                              styleTitle:
                                                  AppFonts.normalBoldInter(
                                                20,
                                                AppThemes.green0,
                                              ),
                                              title: "Thành công",
                                              styleDescription: AppFonts.light(
                                                16,
                                                AppThemes.dark1,
                                              ),
                                              imageClose: AppImages.closeNormal,
                                              description: "Đã xóa thành công");
                                        });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    AppImages.iconTrashGrey,
                                    height: 24,
                                    width: 24,
                                    color: AppThemes.red0,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: group.listGroupCustomer.length,
                            itemBuilder: (context, index) {
                              return CardProductCheck(
                                  haveIcon: true,
                                  onTapDelete: () {
                                    AppFunction.hideKeyboard(context);
                                    AppFunction.showDialogAlert(
                                      context,
                                      title: "Xóa nhóm khách hàng",
                                      styleTitle:
                                          AppFonts.bold(20, AppThemes.dark0),
                                      showBtnClose: true,
                                      widgetDescription: Column(
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Image.asset(
                                            AppImages.boyQuestion,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      "Bạn có chắc chắn muốn xóa nhóm khách hàng ",
                                                  style: AppFonts.light(
                                                    16,
                                                    AppThemes.dark2,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text:
                                                        "${group.listGroupCustomer[index].name}",
                                                    style: AppFonts.normalBold(
                                                      16,
                                                      AppThemes.dark1,
                                                    )),
                                                TextSpan(
                                                  text: " ?",
                                                  style: AppFonts.light(
                                                    16,
                                                    AppThemes.dark2,
                                                  ),
                                                ),
                                              ])),
                                          const SizedBox(
                                            height: 24,
                                          )
                                        ],
                                      ),
                                      text1stButton: "Hủy",
                                      isTwoButton: true,
                                      onPress1stButton: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      text2ndButton: "Xóa",
                                      onPress2ndButton: () async {
                                        ApiResponse resGroupCustomer =
                                            await ApiRequest
                                                .deleteGroupCustomer(group
                                                    .listGroupCustomer[index].id
                                                    .toString());
                                        if (resGroupCustomer.result == true) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          AppFunction.showDialogSuccess(context,
                                              content: "Đã xoá thành công");
                                          callApi(null);
                                        } else {
                                          AppFunction.showDialogError(
                                              context,
                                              resGroupCustomer.message ??
                                                  "Lỗi không xác định");
                                        }
                                      },
                                    );
                                  },
                                  onTapEdit: () async {
                                    AppFunction.hideKeyboard(context);
                                    await group.getDetailGroupCustomer(
                                        group.listGroupCustomer[index].id ?? 1);
                                    final checkEdit = await Navigator.pushNamed(
                                      context,
                                      AppRoutes.editGroupCustomerScreen,
                                    );
                                    if (checkEdit == true) {
                                      callApi(null);
                                      AppFunction.showDialogAlert(context,
                                          customImage: Image.asset(
                                            AppImages.notiSuccess,
                                            width: 116,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                          noDivider: true,
                                          showBtnClose: true,
                                          hideBtnBottom: true,
                                          styleTitle: AppFonts.normalBoldInter(
                                            20,
                                            AppThemes.green0,
                                          ),
                                          title: "Thành công",
                                          styleDescription: AppFonts.light(
                                            16,
                                            AppThemes.dark1,
                                          ),
                                          imageClose: AppImages.closeNormal,
                                          description: "Chỉnh sửa thành công");
                                    }
                                  },
                                  isCheck: handel == "chon all"
                                      ? group.isChecked
                                      : group.check[index],
                                  onTapCheckBox: () {
                                    AppFunction.hideKeyboard(context);
                                    if (group.isChecked == true) {
                                      group.oneFalse(index);
                                      group.changeChecked();
                                      setState(() {
                                        handel = "chon tung cai";
                                      });
                                    } else {
                                      group.changeCheck(index);
                                      group.changeChecked();
                                      setState(() {
                                        handel = "chon tung cai";
                                      });
                                    }
                                    group.setAllChecked();
                                  },
                                  numberCard: index,
                                  listData: [
                                    {
                                      "titleLeft": "Tên nhóm",
                                      "titleRight":
                                          group.listGroupCustomer[index].name,
                                      "isTextBlue": true,
                                    },
                                    {
                                      "titleLeft": "Mô tả",
                                      "titleRight": group
                                          .listGroupCustomer[index].description,
                                    },
                                    {
                                      "titleLeft": "Chiết khấu (%)",
                                      "titleRight":
                                          "${(group.listGroupCustomer[index].discount ?? 0).toString()}%",
                                    },
                                  ],
                                  onPressed: () {
                                    AppFunction.hideKeyboard(context);
                                  });
                            }),
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
                              "Tổng: ${group.total}",
                              style: AppFonts.regular(14, AppThemes.dark2),
                              minFontSize: 8,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: AppNumberPaging(
                              currentPage: group.currentPage,
                              totalPage: ((group.total / 5).ceil() > 0)
                                  ? (group.total / 5).ceil()
                                  : 1,
                              onTap: (value) {
                                AppFunction.hideKeyboard(context);
                                setState(() {
                                  selectedPage = value;
                                });
                                group.updatePage(value);

                                callApi("");
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
