import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/promotion_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class ConfigurationPromotionScreen extends BaseScreen {
  const ConfigurationPromotionScreen({super.key});

  @override
  ConfigurationPromotionScreenState createState() => ConfigurationPromotionScreenState();
}

class ConfigurationPromotionScreenState extends BaseState<ConfigurationPromotionScreen> with BaseScreenMixin {
  TextEditingController controller = TextEditingController();

  final NumberPaginatorController controllerPaging = NumberPaginatorController();
  int page = 1;
  int total = 0;
  int size = 10;
  int countPage = 0;

  // List<PromotionPrProModel> listPromotion = [];

  initData() async {
    var promotion = Provider.of<PromotionProvider>(context, listen: false);
    AppFunction.showLoading(context);
    String status = await promotion.getListPromotion(search: "", limit: 10, page: 1);
    if (status == "success") {
      AppFunction.hideLoading(context);
    } else {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(context, "Lỗi không xác định");
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    initData();
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<PromotionProvider>(builder: (context, promotion, child) {
      return MepharBigAppbar(
        title: "Khuyến mại",
        controllerSearch: controller,
        onChanged: (value) {
          if (value.isEmpty) {
            controller.clear();
            // _getPage();
            setState(() {});
          }
        },
        onFieldSubmitted: (value) {
          // _getPage();
          setState(() {});
        },
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: NormalText(
                    "Tổng: $total",
                    style: AppFonts.regular(14, AppThemes.dark2),
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: NumberPaginator(
                    controller: controllerPaging,
                    initialPage: 0,
                    onPageChange: (int index) {
                      AppFunction.hideKeyboard(context);
                      setState(() {
                        page = index;
                      });
                      if (context.mounted) {
                        // _getPage();
                      }
                    },
                    numberPages: ((total / size).ceil() > 0) ? (total / size).ceil() : 1,
                    config: NumberPaginatorUIConfig(
                        height: 36,
                        buttonShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xffE0E2E7), width: 1.0),
                        ),
                        buttonSelectedForegroundColor: AppThemes.red0,
                        buttonUnselectedForegroundColor: const Color(0xff232325),
                        buttonUnselectedBackgroundColor: Colors.white,
                        buttonSelectedBackgroundColor: Colors.white,
                        contentPadding: const EdgeInsets.all(0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        haveIconNearSearch: true,
        haveSuffixSearch: false,
        backgroundColor: AppThemes.blueBackground,
        floatingActionButton: MepharFloatingActionButton(

          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              AppRoutes.addNewPromotionScreen,
            ) as bool?;
            if (result == true) {
              setState(() {
                page = 0;
              });
              controllerPaging.navigateToPage(0);
              if (mounted) {
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
                    description: "Tạo mới thành công");
              }
            }
          },
          heroTag: "add Promotion",
        ),
        body: (promotion.listPromotionProgram.isEmpty)
            ? const BlankPage(
                title: "Chưa có khuyến mãi nào",
                content: "Bấm vào (+) bên dưới để thêm mới",
              )
            : RefreshIndicator(
                color: AppThemes.red0,
                onRefresh: () async {
                  initData();
                },
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Danh sách sổ quỹ",
                            style: AppFonts.bold(
                              18,
                              AppThemes.dark1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: List.generate(
                              promotion.listPromotionProgram.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: CardDetailProduct(
                                      onPressed: () async {
                                        // Provider.of<PromotionProvider>(context,
                                        //         listen: false)
                                        //     .getDetailPromotion(
                                        //         listPromotion[index]);
                                        final result = await Navigator.pushNamed(
                                          context,
                                          AppRoutes.promotionDetailScreen,
                                        ) as bool?;
                                        if (result == true) {
                                          setState(() {
                                            page = 0;
                                          });
                                          controllerPaging.navigateToPage(0);
                                          if (mounted) {
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
                                                description: "Xóa khuyến mãi thành công");
                                          }
                                        }
                                      },
                                      listData: [
                                        {
                                          "titleLeft": "Mã chương trình",
                                          "titleRight": promotion.listPromotionProgram[index].id.toString(),
                                        },
                                        {
                                          "titleLeft": "Tên chương trình",
                                          "titleRight": promotion.listPromotionProgram[index].title,
                                        },
                                        {
                                          "titleLeft": "Từ ngày",
                                          "titleRight": promotion.listPromotionProgram[index].startTime,
                                        },
                                        {
                                          "titleLeft": "Đến ngày",
                                          "titleRight": promotion.listPromotionProgram[index].endTime,
                                        },
                                        // {
                                        //   "titleLeft": "Người tạo",
                                        //   "titleRight": context
                                        //       .watch<UserProvider>()
                                        //       .listAllUser
                                        //       .firstWhere((element) => element.uuid == listPromotion[index].createdBy)
                                        //       .fullName,
                                        // },
                                        // {
                                        //   "titleLeft": "Người tạo",
                                        //   "titleRight": context
                                        //       .watch<UserProvider>()
                                        //       .listAllUser
                                        //       .firstWhere((element) => element.uuid == listPromotion[index].createdBy)
                                        //       .fullName,
                                        // },
                                        {
                                          "titleLeft": "Trạng thái",
                                          "titleRight": promotion.listPromotionProgram[index].status == 1
                                              ? "Kích hoạt"
                                              : "Chưa áp dụng",
                                          "isStatus": true,
                                          "isFinal": true,
                                        },
                                        // {
                                        //   "titleLeft": "Hình thức khuyến mại",
                                        //   "titleRight": AppFunction.map[
                                        //       '${listPromotion[index].method}'],
                                        //   "isFinal": true,
                                        // },
                                      ],
                                      haveBorder: true,
                                    ),
                                  )),
                        ),
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
