import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/shipping_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class GoodsShippedToScreen extends StatefulWidget {
  const GoodsShippedToScreen({super.key});

  @override
  State<GoodsShippedToScreen> createState() => _GoodsShippedToScreenState();
}

class _GoodsShippedToScreenState extends State<GoodsShippedToScreen> {
  int? branchId;
  int selectedPage = 1;
  callApi(BuildContext context) async {
    AppFunction.showLoading(context);
    String getData = await Provider.of<ShippingProvider>(context, listen: false)
        .getListShipping(context,
            keyword: "", page: selectedPage, limit: 10, status: "RECEIVED");
    if (getData == "success" && context.mounted) {
      AppFunction.hideLoading(context);
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(
          context,
          "Lỗi không xác định",
        );
      }
    }
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingProvider>(builder: (context, ship, child) {
      return MepharBigAppbar(
        onTapIconNearSearch: () {
          Navigator.pushNamed(
            context,
            AppRoutes.filterTransactionScreen,
          );
        },
        floatingActionButton: MepharFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.createTransactionBillScreen,
            );
          },
          heroTag: '',
        ),
        onChanged: (value) async {
          String getData = await ship.getListShipping(context,
              keyword: value,
              page: selectedPage,
              limit: 10,
              status: "RECEIVED");
          if (getData == "success" && context.mounted) {
          } else {
            if (context.mounted) {
              AppFunction.showDialogError(context, getData,
                  textButton: "Đóng", title: "Thông báo lỗi");
            }
          }
        },
        haveOneIcon: true,
        haveSuffixSearch: false,
        haveIconNearSearch: true,
        title: "Hàng chuyển đến",
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MepharCheckbox(
                isChecked: false,
                text: "Hàng chuyển đến",
                isCheckBoxRight: true,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ship.listShipping.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: ship.listShipping.length,
                      itemBuilder: (context, index) {
                        return CardProductCheck(
                          numberCard: index,
                          // haveIcon: true,
                          listData: [
                            {
                              "titleLeft": "Mã chuyển hàng",
                              "titleRight": ship.listShipping[index].code,
                            },
                            {
                              "titleLeft": "Từ chi nhánh",
                              "titleRight":
                                  ship.listShipping[index].fromBranch?.name,
                            },
                            {
                              "titleLeft": "Tới chi nhánh",
                              "titleRight":
                                  ship.listShipping[index].toBranch?.name,
                            },
                            {
                              "titleLeft": "Ngày chuyển",
                              "titleRight": ship.listShipping[index].movedAt,
                            },
                            {
                              "titleLeft": "Ngày nhận",
                              "titleRight":
                                  ship.listShipping[index].receivedAt ??
                                      "Đang cập nhật",
                            },
                            {
                              "titleLeft": "Trạng thái",
                              "titleRight":
                                  ship.listShipping[index].status == "RECEIVED"
                                      ? "Đã nhận"
                                      : "Đang cập nhật",
                              "isFinal": true,
                            },
                          ],
                          onPressed: () async {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.transactionBillDetailScreen,
                            );
                            await ship
                                .getDetail(ship.listShipping[index].id ?? 1);
                          },
                        );
                        //   CardDetailProduct(
                        //     onPressed: () {
                        //       Navigator.pushNamed(
                        //         context,
                        //         AppRoutes.goodsShippedDetailScreen,
                        //         arguments: listData1,
                        //       );
                        //     },
                        //     haveBorder: true,
                        //     listData: listData1,
                        //   ),
                        //   const SizedBox(
                        //     height: 12,
                        //   ),
                        //   CardDetailProduct(
                        //     onPressed: () {
                        //       Navigator.pushNamed(
                        //         context,
                        //         AppRoutes.goodsShippedDetailScreen,
                        //         arguments: listData1,
                        //       );
                        //     },
                        //     haveBorder: true,
                        //     listData: listData1,
                        //   )
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceMedium,
                vertical: AppDimens.spaceXSmall,
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: NormalText(
                      "Tổng: ${ship.total}",
                      style: AppFonts.regular(14, AppThemes.dark2),
                      minFontSize: 8,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: AppNumberPaging(
                      currentPage: ship.currentPage,
                      totalPage: ((ship.total / 10).ceil() > 0)
                          ? (ship.total / 5).ceil()
                          : 1,
                      onTap: (value) {
                        AppFunction.hideKeyboard(context);
                        setState(() {
                          selectedPage = value;
                        });
                        ship.updatePage(value);
                        callApi(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
