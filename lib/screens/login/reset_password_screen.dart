import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';

class ResetPasswordScreen extends BaseScreen {
  const ResetPasswordScreen({super.key});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends BaseState<ResetPasswordScreen>
    with BaseScreenMixin {
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();
  static bool checkPassword(
      BuildContext context, String pass, String confirmpass) {
    bool checkPass = true;

    if (pass.length >= 8 && pass == confirmpass) {
      return checkPass;
    } else if (pass.length < 8 && pass == confirmpass) {
      AppFunction.showDialogError(context, 'Mật khẩu quá ngắn');
      return !checkPass;
    } else {
      AppFunction.showDialogError(
          context, 'Mật khẩu xác nhận không giống nhau');
      return !checkPass;
    }
  }

  @override
  void dispose() {
    newpasswordController.dispose();
    checkPasswordController.dispose();
    _field2FocusNode.dispose();
    super.dispose();
  }

  @override
  String setTitle() {
    return "Đặt lại mật khẩu";
  }

  @override
  Widget? buildRightWidget() {
    // TODO: implement buildRightWidget
    return const SizedBox.shrink();
  }

  @override
  Color? setHeaderBackgroundColor() {
    return AppThemes.red0;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5FA),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Đặt lại mật khẩu",
              style: AppFonts.normalBold(32, AppThemes.dark0)
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 24,
            ),
            MepharInput(
              titleInput: "Mật khẩu cũ",
              isPassword: true,
              controller: oldPasswordController,
              onFieldSubmitted: (value) {
                _field2FocusNode.requestFocus();
              },
            ),
            const SizedBox(
              height: 24,
            ),
            MepharInput(
              titleInput: "Mật khẩu mới",
              isPassword: true,
              controller: newpasswordController,
              onFieldSubmitted: (value) {
                _field2FocusNode.requestFocus();
              },
            ),
            const SizedBox(
              height: 24,
            ),
            MepharInput(
              titleInput: "Nhập lại mật khẩu mới",
              isPassword: true,
              nextFocusNode: _field2FocusNode,
              controller: checkPasswordController,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(
              height: 44,
            ),
            MepharButton(
              onPressed: () async {
                if (checkPassword(context, newpasswordController.text,
                    checkPasswordController.text)) {
                  ApiResponse resPass = await ApiRequest.changePassword(
                    oldPasswordController.text,
                    newpasswordController.text,
                    checkPasswordController.text,
                  );
                  if (resPass.result == true) {
                    AppFunction.showDialogSuccess(context,
                        content: "Cập nhật mật khẩu thành công");
                  } else {
                    AppFunction.showDialogError(context, resPass.message);
                  }
                }
              },
              titleButton: "Hoàn thành",
            )
          ],
        ),
      ),
    );
  }
}
