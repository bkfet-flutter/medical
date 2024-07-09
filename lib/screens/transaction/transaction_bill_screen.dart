import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_product_check.dart';
import 'package:mephar_app/widgets/item_setting.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_floating_action_button.dart';
import 'package:provider/provider.dart';

import '../../resource/images/app_images.dart';

class TransactionBillScreen extends StatefulWidget {
  const TransactionBillScreen({super.key});

  @override
  State<TransactionBillScreen> createState() => _TransactionBillScreenState();
}

class _TransactionBillScreenState extends State<TransactionBillScreen> {
  int selectedPage = 1;
  // callApi() async {
  //   AppFunction.showLoading(context);
  //   String getDataCustomer =
  //       await Provider.of<PayCustomerProvider>(context, listen: false)
  //           .getListPayCustomer("", selectedPage, 5, "", 10);
  //   if (getDataCustomer == "success" && context.mounted) {
  //     AppFunction.hideLoading(context);
  //   } else {
  //     if (context.mounted) {
  //       AppFunction.hideLoading(context);
  //       AppFunction.showDialogError(context, getDataCustomer,
  //           textButton: "Đóng", title: "Thông báo lỗi");
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PayCustomerProvider>(builder: (context, pay, child) {
      return MepharBigAppbar(
          haveSuffixSearch: false,
          onTapIconNearSearch: () {
            Navigator.pushNamed(
              context,
              AppRoutes.filterEnterProductScreen,
            );
          },
          title: "Hóa đơn",
          floatingActionButton: MepharFloatingActionButton(onPressed: () {
            AppFunction.customBottomSheet(
              context: context,
              closeWhenTouch: true,
              title: "Bán hàng",
              body: ListView(
                children: [
                  ItemSetting(
                    padding: const EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.createOrderDeliverScreen);
                    },
                    image: AppImages.iconOrder,
                    title: "Tạo đơn và giao hàng",
                    isSale: true,
                  ),
                  ItemSetting(
                    padding: const EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.createOrderCounterScreen);
                    },
                    image: AppImages.iconCreate,
                    title: "Tạo đơn tại quầy",
                    isSale: true,
                    isFinall: true,
                  )
                ],
              ),
            );
          }, heroTag: 'add bill',),
          haveIconNearSearch: true,
          haveOneIcon: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MepharCheckbox(
                    isChecked: false,
                    text: "Hóa đơn",
                    isCheckBoxRight: true,
                  ),
                ),

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pay.listPayCustomer.length,
                    itemBuilder: (context, index) {
                      return CardProductCheck(
                        listData: [
                          {
                            "titleLeft": "Mã hoá đơn",
                            "titleRight": pay.listPayCustomer[index].code,
                          },
                          {
                            "titleLeft": "Khách hàng",
                            "titleRight":
                                pay.listPayCustomer[index].customer?.fullName,
                          },
                          {
                            "titleLeft": "Tổng tiền hàng",
                            "titleRight": pay.listPayCustomer[index].totalPrice,
                          },
                          {
                            "titleLeft": "Giảm giá",
                            "titleRight": pay.listPayCustomer[index].discount,
                          },
                          {
                            "titleLeft": "Khách đã trả",
                            "titleRight":
                                pay.listPayCustomer[index].cashOfCustomer,
                          },
                          {
                            "titleLeft": "Thời gian",
                            "titleRight": pay.listPayCustomer[index].createdAt,
                            "isStatus": true,
                            "isFinal": true,
                          },
                        ],
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.transactionBillDetailScreen,
                            // arguments: listData1,
                          );
                        },
                        numberCard: 1,
                      );
                    }),

                // CardProductCheck(
                //     onPressed: () {
                //       Navigator.pushNamed(
                //         context,
                //         AppRoutes.transactionBillDetailScreen,
                //         arguments: listData1,
                //       );
                //     },
                //     listData: listData1),
                // const SizedBox(
                //   height: 12,
                // ),
                // CardProductCheck(
                //     onPressed: () {
                //       Navigator.pushNamed(
                //         context,
                //         AppRoutes.transactionBillDetailScreen,
                //         arguments: listData2,
                //       );
                //     },
                //     numberCard: 2,
                //     listData: listData2),
              ],
            ),
          ));
    });
  }
}
