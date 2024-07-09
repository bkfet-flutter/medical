import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/product/product_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/dropdown_unit.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:provider/provider.dart';

class GeneralInformationProduct extends StatefulWidget {
  const GeneralInformationProduct({Key? key}) : super(key: key);

  @override
  State<GeneralInformationProduct> createState() =>
      _GeneralInformationProductState();
}

class _GeneralInformationProductState extends State<GeneralInformationProduct> {
  String? codeProduct;
  String? priceProduct;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, product, child) {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardDetailProduct(
                    onPressed: () {},
                    listData: [
                      {
                        "titleLeft": "Mã hàng",
                        "titleRight":
                            codeProduct ?? product.detailProductModel.code,
                      },
                      {
                        "titleLeft": "Mã vạch",
                        "titleRight":
                            codeProduct ?? product.detailProductModel.barCode,
                      },
                      {
                        "titleLeft": "Nhóm hàng",
                        "titleRight":
                            product.detailProductModel.groupProduct?.name
                      },
                      {
                        "titleLeft": "Loại hàng",
                        "titleRight": product.detailProductModel.type == 1
                            ? "Thuốc"
                            : "Hàng hoá",
                      },
                      {
                        "titleLeft": "Tên viết tắt",
                        "titleRight": product.detailProductModel.shortName,
                      },
                      {
                        "titleLeft": "Tên hàng",
                        "titleRight": product.detailProductModel.name,
                      },
                      {
                        "titleLeft": "Giá bán",
                        "titleRight": AppFunction.formatNum(
                            product.detailProductModel.price),
                      },
                      {
                        "titleLeft": "Giá vốn",
                        "titleRight": AppFunction.formatNum(
                            product.detailProductModel.primePrice),
                      },
                      {
                        "titleLeft": "Trọng lượng",
                        "titleRight": product.detailProductModel.weight
                      },
                      {
                        "titleLeft": "Đường dùng",
                        "titleRight":
                            product.detailProductModel.productDosage?.name
                      },
                      {
                        "titleLeft": "Vị trí",
                        "titleRight":
                            product.detailProductModel.productPosition?.name,
                        "isFinal": true,
                      },
                      // {
                      //   "titleLeft": "Cảnh báo hết hạn",
                      //   "titleRight":
                      //       product.detailProductModel.warningExpiryDate,
                      //   "isFinal": true,
                      // },
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CardDetailProduct(
                    cross: CrossAxisAlignment.center,
                    onPressed: () {},
                    listData: [
                      {
                        "titleLeft": "Số đăng ký",
                        "titleRight": product.detailProductModel.registerNumber,
                      },
                      {
                        "titleLeft": "Hoạt chát",
                        "titleRight": product.detailProductModel.activeElement,
                      },
                      {
                        "titleLeft": "Hàm lượng",
                        "titleRight": product.detailProductModel.content,
                      },
                      {
                        "titleLeft": "Hãng sản xuất",
                        "titleRight":
                            product.detailProductModel.productManufacture?.name,
                      },
                      {
                        "titleLeft": "Nước sản xuất",
                        "titleRight": product.detailProductModel.country?.name,
                      },
                      {
                        "titleLeft": "Quy cách đóng gói",
                        "titleRight":
                            product.detailProductModel.packingSpecification,
                      },
                      {
                        "titleLeft": "Mô tả",
                        "titleRight": product.detailProductModel.description,
                      },
                      {
                        "titleLeft": "Danh sách đơn vị",
                        "isWidget": true,
                        "widgetRight": SizedBox(
                          width: 80,
                          child: DropdownUnitButton(
                            value: product.detailProductModel.productUnit
                                        ?.isNotEmpty ==
                                    true
                                ? product.detailProductModel.productUnit![0]
                                : null,
                            listItems:
                                product.detailProductModel.productUnit ?? [],
                            onChange: (value) async {
                              setState(() {
                                codeProduct = value?.code;
                                priceProduct = value?.price.toString();
                              });
                            },
                          ),
                        ),
                      },
                      {
                        "titleLeft": "Trạng thái",
                        "titleRight": product.detailProductModel.status == 1
                            ? "Đang hoạt động"
                            : "Ngưng kinh doanh",
                        "isFinal": true,
                      },
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            if (product.detailProductModel.barCode != null)
                              BarcodeWidget(
                                drawText: false,
                                barcode: Barcode.code128(escapes: true),
                                data: codeProduct ??
                                    product.detailProductModel.code!,
                                width: 335,
                                height: 100,
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              codeProduct ?? product.detailProductModel.code!,
                              style: AppFonts.regular(14, AppThemes.dark1),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xffF3FAFF),
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppDimens.spaceMediumLarge,
                bottom: AppDimens.spaceXSmall10,
                right: AppDimens.spaceXSmall10,
                left: AppDimens.spaceXSmall10,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: ItemActivityCard(
                    title: product.detailProductModel.status == 1
                        ? "Đang hoạt động"
                        : "Ngưng kinh doanh",
                    onPressed: () async {
                      AppFunction.showLoading(context);
                      ApiResponse res = await ApiRequest.changeStatusProduct(
                        status: product.detailProductModel.status == 1 ? 0 : 1,
                        id: product.detailProductModel.id,
                      );
                      if (res.result == true) {
                        await product.fetchProducts(context, firstCall: true);
                        product.getDetail(product.detailProductModel.id ?? 1);
                        if (context.mounted) {
                          AppFunction.hideLoading(context);
                        } else {
                          AppFunction.hideLoading(context);
                        }
                      }
                    },
                  )),
                  Expanded(
                      child: ItemActivityCard(
                    onPressed: () {
                      if (product.detailProductModel.type == 1) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editMedicineScreen,
                        );
                      } else if (product.detailProductModel.type == 2) {
                        // product
                        //     .getDataProductById(product.detailProductModel.id);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editProductScreen,
                        );
                      } else {}
                    },
                    title: "Cập nhật",
                    icon: AppImages.iconPenRed,
                  )),
                  Expanded(
                      child: ItemActivityCard(
                    onPressed: () {
                      if (product.detailProductModel.type == 1) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.copyInformationMedicine,
                        );
                      } else if (product.detailProductModel.type == 2) {
                        // product
                        //     .getDataProductById(product.detailProductModel.id);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.copyInformationProduct,
                        );
                      } else {}
                    },
                    title: "Sao chép",
                    icon: AppImages.iconCopy,
                  )),
                  Expanded(
                    child: ItemActivityCard(
                      onPressed: () {
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
                                        text: "Bạn có chắc chắn muốn xóa ",
                                        style: AppFonts.light(
                                          16,
                                          AppThemes.dark2,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              product.detailProductModel.name ??
                                                  "",
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
                            onPress2ndButton: () async {
                              //
                              ApiResponse res =
                                  await ApiRequest.deleteProductById(
                                      product.detailProductModel.id);
                              if (res.result == true && context.mounted) {
                                context
                                    .read<ProductProvider>()
                                    .fetchProducts(context, firstCall: true);

                                Navigator.of(context).pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                AppFunction.showDialogError(context,
                                    res.message ?? "Lỗi không xác định");
                              }
                            });
                        context
                            .read<ProductProvider>()
                            .fetchProducts(context, firstCall: true);
                      },
                      title: "Xóa",
                      icon: AppImages.iconTrashGrey,
                      colorIcon: AppThemes.red0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
