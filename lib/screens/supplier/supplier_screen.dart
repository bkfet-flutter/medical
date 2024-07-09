import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SupplierProvider, BranchProvider>(
      builder: (context, supplier, branch, child) {
        return MepharWhiteAppbar(
          elevation: 4,
          title: "Nhà cung cấp",
          body: Container(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ItemSettingAccount(
                    onPressed: () {
                      supplier.clearList();
                      supplier.getDataSupplier(context, "", 1, 5);
                      supplier.getDataGroupSupplier(context, "", 1, 5);
                      branch.fetchBranches(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.listSupplierScreen,
                      );
                    },
                    icon: AppImages.iconSupplierGrey,
                    title: "Nhà cung cấp",
                    isArrow: true,
                  ),
                  ItemSettingAccount(
                    onPressed: () {
                      supplier.clearListGroup();
                      supplier.getDataGroupSupplier(context, "", 1, 5);
                      supplier.getDataSupplier(context, "", 1, 5);
                      branch.fetchBranches(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.groupSupplierScreen,
                      );
                    },
                    icon: AppImages.iconListSupplier,
                    title: "Nhóm nhà cung cấp",
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
