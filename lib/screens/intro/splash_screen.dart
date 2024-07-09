import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLogged(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('logged') == true) {
      if (context.mounted) {
        bool getUserData = await Provider.of<UserProvider>(context, listen: false).getUser(context);
        if (getUserData == true && context.mounted) {
          AppFunction.hideLoading(context);
          Navigator.pushReplacementNamed(context, AppRoutes.homeMain);
        } else {
          if (context.mounted) {
            prefs.setBool('logged', false);
            AppFunction.showDialogError(context, "Phiên đăng nhập hết hạn", onPressButton: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
            });
          }
        }
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.onboardingScreen,
        );
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => checkLogged(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.splash,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
