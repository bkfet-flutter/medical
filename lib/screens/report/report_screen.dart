import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MepharWhiteAppbar(
      elevation: 4,
      title: "Báo cáo",
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.reportCustomerScreen,
                  );
                },
                icon: AppImages.iconProfile,
                title: "Báo cáo khách hàng",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.reportSupplierScreen,
                  );
                },
                icon: AppImages.iconListSupplier,
                title: "Báo cáo nhà cung cấp",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.reportStaffScreen,
                  );
                },
                icon: AppImages.iconProfile,
                title: "Báo cáo nhân viên",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.reportSaleScreen,
                  );
                },
                icon: AppImages.iconShoppingBag,
                title: "Báo cáo bán hàng",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.reportProductScreen,
                  );
                },
                icon: AppImages.iconUserTag,
                title: "Báo cáo sản phẩm",
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
  }
}
