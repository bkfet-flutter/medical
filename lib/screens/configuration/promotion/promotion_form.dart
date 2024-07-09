import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/product_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/promotion_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:provider/provider.dart';

class PromotionForm extends StatefulWidget {
  const PromotionForm({super.key});

  @override
  State<PromotionForm> createState() => _PromotionFormState();
}

class _PromotionFormState extends State<PromotionForm> {
  bool isLoading = false;
  List<ProductModel> listProduct = [];
  UserProvider user = UserProvider();
  PromotionProvider promotion = PromotionProvider();

  // void _callApiDetail(String? ids, String? branchId) async {
  //   if (!isLoading) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     var res = await ApiRequest.getProductForPromotion(ids, branchId);
  //     if (res.result == true) {
  //       for (var e in res.data) {
  //         listProduct.add(ProductModel.fromJson(e));
  //       }
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       if (context.mounted) {
  //         AppFunction.showDialogError(context, res.message ?? 'co loi bat ngo xay ra');
  //       }
  //     }
  //   }
  // }

  String? _checkNameProduct(String? id) {
    if (id != null) {
      List<String> list = [];
      List<String> listPro = [];
      list.addAll(id.split(","));
      for (var e in list) {
        String? select =
            listProduct.firstWhere((element) => element.id == e).name;
        if (select != null) {
          listPro.add(select);
        }
      }
      return listPro.join(", ");
    } else {
      return null;
    }
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    promotion = Provider.of<PromotionProvider>(context, listen: false);
    super.initState();
    //_callApiDetail(promotion.idsGiven, user.branch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3FAFF),
      body: Column(
        children: [
          Expanded(
            child: (isLoading)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppThemes.red0,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        promotion.promotionDetail.listPolicy!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 20),
                          child: (promotion.promotionDetail.method ==
                                  'GIFTING_PRODUCT_WHEN_BUY_PRODUCT')
                              ? CardDetailProduct(
                                  onPressed: () {},
                                  haveBorder: true,
                                  listData: [
                                    {
                                      "titleLeft": "Hàng/Nhóm hàng tặng",
                                      "titleRight": _checkNameProduct(promotion
                                          .promotionDetail
                                          .listPolicy?[index]
                                          .givenProductIds),
                                    },
                                    {
                                      "titleLeft": "Số lượng tặng",
                                      "titleRight": promotion
                                          .promotionDetail
                                          .listPolicy?[index]
                                          .givenProductQuantity
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Hàng/Nhóm hàng mua",
                                      "titleRight": _checkNameProduct(promotion
                                          .promotionDetail
                                          .listPolicy?[index]
                                          .purchaseProductIds),
                                    },
                                    {
                                      "titleLeft": "Số lượng mua",
                                      "titleRight": promotion.promotionDetail
                                          .listPolicy?[index].purchaseQuantity
                                          .toString(),
                                      "isFinal": true,
                                    },
                                  ],
                                )
                              : (promotion.promotionDetail.method ==
                                      'DISCOUNT_BILL')
                                  ? CardDetailProduct(
                                      onPressed: () {},
                                      haveBorder: true,
                                      listData: [
                                        {
                                          "titleLeft": "Tổng tiền hàng",
                                          "titleRight":
                                              AppFunction.formatValueDiscount(
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .startPrice,
                                                  "VALUE"),
                                        },
                                        {
                                          "titleLeft": "Giảm giá hóa đơn",
                                          "titleRight":
                                              AppFunction.formatValueDiscount(
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .discountValue,
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .discountType),
                                          "isFinal": true,
                                        },
                                      ],
                                    )
                                  : (promotion.promotionDetail.method ==
                                          'GIFTING_PRODUCTS')
                                      ? CardDetailProduct(
                                          onPressed: () {},
                                          haveBorder: true,
                                          listData: [
                                            {
                                              "titleLeft": "Tổng tiền hàng",
                                              "titleRight": AppFunction
                                                  .formatValueDiscount(
                                                      promotion
                                                          .promotionDetail
                                                          .listPolicy?[index]
                                                          .startPrice,
                                                      "VALUE"),
                                            },
                                            {
                                              "titleLeft":
                                                  "Hàng/Nhóm hàng tặng",
                                              "titleRight": _checkNameProduct(
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .givenProductIds),
                                            },
                                            {
                                              "titleLeft": "Số lượng tặng",
                                              "titleRight": promotion
                                                  .promotionDetail
                                                  .listPolicy?[index]
                                                  .givenProductQuantity
                                                  .toString(),
                                              "isFinal": true,
                                            },
                                          ],
                                        )
                                      : CardDetailProduct(
                                          onPressed: () {},
                                          haveBorder: true,
                                          listData: [
                                            {
                                              "titleLeft": "Hàng/Nhóm hàng mua",
                                              "titleRight": _checkNameProduct(
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .purchaseProductIds),
                                            },
                                            {
                                              "titleLeft": "Số lượng mua",
                                              "titleRight": promotion
                                                  .promotionDetail
                                                  .listPolicy?[index]
                                                  .purchaseQuantity
                                                  .toString(),
                                            },
                                            {
                                              "titleLeft": "Giảm giá",
                                              "titleRight": AppFunction
                                                  .formatValueDiscount(
                                                      promotion
                                                          .promotionDetail
                                                          .listPolicy?[index]
                                                          .discountValue,
                                                      promotion
                                                          .promotionDetail
                                                          .listPolicy?[index]
                                                          .discountType),
                                            },
                                            {
                                              "titleLeft":
                                                  "Hàng/Nhóm hàng được giảm giá",
                                              "titleRight": _checkNameProduct(
                                                  promotion
                                                      .promotionDetail
                                                      .listPolicy?[index]
                                                      .discountProductIds),
                                              "isFinal": true,
                                            },
                                          ],
                                        ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
