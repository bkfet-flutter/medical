import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/enter_product/filter_enter_product_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

class EnterProductScreen extends StatefulWidget {
  const EnterProductScreen({super.key});

  @override
  State<EnterProductScreen> createState() => _EnterProductScreenState();
}

class _EnterProductScreenState extends State<EnterProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => callApi(context));
  }

  callApi(BuildContext context) {
    Future.wait([context.read<ImportProductProvider>().fetchProductsInbound(context, firstCall: true)]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImportProductProvider>(builder: (context, product, child) {
      return MepharBigAppbar(
          controllerSearch: context.watch<ImportProductProvider>().keywordController,
          onFieldSubmitted: (value) => context.read<ImportProductProvider>().changePage(context, 1),
          onChanged: (value) => context.read<ImportProductProvider>().changePage(context, 1),
          haveSuffixSearch: false,
          onTapIconNearSearch: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FilterEnterProductScreen(
                  controller: context.watch<ImportProductProvider>().keywordController,
                ),
              ),
            );
          },
          title: "Nhập sản phẩm",
          haveIconNearSearch: true,
          haveOneIcon: true,
          body: Scaffold(
              body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: product.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppThemes.red0,
                            ),
                          )
                        : product.listProductInbound.isNotEmpty
                            ? Column(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 40, left: 40, top: 20, bottom: 17),
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         flex: 6,
                                  //         child: MepharCheckbox(
                                  //           onTap: () {
                                  //             AppFunction.hideKeyboard(context);
                                  //             // product.setChecked();
                                  //             // setState(() {
                                  //             //   handel = "chon all";
                                  //             // });
                                  //           },
                                  //           isChecked: true,
                                  //           text: "Danh mục thuốc",
                                  //           isCheckBoxRight: true,
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //           flex: 1,
                                  //           child: InkWell(
                                  //             onTap: () {},
                                  //             child: Container(
                                  //               alignment: Alignment.centerRight,
                                  //               child: Image.asset(
                                  //                 AppImages.iconTrashGrey,
                                  //                 height: 24,
                                  //                 width: 24,
                                  //                 color: AppThemes.red0,
                                  //               ),
                                  //             ),
                                  //           ))
                                  //     ],
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(bottom: 50, top: 20),
                                            itemCount: product.listProductInbound.length,
                                            itemBuilder: (context, index) {
                                              return CardProductCheck(
                                                  noCheckBox: true,
                                                  onTapDelete: () {
                                                    AppFunction.hideKeyboard(context);
                                                    AppFunction.showDialogAlert(context,
                                                        title: "Xóa sản phẩm",
                                                        styleTitle: AppFonts.bold(20, AppThemes.dark0),
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
                                                                    text: "Bạn có chắc chắn muốn xóa nhóm khách hàng ",
                                                                    style: AppFonts.light(
                                                                      16,
                                                                      AppThemes.dark2,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                      text: "",
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
                                                          Navigator.of(context, rootNavigator: true).pop();
                                                        },
                                                        text2ndButton: "Xóa",
                                                        onPress2ndButton: () {
                                                          // callApiDelete(product.listproductCustomer[index].id);
                                                          Navigator.of(context, rootNavigator: true).pop();

                                                          AppFunction.showDialogAlert(context,
                                                              customImage: Image.asset(
                                                                AppImages.notiSuccess,
                                                                width: 116,
                                                                height: 120,
                                                                fit: BoxFit.cover,
                                                              ),
                                                              noDivider: true,
                                                              showBtnClose: true,
                                                              hideBtnBottom: true, onPressedClose: () {
                                                            Navigator.of(context, rootNavigator: true).pop();
                                                            // callApi(null);
                                                          },
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
                                                              description: "Đã xóa thành công");
                                                        });
                                                  },
                                                  numberCard: index,
                                                  listData: [
                                                    {
                                                      "titleLeft": "Mã nhập hàng",
                                                      "titleRight": product.listProductInbound[index].code,
                                                    },
                                                    {
                                                      "titleLeft": "Thời gian",
                                                      "titleRight": product.listProductInbound[index].createdAt,
                                                    },
                                                    {
                                                      "titleLeft": "Nhà cung cấp",
                                                      "titleRight": product.listProductInbound[index].supplier?.name,
                                                    },
                                                    {
                                                      "titleLeft": "Cần trả NCC",
                                                      "titleRight":
                                                          product.listProductInbound[index].totalPrice.toString(),
                                                    },
                                                    {
                                                      "titleLeft": "Trạng thái",
                                                      "titleRight":
                                                          product.mapStatus[product.listProductInbound[index].status],
                                                      "isFinal": true,
                                                      "isStatus": true
                                                    },
                                                  ],
                                                  onPressed: () => context
                                                      .read<ImportProductProvider>()
                                                      .navigateDetails(context, product.listProductInbound[index].id));
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
                          color: AppThemes.white, border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tổng: ${context.watch<ImportProductProvider>().total}",
                            style: const TextStyle(
                                fontFamily: AppFonts.laTo,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.dark2),
                          ),
                          AppNumberPaging(
                            currentPage: context.watch<ImportProductProvider>().page,
                            totalPage: context.watch<ImportProductProvider>().totalPage,
                            onTap: (value) => context.read<ImportProductProvider>().changePage(context, value),
                          ),
                        ],
                      ))
                ],
              ),
              Positioned(
                bottom: 75,
                right: 15,
                child: MepharFloatingActionButton(
                  onPressed: () async {
                    final check = await Navigator.pushNamed(
                      context,
                      AppRoutes.createReceiptScreen,
                    );
                    if (check == true && context.mounted) {
                      callApi(context);
                    }
                  },
                  heroTag: 'add enter product',
                ),
              )
            ],
          )));
    });
  }
}
