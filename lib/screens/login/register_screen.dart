import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends BaseScreen {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseState<RegisterScreen>
    with BaseScreenMixin {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isCheck = false;
  TextEditingController nameStoreController = TextEditingController();
  TextEditingController phoneStoreController = TextEditingController();
  TextEditingController emailStoreController = TextEditingController();
  TextEditingController addressStoreController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController numberBusinessController = TextEditingController();

  //error
  final _formKey = GlobalKey<FormState>();
  Color colorIcon = const Color(0xff1F1F39);
  Color colorIcon1 = const Color(0xff1F1F39);
  bool checkAllError = false;
  bool checkErrorBusiness = false;
  String textError = "";

  int? idProvince;
  int? idDistrict;
  int? idWard;
  ImageModel? image;
  int? imageId;
  String? imagePath;
  int? idStore;

  //checkEmty
  static bool checkFieldEmpty(
    BuildContext context,
    String fullname,
    String username,
    String pass,
    String confirmpass,
    String phone,
    String email,
    String nameStore,
    String phoneSote,
    String numberbusinessStore,
    String idProvince,
    String idDistrict,
    String idWard,
    String addressStore,
    String idImage,
  ) {
    bool checkField = true;
    if (fullname.isEmpty ||
        username.isEmpty ||
        pass.isEmpty ||
        confirmpass.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        nameStore.isEmpty ||
        phoneSote.isEmpty ||
        numberbusinessStore.isEmpty ||
        idProvince.toString().isEmpty ||
        idDistrict.toString().isEmpty ||
        idWard.toString().isEmpty ||
        addressStore.isEmpty ||
        idImage.isEmpty) {
      AppFunction.showDialogError(
          context, 'Vui lòng hoàn thành các mục thông tin');
      return !checkField;
    } else {
      return checkField;
    }
  }

  // validate fullName
  static bool checkFullName(BuildContext context, String fullName) {
    bool checkfullName = true;
    if (fullName.length >= 6 && fullName.length <= 40) {
      return checkfullName;
    } else {
      AppFunction.showDialogError(
          context, "Vui lòng điền đầy đủ họ và tên của bạn");
      return !checkfullName;
    }
  }

  static bool checkNameStore(BuildContext context, String fullName) {
    bool checkfullName = true;
    if (fullName.length >= 6 && fullName.length <= 40) {
      return checkfullName;
    } else {
      AppFunction.showDialogError(
          context, "Vui lòng điền đầy đủ tên cửa hàng của bạn");
      return !checkfullName;
    }
  }

  //validate userName
  static bool checkUserName(BuildContext context, String userName) {
    bool checkfullName = true;
    if (userName.length >= 6 && userName.length <= 40) {
      return checkfullName;
    } else {
      AppFunction.showDialogError(
          context, "Tên đăng nhập dài trong khoảng từ 6 đến 40 ký tự");
      return !checkfullName;
    }
  }

  //validate pass
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

  //validate phone
  static bool checkPhone(BuildContext context, String phone) {
    bool checkPhone = true;
    String pattern = r'^(09|08|07|03|05)[0-9]{8}$';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(phone) && phone.length == 10) {
      return checkPhone;
    } else {
      AppFunction.showDialogError(context, 'Số điện thoại không hợp lệ');
      return !checkPhone;
    }
  }

  //validate emial
  static bool checkEmail(BuildContext context, String email) {
    bool checkEmail = true;
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    bool isValidEmail = RegExp(pattern).hasMatch(email);
    if (isValidEmail) {
      return checkEmail;
    } else {
      AppFunction.showDialogError(
        context,
        "Email không hợp lệ",
      );
      return !checkEmail;
    }
  }

  //validate numberbussiness
  static bool checkNumber(BuildContext context, String priceNumber) {
    bool price = true;
    const isNumbericRegex = r'^[0-9]+$';
    bool number = RegExp(isNumbericRegex).hasMatch(priceNumber);
    if (number) {
      return price;
    } else {
      AppFunction.showDialogError(
          context, 'Số đăng ký kinh doanh không hợp lệ');
      return !price;
    }
  }

  static bool agree(BuildContext context, bool ischeck) {
    if (ischeck) {
      return true;
    } else {
      AppFunction.showDialogError(
          context, 'Vui lòng đồng ý với các điều khoản');
      return false;
    }
  }

  // validate input
  bool validateInput() {
    idProvince =
        Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict =
        Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;

    if (checkFieldEmpty(
          context,
          fullNameController.text,
          userNameController.text,
          passwordController.text.replaceAll(" ", ""),
          confirmPassController.text.replaceAll(" ", ""),
          phoneController.text,
          emailController.text,
          nameStoreController.text,
          phoneStoreController.text,
          numberBusinessController.text,
          idProvince.toString(),
          idDistrict.toString(),
          idWard.toString(),
          addressStoreController.text,
          imageId.toString(),
        ) &&
        checkFullName(context, fullNameController.text) &&
        checkUserName(context, userNameController.text) &&
        checkPassword(
            context, passwordController.text, confirmPassController.text) &&
        checkPhone(context, phoneController.text) &&
        checkEmail(context, emailController.text) &&
        checkNameStore(context, nameStoreController.text) &&
        checkPhone(context, phoneStoreController.text) &&
        checkNumber(context, numberBusinessController.text) &&
        agree(context, isCheck)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // getAddress();
    super.initState();
  }

  final FocusNode _field2FocusNode = FocusNode();
  final FocusNode _field3FocusNode = FocusNode();
  final FocusNode _field4FocusNode = FocusNode();
  final FocusNode _field5FocusNode = FocusNode();
  final FocusNode _field6FocusNode = FocusNode();
  final FocusNode _field7FocusNode = FocusNode();
  final FocusNode _field8FocusNode = FocusNode();
  final FocusNode _field9FocusNode = FocusNode();
  final FocusNode _field10FocusNode = FocusNode();
  final FocusNode _field11FocusNode = FocusNode();
  final FocusNode _field12FocusNode = FocusNode();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    nameStoreController.dispose();
    phoneStoreController.dispose();
    emailStoreController.dispose();
    addressStoreController.dispose();
    address2Controller.dispose();
    numberBusinessController.dispose();
    _field2FocusNode.dispose();
    _field3FocusNode.dispose();
    _field4FocusNode.dispose();
    _field5FocusNode.dispose();
    _field6FocusNode.dispose();
    _field7FocusNode.dispose();
    _field8FocusNode.dispose();
    _field9FocusNode.dispose();
    _field10FocusNode.dispose();
    _field11FocusNode.dispose();
    _field12FocusNode.dispose();

    super.dispose();
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    final checkOnLogin = ModalRoute.of(context)!.settings.arguments as bool;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppThemes.red0,
      body: Stack(
        children: [
          Image.asset(
            AppImages.backgroundLogin,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            top: 50,
            right: 0,
            left: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đăng ký",
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
                              text: "Đã có tài khoản? ",
                              style: AppFonts.light(12, Colors.white)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (checkOnLogin) {
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.loginScreen,
                                    );
                                  }
                                },
                              text: "Đăng nhập ngay",
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
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 24, left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "THÔNG TIN NGƯỜI DÙNG",
                              style: AppFonts.bold(14, const Color(0xff1F1F39)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MepharInput(
                                    titleInput: "Họ và tên của bạn*",
                                    controller: fullNameController,
                                    onFieldSubmitted: (value) {
                                      _field2FocusNode.requestFocus();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Tên đăng nhập*",
                                    controller: userNameController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Mật khẩu*",
                                    colorIcon: colorIcon,
                                    isPassword: true,
                                    // onChanged: (value) {
                                    //   value.replaceAll(" ", "");
                                    // },
                                    nextFocusNode: _field3FocusNode,
                                    controller: passwordController,
                                    onFieldSubmitted: (value) {
                                      _field4FocusNode.requestFocus();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Nhập lại mật khẩu*",
                                    colorIcon: colorIcon1,
                                    isPassword: true,
                                    nextFocusNode: _field4FocusNode,
                                    controller: confirmPassController,
                                    onFieldSubmitted: (value) {
                                      _field5FocusNode.requestFocus();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Điện thoại*",
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Email*",
                                    nextFocusNode: _field6FocusNode,
                                    controller: emailController,
                                    onFieldSubmitted: (value) {
                                      _field7FocusNode.requestFocus();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  Text(
                                    "THÔNG TIN CỬA HÀNG",
                                    style: AppFonts.bold(
                                        14, const Color(0xff1F1F39)),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    titleInput: "Tên cửa hàng *",
                                    controller: nameStoreController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MepharInput(
                                    keyboardType: TextInputType.phone,
                                    titleInput: "Điện thoại*",
                                    controller: phoneStoreController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  MepharInput(
                                    titleInput: "Số đăng ký kinh doanh *",
                                    keyboardType: TextInputType.phone,
                                    controller: numberBusinessController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  const DropdownAddressWidget(
                                    haveBoder: true,
                                    havePadding: true,
                                    hideText: true,
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  MepharInput(
                                    titleInput: "Địa chỉ *",
                                    // onChanged: (value) {
                                    //   if (_hasErrorNameStore) {
                                    //     _formKey.currentState!.validate();
                                    //   }
                                    // },

                                    // nextFocusNode: _field7FocusNode,
                                    controller: addressStoreController,
                                    // onFieldSubmitted: (value) {
                                    //   _field8FocusNode.requestFocus();
                                    // },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  // MepharInput(
                                  //   titleInput: "Số đăng ký kinh doanh *",
                                  //   onChanged: (value) {
                                  //     if (_hasErrorNumberBusiness) {
                                  //       _formKey.currentState!.validate();
                                  //     }
                                  //   },
                                  //   validator: validateNumberBusiness,
                                  //   nextFocusNode: _field12FocusNode,
                                  //   controller: numberBusinessController,
                                  //   onFieldSubmitted: (value) {
                                  //     FocusScope.of(context).unfocus();
                                  //   },
                                  // ),
                                  // const SizedBox(
                                  //   height: 16,
                                  // ),
                                  RichText(
                                      text: TextSpan(
                                          text: "Giấy phép đăng ký",
                                          style: AppFonts.regular(
                                            14,
                                            AppThemes.gray,
                                          ),
                                          children: [
                                        TextSpan(
                                          text: " *",
                                          style: AppFonts.regular(
                                            14,
                                            AppThemes.red0,
                                          ),
                                        )
                                      ])),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  imagePath != null
                                      ? Stack(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, right: 8),
                                                child: Image.network(
                                                  "${ApiRequest.domain}$imagePath",
                                                  height: 128,
                                                  width: 93,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    imageId = null;
                                                  });
                                                },
                                                child: Image.asset(
                                                  AppImages.iconRemove,
                                                  height: 16,
                                                  width: 16,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            AppFunction.customBottomSheet(
                                                closeWhenTouch: true,
                                                context: context,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                body: ListView(
                                                  children: [
                                                    TouchableWidget(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        image =
                                                            await AppFunction
                                                                .pickCamera();
                                                        if (image != null) {
                                                          setState(() {
                                                            imageId = image!.id;
                                                            imagePath =
                                                                image!.path;
                                                          });
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xffECF3FD)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Image
                                                                      .asset(
                                                                    AppImages
                                                                        .iconCamera,
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              "Chụp ảnh",
                                                              style: AppFonts.regular(
                                                                  14,
                                                                  const Color(
                                                                      0xff1C1C28)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: const Color(
                                                          0xffC7C9D9),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                    TouchableWidget(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () async {
                                                        Navigator.pop(context);

                                                        image =
                                                            await AppFunction
                                                                .pickImage();
                                                        if (image != null) {
                                                          setState(() {
                                                            imageId = image!.id;
                                                            imagePath =
                                                                image!.path;
                                                          });
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xffECF3FD)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Image
                                                                      .asset(
                                                                    AppImages
                                                                        .iconGallery,
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              "Tải ảnh lên từ thư viện",
                                                              style: AppFonts.regular(
                                                                  14,
                                                                  const Color(
                                                                      0xff1C1C28)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                  ],
                                                ));
                                          },
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                AppImages.imageAdd,
                                                width: 93,
                                                height: 128,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    AppImages.iconAddRed,
                                                    height: 24,
                                                    width: 24,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  (checkErrorBusiness)
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, left: 20),
                                          child: Text(
                                            "Giấy phép đăng ký là bắt buộc",
                                            style: AppFonts.regular(
                                              12,
                                              AppThemes.red0,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              isCheck = !isCheck;
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: isCheck
                                                    ? AppThemes.red0
                                                    : const Color(0xffffffff),
                                                border: Border.fromBorderSide(
                                                  BorderSide(
                                                    width: 1.5,
                                                    color: isCheck
                                                        ? AppThemes.red0
                                                        : const Color(
                                                            0xff8f90a6),
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.check,
                                                size: 12,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "Bằng cách tạo một tài khoản, bạn đã đồng ý với ",
                                                  style: AppFonts.light(12,
                                                      const Color(0xff858597))),
                                              TextSpan(
                                                  text:
                                                      "Điều khoản & điều kiện",
                                                  style: AppFonts.light(12,
                                                      const Color(0xff224BF4))),
                                              TextSpan(
                                                  text: " của chúng tôi.",
                                                  style: AppFonts.light(12,
                                                      const Color(0xff858597))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  (checkAllError)
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            textError,
                                            style: AppFonts.regular(
                                              12,
                                              AppThemes.red0,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  MepharButton(
                                      titleButton: 'Hoàn tất đăng ký',
                                      onPressed: () async {
                                        if (validateInput()) {
                                          ApiResponse resStore =
                                              await ApiRequest.storeRegister(
                                            nameStoreController.text.trim(),
                                            phoneStoreController.text.trim(),
                                            emailStoreController.text.trim(),
                                            idWard!,
                                            idDistrict!,
                                            idProvince!,
                                            addressStoreController.text.trim(),
                                            imageId!,
                                            numberBusinessController.text
                                                .trim(),
                                          );
                                          setState(() {
                                            idStore = resStore.data['id'];
                                          });
                                          ApiResponse resUser =
                                              await ApiRequest.userRegister(
                                            userNameController.text.trim(),
                                            fullNameController.text.trim(),
                                            passwordController.text.trim(),
                                            emailController.text.trim(),
                                            phoneController.text.trim(),
                                            idStore!,
                                          );

                                          if (resStore.result == true &&
                                              resUser.result == true) {
                                            hideLoading();
                                            // ignore: use_build_context_synchronously
                                            AppFunction.showDialogAlert(context,
                                                title: "Thành công",
                                                noDivider: true,
                                                widgetDescription: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 38,
                                                      left: 38,
                                                      bottom: 18),
                                                  child: const Text(
                                                    "Chúc mừng bạn đã đăng ký tài khoản thành công",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                styleTitle: AppFonts.normalBold(
                                                    16,
                                                    const Color(0xff1F1F39)),
                                                customImage: Image.asset(
                                                  AppImages.registerSuccess,
                                                  height: 140,
                                                  width: 140,
                                                ),
                                                text1stButton: "Xong",
                                                onPress1stButton: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.loginScreen,
                                              );
                                            });
                                          } else {
                                            if (resStore.result != true) {
                                              return AppFunction
                                                  .showDialogError(context,
                                                      resStore.message);
                                            }
                                            if (resUser.result != true) {
                                              return AppFunction
                                                  .showDialogError(
                                                      context, resUser.message);
                                            }
                                          }
                                        }
                                      }),

                                  const SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
