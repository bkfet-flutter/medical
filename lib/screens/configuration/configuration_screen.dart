import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MepharWhiteAppbar(
      backgroundColor: Colors.white,
      elevation: 4,
      title: "Cấu hình",
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.storeInformationScreen,
                  );
                },
                icon: AppImages.iconShop,
                title: "Thông tin cửa hàng",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.branchManagementScreen,
                  );
                },
                icon: AppImages.iconManagement,
                title: "Quản lý chi nhánh",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.staffManagerScreen,
                  );
                },
                icon: AppImages.iconUserTag,
                title: "Nhân viên",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.delegationRoleScreen,
                  );
                },
                icon: AppImages.iconRole,
                title: "Phân quyền vai trò",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.configurationPromotionScreen,
                  );
                },
                icon: AppImages.iconGilf,
                title: "Khuyến mãi",
                isArrow: true,
              ),
              ItemSettingAccount(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.setUpPointScreen,
                  );
                },
                icon: AppImages.iconPoint,
                title: "Tích điểm",
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
