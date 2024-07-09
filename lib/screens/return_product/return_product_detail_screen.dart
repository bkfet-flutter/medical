import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/product_return_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/item_order.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:provider/provider.dart';

class ReturnProductDetailScreen extends BaseScreen {
  final int? id;

  const ReturnProductDetailScreen(this.id, {super.key});

  @override
  ReturnProductDetailScreenState createState() => ReturnProductDetailScreenState();
}

class ReturnProductDetailScreenState extends BaseState<ReturnProductDetailScreen> with BaseScreenMixin {
  @override
  String setTitle() =>
      Provider.of<ProductReturnProvider>(context, listen: false).returnProductDetailsModel.purchaseReturn?.code ?? '';

  @override
  TextStyle? setTextStyleTitle() => AppFonts.normalBold(18, AppThemes.dark1);

  @override
  Color? setHeaderBackgroundColor() => Colors.white;

  @override
  Color? setColorLeftWidget() => AppThemes.dark1;

  @override
  Color setMainBackgroundColor() => const Color(0xffF3FAFF);

  callApi(BuildContext context, int? id) =>
      Future.wait([context.read<ProductReturnProvider>().getDetails(context, id)]);

  @override
  void afterFirstLayout(BuildContext context) => callApi(context, widget.id);

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<ProductReturnProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
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
                        "titleLeft": "Mã trả hàng nhập",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.code,
                        "isTextBlue": true,
                      },
                      {
                        "titleLeft": "Thời gian",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.createdAt,
                      },
                      {
                        "titleLeft": "Nhà cung cấp",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.supplier?.name,
                      },
                      {
                        "titleLeft": "Chi nhánh",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.branch?.name,
                      },
                      {
                        "titleLeft": "Người tạo",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.creator?.fullName,
                      },
                      {
                        "titleLeft": "Người trả",
                        "titleRight": provider.returnProductDetailsModel.purchaseReturn?.user?.fullName,
                      },
                      {
                        "titleLeft": "Trạng thái",
                        "titleRight": provider.mapStatus[provider.returnProductDetailsModel.purchaseReturn?.status],
                        "isFinal": true,
                        "isStatus": true
                      },
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: MepharDropDownButton(
                  //     hintText: "Người trả",
                  //     items: const ["Admin", "Người dùng"],
                  //     onChanged: (value) {
                  //       setState(() {});
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 7,
                  // ),
                  // const ItemOrder(
                  //   icon: AppImages.iconPenBlue,
                  //   title: "Thêm ghi chú",
                  //   isBlueText: false,
                  // ),
                  // Container(
                  //   color: const Color(0xffF3FAFF),
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            if (provider.returnProductDetailsModel.products != null)
              CardTotal(
                  heightBottom: 300,
                  widgetTop: Column(
                    children: provider.returnProductDetailsModel.products!
                        .map((e) => CardProductCheck(
                              noCheckBox: true,
                              numberCard: provider.returnProductDetailsModel.products!.indexOf(e),
                              onPressed: () {},
                              listData: [
                                {
                                  "titleLeft": "Mã hàng",
                                  "titleRight": e.product?.code,
                                  "isTextBlue": true,
                                },
                                {
                                  "titleLeft": "Tên hàng",
                                  "titleRight": e.product?.name,
                                },
                                {
                                  "titleLeft": "Số lượng",
                                  "titleRight": e.quantity.toString(),
                                },
                                {
                                  "titleLeft": "Giá nhập",
                                  "titleRight": AppFunction.formatNum(int.parse(e.importPrice ?? "0")),
                                },
                                {
                                  "titleLeft": "Giảm giá",
                                  "titleRight": AppFunction.formatNum(e.discount),
                                },
                                {
                                  "titleLeft": "Thành tiền",
                                  "titleRight": AppFunction.formatNum(e.totalPrice),
                                  "isFinal": true,
                                },
                              ],
                            ))
                        .toList(),
                  ),
                  dataTotal: [
                    {
                      "titleLeft": "Tổng số lượng",
                      "titleRight": provider.returnProductDetailsModel.products
                          ?.fold(0, (pre, e) => pre + (e.quantity ?? 0))
                          .toString(),
                      "maxLines": 1,
                    },
                    {
                      "titleLeft": "Tổng số mặt hàng",
                      "titleRight": provider.returnProductDetailsModel.products?.length.toString(),
                      "maxLines": 1,
                    },
                    {
                      "titleLeft": "Tổng cộng",
                      "titleRight":
                          AppFunction.formatNum(provider.returnProductDetailsModel.purchaseReturn?.totalPrice),
                      "maxLines": 1,
                    },
                    {
                      "titleLeft": "Giảm giá",
                      "titleRight": AppFunction.formatNum(provider.returnProductDetailsModel.purchaseReturn?.discount),
                      "maxLines": 1,
                    },
                    {
                      "titleLeft": "Tiền đã trả NCC",
                      "titleRight": AppFunction.formatNum(provider.returnProductDetailsModel.purchaseReturn?.paid),
                      "maxLines": 1,
                    },
                    {
                      "titleLeft": "Nợ",
                      "titleRight": AppFunction.formatNum(provider.returnProductDetailsModel.purchaseReturn?.debt),
                      "maxLines": 1,
                      "isTextRed": true,
                    },
                  ]),
            const SizedBox(
              height: 45,
            ),
            // Container(
            //   color: const Color(0xffF3FAFF),
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //       top: AppDimens.spaceMediumLarge,
            //       bottom: AppDimens.spaceXSmall10,
            //       right: AppDimens.spaceXSmall10,
            //       left: AppDimens.spaceXSmall10,
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //             child: ItemActivityCard(
            //           onPressed: () {},
            //           title: "In",
            //           icon: AppImages.iconPrinter,
            //         )),
            //         Expanded(
            //             child: ItemActivityCard(
            //           onPressed: () {},
            //           title: "Mở phiếu",
            //           icon: AppImages.iconBill,
            //           colorIcon: AppThemes.red0,
            //         )),
            //         Expanded(
            //             child: ItemActivityCard(
            //           onPressed: () {},
            //           title: "Trả hàng nhập",
            //           icon: AppImages.iconMoneySendRed,
            //         )),
            //         Expanded(
            //             child: ItemActivityCard(
            //           onPressed: () {},
            //           title: "Hủy",
            //           colorIcon: AppThemes.red0,
            //           icon: AppImages.iconCloseCircle,
            //         )),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
