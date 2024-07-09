import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class AddGroupSupplierScreen extends BaseScreen {
  const AddGroupSupplierScreen({super.key});

  @override
  AddGroupSupplierScreenState createState() => AddGroupSupplierScreenState();
}

class AddGroupSupplierScreenState extends BaseState<AddGroupSupplierScreen>
    with BaseScreenMixin {
  TextEditingController nameGroupSupplier = TextEditingController();
  TextEditingController detailController = TextEditingController();
  int? branchId;
  @override
  String setTitle() {
    return "Thêm nhóm nhà cung cấp";
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<SupplierProvider, BranchProvider>(
      builder: (context, supplier, branch, child) {
        return Container(
          color: const Color(0xffF3FAFF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        MepharTextfield(
                          hintText: "Tên nhóm nhà cung cấp*",
                          controller: nameGroupSupplier,
                        ),
                        // MepharDropDownButton(
                        //   haveBorder: false,
                        //   hintText: "Chi nhánh*",
                        //   items: branch.branchDropdown,
                        //   onChanged: (value) {
                        //     setState(() {

                        //     });
                        //   },
                        // ),
                        ObjectDropdownButton(
                            havePadding: true,
                            hinText: "Chi nhánh",
                            listItems: branch.branchDropdown,
                            onChange: (value) {
                              setState(() {
                                branchId = value?.id;
                                print(branchId);
                              });
                            }),
                        MepharTextfield(
                          hintText: "Mô tả",
                          controller: detailController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.spaceXSmall10),
                  child: MepharButton(
                    titleButton: "Thêm",
                    onPressed: () async {
                      if (nameGroupSupplier.text.isNotEmpty == true &&
                          AppFunction.checkStore(context, branchId) &&
                          detailController.text.isNotEmpty == true) {
                        ApiResponse resAddSupplier =
                            await ApiRequest.addSupplierGroup(
                                nameGroupSupplier.text,
                                branchId,
                                detailController.text);
                        if (resAddSupplier.result == true) {
                          supplier.getDataGroupSupplier(context, "", 1, 10);
                          Navigator.pop(context);
                          AppFunction.showDialogSuccess(
                            context,
                            content: 'Thêm mới thành công',
                          );
                          AppFunction.hideLoading(context);
                        } else {
                          if (context.mounted) {
                            AppFunction.hideLoading(context);
                            AppFunction.showDialogError(
                                context, resAddSupplier.message);
                          }
                        }
                      } else {
                        AppFunction.showDialogError(
                            context, "Vui lòng điền tất cả các thông tin ");
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
