import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/dimens_scale.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/item_product.dart';
import 'package:mephar_app/widgets/item_setting.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_search.dart';
import 'package:provider/provider.dart';

class ChooseProductScreen extends StatefulWidget {
  const ChooseProductScreen({super.key});

  @override
  State<ChooseProductScreen> createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  void afterFirstLayout(BuildContext context) =>
      context.read<SellProvider>().fetchProductsSell(context, firstCall: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 60,
        title: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: HeaderButton(
                  iconColor: AppThemes.dark1,
                  icon: AppImages.iconArrowLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconHeight: DimensScale.getInstance(context)?.verticalScale(18),
                  iconWidth: DimensScale.getInstance(context)?.scale(9),
                ),
              ),
              Expanded(
                flex: 9,
                child: MepharSearch(
                  color: AppThemes.light2,
                  controllerSearch: context.watch<SellProvider>().keywordController,
                  onChanged: (value) => context.read<SellProvider>().fetchProductsSell(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<SellProvider>(
        builder: (context, provider, child) {
          return provider.loading
              ? const Center(child: CircularProgressIndicator(color: AppThemes.red0))
              : provider.listProductSell.isEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 52),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 93,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset(
                                  AppImages.imageAddProduct,
                                  width: 165,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -20,
                                  child: Image.asset(
                                    AppImages.buttonAddRed,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 52,
                            ),
                            Text(
                              "Chưa có sản phẩm nào!",
                              textAlign: TextAlign.center,
                              style: AppFonts.bold(16, AppThemes.dark0).copyWith(height: 20 / 16),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Thêm sản phẩm đầu tiên vào danh sách sản phẩm ngay nào",
                              textAlign: TextAlign.center,
                              style: AppFonts.bold(16, AppThemes.dark3).copyWith(height: 20 / 16),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MepharButton(
                              titleButton: "Thêm sản phẩm",
                              onPressed: () {
                                AppFunction.customBottomSheet(
                                  context: context,
                                  closeWhenTouch: true,
                                  title: "Thêm sản phẩm",
                                  body: ListView(
                                    children: [
                                      ItemSetting(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.addNewMedicineScreen,
                                          );
                                        },
                                        image: AppImages.imageAddMedicine,
                                        title: "Thêm mới thuốc",
                                        fit: BoxFit.fitHeight,
                                        isSale: true,
                                      ),
                                      ItemSetting(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.addNewProductScreen,
                                          );
                                        },
                                        image: AppImages.imageAddProduct,
                                        title: "Thêm mới hàng hóa",
                                        isSale: true,
                                        isFinall: true,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: AppThemes.blue4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                    left: 20,
                                  ),
                                  child: Text(
                                    "${provider.total} sản phẩm",
                                    style: AppFonts.regular(14, AppThemes.dark3).copyWith(height: 18 / 14),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: provider.listProductSell
                                      .map((e) => ItemProduct(
                                            isSelected: e.isSelected == true ? true : false,
                                            name: e.product?.name,
                                            code: e.code,
                                            price: e.price,
                                            inventory: e.quantity?.toInt(),
                                            image: e.product?.image?.path,
                                            unitName: e.unitName,
                                            onTap: () {
                                              setState(() {
                                                if (e.isSelected != true) {
                                                  e.isSelected = true;
                                                } else {
                                                  e.isSelected = false;
                                                }
                                              });
                                            },
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MepharButton(
                                    isButtonWhite: true,
                                    titleButton: "Chọn lại",
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, AppRoutes.chooseProductScreen);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: MepharButton(
                                  titleButton: "Xong",
                                  onPressed: () {
                                    List<InboundModel> list = provider.listProductSell
                                        .where((element) => element.isSelected == true)
                                        .toList();
                                    print(list.length);
                                    Navigator.pop(context, list);
                                  },
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
        },
      ),
    );
  }
}
