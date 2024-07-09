import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_dropdown_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class AddSupplierScreen extends BaseScreen {
  const AddSupplierScreen({Key? key}) : super(key: key);

  @override
  AddSupplierScreenState createState() => AddSupplierScreenState();
}

class AddSupplierScreenState extends BaseState<AddSupplierScreen>
    with BaseScreenMixin {
  TextEditingController nameSupplierController = TextEditingController();
  TextEditingController codeSupplierController = TextEditingController();
  TextEditingController phoneSupplierController = TextEditingController();
  TextEditingController emailSupplierController = TextEditingController();
  TextEditingController nameCompanyController = TextEditingController();
  TextEditingController numberBusinessController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  int? branchId;
  int? supplierId;
  int? idProvince;
  int? idDistrict;
  int? idWard;

  @override
  String setTitle() {
    return "Thêm nhà cung cấp";
  }

  getAddress(BuildContext context) {
    idProvince =
        Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict =
        Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;
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
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   color: Colors.white,
                    //   margin: const EdgeInsets.only(top: 7, bottom: 16),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Image.asset(
                    //       AppImages.iconAddImage,
                    //       height: 32,
                    //       width: 32,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            MepharTextfield(
                              hintText: "Tên nhà cung cấp*",
                              controller: nameSupplierController,
                            ),
                            MepharTextfield(
                              hintText: "Mã nhà cung cấp",
                              controller: codeSupplierController,
                            ),
                            MepharTextfield(
                              hintText: "Số điện thoại*",
                              controller: phoneSupplierController,
                            ),
                            MepharTextfield(
                              hintText: "Email",
                              controller: emailSupplierController,
                            ),
                            MepharTextfield(
                              hintText: "Công ty",
                              controller: nameCompanyController,
                            ),
                            // MepharDropDownButton(
                            //   haveBorder: false,
                            //   hintText: "Nhóm NCC",
                            //   items: supplier.nameGroupSupplierModel,
                            //   onChanged: (value) {
                            //     setState(() {});
                            //   },
                            // ),
                            ObjectDropdownButton(
                                havePadding: true,
                                hinText: "Nhóm NCC",
                                listItems: supplier.supplierDropdown,
                                onChange: (value) {
                                  setState(() {
                                    supplierId = value?.id;
                                    print(supplierId);
                                  });
                                }),

                            MepharTextfield(
                              hintText: "Mã số thuế",
                              controller: numberBusinessController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const DropdownAddressWidget(
                              havePadding: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MepharTextfield(
                              hintText: "Địa chỉ",
                              controller: addressController,
                            ),
                            // MepharDropDownButton(
                            //   haveBorder: false,
                            //   hintText: "Chi nhánh",
                            //   items: branch.nameStore,
                            //   onChanged: (value) {
                            //     setState(() {});
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
                            // ObjectDropdownButton(
                            //     havePadding: true,
                            //     hinText: "Chi nhánh",
                            //     listItems: context
                            //         .watch<BranchProvider>()
                            //         .branchDropdown,
                            //     onChange: (value) {
                            //       setState(() {
                            //         // branchId = value?.id;
                            //       });
                            //     }),
                            MepharTextfield(
                              hintText: "Thêm ghi chú",
                              controller: noteController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spaceXSmall10),
                child: MepharButton(
                  titleButton: "Lưu",
                  onPressed: () async {
                    getAddress(context);
                    if (AppFunction.checkNameSupplier(
                            context, nameSupplierController.text) &&
                        AppFunction.checkPhone(
                            context, phoneSupplierController.text) &&
                        AppFunction.checkEmail(
                            context, emailSupplierController.text) &&
                        AppFunction.checkNameCompany(
                            context, nameCompanyController.text) &&
                        AppFunction.checkGroupSupplier(context, supplierId) &&
                        AppFunction.checkBusinessNumber(
                            context, numberBusinessController.text) &&
                        AppFunction.checkAddress(
                            context, idProvince, idDistrict, idWard) &&
                        AppFunction.checkStore(context, branchId)) {
                      supplier.addSupplier(
                        context,
                        addressController.text,
                        branchId!,
                        codeSupplierController.text,
                        nameSupplierController.text,
                        idDistrict!,
                        emailSupplierController.text,
                        supplierId!,
                        nameCompanyController.text,
                        noteController.text,
                        phoneSupplierController.text,
                        idProvince!,
                        numberBusinessController.text,
                        idWard!,
                      );
                      await supplier.getDataSupplier(context, "", 1, 5);

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
