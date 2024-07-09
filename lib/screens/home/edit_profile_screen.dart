import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends BaseScreen {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends BaseState<EditProfileScreen> with BaseScreenMixin {
  String? selected;
  String selectedLanguage = "Tiếng Việt";
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserProvider userProvider = UserProvider();

  String get fullname => fullnameController.text;

  String get username => usernameController.text;

  String get role => roleController.text;

  String get phone => phoneController.text;

  String get time => timeController.text;

  String get address => addressController.text;

  String get facebook => facebookController.text;

  String get email => emailController.text;

  String? birthDay;
  String? selectedDateTime;

  ImageModel? image;
  int? imageId;
  String? imagePath;
  File? selectedImage;

  initData(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    fullnameController = TextEditingController(text: userProvider.userModel.fullName);
    usernameController = TextEditingController(text: userProvider.userModel.username);
    roleController = TextEditingController(text: userProvider.userModel.position);

    emailController = TextEditingController(text: userProvider.userModel.email);
    phoneController = TextEditingController(text: userProvider.userModel.phone);
    facebookController = TextEditingController(text: userProvider.userModel.email);
    addressController = TextEditingController(text: userProvider.userModel.store?.address);
    selected = userProvider.userModel.gender;
    birthDay = userProvider.userModel.birthday;
    imagePath = userProvider.userModel.avatar?.filePath;
    setState(() {});
    imageId = userProvider.userModel.avatar?.id;
    print(selected);
    print(birthDay);
    print(imageId);

    AppFunction.hideLoading(context);
  }

  Future fetchData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([context.read<UserProvider>().getUser(context)]).whenComplete(() {
      initData(context);
      AppFunction.hideLoading(context);
    });
  }

  @override
  String setTitle() {
    return "Trang cá nhân";
  }

  @override
  TextStyle setTextStyleTitle() {
    return AppFonts.normalBold(
      18,
      AppThemes.dark1,
    );
  }

  @override
  Color? setColorLeftWidget() {
    return AppThemes.dark1;
  }

  @override
  Color? setColorRightWidget() {
    return AppThemes.dark1;
  }

  @override
  Color? setHeaderBackgroundColor() {
    return Colors.white;
  }

  @override
  Widget? buildLeftWidget() {
    // TODO: implement buildLeftWidget
    return super.buildLeftWidget();
  }

  @override
  setOnPressLeftButton() {
    // TODO: implement setOnPressLeftButton
    return super.setOnPressLeftButton();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) => fetchData(context);

  @override
  showLoading() {
    // TODO: implement showLoading
    return super.showLoading();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.blue4,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                AppFunction.customBottomSheet(
                                    closeWhenTouch: true,
                                    context: context,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    body: ListView(
                                      children: [
                                        TouchableWidget(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            image = await AppFunction.pickCamera();
                                            if (image != null) {
                                              setState(() {
                                                imageId = image!.id;
                                                imagePath = image!.filePath;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle, color: Color(0xffECF3FD)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                        AppImages.iconCamera,
                                                        height: 24,
                                                        width: 24,
                                                        fit: BoxFit.cover,
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
                                                  style: AppFonts.regular(14, const Color(0xff1C1C28)),
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
                                          width: MediaQuery.of(context).size.width,
                                          color: const Color(0xffC7C9D9),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        TouchableWidget(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            image = await AppFunction.pickImage();
                                            if (image != null) {
                                              setState(() {
                                                imageId = image!.id;
                                                imagePath = image!.filePath;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle, color: Color(0xffECF3FD)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                        AppImages.iconGallery,
                                                        height: 24,
                                                        width: 24,
                                                        fit: BoxFit.cover,
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
                                                  style: AppFonts.regular(14, const Color(0xff1C1C28)),
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
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    imagePath != null
                                        ? Image.network(
                                            imagePath!,
                                            height: 128,
                                            width: 93,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 128,
                                            width: 93,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(color: Colors.blue),
                                            child: Text(
                                              (context.watch<UserProvider>().userModel.fullName?[0] ?? ""),
                                              style: AppFonts.bold(20, Colors.white),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 0,
                            //   right: 0,
                            //   child: InkWell(
                            //     onTap: () {
                            //       setState(() {
                            //         imageId = null;
                            //       });
                            //     },
                            //     child: Image.asset(
                            //       AppImages.iconRemove,
                            //       height: 16,
                            //       width: 16,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          MepharTextfield(
                            hintText: "Tên người dùng*",
                            controller: fullnameController,
                          ),
                          MepharTextfield(
                            hintText: "Tên đăng nhập*",
                            controller: usernameController,
                          ),
                          MepharTextfield(
                            hintText: "Vai trò*",
                            controller: roleController,
                          ),
                          MepharTextfield(
                            hintText: "Điện thoại*",
                            controller: phoneController,
                          ),
                          MepharPickerDatetime(
                            icon: AppImages.iconCalendar,
                            labelText: "Ngày sinh",
                            // dateTimeByText:
                            //     AppFunction.formatDateTimeFromApi(birthDay),

                            onDateTimeChanged: (value) {
                              setState(() {
                                selectedDateTime = DateFormat('yyyy-MM-dd').format(value);
                              });
                            },
                          ),
                          // MepharTextfield(
                          //   hintText: "Ngày sinh",
                          //   readOnly: true,
                          //   controller: TextEditingController(
                          //     text: birthDay,
                          //   ),
                          // ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.black26,
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 10, right: 16, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Giới tính",
                                    style: AppFonts.normalBold(
                                      12,
                                      AppThemes.gray,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MepharRadioButton(
                                          title: "Nam",
                                          isSelected: selected == "Nam",
                                          onSelected: (gender) {
                                            setState(() {
                                              selected = gender;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: MepharRadioButton(
                                          title: "Nữ",
                                          isSelected: selected == "Nữ",
                                          onSelected: (gender) {
                                            setState(() {
                                              selected = gender;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MepharTextfield(
                            hintText: "Địa chỉ",
                            controller: addressController,
                          ),
                          MepharTextfield(
                            hintText: "Facebook",
                            controller: facebookController,
                          ),
                          MepharTextfield(
                            hintText: "Email",
                            controller: emailController,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.black26,
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 10, right: 16, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ngôn ngữ",
                                    style: AppFonts.normalBold(
                                      12,
                                      AppThemes.gray,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MepharRadioButton(
                                          title: "Tiếng Việt",
                                          isSelected: selectedLanguage == "Tiếng Việt",
                                          onSelected: (language) {
                                            setState(() {
                                              selectedLanguage = language;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: MepharRadioButton(
                                          title: "Tiếng Anh",
                                          isSelected: selectedLanguage == "Tiếng Anh",
                                          onSelected: (language) {
                                            setState(() {
                                              selectedLanguage = language;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
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
                  if (AppFunction.checkEmail(context, emailController.text) &&
                      AppFunction.checkPhone(context, phoneController.text) &&
                      AppFunction.checkFullName(context, fullnameController.text) &&
                      AppFunction.checkBirthDayCustomer(context, selectedDateTime!) &&
                      AppFunction.checkGender(context, selected!) &&
                      imageId.toString().isNotEmpty == true) {
                    context.read<UserProvider>().updateProfile(
                          context,
                          fullnameController.text,
                          emailController.text,
                          selectedDateTime!,
                          imageId!,
                          selected!,
                        );
                  } else {
                    AppFunction.showDialogError(context, "Vui lòng điền đầy đủ thông tin");
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
