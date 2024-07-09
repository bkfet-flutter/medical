import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/position_provider.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/provider/sample_prescription_provider.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_product_check_3.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_input.dart';
import 'package:mephar_app/widgets/mephar_radio_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

//EitInformationSampleMedicine
class EditInformationSampleMedicine extends StatefulWidget {
  const EditInformationSampleMedicine({super.key});

  @override
  State<EditInformationSampleMedicine> createState() =>
      _EditInformationSampleMedicineState();
}

class _EditInformationSampleMedicineState
    extends State<EditInformationSampleMedicine> {
  String? selectedStatus;

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController addNew = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<InboundModel> listOrder = [];
  List<Map<String, dynamic>> ingredientProducts = [];
  int? positionId;
  String? positionName;
  int? branchid;
  ImageModel? image;
  int? imageId;
  String? imagePath;
  int count = 1;

  initData() async {
    AppFunction.showLoading(context);
    var branch =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch;

    branchid = branch?.id;
    var sample = Provider.of<SampleProvider>(context, listen: false);
    nameController = TextEditingController(text: sample.sample?.name);
    weightController = TextEditingController(text: sample.sample?.weight);
    noteController = TextEditingController(text: sample.sample?.description);
    positionId = sample.sample?.positionId;
    positionName = sample.sample?.position?.name;
    imageId = sample.sample?.image?.id;
    imagePath = sample.sample?.image?.filePath;

    String position =
        await Provider.of<PositionProvider>(context, listen: false)
            .getListPosition(limit: 10, page: 1);
    if (position == "success") {
      AppFunction.hideLoading(context);
    } else {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(context, "Lỗi không xác định");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  Widget _buildHeaderSearch(int? branchId, BuildContext context) {
    return TypeAheadField<InboundModel>(
      hideSuggestionsOnKeyboardHide: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Image.asset(
              AppImages.iconSearch,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
          ),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 50),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.qrCodePayCounter,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 18, top: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const VerticalDivider(
                        color: AppThemes.dark4,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        AppImages.iconSearchVoice,
                        height: 12,
                        width: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          hintText: 'Tìm tên sản phẩm , tên đơn , mã...',
          hintStyle: AppFonts.normalBold(12, AppThemes.dark3),
        ),
      ),
      itemBuilder: (BuildContext context, InboundModel suggest) {
        final model = suggest;
        return ListTile(
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: model.product?.name ?? '',
                  style: AppFonts.normalBold(
                    14,
                    AppThemes.dark1,
                  )),
              TextSpan(
                  text: " [${model.unitName ?? ''}] ",
                  style: AppFonts.normalBold(
                    14,
                    AppThemes.red0,
                  ))
            ]),
          ),
        );
      },
      onSuggestionSelected: (InboundModel suggest) =>
          context.read<SellProvider>().addToListOrder(suggest),
      suggestionsCallback: (String keyword) async {
        List<InboundModel> items = [];
        if (branchId != null) {
          var res = await ApiRequest.productsMasterForSale(
              keyword: keyword, brandId: branchId);
          if (res.result == true) {
            for (var e in res.data["items"]) {
              items.add(InboundModel.fromJson(e));
            }
          }
        }
        return items;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<SampleProvider, PositionProvider, ImportProductProvider,
        BranchProvider>(
      builder: (context, sample, position, provider, branchProvider, child) {
        return MepharBigAppbar(
          // onChanged: ,
          haveIconNearSearch: true,
          iconNearSearch: AppImages.iconBook,
          title: "Thêm đơn thuốc mẫu",
          customAppBar: true,
          customWidget: TypeAheadField<InboundModel>(
            hideSuggestionsOnKeyboardHide: true,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Image.asset(
                    AppImages.iconSearch,
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                ),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 40, maxWidth: 50),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.qrCodePayCounter,
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 18, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const VerticalDivider(
                              color: AppThemes.dark4,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              AppImages.iconSearchVoice,
                              height: 12,
                              width: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                hintText: 'Tìm tên sản phẩm , tên đơn , mã...',
                hintStyle: AppFonts.normalBold(12, AppThemes.dark3),
              ),
            ),
            itemBuilder: (BuildContext context, InboundModel suggest) {
              final model = suggest;
              return ListTile(
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: model.product?.name ?? '',
                        style: AppFonts.normalBold(
                          14,
                          AppThemes.dark1,
                        )),
                    TextSpan(
                        text: " [${model.unitName ?? ''}] ",
                        style: AppFonts.normalBold(
                          14,
                          AppThemes.red0,
                        ))
                  ]),
                ),
              );
            },
            onSuggestionSelected: (InboundModel? suggest) =>
                provider.addToSearchList(suggest),
            suggestionsCallback: (String keyword) async {
              List<InboundModel> items = [];
              var res = await ApiRequest.productsMaster(
                  keyword: keyword,
                  brandId: branchProvider.defaultBranch?.id ?? 10);
              if (res.result == true) {
                for (var e in res.data["items"]) {
                  items.add(InboundModel.fromJson(e));
                }
              }
              return items;
            },
          ),
          body: Container(
            color: const Color(0xffF3FAFF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      body: ListView(
                                        children: [
                                          TouchableWidget(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              image = await AppFunction
                                                  .pickCamera();
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                margin:
                                    const EdgeInsets.only(top: 7, bottom: 16),
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
                                  hintText: "Tên đơn thuốc mẫu*",
                                  controller: nameController,
                                ),
                                MepharTextfield(
                                  hintText: "Trọng lượng",
                                  controller: weightController,
                                ),
                                MepharTextfield(
                                  hintText: "Ghi chú",
                                  controller: noteController,
                                ),
                                const SizedBox(
                                  height: 2,
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
                                  height: 30,
                                ),
                                _buildSellProducts(context)
                              ],
                            ),
                          ),
                        ),
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
                        // AppFunction.showLoading(context);
                        // List<Map<String, dynamic>> ingredientProducts =
                        //     provider.searchList
                        //         .map((e) => {
                        //               "productId": e.productId,
                        //               "productUnitId": e.productUnitId,
                        //               "quantity":
                        //                   int.parse(e.quantityController!.text),
                        //               "dosage": e.dosageController!.text,
                        //               "price":
                        //                   int.parse(e.priceUnitController!.text)
                        //             })
                        //         .toList();
                        // if (true == true) {
                        //   ApiResponse res =
                        //       await ApiRequest.createNewSampleMedicine(
                        //     status: 1,
                        //     branchId: branchid,
                        //     code: "",
                        //     name: nameController.text,
                        //     positonId: positionId,
                        //     weight: weightController.text,
                        //     imageId: imageId,
                        //     description: noteController.text,
                        //     ingredientProducts: ingredientProducts,
                        //   );
                        //   if (res.result == true) {
                        //     provider.searchList.clear();
                        //     AppFunction.hideLoading(context);

                        //     AppFunction.showDialogSuccess(
                        //       context,
                        //       content: "Thêm mới đơn thuốc mẫu thành công",
                        //     );
                        //   } else {
                        //     AppFunction.hideLoading(context);
                        //     AppFunction.showDialogError(
                        //         context, res.message ?? "Lỗi không xác định");
                        //   }
                        // } else {}
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSellProducts(BuildContext context) {
    return Consumer2<SellProvider, ImportProductProvider>(
        builder: (context, sellProvider, provider, child) {
      return Container(
        alignment: Alignment.center,
        color: const Color(0xffF3FAFF),
        child: provider.searchList.isNotEmpty
            ? Column(
                children: List.generate(
                  provider.searchList.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardProductCheck3(
                          numberCard: index,
                          inboundModel: provider.searchList[index],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        // : Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: TouchableWidget(
        //       onPressed: () async {
        //         AppFunction.hideKeyboard(context);
        //         final result = await Navigator.pushNamed(
        //           context,
        //           AppRoutes.chooseProductScreen,
        //         ) as List<InboundModel>?;
        //         if (result != null) {
        //           if (result.isNotEmpty && context.mounted) {
        //             for (var e in result) {
        //               context.read<SellProvider>().addToListOrder(e);
        //             }
        //           }
        //         }
        //       },
        //       padding: const EdgeInsets.all(0),
        //       child: Column(
        //         children: [
        //           const SizedBox(
        //             height: 24,
        //           ),
        //           Image.asset(
        //             AppImages.imageAddStall,
        //             height: 140,
        //             width: 150,
        //             fit: BoxFit.cover,
        //           ),
        //           const SizedBox(
        //             height: 26,
        //           ),
        //           Text(
        //             "Đơn hàng của bạn chưa có sản phẩm nào!",
        //             style: AppFonts.normalBold(16, AppThemes.dark3),
        //           ),
        //           const SizedBox(
        //             height: 12,
        //           ),
        //           Text(
        //             "Chọn sản phẩm",
        //             style: AppFonts.bold(16, AppThemes.dark0),
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
      );
    });
  }
}
