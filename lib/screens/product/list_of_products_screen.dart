import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/provider/batch_product_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/inventory_provider.dart';
import 'package:mephar_app/provider/product/product_provider.dart';
import 'package:mephar_app/provider/warehouse_card_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/item_product.dart';
import 'package:mephar_app/widgets/item_setting.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class ListOfProductScreen extends BaseScreen {
  const ListOfProductScreen({super.key});

  @override
  ListOfProductScreenState createState() => ListOfProductScreenState();
}

class ListOfProductScreenState extends BaseState<ListOfProductScreen>
    with BaseScreenMixin {
  String typeProduct = "";
  String typeStatus = "";
  String typeInventory = "";
  List<ProvinceModel> listTypeProduct = [
    ProvinceModel(id: 1, name: "Thuốc"),
    ProvinceModel(id: 2, name: "Hàng hoá"),
    ProvinceModel(id: 3, name: "Combo-đóng gói"),
  ];
  List<ProvinceModel> listStatus = [
    ProvinceModel(id: 1, name: "Hoạt động"),
    ProvinceModel(id: 2, name: "Ngừng hoạt động"),
  ];
  List<ProvinceModel> listTypeInventory = [
    ProvinceModel(id: 1, name: "Dưới định mức tồn"),
    ProvinceModel(id: 2, name: "Vượt định mức tồn"),
    ProvinceModel(id: 3, name: "Còn hàng trong kho"),
    ProvinceModel(id: 4, name: "Hết hàng trong kho"),
  ];

  @override
  Widget buildHeader() => const SizedBox.shrink();

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ProductProvider>().fetchProducts(
          context,
          firstCall: true,
        );
    initData();
  }

  int? branchId;
  initData() async {
    showLoading();
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;
    branchId = branch?.id;
    hideLoading();
    setState(() {});
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer4<ProductProvider, WareHouseCradProvider, InventoryProvider,
        BatchProductProvider>(
      builder: (context, product, ware, inventory, batch, child) {
        return MepharBigAppbar(
          haveBack: false,
          haveSuffixSearch: false,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          floatingActionButton: product.listAllProduct.isNotEmpty
              ? MepharFloatingActionButton(
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
                          ItemSetting(
                            onPressed: () {
                              Navigator.pop(context);

                              Navigator.pushNamed(
                                context,
                                AppRoutes.addNewComboProductScreen,
                              );
                            },
                            image: AppImages.imageAddProduct,
                            title: "Thêm mới Combo-Đóng gói",
                            isSale: true,
                            isFinall: true,
                          ),
                        ],
                      ),
                    );
                  },
                  heroTag: 'add product',
                )
              : const SizedBox.shrink(),
          // haveTwoIcon: true,
          title: "Danh sách sản phẩm",
          haveIconNearSearch: true,
          onChanged: (value) {
            context.read<ProductProvider>().fetchProducts(
                  context,
                  firstCall: true,
                  keyword: value,
                );
          },
          onTapIconNearSearch: () {
            AppFunction.customRightSheet(
              context: context,
              body: Material(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "Lọc sản phẩm",
                          style: TextStyle(
                            fontSize: 24,
                            decoration: null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Loại sản phẩm",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ObjectDropdownButton(
                        haveBorder: true,
                        listItems: listTypeProduct,
                        onChange: (value) {
                          setState(() {
                            typeProduct = value?.id.toString() ?? "";
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Trạng thái",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ObjectDropdownButton(
                        haveBorder: true,
                        listItems: listStatus,
                        onChange: (value) {
                          setState(() {
                            typeStatus = value?.id.toString() ?? "";
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Tồn kho",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ObjectDropdownButton(
                        haveBorder: true,
                        // hinText: "Loại sản phẩm",
                        listItems: listTypeInventory,
                        onChange: (value) {
                          setState(() {
                            typeInventory = value?.id.toString() ?? "";
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: const Text(
                                  "Xoá bộ lọc",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    typeStatus = "";
                                    typeProduct = "";
                                    typeInventory = "";
                                  });
                                  context.read<ProductProvider>().fetchProducts(
                                        context,
                                        firstCall: true,
                                      );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: const Text(
                                  "Lọc sản phẩm",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  context.read<ProductProvider>().fetchProducts(
                                        context,
                                        firstCall: true,
                                        status: typeStatus,
                                        type: typeProduct,
                                      );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          body: product.listAllProduct.isEmpty && !product.loading
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
                          style: AppFonts.bold(16, AppThemes.dark0)
                              .copyWith(height: 20 / 16),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Thêm sản phẩm đầu tiên vào danh sách sản phẩm ngay nào",
                          textAlign: TextAlign.center,
                          style: AppFonts.bold(16, AppThemes.dark3)
                              .copyWith(height: 20 / 16),
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
                                  ItemSetting(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.addNewComboProductScreen,
                                      );
                                    },
                                    image: AppImages.imageAddProduct,
                                    title: "Thêm mới Combo-Đóng gói",
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppThemes.blue4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${product.total} sản phẩm",
                                style: AppFonts.regular(14, AppThemes.dark3)
                                    .copyWith(height: 18 / 14),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      onTap: () => product.prevPage(context),
                                      child: Image.asset(
                                        AppImages.iconChevronRight,
                                        width: 6,
                                        height: 10,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${product.page}",
                                      style: AppFonts.normalBold(
                                          16, AppThemes.red0),
                                    ),
                                  ),
                                  Flexible(
                                      child: Text(
                                    "/${(product.totalPage)}",
                                    style: AppFonts.normalBold(
                                        16, AppThemes.dark3),
                                  )),
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  Flexible(
                                    child: InkWell(
                                      onTap: () => product.nextPage(context),
                                      child: Image.asset(
                                        AppImages.iconChevronLeft,
                                        width: 6,
                                        height: 10,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: product.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppThemes.red0,
                                ),
                              )
                            : ListView.builder(
                                itemCount: product.listAllProduct.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ItemProduct(
                                    onTap: () {
                                      product.getDetailProduct(context, index);
                                      ware.getListDebt(
                                        productId:
                                            product.listAllProduct[index].id,
                                        branchId: branchId,
                                        page: 1,
                                        limit: 50,
                                      );
                                      inventory.getListDebt(
                                          id: product.listAllProduct[index].id);
                                      batch.getListDebt(
                                        productId:
                                            product.listAllProduct[index].id,
                                        branchId: branchId,
                                        page: 1,
                                        limit: 50,
                                      );
                                    },
                                    image: product
                                        .listAllProduct[index].image?.path,
                                    name: product.listAllProduct[index].name,
                                    code: product.listAllProduct[index].code,
                                    price: product.listAllProduct[index].price,
                                    inventory:
                                        product.listAllProduct[index].inventory,
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
