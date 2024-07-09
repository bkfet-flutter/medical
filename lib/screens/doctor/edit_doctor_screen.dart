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

class EditInformationDoctor extends BaseScreen {
  const EditInformationDoctor({super.key});

  @override
  EditInformationDoctorState createState() => EditInformationDoctorState();
}

class EditInformationDoctorState extends BaseState<EditInformationDoctor>
    with BaseScreenMixin {
  TextEditingController nameDoctor = TextEditingController();
  TextEditingController codeDoctor = TextEditingController();
  TextEditingController phoneDoctor = TextEditingController();
  TextEditingController emailDoctor = TextEditingController();
  TextEditingController addressDoctor = TextEditingController();
  TextEditingController noteDoctor = TextEditingController();
  TextEditingController addNew = TextEditingController();
  String? selected;
  int? id;
  int? imageId;
  String? imagePath;
  late String avatar;
  String? selectedStatus;
  int? specicalistId;
  int? levelId;
  int? workPlaceId;
  int? idProvince;
  int? idDistrict;
  int? idWard;
  String? status;
  String? specialistName;
  String? levelName;
  String? workPlaceName;
  ImageModel? image;

  initData() async {
    AppFunction.showLoading(context);
    var doctor = Provider.of<DoctorProvider>(context, listen: false);
    nameDoctor = TextEditingController(text: doctor.doctor?.name);
    codeDoctor = TextEditingController(text: doctor.doctor?.code);
    phoneDoctor = TextEditingController(text: doctor.doctor?.phone);
    emailDoctor = TextEditingController(text: doctor.doctor?.email);
    addressDoctor = TextEditingController(text: doctor.doctor?.address);
    noteDoctor = TextEditingController(text: doctor.doctor?.note);
    id = doctor.doctor?.id;
    specicalistId = doctor.doctor?.specialistId;
    levelId = doctor.doctor?.levelId;
    workPlaceId = doctor.doctor?.workPlaceId;
    specialistName = doctor.doctor?.specialist?.name;
    levelName = doctor.doctor?.level?.name;
    workPlaceName = doctor.doctor?.workPlace?.name;

    if (doctor.doctor?.gender == "male") {
      selected = "Nam";
    } else if (doctor.doctor?.gender == "female") {
      selected = "Nữ";
    } else {
      selected = "";
    }

    if (doctor.doctor?.status == 1) {
      selectedStatus = "Hoạt động";
      // status = doctor.doctor?.status;
    } else if (doctor.doctor?.status == 2) {
      selectedStatus = "Ngưng hoạt động";
      // status = doctor.doctor?.status;
    } else {
      selectedStatus = "";
    }
    idProvince = doctor.doctor?.province?.id;
    idDistrict = doctor.doctor?.district?.id;
    idWard = doctor.doctor?.ward?.id;
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
    setState(() {});
  }

  getAddress(BuildContext context) {
    idProvince =
        Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict =
        Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    initData();
  }

  @override
  String setTitle() {
    return "Chỉnh sửa thông tin bác sĩ";
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              AppFunction.customBottomSheet(
                                  closeWhenTouch: true,
                                  context: context,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
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
                                              imagePath = image!.filePath;
                                            });
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffECF3FD)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffECF3FD)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, right: 0),
                                child: Column(
                                  children: [
                                    imagePath != null
                                        ? Image.network(
                                            imagePath!,
                                            height: 128,
                                            width: 93,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            AppImages.defaultAvatar,
                                            height: 128,
                                            width: 93,
                                            fit: BoxFit.cover,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              controller: nameDoctor,
                            ),
                            MepharTextfield(
                              hintText: "Mã bác sĩ",
                              controller: codeDoctor,
                              readOnly: true,
                            ),
                            MepharTextfield(
                              hintText: "Số điện thoại*",
                              controller: phoneDoctor,
                            ),
                            MepharTextfield(
                              hintText: "Email",
                              controller: emailDoctor,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.black26,
                              ))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 10, right: 16, left: 16),
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
                            Row(
                              children: [
                                Expanded(
                                  child: ObjectDropdownButton(
                                      havePadding: true,
                                      hinText: specialistName,
                                      listItems: specialist.dropDownSpecialist,
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
                                            await ApiRequest.addNewSpecialist(
                                          name: addNew.text,
                                        );
                                        if (resAdd.result == true) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          specialist.getListSpecialist(
                                              limit: 10, page: 1);
                                          AppFunction.showDialogSuccess(context,
                                              content: "Thêm mới thành công");
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
                                      hinText: levelName,
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
                                          AppFunction.showDialogSuccess(context,
                                              content: "Thêm mới thành công");
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
                                      hinText: workPlaceName,
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
                                            await ApiRequest.addNewWorkPlace(
                                          name: addNew.text,
                                        );
                                        if (resAdd.result == true) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          specialist.getListSpecialist(
                                              limit: 10, page: 1);
                                          AppFunction.showDialogSuccess(context,
                                              content: "Thêm mới thành công");
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
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.black26,
                              ))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 10, right: 16, left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            isSelected:
                                                selectedStatus == "Hoạt động",
                                            onSelected: (value) {
                                              setState(() {
                                                selectedStatus = value;
                                                status = "active";
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: MepharRadioButton(
                                            title: "Ngưng hoạt động",
                                            isSelected: selectedStatus ==
                                                "Ngưng hoạt động",
                                            onSelected: (value) {
                                              setState(() {
                                                selectedStatus = value;
                                                status = "inactive";
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
                              height: 10,
                            ),
                            DropdownAddressWidget(
                              paddingText: true,
                              havePadding: false,
                              hideText: true,
                              labelText1: doctor.doctor?.province?.name,
                              labelText2: doctor.doctor?.district?.name,
                              labelText3: doctor.doctor?.ward?.name,
                            ),
                            MepharTextfield(
                              hintText: "Địa chỉ",
                              controller: addressDoctor,
                            ),
                            MepharTextfield(
                              hintText: "Thêm ghi chú",
                              controller: noteDoctor,
                            ),
                          ],
                        ),
                      ),
                    )
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
                    print(status);
                    if (AppFunction.checkFullName(context, nameDoctor.text) &&
                            AppFunction.checkEmail(context, emailDoctor.text) &&
                            AppFunction.checkPhone(context, phoneDoctor.text)
                        // AppFunction.checkTypeCustomer(
                        //     context, typeCustomerId) &&
                        // AppFunction.checkBirthDayCustomer(
                        //     context, birthday) &&
                        // AppFunction.checkGender(context, selectedGender) &&
                        // AppFunction.checkStatusCustomer(
                        //     context, selectedStatus) &&
                        // AppFunction.checkGroupCustomer(
                        //     context, groupCustomerId) &&
                        // AppFunction.checkAddress(
                        //     context, idProvince, idDistrict, idWard)
                        ) {
                      // print("ok");
                      ApiResponse res = await ApiRequest.editDoctor(
                        id: id,
                        name: nameDoctor.text,
                        phone: phoneDoctor.text,
                        gender: selected == "Nam" ? "male" : "female",
                        email: emailDoctor.text,
                        status: selectedStatus == "Hoạt động" ? 1 : 2,
                        wardId: idWard ?? doctor.doctor?.ward?.id,
                        districtId: idDistrict ?? doctor.doctor?.district?.id,
                        provinceId: idProvince ?? doctor.doctor?.province?.id,
                        address: addressDoctor.text,
                        note: noteDoctor.text,
                        levelId: levelId,
                        specialistId: specicalistId,
                        workPlaceId: workPlaceId,
                        code: codeDoctor.text,
                      );
                      if (res.result == true) {
                        doctor.listDoctor.clear();
                        Navigator.pop(context);
                        AppFunction.hideLoading(context);
                        AppFunction.showDialogAlert(context,
                            title: "Cập nhật thông tin thành công",
                            text1stButton: "Đóng");

                        await doctor.getListDoctor();
                        Navigator.pop(context);
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
    });
  }
}
