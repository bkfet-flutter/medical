import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/item_setting.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSettingScreen extends StatelessWidget {
  const AddSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: const Color(0xffF3FAFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Image.asset(
                AppImages.backgroundHome,
                width: width,
                height: 120,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: (user.userModel.avatar?.path != null && user.userModel.avatar?.path != "")
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        '${ApiRequest.domain}${user.userModel.avatar?.path}',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                      child: Text(
                                        (user.userModel.fullName?[0] ?? ""),
                                        style: AppFonts.bold(20, Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.userModel.fullName ?? "",
                                  style: AppFonts.bold(14, Colors.white),
                                ),
                                Text(
                                  user.userModel.phone ?? "",
                                  style: AppFonts.bold(14, Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TouchableWidget(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            AppImages.iconEdit,
                            height: 24,
                            width: 24,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ItemSetting(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.cashBookScreen,
                          );
                        },
                        image: AppImages.iconCash,
                        title: "Sổ quỹ",
                      ),
                      // ItemSetting(
                      //   onPressed: () {
                      //     // Navigator.pushNamed(
                      //     //   context,
                      //     //   AppRoutes.reportScreen,
                      //     // );
                      //   },
                      //   image: AppImages.iconReport,
                      //   title: "Báo cáo",
                      // ),
                      ItemSetting(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.configurationScreen,
                          );
                        },
                        image: AppImages.buttonSetting,
                        title: "Cấu hình",
                        isFinall: true,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        // ItemSettingAccount(
                        //   onPressed: () {},
                        // ),
                        // ItemSettingAccount(
                        //   onPressed: () {
                        //     Navigator.pushNamed(
                        //       context,
                        //       AppRoutes.resetPasswordScreen,
                        //     );
                        //   },
                        //   icon: AppImages.iconPassCheck,
                        //   title: "Đổi mật khẩu",
                        // ),
                        ItemSettingAccount(
                          onPressed: () async {
                            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('logged', false);
                            prefs.remove('jwt');
                          },
                          icon: AppImages.iconLogout,
                          title: "Đăng xuất",
                          isFinall: true,
                          isTextRed: true,
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      );
    });
  }
}
