import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/batch_model.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/enter_product/select_batch_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/app_search_bar.dart';
import 'package:mephar_app/widgets/card_product_check_2.dart';
import 'package:mephar_app/widgets/card_product_check_3.dart';
import 'package:mephar_app/widgets/card_product_check_4.dart';
import 'package:mephar_app/widgets/item_quantity_order.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:provider/provider.dart';

class CreateReceiptScreen extends BaseScreen {
  const CreateReceiptScreen({super.key});

  @override
  CreateReceiptScreenState createState() => CreateReceiptScreenState();
}

class CreateReceiptScreenState extends BaseState<CreateReceiptScreen>
    with BaseScreenMixin {
  TextEditingController discountController = TextEditingController();
  TextEditingController paymentsNCCController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController staffController = TextEditingController();
  TextEditingController supplierController = TextEditingController();

  int? userId;
  int? supplierId;

  @override
  Widget buildHeader() => const SizedBox.shrink();

  @override
  Color setMainBackgroundColor() => AppThemes.light1;

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<ImportProductProvider, BranchProvider>(
        builder: (context, provider, branchProvider, child) {
      return MepharBigAppbar(
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
              // suffixIcon: InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       AppRoutes.qrCodePayCounter,
              //     );
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(right: 18, top: 8, bottom: 8),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: Container(
              //             alignment: Alignment.centerLeft,
              //             child: const VerticalDivider(
              //               color: AppThemes.dark4,
              //               thickness: 1,
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           child: Container(
              //             alignment: Alignment.centerRight,
              //             child: Image.asset(
              //               AppImages.iconSearchVoice,
              //               height: 12,
              //               width: 15,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              hintText: 'Tìm tên sản phẩm , tên đơn , mã...',
              hintStyle: AppFonts.normalBold(12, AppThemes.dark3),
            ),
          ),
          itemBuilder: (BuildContext context, InboundModel suggest) {
            final model = suggest;
            return ListTile(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
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
                  const SizedBox(height: 4),
                  Text('Số lượng - ${model.quantity ?? 0}',
                      style: AppFonts.regular(
                        12,
                        AppThemes.dark2,
                      ))
                ],
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
        title: "Tạo phiếu nhập hàng",
        haveIconNearSearch: true,
        noFilter: true,
        // iconNearSearch: AppImages.iconBook,

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      provider.searchList.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardProductCheck4(
                              hideItems: true,
                              numberCard: index,
                              inboundModel: provider.searchList[index],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            provider.searchList[index].product
                                        ?.isBatchExpireControl ==
                                    true
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              if (provider.searchList[index]
                                                      .product?.id !=
                                                  null) {
                                                final result = await Navigator
                                                        .of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectBatchScreen(
                                                              provider
                                                                  .searchList[
                                                                      index]
                                                                  .product!
                                                                  .id!,
                                                              copyList: provider
                                                                      .searchList[
                                                                          index]
                                                                      .batches ??
                                                                  [],
                                                            ))) as List<
                                                    BatchModel>?;
                                                if (result != null &&
                                                    result.isNotEmpty) {
                                                  provider.addBatch(
                                                      index: index,
                                                      list: result);
                                                  provider
                                                          .searchList[index]
                                                          .quantityController
                                                          ?.text =
                                                      result
                                                          .fold(
                                                              0,
                                                              (pre, e) =>
                                                                  pre +
                                                                  AppFunction
                                                                      .textToInt(
                                                                          e.quantityController))
                                                          .toString();
                                                  provider.totalAmount(index);
                                                }
                                              }
                                            },
                                            child: const Text(
                                              'Chọn lô',
                                              style: TextStyle(
                                                  color: Color(0xFFEE0033),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          runSpacing: 5,
                                          children: (provider.searchList[index]
                                                      .batches ??
                                                  [])
                                              .map((e) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  FittedBox(
                                                    child: NormalText(
                                                      '${e.name ?? '-'}-${AppFunction.formatDateString(e.expiryDate ?? '-')} - SL: ${(AppFunction.textToInt(e.quantityController))}',
                                                      maxFontSize: 14,
                                                      minFontSize: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () => provider
                                                        .removeBatch(index, e),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppThemes.blue4,
                      height: 8,
                    ),
                    AppSearchBar(
                      hintText: "Nhân viên phụ trách",
                      controller: staffController,
                      onSuggestionSelected: (value) {
                        staffController.text = value.name ?? "";
                        setState(() {
                          userId = value.id;
                        });
                      },
                      suggestionsCallback: (String keyword) async {
                        List<ProvinceModel> items = [];
                        var res = await ApiRequest.users(keyword: keyword);
                        if (res.result == true) {
                          for (var e in res.data["items"]) {
                            items.add(ProvinceModel.fromJson(e));
                          }
                        }
                        return items;
                      },
                    ),
                    AppSearchBar(
                      hintText: "Nhà cung cấp",
                      controller: supplierController,
                      onSuggestionSelected: (value) {
                        supplierController.text = value.name ?? "";
                        setState(() {
                          supplierId = value.id;
                        });
                      },
                      suggestionsCallback: (String keyword) async {
                        List<ProvinceModel> items = [];
                        var res = await ApiRequest.getSupplier(keyword, 10, 1);
                        if (res.result == true) {
                          for (var e in res.data["items"]) {
                            items.add(ProvinceModel.fromJson(e));
                          }
                        }
                        return items;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          color: AppThemes.transparent,
                          border: Border(
                              bottom: BorderSide(color: AppThemes.light1))),
                      child: Text(
                        "Mã đặt hàng - Mã tự động",
                        style: AppFonts.normalBold(
                          12,
                          AppThemes.gray,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          color: AppThemes.transparent,
                          border: Border(
                              bottom: BorderSide(color: AppThemes.light1))),
                      child: Text(
                        "Trạng thái - Phiếu tạm",
                        style: AppFonts.normalBold(
                          12,
                          AppThemes.gray,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: AppThemes.blue4, width: 8))),
                      child: ItemQuantityOrder(
                        maxLine: 1,
                        title: "Tổng tiền hàng",
                        number: provider.totalPrice.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text('Giảm giá',
                                      style: AppFonts.regular(
                                          14, AppThemes.dark1))),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: MepharTextfield(
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      align: TextAlign.right,
                                      axis: TextDirection.rtl,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      hintText: '',
                                      controller: discountController),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ItemQuantityOrder(
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            title: "Cần trả NCC",
                            number: (provider.totalPrice -
                                    AppFunction.textToInt(discountController))
                                .toString(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Tiền trả nhà cung cấp F8',
                                        style: AppFonts.regular(
                                            14, AppThemes.dark1)),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: MepharTextfield(
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      axis: TextDirection.rtl,
                                      vert: TextAlignVertical.center,
                                      align: TextAlign.right,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      hintText: '',
                                      controller: paymentsNCCController),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ItemQuantityOrder(
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                            title: "Tính vào công nợ",
                            number: (provider.totalPrice -
                                    AppFunction.textToInt(discountController) -
                                    AppFunction.textToInt(
                                        paymentsNCCController))
                                .toString(),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Expanded(
                          //         flex: 1, child: Text('Thêm ghi chú', style: AppFonts.regular(14, AppThemes.dark1))),
                          //     Expanded(
                          //       flex: 1,
                          //       child: MepharTextfield(
                          //           axis: TextDirection.rtl,
                          //           vert: TextAlignVertical.center,
                          //           align: TextAlign.right,
                          //           hintText: '',
                          //           controller: noteController),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
              child: Row(
                children: [
                  // Expanded(
                  //     flex: 2,
                  //     child: MepharButton(
                  //       onPressed: () => sendData(context, "DRAFT"),
                  //       haveIcon: true,
                  //     )),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Expanded(
                      flex: 3,
                      child: MepharButton(
                        colorButton: AppThemes.green0,
                        titleButton: "Hoàn Thành",
                        onPressed: () => sendData(context, "SUCCEED"),
                      ))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  sendData(BuildContext context, String status) async {
    AppFunction.hideKeyboard(context);
    AppFunction.showLoading(context);
    await context
        .read<ImportProductProvider>()
        .enter(context,
            discount: AppFunction.textToInt(discountController),
            paid: AppFunction.textToInt(paymentsNCCController),
            userId: userId,
            supplierId: supplierId,
            description: noteController.text,
            status: status)
        .then((value) {
      AppFunction.hideLoading(context);
      if (value) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    discountController.dispose();
    paymentsNCCController.dispose();
    supplierController.dispose();
    staffController.dispose();
    noteController.dispose();
  }
}
