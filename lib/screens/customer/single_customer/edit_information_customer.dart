import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/provider/group_customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class EditInformationCustomer extends BaseScreen {
  const EditInformationCustomer({super.key});

  @override
  EditInformationCustomerState createState() => EditInformationCustomerState();
}

class EditInformationCustomerState extends BaseState<EditInformationCustomer>
    with BaseScreenMixin {
  TextEditingController fullnameCustomer = TextEditingController();
  TextEditingController codeCustomer = TextEditingController();
  TextEditingController phoneCustomer = TextEditingController();
  TextEditingController emailCustomer = TextEditingController();
  TextEditingController numberCustomer = TextEditingController();
  TextEditingController addressCustomer = TextEditingController();
  TextEditingController noteCustomer = TextEditingController();
  String? selected;
  String? typeCustomer;
  int? typeCustomerId;
  int? groupCustomerId;
  int? id;
  int? imageId;
  String? imagePath;
  late String avatar;
  String? selectedStatus;
  String birthday = DateTime.now().toString();
  int? idProvince;
  int? idDistrict;
  int? idWard;
  String? status;
  ImageModel? image;

  initData() async {
    AppFunction.showLoading(context);
    var customer = Provider.of<CustomerProvider>(context, listen: false);
    fullnameCustomer = TextEditingController(text: customer.customer?.fullName);
    codeCustomer = TextEditingController(text: customer.customer?.code);
    phoneCustomer = TextEditingController(text: customer.customer?.phone);
    emailCustomer = TextEditingController(text: customer.customer?.email);
    numberCustomer = TextEditingController(text: customer.customer?.taxCode);
    addressCustomer = TextEditingController(text: customer.customer?.address);
    noteCustomer = TextEditingController(text: customer.customer?.note);
    id = customer.customer?.id;
    imageId = customer.customer?.avatar?.id;
    imagePath = customer.customer?.avatar?.filePath;
    if (customer.customer?.gender == "male") {
      selected = "Nam";
    } else if (customer.customer?.gender == "female") {
      selected = "Nữ";
    } else {
      selected = "";
    }
    if (customer.customer?.type == 2) {
      typeCustomer = "Công ty";
      typeCustomerId = customer.customer?.type;
    } else if (customer.customer?.type == 1) {
      typeCustomer = "Cá nhân";
      typeCustomerId = customer.customer?.type;
    } else {
      typeCustomer = "";
    }

    if (customer.customer?.status == "active") {
      selectedStatus = "Hoạt động";
      status = customer.customer?.status;
    } else if (customer.customer?.status == "inactive") {
      selectedStatus = "Ngưng hoạt động";
      status = customer.customer?.status;
    } else {
      selectedStatus = "";
    }
    groupCustomerId = customer.customer?.groupCustomerId;
    idProvince = customer.customer?.province?.id;
    idDistrict = customer.customer?.district?.id;
    idWard = customer.customer?.ward?.id;
    setState(() {});
    AppFunction.hideLoading(context);
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
    return "Chỉnh sửa thông tin KH";
  }

  @override
  Widget buildBody(BuildContext context) {
    // final data = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer2<CustomerProvider, GroupCustomerProvider>(builder: (
      context,
      customer,
      groupcustomer,
      child,
    ) {
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
                              hintText: "Tên khách hàng*",
                              controller: fullnameCustomer,
                            ),
                            MepharTextfield(
                              hintText: "Mã khách hàng",
                              controller: codeCustomer,
                              readOnly: true,
                            ),
                            MepharTextfield(
                              hintText: "Số điện thoại*",
                              controller: phoneCustomer,
                            ),
                            MepharTextfield(
                              hintText: "Email",
                              controller: emailCustomer,
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
                            ObjectDropdownButton(
                                havePadding: true,
                                hinText: customer.customer?.groupCustomer?.name,
                                listItems: groupcustomer.groupCustomerDropdown,
                                onChange: (value) {
                                  setState(() {
                                    groupCustomerId = value?.id;
                                  });
                                }),
                            MepharPickerDatetime(
                                icon: AppImages.iconCalendar,
                                labelText: "Ngày sinh",
                                onDateTimeChanged: (value) {
                                  setState(() {
                                    birthday =
                                        DateFormat('yyyy-MM-dd').format(value);
                                    // print(birthday);
                                  });
                                }),
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
                                      "Loại khách",
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
                                            title: "Cá nhân",
                                            isSelected:
                                                typeCustomer == "Cá nhân",
                                            onSelected: (customer) {
                                              setState(() {
                                                typeCustomer = customer;
                                                typeCustomerId = 1;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: MepharRadioButton(
                                            title: "Công ty",
                                            isSelected:
                                                typeCustomer == "Công ty",
                                            onSelected: (customer) {
                                              setState(() {
                                                typeCustomer = customer;
                                                typeCustomerId = 2;
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
                              labelText1: customer.customer?.province?.name,
                              labelText2: customer.customer?.district?.name,
                              labelText3: customer.customer?.ward?.name,
                            ),
                            typeCustomer == "Công ty"
                                ? MepharTextfield(
                                    hintText: "Mã số thuế",
                                    controller: numberCustomer,
                                  )
                                : const SizedBox(),
                            MepharTextfield(
                              hintText: "Địa chỉ",
                              controller: addressCustomer,
                            ),
                            MepharTextfield(
                              hintText: "Thêm ghi chú",
                              controller: noteCustomer,
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
                    if (AppFunction.checkFullName(
                            context, fullnameCustomer.text) &&
                        AppFunction.checkPhone(context, phoneCustomer.text) &&
                        AppFunction.checkEmail(context, emailCustomer.text) &&
                        AppFunction.checkGender(context, selected) &&
                        AppFunction.checkBirthDayCustomer(context, birthday) &&
                        AppFunction.checkGroupCustomer(
                            context, groupCustomerId)) {
                      ApiResponse res = await ApiRequest.editCustomer(
                        id,
                        fullnameCustomer.text,
                        phoneCustomer.text,
                        birthday,
                        selected == "Nam" ? "male" : "female",
                        typeCustomer == "Cá nhân" ? 1 : 2,
                        emailCustomer.text,
                        status ?? customer.customer?.status,
                        imageId,
                        idWard ?? customer.customer?.ward?.id,
                        idDistrict ?? customer.customer?.district?.id,
                        idProvince ?? customer.customer?.province?.id,
                        addressCustomer.text,
                        numberCustomer.text,
                        groupCustomerId ?? customer.customer?.groupCustomerId,
                        noteCustomer.text,
                      );
                      if (res.result == true) {
                        customer.listAllCustomer.clear();
                        customer.getDataCustomer("", 5, 1);
                        // customer.clearCustomer();
                        // customer.getCustomer(context, id!);
                        AppFunction.showDialogAlert(context,
                            title: "Cập nhật thông tin thành công",
                            text1stButton: "Đóng");

                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
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
