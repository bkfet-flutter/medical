import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';

import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends BaseScreen {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseState<LoginScreen> with BaseScreenMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    _field2FocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  Color colorIcon = const Color(0xff1F1F39);

  //valide input
  static bool checkFieldEmpty(
    BuildContext context,
    String username,
    String pass,
  ) {
    bool checkField = true;
    if (pass.isEmpty || username.isEmpty) {
      AppFunction.showDialogError(
          context, 'Vui lòng điền đầy đủ các thông tin');
      return !checkField;
    } else {
      return checkField;
    }
  }

  //validate
  static bool checkUserName(BuildContext context, String userName) {
    bool checkUserName = true;
    if (userName.length >= 6 && userName.length <= 40) {
      return checkUserName;
    } else {
      AppFunction.showDialogError(
          context, "Tên đăng nhập dài tối thiểu 6 ký tự");
      return !checkUserName;
    }
  }

  //validate pass
  static bool checkPassword(BuildContext context, String pass) {
    bool checkPass = true;

    if (pass.length >= 8) {
      return checkPass;
    } else {
      AppFunction.showDialogError(context, 'Mật khẩu tối thiểu dài 8 ký tự');
      return !checkPass;
    }
  }

  bool remember = false;

  @override
  Widget buildHeader() => const SizedBox.shrink();

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, child) {
      return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.backgroundLogin),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Đăng nhập",
                    style: AppFonts.ultraBold(32, Colors.white).copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Chưa có tài khoản? ",
                          style: AppFonts.light(12, Colors.white)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.registerScreen,
                                arguments: true,
                              );
                            },
                          text: "Đăng ký ngay",
                          style: AppFonts.bold(12, Colors.white).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                          )),
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MepharInput(
                          titleInput: "Tên đăng nhập",
                          controller: userNameController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        MepharInput(
                          titleInput: "Mật khẩu",
                          isPassword: true,
                          colorIcon: colorIcon,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            MepharCheckbox(
                              onlyCheckBox: true,
                              isChecked: remember,
                              onTap: () {
                                setState(() {
                                  remember = !remember;
                                });
                              },
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Nhớ đăng nhập",
                              style: AppFonts.regular(
                                14,
                                const Color(0xffEB1F28),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPasswordScreen,
                              ),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Quên mật khẩu?",
                                  style: AppFonts.regular(
                                      14, const Color(0xffEB1F28)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        MepharButton(
                          onPressed: () async => login(context),
                          titleButton: "Đăng nhập",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  void login(BuildContext context) async {
    AppFunction.hideKeyboard(context);
    if (true == true
        // checkFieldEmpty(context, userNameController.text, passwordController.text) &&
        //   checkUserName(context, userNameController.text) &&
        //   checkPassword(context, passwordController.text)
        ) {
      showLoading();
      setState(() {
        colorIcon = const Color(0xff1F1F39);
      });
      final res = await ApiRequest.userLogin(
          passwordController.text, userNameController.text);
      if (res.result == true && context.mounted) {
        String token = res.data["accessToken"]["token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', token);
        await prefs.setString('username', userNameController.text);
        await prefs.setBool('logged', remember);
        if (context.mounted) {
          hideLoading();
          Navigator.pushReplacementNamed(context, AppRoutes.homeMain);
        }
      } else {
        if (context.mounted) {
          hideLoading();
          AppFunction.showDialogError(context, res.message,
              textButton: "Đóng", title: "Thông báo lỗi");
        }
      }
    }
  }
}
