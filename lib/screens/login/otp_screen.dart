import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends BaseScreen {
  const OtpScreen({super.key});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends BaseState<OtpScreen> with BaseScreenMixin {
  @override
  String setTitle() {
    return "Xác thực OTP";
  }

  @override
  Color? setHeaderBackgroundColor() {
    return AppThemes.red0;
  }

  @override
  Widget? buildRightWidget() {
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _isCountingDown = false; // Stop the countdown
    pinPutController.dispose(); // Dispose of the controller
    super.dispose();
  }

  late int _secondsLeft;
  bool _isCountingDown = true;
  Color colorText = AppThemes.dark0;
  String get timerText {
    int minutes = _secondsLeft ~/ 60;
    int seconds = _secondsLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startCountdown() async {
    while (_isCountingDown) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) {
        break; // Exit the loop if the widget is no longer mounted
      }
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft == 0) {
        _isCountingDown = false;
        colorText = AppThemes.dark0;
      }
    }
  }

  void _resetCountdown() {
    setState(() {
      _secondsLeft = 180;
      _isCountingDown = true;
      colorText = AppThemes.dark0;
    });
    _startCountdown();
  }

  @override
  void initState() {
    _resetCountdown();
    super.initState();
  }

  final defaultPinTheme = PinTheme(
    width: 44,
    height: 50,
    textStyle: AppFonts.normalBoldInter(
      24,
      AppThemes.dark0,
    ).copyWith(height: 32 / 24),
    decoration: BoxDecoration(
        border: const Border.fromBorderSide(
          BorderSide(
              width: 1, color: Color(0xffb8b8d2), style: BorderStyle.solid),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)),
  );

  final TextEditingController pinPutController = TextEditingController();
  @override
  Widget buildBody(BuildContext context) {
    final goHome = ModalRoute.of(context)!.settings.arguments as bool;
    return Container(
        margin: const EdgeInsets.all(20),
        color: const Color(0xFFF5F5FA),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 21,
                    ),
                    Text(
                      "Một mã xác thực đã được gửi tới sđt:",
                      style: AppFonts.light(
                        16,
                        AppThemes.dark1,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "0868666888",
                      style: AppFonts.normalBoldInter(16, AppThemes.red0),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Pinput(
                      length: 6,
                      autofocus: true,
                      defaultPinTheme: defaultPinTheme,
                      controller: pinPutController,
                      pinAnimationType: PinAnimationType.fade,
                    ),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Gửi lại OTP",
                  style: AppFonts.normalBold(16, AppThemes.red0),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  timerText,
                  style: AppFonts.normalBold(16, AppThemes.red0),
                ),
              ],
            ),
            const SizedBox(
              height: 67,
            ),
            MepharButton(
              onPressed: () {
                if (goHome) {
                  AppFunction.showDialogAlert(context,
                      title: "Thành công",
                      description: "Chúc mừng bạn đã tạo tài khoản thành công",
                      text1stButton: "Xong", onPress1stButton: () async {
                    ApiResponse res =
                        await ApiRequest.userLogin("12345678", "admin");
                    if (res.result == true) {
                      String token = res.data["accessToken"];
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('jwt', token);
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.homeMain,
                        );
                      }
                    }
                  },
                      customImage: Image.asset(
                        AppImages.registerSuccess,
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                      ));
                  Timer(const Duration(seconds: 5), () async {});
                } else {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.resetPasswordScreen,
                  );
                }
              },
              titleButton: "Xác thực",
            )
          ],
        ));
  }
}
