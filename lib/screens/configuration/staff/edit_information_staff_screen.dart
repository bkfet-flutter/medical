import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/role_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:provider/provider.dart';

class EditInformationStaffScreen extends BaseScreen {
  final int? id;

  const EditInformationStaffScreen({super.key, required this.id});

  @override
  EditInformationStaffScreenState createState() => EditInformationStaffScreenState();
}

class EditInformationStaffScreenState extends BaseState<EditInformationStaffScreen> with BaseScreenMixin {
  @override
  String setTitle() => "Chỉnh sửa thông tin nv ";

  @override
  setOnPressLeftButton() => Navigator.pop(context, false);

  @override
  Widget? buildRightWidget() => const SizedBox.shrink();

  @override
  Color setMainBackgroundColor() => AppThemes.white;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final FocusNode _field2FocusNode = FocusNode();
  final FocusNode _field3FocusNode = FocusNode();
  final FocusNode _field4FocusNode = FocusNode();
  final FocusNode _field5FocusNode = FocusNode();
  final FocusNode _field6FocusNode = FocusNode();
  final FocusNode _field7FocusNode = FocusNode();

  String get name => nameController.text;

  String get username => usernameController.text;

  String get phone => phoneController.text;

  String get email => emailController.text;

  String get password => passwordController.text;

  String get checkPassword => checkPasswordController.text;

  String get address => addressController.text;

  String dOB = DateTime.now().toString();

  ProvinceModel? roleValue;
  ProvinceModel? branchValue;
  String? position;

  initData(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(text: userProvider.staffDetails.fullName);
    usernameController = TextEditingController(text: userProvider.staffDetails.username);
    phoneController = TextEditingController(text: userProvider.staffDetails.phone);
    emailController = TextEditingController(text: userProvider.staffDetails.email);
    dOB = userProvider.staffDetails.birthday ?? "";
    position = userProvider.staffDetails.position;
    final role = Provider.of<RoleProvider>(context, listen: false);
    final branch = Provider.of<BranchProvider>(context, listen: false);
    Future.wait([role.fetchRoles(context), branch.fetchBranches(context)]).then((value) {
      roleValue = role.findRole(userProvider.staffDetails.role?.id);
      branchValue = branch.findBranch(userProvider.staffDetails.branch?.id);
    });
    setState(() {});
  }

  Future fetchData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([context.read<UserProvider>().getStaffDetails(context, widget.id)]).whenComplete(() {
      initData(context);
      AppFunction.hideLoading(context);
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => fetchData(context);

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    addressController.dispose();
    _field2FocusNode.dispose();
    _field3FocusNode.dispose();
    _field4FocusNode.dispose();
    _field5FocusNode.dispose();
    _field6FocusNode.dispose();
    _field7FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(children: _buildInput().addBetween(const SizedBox(height: 12))),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
            child: MepharButton(
              titleButton: "Lưu",
              onPressed: () => save(context,
                  userModel: UserModel(
                      id: widget.id,
                      fullName: name,
                      username: username,
                      phone: phone,
                      email: email,
                      birthday: dOB,
                      roleId: roleValue?.id,
                      branch: BranchModel(id: branchValue?.id),
                      position: position),
                  address: address,
                  password: password,
                  checkPass: checkPassword),
            ),
          ),
        ),
      ],
    );
  }

  void save(BuildContext context,
      {required UserModel userModel, String? password, String? checkPass, String? address}) {
    AppFunction.hideKeyboard(context);
    AppFunction.showLoading(context);
    context
        .read<UserProvider>()
        .editStaff(context, userModel: userModel, password: password, checkPass: checkPass, address: address)
        .then((value) => AppFunction.hideLoading(context));
  }

  List<Widget> _buildInput() {
    return [
      MepharTextfield(
        hintText: "Họ và tên nhân viên*",
        controller: nameController,
        onFieldSubmitted: (value) {
          _field2FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Tên đăng nhập *",
        controller: usernameController,
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
        hintText: "Email",
        controller: emailController,
        nextFocusNode: _field4FocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
      MepharPickerDatetime(
          icon: AppImages.iconCalendar,
          labelText: "Ngày sinh",
          dateTimeByText: dOB,
          onDateTimeChanged: (value) {
            AppFunction.hideKeyboard(context);
            setState(() {
              dOB = AppFunction.formatDate(value);
            });
          }),
      MepharTextfield(
        hintText: "Địa chỉ",
        controller: addressController,
        nextFocusNode: _field5FocusNode,
        onFieldSubmitted: (value) {
          _field6FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Mật khẩu",
        controller: passwordController,
        isPassword: true,
        nextFocusNode: _field6FocusNode,
        onFieldSubmitted: (value) {
          _field7FocusNode.requestFocus();
        },
      ),
      MepharTextfield(
        hintText: "Nhập lại mật khẩu",
        controller: checkPasswordController,
        isPassword: true,
        nextFocusNode: _field7FocusNode,
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
      ObjectDropdownButton(
          havePadding: true,
          hinText: "Vai trò",
          value: roleValue,
          listItems: context.watch<RoleProvider>().roleDropdown,
          onChange: (value) {
            roleValue = value;
            setState(() {});
          }),
      ObjectDropdownButton(
          havePadding: true,
          hinText: "Chi nhánh",
          value: branchValue,
          listItems: context.watch<BranchProvider>().branchDropdown,
          onChange: (value) {
            branchValue = value;
            setState(() {});
          }),
      ObjectDropdownButton(
          havePadding: true,
          hinText: "Chọn Vị trí",
          listItems: context.watch<RoleProvider>().positions,
          value: context.watch<RoleProvider>().positionMap[position],
          onChange: (value) {
            position = context.read<RoleProvider>().findKey(value);
            setState(() {});
          }),
    ];
  }
}
