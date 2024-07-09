import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/model/unit_product_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/country_produce_provider.dart';
import 'package:mephar_app/provider/dosage_provider.dart';
import 'package:mephar_app/provider/group_product_provider.dart';
import 'package:mephar_app/provider/manufacture_provider.dart';
import 'package:mephar_app/provider/medicine_provider.dart';
import 'package:mephar_app/provider/position_provider.dart';
import 'package:mephar_app/provider/product/product_provider.dart';

import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/product/medicine/add_information_unit.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/header_add_product.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_checkbox.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class AddNewProductScreen extends BaseScreen {
  const AddNewProductScreen({super.key});

  @override
  AddNewProductScreenState createState() => AddNewProductScreenState();
}

class AddNewProductScreenState extends BaseState<AddNewProductScreen>
    with BaseScreenMixin {
  int _currentIndex = 0;
  Color colorBackground1 = Colors.white;
  Color colorText1 = AppThemes.red0;
  Color colorBackground2 = const Color(0xff767680).withOpacity(0.12);
  Color colorText2 = AppThemes.dark1;
  bool checkWarning = false;
  TextEditingController codeProduct = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController nameProduct = TextEditingController();
  TextEditingController shortNameProduct = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController inventoryProduct = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController warningDate = TextEditingController();
  TextEditingController baseUnit = TextEditingController();
  TextEditingController packingSpecification = TextEditingController();
  TextEditingController addNew = TextEditingController();
  List<UnitProductsModel> listUnitProducts = [];
  List<Map<String, Object>> productUnits = [];
  String? imagePath;
  int? imageId;
  int? positionId;
  ImageModel? image;
  int? groupProductId;
  int? manufactureId;
  int? countryProduceId;
  int? branchId;
  initData() async {
    AppFunction.showLoading(context);
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;
    branchId = branch?.id;
    String dosage = await Provider.of<DosageProvider>(context, listen: false)
        .getListDosage(limit: 10, page: 1);
    String position =
        await Provider.of<PositionProvider>(context, listen: false)
            .getListPosition(limit: 10, page: 1);
    String groupProduct =
        await Provider.of<GroupProductProvider>(context, listen: false)
            .getListGroupProduct(
      limit: 10,
      page: 1,
    );
    String manufacture =
        await Provider.of<ManufactureProvider>(context, listen: false)
            .getListManufacture(limit: 10, page: 1, keyword: "");
    String countryProduce =
        await Provider.of<CountryProduceProvider>(context, listen: false)
            .getListCountryProduce(limit: 10, page: 1, keyword: "");
    if (dosage == "success" &&
        position == "success" &&
        groupProduct == "success" &&
        manufacture == "success" &&
        countryProduce == "success") {
      AppFunction.hideLoading(context);
    } else {
      AppFunction.showDialogError(context, "Lỗi không xác định");
    }
  }

  @override
  String setTitle() {
    return "Thêm hàng hóa";
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    super.afterFirstLayout(context);
    initData();
  }

  @override
  setOnPressLeftButton() {
    // TODO: implement setOnPressLeftButton
    return super.setOnPressLeftButton();
  }

  @override
  TextStyle setTextStyleTitle() {
    return AppFonts.normalBold(18, Colors.white);
  }

  @override
  setOnPressRightButton() {
    Navigator.pop(context);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer5<DosageProvider, PositionProvider, GroupProductProvider,
            ManufactureProvider, CountryProduceProvider>(
        builder: (context, dosage, position, groupProduct, manufacture, country,
            child) {
      return Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 7, bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
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
                                    const EdgeInsets.only(top: 8, right: 8),
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
                                            AppImages.iconAddImage,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              MepharTextfield(
                                hintText: "Mã hàng",
                                controller: codeProduct,
                              ),
                              MepharTextfield(
                                hintText: "Mã vạch",
                                controller: barcode,
                              ),
                              MepharTextfield(
                                hintText: "Tên hàng hóa",
                                controller: nameProduct,
                              ),
                              MepharTextfield(
                                hintText: "Tên viết tắt",
                                controller: shortNameProduct,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ObjectDropdownButton(
                                        havePadding: true,
                                        hinText: "Nhóm",
                                        listItems:
                                            groupProduct.groupProductDropDown,
                                        onChange: (value) {
                                          setState(() {
                                            groupProductId = value?.id;
                                          });
                                          print(groupProductId);
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AppFunction.showDialogAlert(
                                        context,
                                        isTwoButton: true,
                                        title: "Thêm nhóm",
                                        widgetDescription: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: MepharInput(
                                            titleInput: "Nhóm",
                                            controller: addNew,
                                          ),
                                        ),
                                        text1stButton: "Huỷ bỏ",
                                        text2ndButton: "Xong",
                                        onPress2ndButton: () async {
                                          ApiResponse resAdd = await ApiRequest
                                              .addNewGroupProduct(
                                            name: addNew.text,
                                          );
                                          if (resAdd.result == true) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            groupProduct.getListGroupProduct(
                                                limit: 10, page: 1);
                                            AppFunction.showDialogSuccess(
                                                context,
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
                                        hinText: "Vị trí",
                                        listItems: position.positionDropdown,
                                        onChange: (value) {
                                          setState(() {
                                            positionId = value?.id;
                                          });
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AppFunction.showDialogAlert(
                                        context,
                                        isTwoButton: true,
                                        title: "Thêm vị trí",
                                        widgetDescription: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: MepharInput(
                                            titleInput: "Vị trí",
                                            controller: addNew,
                                          ),
                                        ),
                                        text1stButton: "Huỷ bỏ",
                                        text2ndButton: "Xong",
                                        onPress2ndButton: () async {
                                          ApiResponse resAdd =
                                              await ApiRequest.addNewPosition(
                                            name: addNew.text,
                                          );
                                          if (resAdd.result == true) {
                                            setState(() {});
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            position.getListPosition(
                                                limit: 10, page: 1);
                                            AppFunction.showDialogSuccess(
                                                context,
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
                              MepharTextfield(
                                hintText: "Trọng lượng",
                                controller: weight,
                              ),
                              MepharTextfield(
                                hintText: "Quy cách đóng gói",
                                controller: packingSpecification,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ObjectDropdownButton(
                                        havePadding: true,
                                        hinText: "Hãng sản xuất",
                                        listItems:
                                            manufacture.manufactureDropdown,
                                        onChange: (value) {
                                          setState(() {
                                            manufactureId = value?.id;
                                          });
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AppFunction.showDialogAlert(
                                        context,
                                        isTwoButton: true,
                                        title: "Thêm hãng sản xuất",
                                        widgetDescription: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: MepharInput(
                                            titleInput: "Hãng sản xuất",
                                            controller: addNew,
                                          ),
                                        ),
                                        text1stButton: "Huỷ bỏ",
                                        text2ndButton: "Xong",
                                        onPress2ndButton: () async {
                                          ApiResponse resAdd = await ApiRequest
                                              .addNewManufacture(
                                            name: addNew.text,
                                          );
                                          if (resAdd.result == true) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            manufacture.getListManufacture(
                                                limit: 10, page: 1);
                                            AppFunction.showDialogSuccess(
                                                context,
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
                              ObjectDropdownButton(
                                  havePadding: true,
                                  hinText: "Nước sản xuất",
                                  listItems: country.countryProduceDropdown,
                                  onChange: (value) {
                                    setState(() {
                                      countryProduceId = value?.id;
                                    });
                                  }),
                              checkWarning == true
                                  ? const SizedBox.shrink()
                                  : MepharTextfield(
                                      hintText: "Tồn kho",
                                      controller: inventoryProduct,
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              MepharCheckbox(
                                isChecked: checkWarning,
                                text: "Lô, hạn sử dụng",
                                onTap: () {
                                  setState(() {
                                    checkWarning = !checkWarning;
                                  });
                                },
                              ),
                              checkWarning == true
                                  ? MepharTextfield(
                                      hintText: "Cảnh báo hết hạn",
                                      controller: warningDate,
                                    )
                                  : const SizedBox(
                                      height: 10,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const HeaderAddProduct(
                                icon: AppImages.iconTagBlue,
                                title: "Giá sản phẩm",
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: MepharTextfield(
                                      hintText: "Giá vốn",
                                      controller: price,
                                      onChanged: (value) {
                                        price.text =
                                            AppFunction.formatStringNum(value);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: MepharTextfield(
                                      hintText: "Giá bán",
                                      controller: salePrice,
                                      onChanged: (value) {
                                        salePrice.text =
                                            AppFunction.formatStringNum(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              MepharTextfield(
                                hintText: "Đơn vị cơ bản",
                                controller: baseUnit,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      listUnitProducts.isEmpty
                          ? const SizedBox.shrink()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listUnitProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: AddInformationUnit(
                                    unitProductsModel: listUnitProducts[index],
                                    // ignore: unnecessary_null_comparison
                                    price: AppFunction.formatStringToNum(
                                        salePrice.text),
                                  ),
                                );
                              }),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Column(
                            children: [
                              HeaderAddProduct(
                                title: "Thêm đơn vị",
                                haveRemoveFunction: () {
                                  setState(() {
                                    if (listUnitProducts.isNotEmpty) {
                                      listUnitProducts.removeLast();
                                      // Xóa phần tử tương ứng trong productUnits
                                      if (productUnits.isNotEmpty) {
                                        productUnits.removeLast();
                                      }
                                    } else {
                                      AppFunction.showDialogError(
                                          context, "Không thể thao tác");
                                    }
                                  });
                                },
                                haveAddFunction: () {
                                  setState(() {
                                    listUnitProducts.add(
                                      UnitProductsModel(
                                        barCode: TextEditingController(),
                                        name: TextEditingController(),
                                        point: TextEditingController(),
                                        salePrice: TextEditingController(),
                                        codeUnit: TextEditingController(),
                                        value: TextEditingController(),
                                      ),
                                    );
                                  });
                                },
                                haveButtonAdd: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppDimens.spaceXSmall10),
                          child: MepharButton(
                            titleButton: "Thêm",
                            onPressed: () async {
                              // AppFunction.showLoading(context);
                              productUnits = listUnitProducts
                                  .map((e) => {
                                        "unitName": e.name.text,
                                        "exchangeValue":
                                            int.parse(e.value.text),
                                        "isBaseUnit": false,
                                        "isDirectSale": false,
                                        "barCode": "",
                                        "point": e.point.text.isEmpty
                                            ? 0
                                            : int.parse(e.point.text),
                                        "price": AppFunction.formatStringToNum(
                                            e.salePrice.text)
                                      })
                                  .toList();

                              if (true == true) {
                                Map<String, Object> baseProduct = {
                                  "unitName": baseUnit.text,
                                  "exchangeValue": 1,
                                  "isBaseUnit": true,
                                  "isDirectSale": false,
                                  "barCode": codeProduct.text,
                                  "point": 10,
                                  "price": AppFunction.formatStringToNum(
                                      salePrice.text)
                                };

                                productUnits.add(baseProduct);

                                ApiResponse resAdd =
                                    await ApiRequest.addProduct(
                                  name: nameProduct.text,
                                  // code: codeProduct.text,
                                  barCode: barcode.text,
                                  branchId: branchId,
                                  positionId: positionId,
                                  manufactureId: manufactureId,
                                  groupProductId: groupProductId,
                                  countryId: countryProduceId,
                                  price:
                                      AppFunction.formatStringToNum(price.text),
                                  weight: weight.text,
                                  baseUnit: baseUnit.text,
                                  isDirectSale: false,
                                  exchangeValue: 1,
                                  isBaseUnit: true,
                                  point: "",
                                  unitName: baseUnit.text,
                                  imageId: imageId,
                                  isBatchExpireControl: true,
                                  primePrice: AppFunction.formatStringToNum(
                                      salePrice.text),
                                  shortName: shortNameProduct.text,
                                  inventory: AppFunction.formatStringToNum(
                                      inventoryProduct.text),
                                  packingSpecification:
                                      packingSpecification.text,
                                  productUnits: productUnits,
                                );
                                if (resAdd.result == true) {
                                  context
                                      .read<ProductProvider>()
                                      .fetchProducts(context, firstCall: true);
                                  AppFunction.hideLoading(context);
                                  Navigator.pop(context);
                                  AppFunction.showDialogSuccess(context,
                                      content: "Thêm mới sản phẩm thành công");
                                } else {
                                  AppFunction.hideLoading(context);
                                  AppFunction.showDialogError(context,
                                      resAdd.message ?? "Lỗi không xác định");
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 7, bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: InkWell(
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
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
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
                                              AppImages.iconAddImage,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const HeaderAddProduct(
                                icon: AppImages.iconInfo,
                                title: "Định mức tồn",
                              ),
                              MepharTextfield(hintText: "Ít nhất"),
                              MepharTextfield(hintText: "Nhiều nhất"),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              MepharTextfield(
                                hintText: "Mô tả",
                                maxLines: 4,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              MepharTextfield(
                                hintText: "Mẫu ghi chú (hóa đơn, đặt hàng)",
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Container _buildHeader() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff767680).withOpacity(0.12)),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                      colorBackground1 = Colors.white;
                      colorText1 = AppThemes.red0;
                      colorBackground2 = const Color(0xff767680).withOpacity(0);
                      colorText2 = AppThemes.dark1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: _currentIndex == 0
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      offset: const Offset(0, 3),
                                      blurRadius: 1,
                                      spreadRadius: 0),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      offset: const Offset(0, 3),
                                      blurRadius: 8,
                                      spreadRadius: 0),
                                ]
                              : null,
                          color: colorBackground1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        child: Text(
                          "Thông tin",
                          style: AppFonts.normalBold(15, colorText1)
                              .copyWith(height: 20 / 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                      colorBackground2 = Colors.white;
                      colorText2 = AppThemes.red0;
                      colorBackground1 = const Color(0xff767680).withOpacity(0);
                      colorText1 = AppThemes.dark1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: _currentIndex == 1
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      offset: const Offset(0, 3),
                                      blurRadius: 1,
                                      spreadRadius: 0),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      offset: const Offset(0, 3),
                                      blurRadius: 8,
                                      spreadRadius: 0),
                                ]
                              : null,
                          color: colorBackground2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Text(
                          "Mô tả chi tiết",
                          style: AppFonts.normalBold(15, colorText2)
                              .copyWith(height: 20 / 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
