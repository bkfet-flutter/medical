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

class ListSupplierScreen extends StatefulWidget {
  const ListSupplierScreen({super.key});

  @override
  State<ListSupplierScreen> createState() => _ListSupplierScreenState();
}

class _ListSupplierScreenState extends State<ListSupplierScreen> {
  TextEditingController searchController = TextEditingController();
  String? keyword;
  int selectedPage = 1;
  callApi() async {
    AppFunction.showLoading(context);

    await Provider.of<SupplierProvider>(context, listen: false)
        .getDataSupplier(context, "", selectedPage, 5);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(
      builder: (context, supplier, child) {
        return MepharBigAppbar(
            haveSuffixSearch: false,
            title: "Nhà cung cấp",
            controllerSearch: searchController,
            floatingActionButton: MepharFloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addSupplierScreen,
                );
              }, heroTag: 'add supplier',
            ),
            onChanged: (value) async {
              if (value.isEmpty == true) {
                supplier.clearList();

                await supplier.getDataSupplier(context, "", 5, 1);
              }
            },
            onFieldSubmitted: (String? search) async {
              setState(() {
                // Chuyển đổi khoảng trắng thành dấu cộng
                keyword = searchController.text.replaceAll(' ', '+');
              });
              await supplier.getDataSupplier(context, keyword, 1, 5);
            },
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MepharCheckbox(
                    isChecked: false,
                    text: "Nhà cung cấp",
                    isCheckBoxRight: true,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: supplier.listSupplier.length,
                      itemBuilder: (context, index) {
                        return CardProductCheck(
                            numberCard: index,
                            haveIcon: true,
                            listData: [
                              {
                                "titleLeft": "Mã nhà cung cấp",
                                "titleRight": supplier.listSupplier[index].code,
                                "isTextBlue": true,
                              },
                              {
                                "titleLeft": "Tên nhà cung cấp",
                                "titleRight": supplier.listSupplier[index].name,
                              },
                              {
                                "titleLeft": "Điện thoại",
                                "titleRight":
                                    supplier.listSupplier[index].phone,
                              },
                              {
                                "titleLeft": "Email",
                                "titleRight":
                                    supplier.listSupplier[index].email,
                              },
                              // {
                              //   "titleLeft": "Nợ cần trả hiện tại",
                              //   "titleRight": supplier
                              //       .listSupplier[index].
                              //       .toString(),
                              // },
                              // {
                              //   "titleLeft": "Tổng mua",
                              //   "titleRight": supplier
                              //       .listSupplier[index].totalMoneyPurchase
                              //       .toString(),
                              // },
                            ],
                            onTapDelete: () {
                              AppFunction.showDialogAlert(context,
                                  title: "Xóa nhà cung cấp",
                                  styleTitle:
                                      AppFonts.bold(20, AppThemes.dark0),
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
                                        "Bạn có chắc chắn muốn xóa nhà cung cấp ${supplier.listSupplier[index].name}?",
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  text2ndButton: "Xóa",
                                  onPress2ndButton: () async {
                                    ApiResponse res =
                                        await ApiRequest.deleteSupplier(
                                            supplier.listSupplier[index].id);
                                    if (res.code == 200) {
                                      supplier.clearList();
                                      supplier.getDataSupplier(
                                          context, "", 1, 10);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    }
                                  });
                            },
                            onPressed: () async {
                              await supplier.getDetailSupplier(
                                  supplier.listSupplier[index].id ?? 1);
                              Navigator.pushNamed(
                                context,
                                AppRoutes.supplierDetailScreen,
                                // arguments: supplier.listSupplier[index],
                              );
                            });
                      }),
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
                          "Tổng: ${supplier.total}",
                          style: AppFonts.regular(14, AppThemes.dark2),
                          minFontSize: 8,
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: AppNumberPaging(
                          currentPage: supplier.currentPage,
                          totalPage: ((supplier.total / 5).ceil() > 0)
                              ? (supplier.total / 5).ceil()
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
            ));
      },
    );
  }
}
