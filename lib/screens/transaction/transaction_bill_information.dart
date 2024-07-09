import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/shipping_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/item_order.dart';

import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:provider/provider.dart';

class TransactionBillInformation extends BaseScreen {
  const TransactionBillInformation({super.key});

  @override
  TransactionBillInformationState createState() =>
      TransactionBillInformationState();
}

class TransactionBillInformationState
    extends BaseState<TransactionBillInformation> with BaseScreenMixin {
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<ShippingProvider>(builder: (context, ship, child) {
      return Scaffold(
        backgroundColor: const Color(0xffF3FAFF),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                "titleLeft": "Mã đơn chuyển hàng",
                                "titleRight": ship.detailShippingModel.code,
                              },
                              {
                                "titleLeft": "Từ chi nhánh",
                                "titleRight":
                                    ship.detailShippingModel.fromBranch?.name,
                              },
                              {
                                "titleLeft": "Ngày chuyển",
                                "titleRight": ship.detailShippingModel.movedAt,
                              },
                              {
                                "titleLeft": "Người tạo",
                                "titleRight": ship
                                    .detailShippingModel.movedByUser?.fullName,
                              },
                              {
                                "titleLeft": "Tới chi nhánh",
                                "titleRight":
                                    ship.detailShippingModel.toBranch?.name,
                              },
                              {
                                "titleLeft": "Ngày nhận",
                                "titleRight":
                                    ship.detailShippingModel.receivedAt ??
                                        "Đang cập nhật",
                              },
                              {
                                "titleLeft": "Ngày tạo",
                                "titleRight": ship.detailShippingModel.movedAt,
                              },
                              {
                                "titleLeft": "Ghi chú",
                                "titleRight": ship.detailShippingModel.note,
                              },
                              {
                                "titleLeft": "Trạng thái",
                                "titleRight":
                                    ship.detailShippingModel.status == "MOVING"
                                        ? "Đang vận chuyển"
                                        : "Đã nhận",
                                "isFinal": true,
                              },
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MepharDropDownButton(
                              hintText: "Người trả",
                              items: const ["Admin", "Người dùng"],
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const ItemOrder(
                            icon: AppImages.iconPenBlue,
                            title: "Thêm ghi chú",
                            isBlueText: false,
                          ),
                          Container(
                            color: const Color(0xffF3FAFF),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CardTotal(
                        heightBottom: 240,
                        widgetTop: Column(
                          children: List.generate(
                            ship.detailShippingModel.items!.length,
                            (index) => CardProductCheck(
                              numberCard: index,
                              onPressed: () {},
                              listData: [
                                {
                                  "titleLeft": "Mã hàng",
                                  "titleRight": ship.detailShippingModel
                                      .items?[index].product?.code,
                                  "isTextBlue": true,
                                },
                                {
                                  "titleLeft": "Tên hàng",
                                  "titleRight": ship.detailShippingModel
                                      .items?[index].product?.name,
                                },
                                {
                                  "titleLeft": "Số lượng",
                                  "titleRight": ship.detailShippingModel
                                      .items?[index].quantity
                                      .toString()
                                },
                                {
                                  "titleLeft": "Giảm giá",
                                  "titleRight": ship
                                      .detailShippingModel.items?[index].price
                                      .toString(),
                                },
                                {
                                  "titleLeft": "Số lượng nhận",
                                  "titleRight":
                                      ship.detailShippingModel.status ==
                                              "MOVING"
                                          ? "0"
                                          : ship.detailShippingModel
                                              .items?[index].quantity
                                              .toString(),
                                  "isFinal": true,
                                },
                              ],
                            ),
                          ),
                        ),
                        dataTotal: [
                          {
                            "titleLeft": "Tổng số mặt hàng",
                            "titleRight":
                                ship.detailShippingModel.totalItem.toString(),
                            "maxLines": 1,
                          },
                          {
                            "titleLeft": "Tổng số lượng chuyển",
                            "titleRight":
                                ship.detailShippingModel.totalItem.toString(),
                            "maxLines": 1,
                          },
                        ]),
                    const SizedBox(
                      height: 50,
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
                    ship.detailShippingModel.toBranch?.id ==
                            context.read<BranchProvider>().defaultBranch?.id
                        ? Expanded(
                            child: ItemActivityCard(
                            title: "Nhận hàng",
                            onPressed: () async {
                              ApiResponse res = await ApiRequest.getMoveById(
                                  ship.detailShippingModel.id ?? 0);
                            },
                          ))
                        : const SizedBox.shrink(),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Lưu",
                      icon: AppImages.iconPrinter,
                    )),
                    Expanded(
                        child: ItemActivityCard(
                      onPressed: () {},
                      title: "Hủy",
                      icon: AppImages.iconCloseCircle,
                      colorIcon: AppThemes.red0,
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
