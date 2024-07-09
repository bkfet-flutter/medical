import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class FilterReturnProductScreen extends StatelessWidget {
  const FilterReturnProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CustomerProvider, GroupCustomerProvider>(
      builder: (context, customer, group, child) {
        return MepharWhiteAppbar(
          elevation: 4,
          title: "Khách hàng",
          body: Container(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ItemSettingAccount(
                    onPressed: () async {
                      customer.clearList();
                      // await group.getDataGroupCustomer("", 1, 5);
                      // customer.getDataCustomer("", 10, 1);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.listCustomerScreen,
                      );
                    },
                    icon: AppImages.iconProfile,
                    title: "Khách hàng",
                    isArrow: true,
                  ),
                  ItemSettingAccount(
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.groupCustomerScreen,
                      );
                    },
                    icon: AppImages.iconListProfile,
                    title: "Nhóm khách hàng",
                    isArrow: true,
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
      },
    );
  }
}
