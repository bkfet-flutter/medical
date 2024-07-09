import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/store_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/address_provider.dart';
import 'package:mephar_app/provider/store_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/address.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:provider/provider.dart';

class StoreInformationScreen extends BaseScreen {
  const StoreInformationScreen({super.key});

  @override
  StoreInformationScreenState createState() => StoreInformationScreenState();
}

class StoreInformationScreenState extends BaseState<StoreInformationScreen> with BaseScreenMixin {
  TextEditingController nameStoreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController businessRegistrationNumber = TextEditingController();
  TextEditingController addressController = TextEditingController();

  StoreProvider storeProvider = StoreProvider();

  String get name => nameStoreController.text;

  String get email => emailController.text;

  String get phone => phoneController.text;

  String get numberRegister => businessRegistrationNumber.text;

  String get address => addressController.text;

  initData(BuildContext context) {
    storeProvider = Provider.of<StoreProvider>(context, listen: false);
    nameStoreController = TextEditingController(text: storeProvider.storeModel.name);
    emailController = TextEditingController(text: storeProvider.storeModel.email);
    phoneController = TextEditingController(text: storeProvider.storeModel.phone);
    businessRegistrationNumber = TextEditingController(text: storeProvider.storeModel.businessRegistrationNumber);
    addressController = TextEditingController(text: storeProvider.storeModel.address);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    Future.wait([
      addressProvider.selectProvince(storeProvider.storeModel.province),
      addressProvider.selectDistrict(storeProvider.storeModel.district),
      addressProvider.selectWard(storeProvider.storeModel.ward),
    ]);
    setState(() {});
  }

  Future fetchData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([context.read<StoreProvider>().getStore(context)]).whenComplete(() {
      initData(context);
      AppFunction.hideLoading(context);
    });
  }

  @override
  String setTitle() {
    return "Thông tin cửa hàng";
  }

  @override
  Color setMainBackgroundColor() {
    return AppThemes.white;
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) => fetchData(context);

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<StoreProvider>(
            builder: (context, provider, child) {
              return ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  ..._buildInfo(),
                  ..._buildAddress(),
                  ..._buildDateTime(provider.storeModel.createdAt, ""),
                  ..._buildLogo()
                ].addBetween(const SizedBox(height: 16)),
              );
            },
          ),
        ),
        _buildButtonUpdate(context)
      ],
    );
  }

  Widget _buildHeaderText(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xffF3FAFF),
      child: Text(
        text,
        style: AppFonts.normalBold(
          16,
          AppThemes.dark1,
        ),
      ),
    );
  }

  Widget _buildButtonUpdate(BuildContext context) {
    return Consumer2<AddressProvider, StoreProvider>(builder: (context, addressProvider, store, child) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
          child: MepharButton(
            titleButton: "Lưu",
            onPressed: () => context.read<StoreProvider>().updateStore(
                  context,
                  data: StoreModel(
                      name: name,
                      email: email,
                      phone: phone,
                      businessRegistrationNumber: numberRegister,
                      provinceId: addressProvider.provinceValue?.id,
                      districtId: addressProvider.districtValue?.id,
                      wardId: addressProvider.wardValue?.id,
                      address: address),
                ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildInfo() {
    return [
      _buildHeaderText("Thông tin liên hệ"),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: _listTextField().addBetween(const SizedBox(height: 16))),
      )
    ];
  }

  List<Widget> _listTextField() {
    return [
      MepharTextfield(
        hintText: "Tên cửa hàng*",
        controller: nameStoreController,
      ),
      MepharTextfield(
        hintText: "Địa chỉ email *",
        controller: emailController,
      ),
      MepharTextfield(
        hintText: "Số điện thoại*",
        controller: phoneController,
      ),
      MepharTextfield(
        hintText: "Số đăng ký kinh doanh*",
        controller: businessRegistrationNumber,
      ),
    ];
  }

  List<Widget> _buildAddress() {
    return [
      _buildHeaderText("Địa chỉ cửa hàng"),
      Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const DropdownAddressWidget(
                havePadding: true,
              ),
              const SizedBox(height: 16),
              MepharTextfield(
                hintText: "Địa chỉ*",
                controller: addressController,
              ),
            ],
          ))
    ];
  }

  List<Widget> _buildDateTime(String? create, String? end) {
    return [
      _buildHeaderText("Thông tin tài khoản"),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            MepharTextfield(
              hintText: "Ngày tạo",
              readOnly: true,
              controller: TextEditingController(
                text: AppFunction.formatDateTimeFromApi(create),
              ),
            ),
            const SizedBox(height: 16),
            MepharTextfield(
              hintText: "Ngày hết hạn",
              readOnly: true,
              controller: TextEditingController(),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _buildLogo() {
    return [
      Consumer<StoreProvider>(builder: (context, store, child) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  store.storeModel.logo?.path != null
                      ? Image.network(
                          '${ApiRequest.domain}${store.storeModel.logo?.path}',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppImages.avatarCustomer,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                  Positioned(
                    bottom: 12,
                    right: 61.5,
                    left: 60.5,
                    child: InkWell(
                      onTap: () => store.changeLogo(),
                      child: Image.asset(
                        AppImages.productAdd,
                        height: 28,
                        width: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Dung lượng tối đa ảnh tải lên là 2 MB (.PNG .JPG .JPEG .GIF)",
              textAlign: TextAlign.center,
              style: AppFonts.light(
                12,
                AppThemes.dark3,
              ),
            )
          ],
        );
      }),
    ];
  }
}
