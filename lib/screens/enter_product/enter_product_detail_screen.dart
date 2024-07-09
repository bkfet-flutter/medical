import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/product_inbound_details_model.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:provider/provider.dart';

class EnterProductDetailScreen extends BaseScreen {
  final int id;

  const EnterProductDetailScreen({super.key, required this.id});

  @override
  EnterProductDetailScreenState createState() => EnterProductDetailScreenState();
}

class EnterProductDetailScreenState extends BaseState<EnterProductDetailScreen> with BaseScreenMixin {
  @override
  String setTitle() =>
      Provider.of<ImportProductProvider>(context, listen: false).productInboundModel.inbound?.code ?? '';

  @override
  TextStyle? setTextStyleTitle() => AppFonts.normalBold(18, AppThemes.dark1);

  @override
  Color? setHeaderBackgroundColor() => Colors.white;

  @override
  Color? setColorLeftWidget() => AppThemes.dark1;

  int getTotalQuantityOfOneProduct(List<ProductBatchHistories>? list) {
    int totalQuantity = 0;
    if (list == null || list.isEmpty) {
      return 0;
    } else {
      totalQuantity = list.fold(0, (previousValue, element) => previousValue + (element.quantity ?? 0));
    }
    return totalQuantity;
  }

  int getTotalAllQuantity(List<Products>? list) {
    int totalQuantity = 0;
    if (list == null || list.isEmpty) {
      return 0;
    }
    totalQuantity = list.fold(
        0, (previousValue, element) => previousValue + getTotalQuantityOfOneProduct(element.productBatchHistories));
    return totalQuantity;
  }

  callApi(BuildContext context, int id) => Future.wait([context.read<ImportProductProvider>().getDetails(context, id)]);

