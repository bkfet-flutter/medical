import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class EditGroupCustomerScreen extends BaseScreen {
  const EditGroupCustomerScreen({super.key});

  @override
  EditGroupCustomerScreenState createState() => EditGroupCustomerScreenState();
}

class EditGroupCustomerScreenState extends BaseState<EditGroupCustomerScreen>
    with BaseScreenMixin {
  TextEditingController nameGroupCustomerController = TextEditingController();
  TextEditingController reducePerController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  int? id;
  final FocusNode _field2FocusNode = FocusNode();
  final FocusNode _field3FocusNode = FocusNode();
  @override
  void dispose() {
    _field2FocusNode.dispose();
    _field3FocusNode.dispose();
    super.dispose();
  }

  @override
  String setTitle() {
    return "Chỉnh sửa nhóm khách hàng";
  }

  initData() async {
    var group = Provider.of<GroupCustomerProvider>(context, listen: false);
    nameGroupCustomerController =
        TextEditingController(text: group.group?.name);
    reducePerController =
        TextEditingController(text: group.group?.discount.toString());
    noteController = TextEditingController(text: group.group?.description);
    id = group.group?.id;
    setState(() {});
    print(nameGroupCustomerController.text);
  }

  @override
  setOnPressLeftButton() {
    Navigator.pop(context, false);
  }

  @override
  setOnPressRightButton() {
    // final provider = Provider.of<GroupCustomerProvider>(context, listen: false);

    // if (provider.nameGroupCustomerController.text.trim().isNotEmpty) {
    //   apiEdit(
    //       provider.groupCustomer.id,
    //       provider.nameGroupCustomerController.text.trim(),
    //       provider.reducePerController.text.trim(),
    //       provider.noteController.text.trim());
    // } else {
    //   AppFunction.showDialogError(
    //     context,
    //     "Vui lòng điền đủ thông tin",
    //     textButton: "Đóng",
    //     title: "Thông báo lỗi",
    //   );
    // }
  }
  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    initData();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer<GroupCustomerProvider>(
      builder: (context, group, child) {
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
                          controller: noteController,
                          nextFocusNode: _field3FocusNode,
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
                    onPressed: () async {
                      if (nameGroupCustomerController.text.trim().isNotEmpty &&
                          reducePerController.text.isNotEmpty &&
                          noteController.text.isNotEmpty) {
                        int discount = int.parse(reducePerController.text);
                        group.editGroupCustomer(
                          context,
                          id,
                          nameGroupCustomerController.text,
                          discount,
                          noteController.text,
                        );
                        await group.getDataGroupCustomer("", 1, 5);
                        Navigator.pop(context);
                      } else {
                        AppFunction.showDialogError(
                            context, "vui lòng điền đầy đủ thông tin");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
