import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/pay_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/provider/payment_history_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/card_total.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/item_activity_card.dart';
import 'package:mephar_app/widgets/item_order.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

// InformationCustomerPayScreen
class InformationCustomerPayScreen extends StatefulWidget {
  const InformationCustomerPayScreen({super.key});

  @override
  State<InformationCustomerPayScreen> createState() =>
      _InformationCustomerPayScreenState();
}

class _InformationCustomerPayScreenState
    extends State<InformationCustomerPayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  String price(List<Products>? products) {
    double sum = 0;
    for (int i = 0; i < products!.length; i++) {
      sum = sum + products[i].price!;
    }
    return sum.toInt().toString();
  }

  String priceForSale(List<Products> products, int discount) {
    int sum = 0;
    for (int i = 0; i < products.length; i++) {
      sum = sum + products[i].price!;
    }
    return (sum - sum * (discount / 100)).toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PayCustomerProvider, PaymentHistoryProvider>(
      builder: (context, pay, payHistory, child) {
        return MepharWhiteAppbar(
          backgroundColor: const Color(0xffF3FAFF),
          isCheck: false,
          title: "Thông tin chi tiết hoá đơn",
          body: Column(
            children: [
              Container(
                color: const Color(0xffF3FAFF),
                child: TabBar(
                    controller: tabController,
                    labelColor: AppThemes.red0,
                    unselectedLabelColor: AppThemes.dark3,
                    indicator: const CustomTabIndicator(
                        color: AppThemes.red0, indicatorHeight: 4),
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        text: "Thông tin",
                      ),
                      Tab(
                        text: "Lịch sử thanh toán",
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          CardDetailProduct(
                            onPressed: () {},
                            listData: [
                              {
                                "titleLeft": "Mã hoá đơn",
                                "titleRight": pay.pay?.code,
                              },
                              {
                                "titleLeft": "Thời gian",
                                "titleRight": pay.pay?.createdAt,
                              },
                              {
                                "titleLeft": "Khách hàng",
                                "titleRight": pay.pay?.customer?.fullName ??
                                    "Đang cập nhật",
                              },
                              {
                                "titleLeft": "Ngày tạo",
                                "titleRight": pay.pay?.createdAt,
                              },
                              const {
                                "titleLeft": "Bảng giá",
                                "titleRight": "Bảng giá chung",
                              },
                              {
                                "titleLeft": "Chi nhánh",
                                "titleRight": pay.pay?.branch?.name,
                              },
                              {
                                "titleLeft": "Người bán",
                                "titleRight": pay.pay?.user?.fullName,
                              },
                              {
                                "titleLeft": "Người tạo",
                                "titleRight": pay.pay?.user?.fullName,
                              },
                              {
                                "titleLeft": "Ghi chú",
                                "titleRight": pay.pay?.description,
                              },
                              {
                                "titleLeft": "Trạng thái",
                                "titleRight": pay.pay?.status == "SUCCEED"
                                    ? "Đơn hàng thành công"
                                    : "Đang cập nhật",
                                "isFinal": true,
                              },
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          // const ItemOrder(
                          //   icon: AppImages.iconPenBlue,
                          //   title: "Thêm ghi chú",
                          //   isBlueText: false,
                          // ),
                          // Container(
                          //   color: const Color(0xffF3FAFF),
                          // ),
                          // pay.pay?.products == null
                          //     ? const SizedBox.shrink()
                          //     :
                          // List.generate(

                          CardTotal(
                            heightBottom: 240,
                            widgetTop: Column(
                              children: List.generate(
                                pay.pay!.products!.length,
                                (index) => CardProductCheck(
                                  numberCard: index,
                                  onPressed: () {},
                                  listData: [
                                    {
                                      "titleLeft": "Mã hàng",
                                      "titleRight": pay
                                          .pay?.products?[index].product?.code,
                                      "isTextBlue": true,
                                    },
                                    {
                                      "titleLeft": "Tên hàng",
                                      "titleRight": pay
                                          .pay?.products?[index].product?.name,
                                    },
                                    {
                                      "titleLeft": "Số lượng",
                                      "titleRight": pay
                                          .pay?.products?[index].quantity
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Đơn giá",
                                      "titleRight": pay
                                          .pay?.products?[index].price
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Giảm giá",
                                      "titleRight": pay
                                          .pay?.products?[index].discount
                                          .toString(),
                                    },
                                    // {
                                    //   "titleLeft": "Giá nhập",
                                    //   "titleRight": product
                                    //       .productInboundModel
                                    //       .products![index]
                                    //       .productBatchHistories?[0]
                                    //       .importPrice
                                    //       .toString(),
                                    // },
                                    {
                                      "titleLeft": "Thành tiền",
                                      "titleRight": pay
                                          .pay?.products?[index].price
                                          .toString(),
                                      "isFinal": true,
                                    },
                                  ],
                                ),
                              ),
                            ),
                            dataTotal: [
                              {
                                "titleLeft": "Tổng số lượng",
                                "titleRight": pay.pay?.totalProducts.toString(),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Tổng tiền hàng",
                                "titleRight": price(pay.pay?.products),
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Giảm giá hoá đơn",
                                "titleRight":
                                    "${pay.pay?.discount.toString()}%",
                                "maxLines": 1,
                              },
                              {
                                "titleLeft": "Khách cần trả",
                                "titleRight": priceForSale(
                                    pay.pay?.products ?? [],
                                    pay.pay?.discount ?? 0),
                                "maxLines": 1,
                                "isTextRed": true,
                              },
                              {
                                "titleLeft": "Khách đã trả",
                                "titleRight":
                                    pay.pay?.cashOfCustomer.toString(),
                                "maxLines": 1,
                              },
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          payHistory.listPaymentHistory.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: CardDetailProduct(
                              // onPressed: () {},
                              listData: [
                                {
                                  "titleLeft": "Mã phiếu",
                                  "titleRight":
                                      payHistory.listPaymentHistory[index].code,
                                  //payHistory
                                },
                                {
                                  "titleLeft": "Thời gian",
                                  "titleRight": payHistory
                                      .listPaymentHistory[index].createdAt,
                                },
                                const {
                                  "titleLeft": "Người tạo",
                                  "titleRight": "",
                                },
                                {
                                  "titleLeft": "Giá trị phiếu",
                                  "titleRight": payHistory
                                      .listPaymentHistory[index].totalAmount
                                      .toString(),
                                },
                                {
                                  "titleLeft": "Phương thức",
                                  "titleRight": payHistory
                                              .listPaymentHistory[index]
                                              .paymentMethod ==
                                          "CASH"
                                      ? "Tiền mặt"
                                      : "Chuyển khoản",
                                },
                                {
                                  "titleLeft": "Tiền thu/chi",
                                  "titleRight": payHistory
                                      .listPaymentHistory[index].amount,
                                },
                                {
                                  "titleLeft": "Trạng thái",
                                  "titleRight": payHistory
                                              .listPaymentHistory[index]
                                              .status ==
                                          "DONE"
                                      ? "Đơn hàng thành công"
                                      : "Đang cập nhật",
                                  "isFinal": true,
                                },
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
                      // Expanded(
                      //     child: ItemActivityCard(
                      //   onPressed: () async {
                      //     // await groupcustomer.getDataGroupCustomer("", 1, 20);
                      //     // // groupcustomer.
                      //     // Navigator.pushNamed(
                      //     //   context,
                      //     //   AppRoutes.editInformationCustomer,
                      //     // arguments: customer.customerDetail.id,
                      //     // );
                      //   },
                      //   title: "In phiếu",
                      //   icon: AppImages.iconPenRed,
                      // )),
                      // Expanded(
                      //   child: ItemActivityCard(
                      //     onPressed: () {},
                      //     title: "Trả hàng",
                      //     icon: AppImages.iconShieldGreen,
                      //   ),
                      // ),
                      Expanded(
                        child: ItemActivityCard(
                          onPressed: () {
                            AppFunction.showDialogAlert(context,
                                title: "Xóa hoá đơn",
                                styleTitle: AppFonts.bold(20, AppThemes.dark0),
                                showBtnClose: false,
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
                                      "Bạn có chắc chắn muốn xóa hoá đơn này",
                                      style: AppFonts.light(
                                        16,
                                        AppThemes.dark2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    )
                                  ],
                                ),
                                text1stButton: "Hủy",
                                isTwoButton: true,
                                onPress1stButton: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                text2ndButton: "Xóa",
                                onPress2ndButton: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  AppFunction.showLoading(context);
                                  ApiResponse res =
                                      await ApiRequest.deleteOrder(pay.pay?.id);
                                  if (res.code == 200) {
                                    pay.listPayCustomer.clear();
                                    await pay.getListPayCustomer(
                                        "", 1, 10, "", pay.pay?.branchId ?? 0);
                                    AppFunction.hideLoading(context);

                                    Navigator.of(context).pop();
                                  } else {
                                    AppFunction.hideLoading(context);
                                    AppFunction.showDialogError(
                                        context, res.message ?? "Lỗi");
                                  }
                                });
                          },
                          title: "Huỷ bỏ",
                          colorIcon: AppThemes.red0,
                          icon: AppImages.iconTrashGrey,
                        ),
                      ),
                    ],
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
