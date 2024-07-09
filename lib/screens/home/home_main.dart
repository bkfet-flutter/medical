import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/app/constant.dart';
import 'package:mephar_app/model/config/permission_model.dart';
import 'package:mephar_app/provider/root_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/item_setting.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RootProvider>(builder: (context, root, child) {
      return Scaffold(
        backgroundColor: AppThemes.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          heroTag: "home",
          onPressed: () => _navigateSellScreen(context),
          child: Image.asset((AppImages.iconSell)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppThemes.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => index == 2 ? _navigateSellScreen(context) : root.pageChange(index),
            currentIndex: root.currentPage,
            iconSize: 24,
            selectedItemColor: AppThemes.red0,
            unselectedItemColor: AppThemes.dark2,
            selectedLabelStyle: _getStyleLabel(),
            unselectedLabelStyle: _getStyleLabel(),
            items: const [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppImages.iconHome)),
                  activeIcon: ImageIcon(AssetImage(AppImages.iconHomeRed)),
                  label: "Tổng quan"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppImages.iconBox)),
                  activeIcon: ImageIcon(AssetImage(AppImages.iconBoxRed)),
                  label: "Sản phẩm"),
              BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24), label: "Bán hàng"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppImages.iconMenu)),
                  activeIcon: ImageIcon(AssetImage(AppImages.iconNoteRed)),
                  label: "Đơn hàng"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppImages.iconCategory)),
                  activeIcon: ImageIcon(AssetImage(AppImages.iconCategoryRed)),
                  label: "Thêm"),
            ]),
        body: root.tabs[root.currentPage],
      );
    });
  }

  TextStyle _getStyleLabel() => const TextStyle(
        fontFamily: AppFonts.laTo,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 16 / 12,
      );

  void _navigateSellScreen(BuildContext context) {
    final check = AppFunction.checkPermission(context, model: "sale", permission: Permission.read);
    if (check) {
      AppFunction.customBottomSheet(
        context: context,
        closeWhenTouch: true,
        title: "Bán hàng",
        body: ListView(
          children: [
            // ItemSetting(
            //   padding: const EdgeInsets.all(10),
            //   onPressed: () {
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, AppRoutes.createOrderDeliverScreen);
            //   },
            //   image: AppImages.iconOrder,
            //   title: "Tạo đơn và giao hàng",
            //   isSale: true,
            // ),
            ItemSetting(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.createOrderCounterScreen);
              },
              image: AppImages.iconCreate,
              title: "Tạo đơn tại quầy",
              isSale: true,
              isFinall: true,
            )
          ],
        ),
      );
    }
  }
}
