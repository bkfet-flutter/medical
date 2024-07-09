import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              AppImages.backgroundLogin,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 60,
              child: Container(
                margin: const EdgeInsets.only(left: 24),
                child: Text(
                  "Quên mật khẩu",
                  style: AppFonts.ultraBold(32, Colors.white).copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, right: 24, left: 24),
                  child: Column(
                    children: [
                      MepharInput(
                        titleInput: "Nhập SĐT đăng nhập",
                        controller: phoneController,
                      ),
                      const SizedBox(
                        height: 144,
                      ),
                      MepharButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.otpScreen,
                            arguments: false,
                          );
                        },
                        titleButton: "Lấy mã xác nhận",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
