import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/pay_customer_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MepharWhiteAppbar(
      elevation: 4,
      title: "Giao dịch",
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              ItemSettingAccount(
                onPressed: () async {
                  String getDataCustomer =
                      await Provider.of<PayCustomerProvider>(context,
                              listen: false)
                          .getListPayCustomer("", 1, 5, "", 10);
                  if (getDataCustomer == "success" && context.mounted) {
                    AppFunction.hideLoading(context);
                    Navigator.pushNamed(
                      context,
                      AppRoutes.customerPayScreen,
                    );
                  } else {
                    if (context.mounted) {
                      AppFunction.hideLoading(context);
                      AppFunction.showDialogError(context, getDataCustomer,
                          textButton: "Đóng", title: "Thông báo lỗi");
                    }
                  }
                },
                icon: AppImages.iconBill,
                title: "Hóa đơn",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.oderCustomerScreen,
                  );
                },
                icon: AppImages.iconReturn,
                title: "Đơn hàng",
                isArrow: true,
              ),
              // ItemSettingAccount(
              //   onPressed: () async {
              //     Navigator.pushNamed(
              //       context,
              //       AppRoutes.backBillScreen,
              //     );
              //   },
              //   icon: AppImages.iconReturn,
              //   title: "Khách trả hàng",
              //   isArrow: true,
              // ),
              ItemSettingAccount(
                onPressed: () {},
                icon: AppImages.iconShip,
                title: "Chuyển hàng",
                isArrow: true,
                isShow: true,
                isFinall: true,
                widgetAdd: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      ItemSettingAccount(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.goodsShippedToScreen,
                          );
                        },
                        icon: AppImages.iconShipIn,
                        title: "Hàng chuyển đến",
                      ),
                      ItemSettingAccount(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.goodsShippedScreen,
                          );
                        },
                        icon: AppImages.iconShipOut,
                        title: "Hàng chuyển đi",
                        isFinall: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Image.asset(
                AppImages.house,
                width: 262,
                height: 300,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
