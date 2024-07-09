import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/batch_product_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/inventory_provider.dart';
import 'package:mephar_app/provider/product/product_provider.dart';
import 'package:mephar_app/provider/warehouse_card_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/product/product/general_information_product.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/dropdown_unit.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends BaseScreen {
  const DetailProductScreen({super.key});

  @override
  DetailProductScreenState createState() => DetailProductScreenState();
}

class DetailProductScreenState extends BaseState<DetailProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // int? index;
  double? numberUnit;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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

  String status(int status) {
    switch (status) {
      case 1:
        return "Nhập hàng";
      case 2:
        return "Đặt hàng";
      case 3:
        return "Trả hàng nhập";
      case 4:
        return "Đang cập nhật";
      case 5:
        return "Five";
      case 6:
        return "Six";
      default:
        return "Đang cập nhật";
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    initData();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer4<ProductProvider, WareHouseCradProvider, InventoryProvider,
        BatchProductProvider>(
      builder: (context, product, ware, inventory, batch, child) {
        return MepharWhiteAppbar(
          backgroundColor: Colors.white,
          ontapBack: () {
            Navigator.pop(context, {
              "checkDelete": false,
              "checkReset": false,
              "checkGo1": true,
            });
          },
          isCheck: false,
          title: "Chi tiết sản phẩm",
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffF3FAFF),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    product.detailProductModel.name ?? "",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.normalBold(
                      16,
                      AppThemes.dark1,
                    ).copyWith(height: 20 / 16),
                  ),
                ),
              ),
              Container(
                color: const Color(0xffF3FAFF),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TabBar(
                          controller: tabController,
                          labelColor: AppThemes.red0,
                          unselectedLabelColor: AppThemes.dark3,
                          indicator: const CustomTabIndicator(
                              color: AppThemes.red0, indicatorHeight: 4),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: "Thông tin chung",
                            ),
                            Tab(
                              text: "Thẻ kho",
                            ),
                            Tab(
                              text: "Tồn kho",
                            ),
                            // product.detailProductModel.type == 1
                            Tab(
                              text: "Lô/Hạn sử dụng",
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const GeneralInformationProduct(),
                    ware.listWareHouse.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                ware.listWareHouse.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: CardDetailProduct(
                                    haveBorder: true,
                                    onPressed: () {},
                                    listData: [
                                      {
                                        "titleLeft": "Chứng từ",
                                        "titleRight":
                                            ware.listWareHouse[index].code ??
                                                "Đang cập nhật",
                                      },
                                      {
                                        "titleLeft": "Phương thức",
                                        "titleRight": status(
                                            ware.listWareHouse[index].type ??
                                                8),
                                      },
                                      {
                                        "titleLeft": "Thời gian",
                                        "titleRight": ware.listWareHouse[index]
                                                .createdAt ??
                                            "Đang cập nhật",
                                      },
                                      {
                                        "titleLeft": "Đối tác",
                                        "titleRight":
                                            ware.listWareHouse[index].partner ??
                                                "Đang cập nhật",
                                      },
                                      {
                                        "titleLeft": "Số lượng",
                                        "titleRight": ware
                                            .listWareHouse[index].changeQty
                                            .toString(),
                                      },
                                      {
                                        "titleLeft": "Tồn cuối",
                                        "titleRight": ware
                                            .listWareHouse[index].remainQty
                                            .toString(),
                                        "isFinal": true,
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    inventory.listInventory.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                inventory.listInventory.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: CardDetailProduct(
                                    haveBorder: true,
                                    onPressed: () {},
                                    listData: [
                                      {
                                        "titleLeft": "Chi nhánh",
                                        "titleRight": inventory
                                            .listInventory[index].branch?.name,
                                      },
                                      {
                                        "titleLeft": "Tồn kho",
                                        "titleRight": inventory
                                            .listInventory[index].quantity
                                            .toString(),
                                      },
                                      const {
                                        "titleLeft": "Khách đặt hàng",
                                        "titleRight": "Đang cập nhật",
                                      },
                                      const {
                                        "titleLeft": "Dự kiến hết hàng",
                                        "titleRight": "Đang cập nhật",
                                      },
                                      const {
                                        "titleLeft": "Trạng thái",
                                        "titleRight": "Đang cập nhật",
                                        "isFinal": true,
                                      },
                                      // {
                                      //   "titleLeft": "Tồn cuối",
                                      //   "titleRight": ware
                                      //       .listWareHouse[index].remainQty
                                      //       .toString(),
                                      //   "isFinal": true,
                                      // },
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    product.detailProductModel.type == 1
                        ? SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                batch.listBatch.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: CardDetailProduct(
                                    cross: CrossAxisAlignment.center,
                                    haveBorder: true,
                                    onPressed: () {},
                                    listData: [
                                      {
                                        "titleLeft": "Lô/hạn sử dụng",
                                        "titleRight":
                                            batch.listBatch[index].name ??
                                                "Đang cập nhật",
                                      },
                                      {
                                        "titleLeft": "Ngày hết hạn",
                                        "titleRight": batch
                                                    .listBatch.isNotEmpty &&
                                                index < batch.listBatch.length
                                            ? batch.listBatch[index].expiryDate
                                            : "Đang cập nhật",
                                      },
                                      {
                                        "titleLeft": "Đơn vị",
                                        "isWidget": true,
                                        "widgetRight": SizedBox(
                                          width: 80,
                                          child: DropdownUnitButton(
                                            value: product
                                                        .detailProductModel
                                                        .productUnit
                                                        ?.isNotEmpty ==
                                                    true
                                                ? product.detailProductModel
                                                    .productUnit![0]
                                                : null,
                                            listItems: product
                                                    .detailProductModel
                                                    .productUnit ??
                                                [],
                                            onChange: (value) async {
                                              setState(() {
                                                batch.listBatch[index].value =
                                                    batch.listBatch[index]
                                                            .quantity! /
                                                        value!.exchangeValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      },
                                      {
                                        "titleLeft": "Số lượng",
                                        "titleRight": batch
                                                .listBatch[index].value
                                                ?.toInt()
                                                .toString() ??
                                            "12",
                                        "isFinal": true,
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
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
