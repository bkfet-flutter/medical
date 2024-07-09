import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/doctor_provider.dart';
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
import 'package:provider/provider.dart';

class ListDoctorScreen extends BaseScreen {
  const ListDoctorScreen({super.key});

  @override
  ListDoctorScreenState createState() => ListDoctorScreenState();
}

class ListDoctorScreenState extends BaseState<ListDoctorScreen>
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

  callApi(BuildContext context) async {
    showLoading();
    isCheck = false;
    for (var i = 0; i < check.length; i++) {
      check[i] = false;
    }
    Provider.of<DoctorProvider>(context, listen: false).listDoctor.clear();
    String getDataDoctor =
        await Provider.of<DoctorProvider>(context, listen: false)
            .getListDoctor();
    if (getDataDoctor == "success" && context.mounted) {
      hideLoading();
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataDoctor,
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
    String getDataDoctor =
        await Provider.of<DoctorProvider>(context, listen: false)
            .getListDoctor();
    if (getDataDoctor == "success" && context.mounted) {
      hideLoading();
      // _controller.navigateToPage(0);
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getDataDoctor,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    callApi(context);
    // isCheck = false;
    // for (var i = 0; i < check.length; i++) {
    //   check[i] = false;
    // }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, doctor, child) {
        return RefreshIndicator(
          onRefresh: () => callApiRefresh(),
          child: MepharBigAppbar(
            controllerSearch: controllerSearch,
            onChanged: (value) async {
              // if (value.isEmpty == true) {
              showLoading();

              String getDataDoctor = await doctor.getListDoctor(
                  keyword: value, limit: 10, page: selectedPage);
              if (getDataDoctor == "success" && context.mounted) {
                hideLoading();
              } else {
                if (context.mounted) {
                  hideLoading();
                  AppFunction.showDialogError(context, getDataDoctor,
                      textButton: "Đóng", title: "Thông báo lỗi");
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
            // haveOneIcon: true,
            // haveIconNearSearch: true,
            haveSuffixSearch: false,
            floatingActionButton: doctor.listDoctor.isNotEmpty
                ? MepharFloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.addDoctorScreen,
                      );
                    },
                    heroTag: 'addDoctorScreen',
                  )
                : const SizedBox.shrink(),
            icon: AppImages.iconMoreVertical,
            title: "Bác sĩ",

            body: doctor.listDoctor.isEmpty
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
                            "Chưa có bác sĩ nào!",
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
                            "Thêm bác sĩ đầu tiên vào danh sách ngay nào",
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
                            titleButton: "Thêm bác sĩ",
                          )
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: doctor.listDoctor.isNotEmpty
                            ? Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 40,
                                          left: 40,
                                          top: 20,
                                          bottom: 17),
                                      child: SizedBox()
                                      // MepharCheckbox(
                                      //   onTap: () {
                                      //     AppFunction.hideKeyboard(context);
                                      //     setState(() {
                                      //       handel = "chon all";
                                      //       isCheck = !isCheck;
                                      //     });
                                      //   },
                                      //   isChecked: isCheck,
                                      //   text: "Bác sĩ",
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
                                            itemCount: doctor.listDoctor.length,
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
                                                      "titleLeft": "Mã bác sĩ",
                                                      "titleRight": doctor
                                                          .listDoctor[index]
                                                          .code,
                                                      "isTextBlue": true,
                                                    },
                                                    {
                                                      "titleLeft": "Tên bác sĩ",
                                                      "titleRight": doctor
                                                          .listDoctor[index]
                                                          .name,
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Số điện thoại",
                                                      "titleRight": doctor
                                                                  .listDoctor[
                                                                      index]
                                                                  .phone ==
                                                              ""
                                                          ? "Đang cập nhật"
                                                          : doctor
                                                                  .listDoctor[
                                                                      index]
                                                                  .phone ??
                                                              "Đang cập nhật",
                                                    },
                                                    {
                                                      "titleLeft":
                                                          "Chuyên khoa",
                                                      "titleRight": doctor
                                                              .listDoctor[index]
                                                              .specialist
                                                              ?.name ??
                                                          "Đang cập nhật",
                                                    },
                                                    {
                                                      "titleLeft": "Trình độ",
                                                      "titleRight": doctor
                                                              .listDoctor[index]
                                                              .level
                                                              ?.name ??
                                                          "Đang cập nhật",
                                                    },
                                                    {
                                                      "titleLeft": "Trạng thái",
                                                      "titleRight": doctor
                                                                  .listDoctor[
                                                                      index]
                                                                  .status ==
                                                              1
                                                          ? "Đang hoạt động"
                                                          : "Ngưng hoạt động",
                                                      "isStatus": doctor
                                                                  .listDoctor[
                                                                      index]
                                                                  .status ==
                                                              1
                                                          ? true
                                                          : false,
                                                      "isFinal": true,
                                                    },
                                                  ],
                                                  onPressed: () async {
                                                    await doctor
                                                        .getDetailCustomer(
                                                            doctor
                                                                    .listDoctor[
                                                                        index]
                                                                    .id ??
                                                                1);
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .doctorDetailScreen,
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
                                title: "Không tìm thấy bác sĩ  nào!",
                                content: "Hãy thử tìm những bác sĩ tương tự",
                              ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalText(
                              "Tổng: ${doctor.total}",
                              style: AppFonts.regular(14, AppThemes.dark2),
                              minFontSize: 8,
                              maxLines: 1,
                            ),
                            AppNumberPaging(
                              currentPage: doctor.currentPage,
                              totalPage: ((doctor.total / 10).ceil() > 0)
                                  ? (doctor.total / 10).ceil()
                                  : 1,
                              onTap: (value) {
                                AppFunction.hideKeyboard(context);
                                setState(() {
                                  selectedPage = value;
                                });
                                doctor.updatePage(value);

                                callApi(context);
                              },
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
