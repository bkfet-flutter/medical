import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class GroupSupplierScreen extends StatefulWidget {
  const GroupSupplierScreen({super.key});

  @override
  State<GroupSupplierScreen> createState() => _GroupSupplierScreenState();
}

class _GroupSupplierScreenState extends State<GroupSupplierScreen> {
  TextEditingController controllerSreach = TextEditingController();
  String? keyword;
  int selectedPage = 1;
  callApi() async {
    AppFunction.showLoading(context);

    await Provider.of<SupplierProvider>(context, listen: false)
        .getDataGroupSupplier(context, "", selectedPage, 5)
        .whenComplete(() => null);
    AppFunction.hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(
      builder: (context, supplier, child) {
        return MepharBigAppbar(
          haveSuffixSearch: false,
          title: "Nhóm nhà cung cấp",
          floatingActionButton: MepharFloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.addGroupSupplierScreen,
              );
            }, heroTag: 'add group supplier',
          ),
          controllerSearch: controllerSreach,
          onChanged: (value) async {
            if (value.isEmpty == true) {
              supplier.clearList();

              await supplier.getDataGroupSupplier(context, "", 10, 1);
            }
          },
          onFieldSubmitted: (value) async {
            setState(() {
              // Chuyển đổi khoảng trắng thành dấu cộng
              keyword = controllerSreach.text.replaceAll(' ', '+');
            });

            await supplier.getDataGroupSupplier(context, keyword, 1, 5);
            print(keyword);
          },
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MepharCheckbox(
                  isChecked: false,
                  text: "Nhóm NCC",
                  isCheckBoxRight: true,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: supplier.listGroupSupplier.length,
                  itemBuilder: (context, index) {
                    return CardProductCheck(
                      haveIcon: true,
                      numberCard: index,
                      listData: [
                        {
                          "titleLeft": "Tên nhóm",
                          "titleRight": supplier.listGroupSupplier[index].name,
                          "isTextBlue": true,
                        },
                        {
                          "titleLeft": "Mô tả",
                          "titleRight":
                              supplier.listGroupSupplier[index].description,
                        },
                      ],
                      onPressed: () {},
                      onTapEdit: () async {
                        await supplier.getGroupSupplier(
                            supplier.listGroupSupplier[index].id ?? 1);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editGroupSupplier,
                        );
                        print(supplier.listGroupSupplier[index].id);
                      },
                      onTapDelete: () {
                        AppFunction.showDialogAlert(context,
                            title: "Xóa nhóm nhà cung cấp",
                            styleTitle: AppFonts.bold(20, AppThemes.dark0),
                            showBtnClose: false,
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
                                  "Bạn có chắc chắn muốn xóa nhóm nhà cung cấp ${supplier.listGroupSupplier[index].name}?",
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
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            text2ndButton: "Xóa",
                            onPress2ndButton: () async {
                              ApiResponse res =
                                  await ApiRequest.deleteGroupSupplier(
                                      supplier.listGroupSupplier[index].id);
                              if (res.code == 200) {
                                supplier.getDataGroupSupplier(
                                    context, "", 1, 10);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              }
                            });
                      },
                    );
                  },
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
                        "Tổng: ${supplier.totalGroup}",
                        style: AppFonts.regular(14, AppThemes.dark2),
                        minFontSize: 8,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: AppNumberPaging(
                        currentPage: supplier.currentPage,
                        totalPage: ((supplier.totalGroup / 5).ceil() > 0)
                            ? (supplier.totalGroup / 5).ceil()
                            : 1,
                        onTap: (value) {
                          AppFunction.hideKeyboard(context);
                          setState(() {
                            selectedPage = value;
                          });
                          supplier.updatePage(value);

                          callApi();
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
