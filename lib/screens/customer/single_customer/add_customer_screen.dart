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

class AddCustomerScreen extends BaseScreen {
  const AddCustomerScreen({super.key});

  @override
  AddCustomerScreenState createState() => AddCustomerScreenState();
}

class AddCustomerScreenState extends BaseState<AddCustomerScreen> with BaseScreenMixin {
  String? selectedGender;
  String? selectedStatus;
  String? typeCustomer;
  int? typeCustomerId;
  int? groupCustomerId;
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController taxCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController numberBusiness = TextEditingController();

  int? idProvince;
  int? idDistrict;
  int? idWard;
  ImageModel? image;
  int? imageId;
  String? imagePath;

  getAddress() {
    idProvince = Provider.of<AddressProvider>(context, listen: false).provinceValue?.id;
    idDistrict = Provider.of<AddressProvider>(context, listen: false).districtValue?.id;
    idWard = Provider.of<AddressProvider>(context, listen: false).wardValue?.id;
    setState(() {});
  }

  String birthday = DateTime.now().toString();

  @override
  String setTitle() {
    return "Thêm khách hàng";
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<GroupCustomerProvider>().getDataGroupCustomer("", 1, 20));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<CustomerProvider, GroupCustomerProvider>(
      builder: (context, customer, groupcustomer, child) {
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
                                                imagePath = image!.path;
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
                                                imagePath = image!.path;
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
                                margin: const EdgeInsets.only(top: 7, bottom: 16),
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
                                  hintText: "Tên khách hàng*",
                                  controller: nameController,
                                ),
                                MepharTextfield(
                                  hintText: "Email",
                                  controller: emailController,
                                ),
                                MepharTextfield(
                                  hintText: "Số điện thoại*",
                                  controller: phoneController,
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
                                    padding: const EdgeInsets.only(top: 4, bottom: 10, right: 16, left: 16),
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
                                                isSelected: typeCustomer == "Cá nhân",
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
                                                isSelected: typeCustomer == "Công ty",
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
                                MepharPickerDatetime(
                                    icon: AppImages.iconCalendar,
                                    labelText: "Ngày sinh",
                                    onDateTimeChanged: (value) {
                                      setState(() {
                                        birthday = DateFormat('yyyy-MM-dd').format(value);
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
                                                isSelected: selectedGender == "Nam",
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
                                                isSelected: selectedGender == "Nữ",
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
                                    padding: const EdgeInsets.only(top: 4, bottom: 10, right: 16, left: 16),
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
                                                isSelected: selectedStatus == "Hoạt động",
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
                                                isSelected: selectedStatus == "Ngưng hoạt động",
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
                                ObjectDropdownButton(
                                    havePadding: true,
                                    hinText: "Nhóm khách hàng",
                                    listItems: groupcustomer.groupCustomerDropdown,
                                    onChange: (value) {
                                      setState(() {
                                        groupCustomerId = value?.id;
                                      });
                                    }),
                                const SizedBox(
                                  height: 1,
                                ),
                                const DropdownAddressWidget(
                                  havePadding: true,
                                ),
                                typeCustomer == "Công ty"
                                    ? MepharTextfield(
                                        hintText: "Mã số thuế",
                                        controller: taxCodeController,
                                      )
                                    : const SizedBox(),
                                MepharTextfield(
                                  hintText: "Địa chỉ",
                                  controller: addressController,
                                ),
                                MepharTextfield(
                                  hintText: "Thêm ghi chú",
                                  controller: noteController,
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
                      getAddress();
                      // print(idWard);
                      if (AppFunction.checkFullName(context, nameController.text) &&
                          AppFunction.checkEmail(context, emailController.text) &&
                          AppFunction.checkPhone(context, phoneController.text) &&
                          AppFunction.checkTypeCustomer(context, typeCustomerId) &&
                          AppFunction.checkBirthDayCustomer(context, birthday) &&
                          AppFunction.checkGender(context, selectedGender) &&
                          AppFunction.checkStatusCustomer(context, selectedStatus) &&
                          AppFunction.checkGroupCustomer(context, groupCustomerId) &&
                          AppFunction.checkAddress(context, idProvince, idDistrict, idWard)) {
                        // print("ok");
                        ApiResponse res = await ApiRequest.creatNewCustomer(
                          nameController.text,
                          phoneController.text,
                          birthday,
                          selectedGender == "Nam" ? "male" : "female",
                          typeCustomer == "Cá nhân" ? 1 : 2,
                          emailController.text,
                          selectedStatus == "Hoạt động" ? "active" : "inactive",
                          imageId,
                          idWard,
                          idDistrict,
                          idProvince,
                          addressController.text,
                          taxCodeController.text,
                          groupCustomerId,
                          noteController.text,
                        );
                        if (res.result == true) {
                          customer.listAllCustomer.clear();
                          AppFunction.showDialogAlert(context,
                              title: "Thêm mới khách hàng thành công", text1stButton: "Đóng");

                          await customer.refreshCustomerList(context);
                          Navigator.pop(context);
                        } else {
                          AppFunction.showDialogError(context, res.message ?? "Lỗi không xác định");
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
