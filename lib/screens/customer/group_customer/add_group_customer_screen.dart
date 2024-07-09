import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';

import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class AddGroupCustomerScreen extends BaseScreen {
  const AddGroupCustomerScreen({super.key});

  @override
  AddGroupCustomerScreenState createState() => AddGroupCustomerScreenState();
}

class AddGroupCustomerScreenState extends BaseState<AddGroupCustomerScreen>
    with BaseScreenMixin {
  TextEditingController nameGroupCustomerController = TextEditingController();
  TextEditingController reducePerController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();
  final FocusNode _field3FocusNode = FocusNode();

  @override
  void dispose() {
    nameGroupCustomerController.dispose();
    reducePerController.dispose();
    noteController.dispose();
    _field2FocusNode.dispose();
    _field3FocusNode.dispose();
    super.dispose();
  }

  @override
  String setTitle() {
    return "Thêm nhóm khách hàng";
  }

  apiCreate(String? name, String? reducePer, String? note) async {
    showLoading();
    String getCreateGroupCustomer =
        await Provider.of<GroupCustomerProvider>(context, listen: false)
            .createGroupCustomer(name, reducePer ?? "0", note ?? "");

    if (getCreateGroupCustomer == "success" && context.mounted) {
      hideLoading();
      Navigator.pop(context, true);
    } else {
      if (context.mounted) {
        hideLoading();
        AppFunction.showDialogError(context, getCreateGroupCustomer,
            textButton: "Đóng", title: "Thông báo lỗi");
      }
    }
  }

  @override
  setOnPressLeftButton() {
    Navigator.pop(context, false);
  }

  @override
  setOnPressRightButton() {
    if (nameGroupCustomerController.text.trim().isNotEmpty) {
      apiCreate(
        nameGroupCustomerController.text.trim(),
        (reducePerController.text.trim().isEmpty ||
                num.tryParse(reducePerController.text.trim()) == null)
            ? "0"
            : reducePerController.text,
        noteController.text.trim().isEmpty ? "" : noteController.text.trim(),
      );
    } else {
      AppFunction.showDialogError(context, "Vui lòng điền đủ thông tin",
          textButton: "Đóng", title: "Thông báo lỗi");
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    MepharTextfield(
                      hintText: "Tên nhóm khách hàng*",
                      controller: nameGroupCustomerController,
                      onFieldSubmitted: (value) {
                        _field2FocusNode.requestFocus();
                      },
                    ),
                    MepharTextfield(
                      hintText: "Chiết khấu (%)",
                      keyboardType: TextInputType.number,
                      nextFocusNode: _field2FocusNode,
                      controller: reducePerController,
                      onFieldSubmitted: (value) {
                        _field3FocusNode.requestFocus();
                      },
                    ),
                    MepharTextfield(
                      hintText: "Mô tả",
                      nextFocusNode: _field3FocusNode,
                      controller: noteController,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
              child: MepharButton(
                titleButton: "Lưu",
                onPressed: () {
                  if (nameGroupCustomerController.text.trim().isNotEmpty &&
                      reducePerController.text.isNotEmpty &&
                      noteController.text.isNotEmpty) {
                    apiCreate(
                      nameGroupCustomerController.text.trim(),
                      (reducePerController.text.trim().isEmpty ||
                              num.tryParse(reducePerController.text.trim()) ==
                                  null)
                          ? "0"
                          : reducePerController.text.trim(),
                      noteController.text.trim().isEmpty
                          ? ""
                          : noteController.text.trim(),
                    );
                  } else {
                    AppFunction.showDialogError(
                        context, "Vui lòng điền đủ thông tin bắt buộc",
                        textButton: "Đóng", title: "Thông báo lỗi");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
