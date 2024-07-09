// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/model/product_model.dart';
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
import 'package:mephar_app/screens/product/medicine/edit_information_unit.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/header_add_product.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class CopyInformationMedicine extends StatefulWidget {
  const CopyInformationMedicine({super.key});

  @override
  State<CopyInformationMedicine> createState() =>
      _CopyInformationMedicineState();
}

class _CopyInformationMedicineState extends State<CopyInformationMedicine> {
  int? groupProductId;
  String? groupProductName;
  int? dosageId;
  String? dosageName;
  int? positionId;
  String? positionName;
  int? countryProduceId;
  String? countryProduceName;
  int? medicineId;
  int? manufactureId;
  String? manufactureProduct;
  String? countryProduct;
  ImageModel? image;
  int? imageId;
  String? imagePath;
  // String? name;
  TextEditingController searchController = TextEditingController();
  TextEditingController codeProduct = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController numberRegister = TextEditingController();
  TextEditingController unitName = TextEditingController();
  TextEditingController activeElement = TextEditingController();
  TextEditingController baseUnit = TextEditingController();
  TextEditingController expiryPeriod = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController packingSpecification = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController shortName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController addNew = TextEditingController();
  List<ProductUnit> productUnits = [];
  List<UnitProductsModel> listUnitProducts = [];
  List<Map<String, Object>> dataUnits = [];
  int? branchId;
  int? id;

