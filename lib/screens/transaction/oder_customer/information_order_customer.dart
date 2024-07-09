import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/pay_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/oder_provider.dart';
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
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

// InformationCustomerPayScreen
class InformationCustomerOrderScreen extends StatefulWidget {
  const InformationCustomerOrderScreen({super.key});

  @override
  State<InformationCustomerOrderScreen> createState() =>
      _InformationCustomerOrderScreenState();
}

class _InformationCustomerOrderScreenState
    extends State<InformationCustomerOrderScreen>
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
    return Consumer2<OderCustomerProvider, PaymentHistoryProvider>(
      builder: (context, oder, payHistory, child) {
        return MepharWhiteAppbar(
          backgroundColor: const Color(0xffF3FAFF),
          isCheck: false,
          title: "Thông tin chi tiết đơn hàng",
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
                                "titleLeft": "Mã đơn hàng",
                                "titleRight": oder.oder?.code,
                              },
                              {
                                "titleLeft": "Người mua",
                                "titleRight": oder.oder?.customer?.fullName,
                              },
                              {
                                "titleLeft": "Trạng thái",
                                "titleRight": oder.oder?.status == "SUCCEED"
                                    ? "Đơn hàng thành công"
                                    : "Đang cập nhật",
                              },
                              {
                                "titleLeft": "Ghi chú",
                                "titleRight": oder.oder?.description,
                              },
                              // {
                              //   "titleLeft": "Tổng tiền sản phẩm",
                              //   "titleRight": pay.pay?.branch?.name,
                              // },
                              {
                                "titleLeft": "Tổng tiền thanh toán",
                                "titleRight":
                                    oder.oder?.cashOfCustomer.toString(),
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

                          Column(
                            children: List.generate(
                              oder.oder!.products!.length,
                              (index) => CardProductCheck(
                                numberCard: index,
                                onPressed: () {},
                                listData: [
                                  {
                                    "titleLeft": "Mã hàng",
                                    "titleRight": oder
                                        .oder?.products?[index].product?.code,
                                    "isTextBlue": true,
                                  },
                                  {
                                    "titleLeft": "Tên hàng",
                                    "titleRight": oder
                                        .oder?.products?[index].product?.name,
                                  },
                                  {
                                    "titleLeft": "Số lượng",
                                    "titleRight": oder
                                        .oder?.products?[index].quantity
                                        .toString(),
                                  },
                                  {
                                    "titleLeft": "Đơn giá",
                                    "titleRight": oder
                                        .oder?.products?[index].price
                                        .toString(),
                                  },
                                  {
                                    "titleLeft": "Giảm giá",
                                    "titleRight": oder
                                        .oder?.products?[index].discount
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
                                    "titleRight": oder
                                        .oder?.products?[index].price
                                        .toString(),
                                    "isFinal": true,
                                  },
                                ],
                              ),
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
                                        "titleRight": payHistory
                                            .listPaymentHistory[index].code,
                                        //payHistory
                                      },
                                      {
                                        "titleLeft": "Thời gian",
                                        "titleRight": payHistory
                                            .listPaymentHistory[index]
                                            .createdAt,
                                      },
                                      const {
                                        "titleLeft": "Người tạo",
                                        "titleRight": "",
                                      },
                                      {
                                        "titleLeft": "Giá trị phiếu",
                                        "titleRight": payHistory
                                            .listPaymentHistory[index]
                                            .totalAmount
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
                      alignment: Alignment.center,
                      child: Text(
                        "Đang cập nhật",
                        style: AppFonts.normalBold(
                          18,
                          Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
