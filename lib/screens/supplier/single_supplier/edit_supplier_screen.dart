import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class EditInformationSupplier extends BaseScreen {
  const EditInformationSupplier({super.key});

  @override
  EditInformationSupplierState createState() => EditInformationSupplierState();
}

class EditInformationSupplierState extends BaseState<EditInformationSupplier>
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
    return "Chỉnh sửa thông tin NCC";
  }

  getAddress(BuildContext context) {
    idProvince =
        Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict =
        Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;
  }

  Future fetchData(BuildContext context) async {
    AppFunction.showLoading(context);
    var supplier = Provider.of<SupplierProvider>(context, listen: false);
    nameSupplierController =
        TextEditingController(text: supplier.supplier?.name);
    codeSupplierController =
        TextEditingController(text: supplier.supplier?.code);
    emailSupplierController =
        TextEditingController(text: supplier.supplier?.email);
    numberBusinessController =
        TextEditingController(text: supplier.supplier?.taxCode);
    phoneSupplierController =
        TextEditingController(text: supplier.supplier?.phone);
    nameCompanyController =
        TextEditingController(text: supplier.supplier?.companyName);
    addressController = TextEditingController(text: supplier.supplier?.address);
    noteController = TextEditingController(text: supplier.supplier?.note);
    supplierId = supplier.supplier?.groupSupplierId;
    branchId = supplier.supplier?.branch?.id;
    setState(() {});
    AppFunction.hideLoading(context);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    fetchData(context);
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
                            ObjectDropdownButton(
                                havePadding: true,
                                hinText: supplier.supplier?.groupSupplier?.name,
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
                            DropdownAddressWidget(
                              havePadding: false,
                              hideText: true,
                              labelText1: supplier.supplier?.province?.name,
                              labelText2: supplier.supplier?.district?.name,
                              labelText3: supplier.supplier?.ward?.name,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MepharTextfield(
                              hintText: "Địa chỉ",
                              controller: addressController,
                            ),
                            ObjectDropdownButton(
                                havePadding: true,
                                hinText: supplier.supplier?.branch?.name,
                                listItems: branch.branchDropdown,
                                onChange: (value) {
                                  setState(() {
                                    branchId = value?.id;
                                    print(branchId);
                                  });
                                }),
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
                  titleButton: "Cập nhật thông tin",
                  onPressed: () async {
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
                        AppFunction.checkStore(context, branchId)) {
                      getAddress(context);
                      supplier.editSupplier(
                        context,
                        supplier.supplier!.id!,
                        addressController.text,
                        branchId ?? supplier.supplier!.branch!.id!,
                        codeSupplierController.text,
                        nameSupplierController.text,
                        idDistrict ?? supplier.supplier!.district!.id!,
                        emailSupplierController.text,
                        supplierId ?? supplier.supplier!.groupSupplierId!,
                        nameCompanyController.text,
                        noteController.text,
                        phoneSupplierController.text,
                        idProvince ?? supplier.supplier!.province!.id!,
                        numberBusinessController.text,
                        idWard ?? supplier.supplier!.province!.id!,
                      );
                      await supplier.getDataSupplier(context, "", 1, 5);
                      await supplier.getDetailSupplier(supplier.supplier!.id!);

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