  initData() {
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;
    branchId = branch?.id;
    var data = Provider.of<ProductProvider>(context, listen: false);
    var manufacture = Provider.of<ManufactureProvider>(context, listen: false);
    var country = Provider.of<CountryProduceProvider>(context, listen: false);
    manufacture.getListManufacture(keyword: "", limit: 10, page: 1);
    country.getListCountryProduce(keyword: "", limit: 10, page: 1);
    id = data.detailProductModel.id;
    codeProduct = TextEditingController(text: data.detailProductModel.code);
    barcode = TextEditingController(text: data.detailProductModel.barCode);
    TextEditingController(text: data.detailProductModel.code ?? "");
    numberRegister = TextEditingController(
        text: data.detailProductModel.registerNumber ?? "");
    name = TextEditingController(text: data.detailProductModel.name ?? "");
    activeElement = TextEditingController(
        text: data.detailProductModel.activeElement ?? "");
    packingSpecification = TextEditingController(
        text: data.detailProductModel.packingSpecification ?? "");
    price =
        TextEditingController(text: data.detailProductModel.price.toString());
    salePrice = TextEditingController(
        text: data.detailProductModel.primePrice.toString());
    weight = TextEditingController(text: data.detailProductModel.weight);
    expiryPeriod = TextEditingController(
        text: data.detailProductModel.expiryPeriod.toString());
    baseUnit = TextEditingController(text: data.detailProductModel.baseUnit);

    content =
        TextEditingController(text: data.detailProductModel.content ?? "");

    shortName =
        TextEditingController(text: data.detailProductModel.shortName ?? "");
    imagePath = data.detailProductModel.image?.filePath;
    imageId = data.detailProductModel.imageId;
    groupProductName = data.detailProductModel.groupProduct?.name ?? "Nhóm";
    dosageName = data.detailProductModel.productDosage?.name ?? "Đường dùng";
    positionName = data.detailProductModel.productPosition?.name ?? "Vị trí";
    countryProduceName =
        data.detailProductModel.country?.name ?? "Nước sản xuất";
    manufactureProduct =
        data.detailProductModel.productManufacture?.name ?? "Hãng sản xuất";
    groupProductId = data.detailProductModel.groupProductId;
    positionId = data.detailProductModel.positionId;
    manufactureId = data.detailProductModel.manufactureId;
    dosageId = data.detailProductModel.dosageId;
    countryProduceId = data.detailProductModel.countryId;
    for (int i = 0; i < data.detailProductModel.productUnit!.length; i++) {
      if (data.detailProductModel.productUnit![i].isBaseUnit == false) {
        productUnits.add(data.detailProductModel.productUnit![i]);
      }
    }
    // productUnits = data.detailProductModel.productUnit!;
    listUnitProducts = List.generate(
      productUnits.length,
      (index) => UnitProductsModel(
        barCode: TextEditingController(),
        name: TextEditingController(),
        point: TextEditingController(),
        salePrice: TextEditingController(),
        codeUnit: TextEditingController(),
        value: TextEditingController(),
      ),
    );
    print(listUnitProducts.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer6<DosageProvider, PositionProvider, GroupProductProvider,
            MedicineProvider, ManufactureProvider, CountryProduceProvider>(
        builder: (context, dosage, position, groupProduct, medicine,
            manufacture, country, child) {
      return Material(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                                hintText: "Tên thuốc",
                                controller: name,
                              ),
                              MepharTextfield(
                                hintText: "Tên viết tắt",
                                controller: shortName,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ObjectDropdownButton(
                                        havePadding: true,
                                        hinText: groupProductName,
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
                                        hinText: dosageName,
                                        listItems: dosage.dosageDropdown,
                                        onChange: (value) {
                                          setState(() {
                                            dosageId = value?.id;
                                          });
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      AppFunction.showDialogAlert(
                                        context,
                                        isTwoButton: true,
                                        title: "Thêm đường dùng",
                                        widgetDescription: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: MepharInput(
                                            titleInput: "Đường dùng",
                                            controller: addNew,
                                          ),
                                        ),
                                        text1stButton: "Huỷ bỏ",
                                        text2ndButton: "Xong",
                                        onPress2ndButton: () async {
                                          ApiResponse resAdd =
                                              await ApiRequest.addNewDosage(
                                            name: addNew.text,
                                          );
                                          if (resAdd.result == true) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            dosage.getListDosage(
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
                                        hinText: positionName,
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
                                hintText: "Cảnh báo hết hạn",
                                havesuffix: true,
                                controller: expiryPeriod,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(
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
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Expanded(
                                    child: MepharTextfield(
                                      hintText: "Giá bán",
                                      controller: salePrice,
                                      onChanged: (value) {
                                        salePrice.text =
                                            AppFunction.formatStringNum(value);
                                      },
                                      keyboardType: TextInputType.number,
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
                              const SizedBox(
                                height: 10,
                              ),
                              const HeaderAddProduct(),
                              MepharTextfield(
                                hintText: "Số đăng ký",
                                controller: numberRegister,
                              ),
                              MepharTextfield(
                                hintText: "Hoạt chất",
                                controller: activeElement,
                                keyboardType: TextInputType.number,
                              ),
                              MepharTextfield(
                                hintText: "Hàm lượng",
                                controller: content,
                                keyboardType: TextInputType.number,
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
                                        hinText: manufactureProduct,
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
                                  hinText: countryProduceName,
                                  listItems: country.countryProduceDropdown,
                                  onChange: (value) {
                                    setState(() {
                                      countryProduceId = value?.id;
                                    });
                                  }),
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
                              )
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
                                  child: EditInformationUnit(
                                    unitProductsModel: listUnitProducts[index],
                                    // price: int.parse(salePrice.text),
                                    data: productUnits[index],
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
                                      productUnits.removeLast();
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
                  padding: const EdgeInsets.all(AppDimens.spaceXSmall10),
                  child: MepharButton(
                    titleButton: "Thêm",
                    onPressed: () async {
                      AppFunction.showLoading(context);
                      dataUnits = listUnitProducts
                          .map((e) => {
                                "unitName": e.name.text,
                                "exchangeValue": int.parse(e.value.text),
                                "isBaseUnit": false,
                                "isDirectSale": false,
                                "barCode": e.barCode.text,
                                "point": int.parse(e.point.text),
                                // "code": e.codeUnit.text,
                                "price": int.parse(e.salePrice.text)
                              })
                          .toList();
                      print(dataUnits);
                      if (true == true) {
                        Map<String, Object> baseProduct = {
                          "unitName": baseUnit.text,
                          "exchangeValue": 1,
                          "isBaseUnit": true,
                          "isDirectSale": false,
                          "barCode": codeProduct.text,
                          "point": 10,
                          "price": int.parse(salePrice.text)
                        };
                        dataUnits.add(baseProduct);

                        ApiResponse resAdd =
                            await ApiRequest.addMedicineProduct(
                          name: name.text,
                          activeElement: activeElement.text,
                          // code: codeProduct.text,
                          barCode: barcode.text,
                          branchId: branchId,
                          dosageId: dosageId,
                          positionId: positionId,
                          manufactureId: manufactureId,
                          groupProductId: groupProductId,
                          countryId: countryProduceId,
                          content: content.text,
                          price: int.parse(price.text),
                          expiryPeriod: int.parse(expiryPeriod.text),
                          weight: weight.text,
                          baseUnit: baseUnit.text,
                          isDirectSale: false,
                          exchangeValue: 1,
                          isBaseUnit: true,
                          point: "",
                          priceProductUnits: int.parse(price.text),
                          unitName: baseUnit.text,
                          imageId: imageId,
                          isBatchExpireControl: true,
                          primePrice: int.parse(salePrice.text),
                          shortName: shortName.text,
                          packingSpecification: packingSpecification.text,
                          productUnits: dataUnits,
                        );
                        if (resAdd.result == true) {
                          context
                              .read<ProductProvider>()
                              .fetchProducts(context, firstCall: true);
                          AppFunction.hideLoading(context);
                          AppFunction.showDialogSuccess(context,
                              content: "Thêm mới thành công");
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          AppFunction.hideLoading(context);
                          AppFunction.showDialogError(
                              context, resAdd.message ?? "Lỗi không xác định");
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
