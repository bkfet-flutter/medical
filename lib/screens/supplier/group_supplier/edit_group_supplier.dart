import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
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
      
class EditGroupSupplierScreen extends BaseScreen {
  const EditGroupSupplierScreen({super.key});

  @override
  EditGroupSupplierScreenState createState() => EditGroupSupplierScreenState();
}

class EditGroupSupplierScreenState extends BaseState<EditGroupSupplierScreen>
    with BaseScreenMixin {
  TextEditingController nameGroupCustomer = TextEditingController();
  TextEditingController detailController = TextEditingController();
  int? branchId;
  initData() {
    var supplier = Provider.of<SupplierProvider>(context, listen: false);
    nameGroupCustomer =
        TextEditingController(text: supplier.groupSupplier?.name);
    detailController =
        TextEditingController(text: supplier.groupSupplier?.description);
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    initData();
  }

  @override
  String setTitle() {
    return "Chỉnh sửa thông tin NCC";
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
                          controller: nameGroupCustomer,
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
                    titleButton: "Cập nhật thông tin",
                    onPressed: () async {
                      if (nameGroupCustomer.text.isNotEmpty == true &&
                          detailController.text.isNotEmpty == true) {
                        supplier.editGroupSupplier(
                          context,
                          supplier.groupSupplier!.id ?? 1,
                          nameGroupCustomer.text,
                          branchId ?? supplier.groupSupplier!.storeId!,
                          detailController.text,
                        );
                        supplier.listGroupSupplier.clear();
                        await supplier.getDataGroupSupplier(context, "", 1, 5);
                        Navigator.pop(context);
                      } else {
                        AppFunction.showDialogError(
                            context, "Vui lòng điền đầy đủ các thông tin");
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
