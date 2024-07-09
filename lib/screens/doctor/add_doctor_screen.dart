import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/doctor_provider.dart';
import 'package:mephar_app/provider/level_provider.dart';
import 'package:mephar_app/provider/specialist_provider.dart';
import 'package:mephar_app/provider/work_place_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class AddDoctorScreen extends BaseScreen {
  const AddDoctorScreen({super.key});

  @override
  AddDoctorScreenState createState() => AddDoctorScreenState();
}

class AddDoctorScreenState extends BaseState<AddDoctorScreen>
    with BaseScreenMixin {
  String? selectedGender;
  String? selectedStatus;
  String? typeCustomer;
  int? specicalistId;
  int? levelId;
  int? workPlaceId;
  int? status;
  TextEditingController nameDoctorController = TextEditingController();
  TextEditingController codeDoctorController = TextEditingController();
  TextEditingController phoneDoctorController = TextEditingController();
  TextEditingController emailDoctorController = TextEditingController();
  TextEditingController addressDoctorController = TextEditingController();
  TextEditingController noteDoctorController = TextEditingController();
  TextEditingController addNew = TextEditingController();

  int? idProvince;
  int? idDistrict;
  int? idWard;
  ImageModel? image;
  int? imageId;
  String? imagePath;

  getAddress() {
    idProvince =
        Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict =
        Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;
    setState(() {});
  }

  initData() async {
    AppFunction.showLoading(context);
    String specialist =
        await Provider.of<SpecialistProvider>(context, listen: false)
            .getListSpecialist(limit: 10, page: 1);
    String level =
        await Provider.of<LevelDoctorProvider>(context, listen: false)
            .getListLevelDoctor(limit: 10, page: 1);
    String workPlace =
        await Provider.of<WorkPlaceDoctorProvider>(context, listen: false)
            .getListWorkPlaceDoctor(limit: 10, page: 1);
    if (specialist == "success" &&
        level == "success" &&
        workPlace == "success") {
      AppFunction.hideLoading(context);
    } else {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(context, "Lỗi không xác định");
    }
  }

  String birthday = DateTime.now().toString();

  @override
  String setTitle() {
    return "Thêm bác sĩ";
  }

  @override
  TextStyle setTextStyleTitle() {
    return AppFonts.bold(18, Colors.white);
  }

  @override
  setOnPressRightButton() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initData());
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer4<DoctorProvider, LevelDoctorProvider, SpecialistProvider,
        WorkPlaceDoctorProvider>(
      builder: (context, doctor, level, specialist, workplace, child) {
        return Container(
          color: const Color(0xffF3FAFF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      imagePath == null
                          ? InkWell(
                              onTap: () {
                                AppFunction.customBottomSheet(
                                    closeWhenTouch: true,
                                    context: context,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    body: ListView(
                                      children: [
                                        TouchableWidget(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            image =
                                                await AppFunction.pickCamera();
                                            if (image != null) {
                                              setState(() {
                                                imageId = image!.id;
                                                imagePath = image!.path;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(
                                                              0xffECF3FD)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
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
                                                  style: AppFonts.regular(14,
                                                      const Color(0xff1C1C28)),
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
                                              MediaQuery.of(context).size.width,
                                          color: const Color(0xffC7C9D9),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        TouchableWidget(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            image =
                                                await AppFunction.pickImage();
                                            if (image != null) {
                                              setState(() {
                                                imageId = image!.id;
                                                imagePath = image!.path;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(
                                                              0xffECF3FD)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
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
                                                  style: AppFonts.regular(14,
                                                      const Color(0xff1C1C28)),
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
                                margin:
                                    const EdgeInsets.only(top: 7, bottom: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(
                                    AppImages.iconAddImage,
                                    height: 32,
                                    width: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 7, bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.network(
                                  "${ApiRequest.domain}$imagePath",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                  hintText: "Tên bác sĩ*",
                                  controller: nameDoctorController,
                                ),
                                MepharTextfield(
                                  hintText: "Mã bác sĩ",
                                  controller: codeDoctorController,
                                ),
                                MepharTextfield(
                                  hintText: "Email",
                                  controller: emailDoctorController,
                                ),
                                MepharTextfield(
                                  hintText: "Số điện thoại*",
                                  controller: phoneDoctorController,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.black26,
                                  ))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 10,
                                        right: 16,
                                        left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                isSelected:
                                                    selectedGender == "Nam",
                                                onSelected: (gender) {
                                                  setState(() {
                                                    selectedGender = gender;
                                                    // print(selectedGender);
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: MepharRadioButton(
                                                title: "Nữ",
                                                isSelected:
                                                    selectedGender == "Nữ",
                                                onSelected: (gender) {
                                                  setState(() {
                                                    selectedGender = gender;
                                                    // print(selectedGender);
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: ObjectDropdownButton(
                                          havePadding: true,
                                          hinText: "Chuyên khoa",
                                          listItems:
                                              specialist.dropDownSpecialist,
                                          onChange: (value) {
                                            setState(() {
                                              specicalistId = value?.id;
                                            });
                                            print(specicalistId);
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppFunction.showDialogAlert(
                                          context,
                                          isTwoButton: true,
                                          title: "Thêm chuyên khoa",
                                          widgetDescription: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: MepharInput(
                                              titleInput: "Tên chuyên khoa",
                                              controller: addNew,
                                            ),
                                          ),
                                          text1stButton: "Huỷ bỏ",
                                          text2ndButton: "Xong",
                                          onPress2ndButton: () async {
                                            ApiResponse resAdd =
                                                await ApiRequest
                                                    .addNewSpecialist(
                                              name: addNew.text,
                                            );
                                            if (resAdd.result == true) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              specialist.getListSpecialist(
                                                  limit: 10, page: 1);
                                              AppFunction.showDialogSuccess(
                                                  context,
                                                  content:
                                                      "Thêm mới thành công");
                                            } else {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              AppFunction.showDialogError(
                                                  context,
                                                  resAdd.message ??
                                                      "Lỗi không xác định");
                                            }
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        AppImages.iconAdd,
                                        height: 10,
                                        width: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ObjectDropdownButton(
                                          havePadding: true,
                                          hinText: "Trình độ",
                                          listItems: level.levelDoctorDropdown,
                                          onChange: (value) {
                                            setState(() {
                                              levelId = value?.id;
                                            });
                                            print(levelId);
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppFunction.showDialogAlert(
                                          context,
                                          isTwoButton: true,
                                          title: "Thêm trình độ",
                                          widgetDescription: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: MepharInput(
                                              titleInput: "Tên trình độ",
                                              controller: addNew,
                                            ),
                                          ),
                                          text1stButton: "Huỷ bỏ",
                                          text2ndButton: "Xong",
                                          onPress2ndButton: () async {
                                            ApiResponse resAdd =
                                                await ApiRequest.addNewLevel(
                                              name: addNew.text,
                                            );
                                            if (resAdd.result == true) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              specialist.getListSpecialist(
                                                  limit: 10, page: 1);
                                              AppFunction.showDialogSuccess(
                                                  context,
                                                  content:
                                                      "Thêm mới thành công");
                                            } else {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              AppFunction.showDialogError(
                                                  context,
                                                  resAdd.message ??
                                                      "Lỗi không xác định");
                                            }
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        AppImages.iconAdd,
                                        height: 10,
                                        width: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ObjectDropdownButton(
                                          havePadding: true,
                                          hinText: "Nơi công tác",
                                          listItems:
                                              workplace.workPlaceDoctorDropdown,
                                          onChange: (value) {
                                            setState(() {
                                              workPlaceId = value?.id;
                                            });
                                            print(workPlaceId);
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppFunction.showDialogAlert(
                                          context,
                                          isTwoButton: true,
                                          title: "Thêm nơi công tác",
                                          widgetDescription: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: MepharInput(
                                              titleInput: "Tên nơi công tác",
                                              controller: addNew,
                                            ),
                                          ),
                                          text1stButton: "Huỷ bỏ",
                                          text2ndButton: "Xong",
                                          onPress2ndButton: () async {
                                            ApiResponse resAdd =
                                                await ApiRequest
                                                    .addNewWorkPlace(
                                              name: addNew.text,
                                            );
                                            if (resAdd.result == true) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              specialist.getListSpecialist(
                                                  limit: 10, page: 1);
                                              AppFunction.showDialogSuccess(
                                                  context,
                                                  content:
                                                      "Thêm mới thành công");
                                            } else {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              AppFunction.showDialogError(
                                                  context,
                                                  resAdd.message ??
                                                      "Lỗi không xác định");
                                            }
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        AppImages.iconAdd,
                                        height: 10,
                                        width: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                const DropdownAddressWidget(
                                  havePadding: true,
                                ),
                                MepharTextfield(
                                  hintText: "Địa chỉ",
                                  controller: addressDoctorController,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.black26,
                                  ))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 10,
                                        right: 16,
                                        left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Trạng thái hoạt động",
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
                                                title: "Hoạt động",
                                                isSelected: selectedStatus ==
                                                    "Hoạt động",
                                                onSelected: (active) {
                                                  setState(() {
                                                    selectedStatus = active;
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: MepharRadioButton(
                                                title: "Ngưng hoạt động",
                                                isSelected: selectedStatus ==
                                                    "Ngưng hoạt động",
                                                onSelected: (disable) {
                                                  setState(() {
                                                    selectedStatus = disable;
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
                                  hintText: "Ghi chú",
                                  controller: noteDoctorController,
                                ),
                              ],
                            ),
                          )),
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
                      AppFunction.showLoading(context);
                      getAddress();
                      print(idWard);
                      if (AppFunction.checkFullName(
                              context, nameDoctorController.text) &&
                          AppFunction.checkEmail(
                              context, emailDoctorController.text) &&
                          AppFunction.checkPhone(
                              context, phoneDoctorController.text) &&
                          // AppFunction.checkTypeCustomer(
                          //     context, typeCustomerId) &&
                          // AppFunction.checkBirthDayCustomer(
                          //     context, birthday) &&
                          AppFunction.checkGender(context, selectedGender) &&
                          // AppFunction.checkStatusCustomer(
                          //     context, selectedStatus) &&
                          // AppFunction.checkGroupCustomer(
                          //     context, groupCustomerId) &&
                          AppFunction.checkAddress(
                              context, idProvince, idDistrict, idWard)) {
                        // print("ok");
                        ApiResponse res = await ApiRequest.creatNewDoctor(
                          name: nameDoctorController.text,
                          phone: phoneDoctorController.text,
                          gender: selectedGender == "Nam" ? "male" : "female",
                          email: emailDoctorController.text,
                          status: selectedStatus == "Hoạt động" ? 1 : 2,
                          wardId: idWard,
                          districtId: idDistrict,
                          provinceId: idProvince,
                          address: addressDoctorController.text,
                          note: noteDoctorController.text,
                          levelId: levelId,
                          specialistId: specicalistId,
                          workPlaceId: workPlaceId,
                          code: codeDoctorController.text,
                        );
                        if (res.result == true) {
                          doctor.listDoctor.clear();
                          Navigator.pop(context);
                          AppFunction.hideLoading(context);
                          AppFunction.showDialogAlert(context,
                              title: "Thêm mới bác sĩ thành công",
                              text1stButton: "Đóng");

                          await doctor.getListDoctor();
                          Navigator.pop(context);
                        } else {
                          AppFunction.hideLoading(context);
                          AppFunction.showDialogError(
                              context, res.message ?? "Lỗi không xác định");
                        }
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
