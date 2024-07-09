import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class EditBranchScreen extends BaseScreen {
  final int? id;

  const EditBranchScreen({super.key, required this.id});

  @override
  EditBranchScreenState createState() => EditBranchScreenState();
}

class EditBranchScreenState extends BaseState<EditBranchScreen> with BaseScreenMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeBranchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  final FocusNode _field2FocusNode = FocusNode();
  final FocusNode _field3FocusNode = FocusNode();
  final FocusNode _field4FocusNode = FocusNode();
  final FocusNode _field5FocusNode = FocusNode();

  String get name => nameController.text;

  String get code => codeBranchController.text;

  String get phone => phoneController.text;

  String get zipCode => zipCodeController.text;

  String get address1 => address1Controller.text;

  String get address2 => address2Controller.text;

  @override
  void dispose() {
    nameController.dispose();
    codeBranchController.dispose();
    phoneController.dispose();
    zipCodeController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    _field2FocusNode.dispose();
    _field3FocusNode.dispose();
    _field4FocusNode.dispose();
    _field5FocusNode.dispose();
    super.dispose();
  }

  initData(BuildContext context) {
    var branchProvider = Provider.of<BranchProvider>(context, listen: false);
    nameController = TextEditingController(text: branchProvider.branchModel.name);
    codeBranchController = TextEditingController(text: branchProvider.branchModel.code);
    phoneController = TextEditingController(text: branchProvider.branchModel.phone);
    zipCodeController = TextEditingController(text: branchProvider.branchModel.zipCode);
    address1Controller = TextEditingController(text: branchProvider.branchModel.address1);
    address2Controller = TextEditingController(text: branchProvider.branchModel.address2);
    branchProvider.changeDefault(value: branchProvider.branchModel.isDefaultBranch);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    Future.wait([
      addressProvider.selectProvince(branchProvider.branchModel.province),
      addressProvider.selectDistrict(branchProvider.branchModel.district),
      addressProvider.selectWard(branchProvider.branchModel.ward),
    ]);
    setState(() {});
  }

  Future fetchData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([context.read<BranchProvider>().detailsBranch(context, widget.id)]).whenComplete(() {
      initData(context);
      AppFunction.hideLoading(context);
    });
  }

  @override
  Color setMainBackgroundColor() => AppThemes.white;

  @override
  String setTitle() {
    return "Chỉnh sửa";
  }

  @override
  setOnPressLeftButton() {
    Navigator.pop(context, false);
  }

  @override
  Widget? buildRightWidget() => const SizedBox.shrink();

  @override
  void afterFirstLayout(BuildContext context) => fetchData(context);

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<BranchProvider, AddressProvider>(
      builder: (context, branch, address, child) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  ...buildInput(),
                  MepharCheckbox(
                    onTap: () => branch.changeDefault(),
                    isCheckBoxRight: false,
                    text: "Chi nhánh mặc định",
                    isChecked: branch.isDefault,
                  ),
                ].addBetween(const SizedBox(height: 16)),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
                child: MepharButton(
                  titleButton: "Lưu",
                  onPressed: () => save(
                      context,
                      widget.id,
                      BranchModel(
                          name: name,
                          code: code,
                          phone: phone,
                          zipCode: zipCode,
                          address1: address1,
                          provinceId: address.provinceValue?.id,
                          districtId: address.districtValue?.id,
                          wardId: address.wardValue?.id,
                          address2: address2,
                          isDefaultBranch: branch.isDefault)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void save(BuildContext context, int? id, BranchModel branchModel) {
    AppFunction.hideKeyboard(context);
    AppFunction.showLoading(context);
    context
        .read<BranchProvider>()
        .editBranch(context, id: id, branchModel: branchModel)
        .then((value) => AppFunction.hideLoading(context));
  }

  List<Widget> buildInput() {
    return [
      MepharTextfield(
        hintText: "Tên*",
        controller: nameController,
        onFieldSubmitted: (value) {
          _field2FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Mã chi nhánh",
        controller: codeBranchController,
        keyboardType: TextInputType.number,
        nextFocusNode: _field2FocusNode,
        onFieldSubmitted: (value) {
          _field3FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Số điện thoại*",
        controller: phoneController,
        keyboardType: TextInputType.phone,
        nextFocusNode: _field3FocusNode,
        onFieldSubmitted: (value) {
          _field4FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Mã bưu điện",
        controller: zipCodeController,
        keyboardType: TextInputType.number,
        nextFocusNode: _field4FocusNode,
        onFieldSubmitted: (value) {
          _field5FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Địa chỉ 1*",
        controller: address1Controller,
        nextFocusNode: _field5FocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
      const DropdownAddressWidget(
        havePadding: true,
      ),
      MepharTextfield(
        hintText: "Địa chỉ 2",
        controller: address2Controller,
      ),
    ];
  }
}