  @override
  void afterFirstLayout(BuildContext context) => callApi(context, widget.id);

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<ImportProductProvider>(builder: (context, product, child) {
      return Scaffold(
        backgroundColor: const Color(0xffF3FAFF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    CardDetailProduct(
                      onPressed: () {},
                      listData: [
                        {
                          "titleLeft": "Mã nhập hàng",
                          "titleRight": product.productInboundModel.inbound?.code,
                          "isTextBlue": true,
                        },
                        {
                          "titleLeft": "Thời gian",
                          "titleRight": product.productInboundModel.inbound?.createdAt,
                        },
                        {
                          "titleLeft": "Nhà cung cấp",
                          "titleRight": product.productInboundModel.inbound?.supplier?.name,
                        },
                        {
                          "titleLeft": "Cần trả NCC",
                          "titleRight": AppFunction.formatNum(product.productInboundModel.inbound?.totalPrice ?? 0)
                        },
                        {
                          "titleLeft": "Chi nhánh",
                          "titleRight": product.productInboundModel.inbound?.branch?.name,
                        },
                        {
                          "titleLeft": "Người trả",
                          "titleRight": product.productInboundModel.inbound?.user?.fullName,
                        },
                        {
                          "titleLeft": "Trạng thái",
                          "titleRight": product.mapStatus[product.productInboundModel.inbound?.status],
                          "isFinal": true,
                          "isStatus": true
                        },
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              product.productInboundModel.products == null
                  ? const SizedBox.shrink()
                  : product.productInboundModel.products!.isEmpty
                      ? const SizedBox.shrink()
                      : CardTotal(
                          heightBottom: 300,
                          widgetTop: Column(
                              children: List.generate(
                                  product.productInboundModel.products!.length,
                                  (index) => CardProductCheck(
                                        numberCard: index,
                                        onPressed: () {},
                                        listData: [
                                          {
                                            "titleLeft": "Mã hàng",
                                            "titleRight": product.productInboundModel.products![index].product?.code,
                                            "isTextBlue": true,
                                          },
                                          {
                                            "titleLeft": "Tên hàng",
                                            "titleRight": product.productInboundModel.products![index].product?.name,
                                          },
                                          {
                                            "titleLeft": "Số lượng",
                                            "titleRight": getTotalQuantityOfOneProduct(
                                                    product.productInboundModel.products![index].productBatchHistories)
                                                .toString()
                                          },
                                          {
                                            "titleLeft": "Giảm giá",
                                            "titleRight":
                                                product.productInboundModel.products![index].discount.toString(),
                                          },
                                          {
                                            "titleLeft": "Lô số",
                                            "titleRight": product.productInboundModel.products![index].price.toString(),
                                          },
                                          {
                                            "titleLeft": "Số lượng lô",
                                            "titleRight":
                                                product.productInboundModel.products![index].quantity.toString(),
                                          },
                                          {
                                            "titleLeft": "Hạn lô",
                                            "titleRight":
                                                product.productInboundModel.products![index].quantity.toString(),
                                          },
                                          {
                                            "titleLeft": "Giá nhập",
                                            "titleRight": product.productInboundModel.products![index].price.toString(),
                                          },
                                          {
                                            "titleLeft": "Thành tiền",
                                            "titleRight": AppFunction.formatNum(
                                                product.productInboundModel.products![index].price),
                                            "isFinal": true,
                                          },
                                        ],
                                      ))),
                          dataTotal: [
                              {
                                "titleLeft": "Tổng số lượng",
                                "titleRight": getTotalAllQuantity(product.productInboundModel.products).toString(),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Tổng số mặt hàng",
                                "titleRight": product.productInboundModel.products?.length.toString(),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Tổng cộng",
                                "titleRight":
                                    AppFunction.formatNum(product.productInboundModel.inbound?.totalPrice ?? 0),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Giảm giá",
                                "titleRight": AppFunction.formatNum(product.productInboundModel.inbound?.discount ?? 0),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Nợ",
                                "titleRight": AppFunction.formatNum((product.productInboundModel.inbound?.debt ?? 0)),
                                "maxLines": 1,
                                "isTextRed": true,
                              },
                              {
                                "titleLeft": "Tiền đã trả NCC",
                                "titleRight": AppFunction.formatNum(product.productInboundModel.inbound?.paid ?? 0),
                                "maxLines": 1,
                              },
                            ]),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MepharButton(
                      isButtonWhite: true,
                      onPressed: () => _deleteDialog(context, widget.id),
                      titleButton: "Huỷ",
                    ),
                  ),
                  Expanded(
                    child: MepharButton(
                      onPressed: () => _returnProduct(context),
                      titleButton: "Trả hàng nhập",
                      colorButton: AppThemes.green0,
                      colorTitle: AppThemes.white,
                    ),
                  ),
                ].addBetween(const SizedBox(width: 16), bound: true),
              ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      );
    });
  }

  void _deleteDialog(BuildContext context, int? id) => AppFunction.showDialogAlert(context,
      title: "Xóa đơn hàng nhập",
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
          Text(
            "Bạn có chắc chắn muốn xóa đơn này không?",
            textAlign: TextAlign.center,
            style: AppFonts.light(
              16,
              AppThemes.dark2,
            ),
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
      onPress2ndButton: () {
        Navigator.of(context, rootNavigator: true).pop();
        _delete(context, id);
      });

  _delete(BuildContext context, int? id) {
    if (id != null) {
      AppFunction.showLoading(context);
      context.read<ImportProductProvider>().delete(context, id).then((value) {
        AppFunction.hideLoading(context);
        if (value == true) {
          Navigator.pop(context, true);
        }
      });
    }
  }

  _returnProduct(BuildContext context) {
    AppFunction.showLoading(context);
    context.read<ImportProductProvider>().productReturn(context, status: "SUCCEED").then((value) {
      AppFunction.hideLoading(context);
      if (value == true) {
        Navigator.pushReplacementNamed(context, AppRoutes.returnProductScreen);
      }
    });
  }
}
