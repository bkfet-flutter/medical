import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/app/constant.dart';
import 'package:mephar_app/model/customer_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/model/sell_products_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/sell/counter/pay_counter_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/card_order_count.dart';
import 'package:mephar_app/widgets/item_order.dart';
import 'package:mephar_app/widgets/item_quantity_order.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/price_adjustment.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class CreateOrderCounterScreen extends StatefulWidget {
  const CreateOrderCounterScreen({super.key});

  @override
  State<CreateOrderCounterScreen> createState() => _CreateOrderCounterScreenState();
}

class _CreateOrderCounterScreenState extends State<CreateOrderCounterScreen> {
  CustomerModel? customerModel;
  int? cashOfCustomer;
  String? paymentType;
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  int? discount;
  int? discountType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BranchProvider>(
      builder: (context, branchProvider, child) {
        return MepharBigAppbar(
          haveIconNearSearch: true,
          noFilter: true,
          // iconNearSearch: AppImages.iconBook,
          title: "Tạo đơn tại quầy",
          haveSuffixSearch: false,
          backgroundColor: AppThemes.blue4,
          customAppBar: true,
          customWidget: _buildHeaderSearch(branchProvider.defaultBranch?.id, context),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSellProducts(context),
                      _buildTotalOrder(context),
                      _buildCustomer(context),
                      _buildPaymentMethod(),
                      _buildNote(context)
                    ].addBetween(const SizedBox(height: 8)),
                  ),
                ),
              ),
              _buildBottom(context)
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Consumer3<SellProvider, UserProvider, BranchProvider>(
        builder: (context, providerSell, providerUser, providerBranch, child) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          "Tạm tính",
                          style: AppFonts.regular(
                            14,
                            AppThemes.dark1,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          color: AppThemes.blue4,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "${providerSell.listOrder.length} sp",
                              style: AppFonts.normalBold(
                                14,
                                AppThemes.kPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${AppFunction.formatNum(providerSell.getTotalPrice(discountValue: discount, discountType: discountType))}đ",
                      textAlign: TextAlign.right,
                      style: AppFonts.bold(
                        20,
                        AppThemes.dark1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: AppThemes.light0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Row(
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: MepharButton(
                  //     haveIcon: true,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Expanded(
                      flex: 3,
                      child: MepharButton(
                        titleButton: "Thanh toán",
                        onPressed: () => _pay(
                            context,
                            SellModel(
                                paymentType: paymentType,
                                userId: providerUser.userModel.id,
                                customerId: customerModel?.id,
                                cashOfCustomer: cashOfCustomer,
                                description: noteController.text,
                                discount: discount,
                                discountType: discountType,
                                branchId: providerBranch.defaultBranch?.id,
                                totalPrice:
                                    providerSell.getTotalPrice(discountValue: discount, discountType: discountType),
                                products: providerSell.listOrder
                                    .map((e) => Products(
                                        productUnitId: e.id,
                                        productId: e.productId,
                                        originProductUnitId: e.id,
                                        productType: e.product?.type,
                                        quantity: AppFunction.textToInt(e.quantityController),
                                        batches: e.batchesForSale
                                            ?.where((batches) => batches.isSelected == true)
                                            .map((batch) => Batches(
                                                id: batch.id,
                                                quantity: AppFunction.textToInt(batch.batchQuantityController)))
                                            .toList()))
                                    .toList())),
                      ))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNote(BuildContext context) {
    return Container(
      color: const Color(0xffF3FAFF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: ItemOrder(
        icon: AppImages.iconPenBlue,
        title: "Thêm ghi chú",
        isBlueText: false,
        isArrow: true,
        onTap: () => AppFunction.showDialogAlert(context, dismiss: true, isTwoButton: true, onPress1stButton: () {
          noteController.clear();
          Navigator.of(context, rootNavigator: true).pop();
        },
            text2ndButton: "Lưu",
            title: "Ghi chú đơn hàng",
            styleTitle: const TextStyle(
                fontFamily: AppFonts.laTo, fontSize: 20, fontWeight: FontWeight.w700, color: AppThemes.dark0),
            noDivider: true,
            widgetDescription: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: AppThemes.dark4), borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                maxLines: null,
                controller: noteController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            )),
      ),
    );
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
          suffixIconConstraints: const BoxConstraints(maxHeight: 40, maxWidth: 50),
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
                      )),
                  if (model.quantity == null || model.quantity == 0)
                    TextSpan(
                        text: " -Hết hàng ",
                        style: AppFonts.normalBold(
                          14,
                          AppThemes.red0,
                        ))
                ]),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "${model.code}",
                      style: AppFonts.regular(
                        12,
                        AppThemes.dark2,
                      )),
                  TextSpan(
                      text: " -Số lượng: ${model.quantity ?? 0}",
                      style: AppFonts.regular(
                        12,
                        AppThemes.dark2,
                      )),
                  TextSpan(
                      text: " [${AppFunction.formatNum(model.price)}đ] ",
                      style: AppFonts.normalBold(
                        12,
                        AppThemes.red0,
                      )),
                ]),
              ),
            ],
          ),
        );
      },
      onSuggestionSelected: (InboundModel suggest) => context.read<SellProvider>().addToListOrder(suggest),
      suggestionsCallback: (String keyword) async {
        List<InboundModel> items = [];
        if (branchId != null) {
          var res = await ApiRequest.productsMasterForSale(keyword: keyword, brandId: branchId);
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

  Widget _buildSellProducts(BuildContext context) {
    return Consumer<SellProvider>(builder: (context, sellProvider, child) {
      return Container(
        alignment: Alignment.center,
        color: const Color(0xffF3FAFF),
        child: sellProvider.listOrder.isNotEmpty
            ? Column(
                children: sellProvider.listOrder
                    .map((e) => CardOrderCount(
                          model: e,
                        ))
                    .toList(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.imageAddStall,
                      height: 140,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Đơn hàng của bạn chưa có sản phẩm nào!",
                      style: AppFonts.normalBold(16, AppThemes.dark3),
                      textAlign: TextAlign.center,
                    ),
                    TouchableWidget(
                      padding: const EdgeInsets.all(8),
                      center: false,
                      onPressed: () async {
                        AppFunction.hideKeyboard(context);
                        final result = await Navigator.pushNamed(
                          context,
                          AppRoutes.chooseProductScreen,
                        ) as List<InboundModel>?;
                        if (result != null) {
                          if (result.isNotEmpty && context.mounted) {
                            for (var e in result) {
                              context.read<SellProvider>().addToListOrder(e);
                            }
                          }
                        }
                      },
                      child: Text(
                        "Chọn sản phẩm",
                        style: AppFonts.bold(16, AppThemes.dark0),
                      ),
                    ),
                  ].addBetween(const SizedBox(height: 12), bound: true),
                ),
              ),
      );
    });
  }

  Widget _buildTotalOrder(BuildContext context) {
    return Container(
      color: const Color(0xffF3FAFF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(children: [
        ItemQuantityOrder(
          title: "Tổng tiền hàng",
          number: AppFunction.formatNum(context.watch<SellProvider>().totalMoney.toInt()),
        ),
        // const SizedBox(height: 12),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: AppThemes.light0,
        ),

        GestureDetector(
          onTap: () => AppFunction.showDialogAlert(context,
              dismiss: true,
              isTwoButton: true,
              // onPress1stButton: () {
              //   discountController.clear();
              //   Navigator.of(context, rootNavigator: true).pop();
              // },
              text2ndButton: "Lưu", onPress2ndButton: () {
            Navigator.of(context, rootNavigator: true).pop();
            setState(() {
              discount = AppFunction.textToInt(discountController);
              discountType ?? (discountType = 1);
            });
            //  Provider.of<SellProvider>(context, listen: false).getTotalPrice(discountType: discountType, discountValue: discount);
          },
              title: "Thêm chiết khấu",
              styleTitle: const TextStyle(
                  fontFamily: AppFonts.laTo, fontSize: 20, fontWeight: FontWeight.w700, color: AppThemes.dark0),
              noDivider: true,
              widgetDescription: Row(
                children: [
                  const Text(
                    "Giá trị",
                    style: TextStyle(
                        fontFamily: AppFonts.laTo, fontSize: 16, fontWeight: FontWeight.w500, color: AppThemes.dark0),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppThemes.dark4), borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: discountController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  StatefulBuilder(builder: (context, setState) {
                    return CustomSwitch(
                      options: const ["VND", "%"],
                      value: discountType == 2,
                      onTapOption1: () => setState(() {
                        discountType = 2;
                      }),
                      onTapOption2: () => setState(() {
                        discountType = 1;
                      }),
                    );
                  })
                ],
              )),
          child: ItemQuantityOrder(
            title: "Chiết khấu",
            isBlueText: true,
            number: ('${discount ?? ""} ${discountType == 1 ? "%" : discountType == 2 ? "đ" : ""}')
                .toString(),
          ),
        ),

        // const ItemOrder(), //áp dụng khuyến mãi
      ]),
    );
  }

  Widget _buildCustomer(BuildContext context) {
    return Container(
      color: const Color(0xffF3FAFF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Khách hàng",
            style: AppFonts.normalBold(14, AppThemes.dark1),
          ),
          const SizedBox(height: 12),
          ItemOrder(
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.addCustomerBuyScreen,
              ) as CustomerModel?;
              if (result != null) {
                setState(() {
                  customerModel = result;
                  discount = result.groupCustomer?.discount;
                  discountType = 1;
                });
              }
            },
            icon: AppImages.iconAddUserBlue,
            title: customerModel == null ? "Thêm khách hàng" : "${customerModel?.fullName} - ${customerModel?.phone}",
            isArrow: true,
            iconClose: customerModel != null ? true : false,
            onTapClose: () {
              setState(() {
                customerModel = null;
                discount = null;
                discountType = null;
              });
            },
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 12),
          //   height: 1,
          //   width: MediaQuery.of(context).size.width - 40,
          //   color: AppThemes.light0,
          // ),
          // const ItemOrder(
          //   icon: AppImages.iconTagBlue,
          //   title: "Giá bán lẻ",
          //   isArrow: true,
          // ),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      color: const Color(0xffF3FAFF),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: ItemOrder(
        onTap: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PayCounterScreen(
                    customerId: customerModel?.id,
                    discount: discount,
                    discountType: discountType,
                    cashOfCustomer: cashOfCustomer,
                    payType: paymentType,


                  ))) as SellModel?;
          if (result != null) {
            setState(() {
              cashOfCustomer = result.cashOfCustomer;
              paymentType = result.paymentType;
            });
          }
        },
        icon: AppImages.iconCard,
        title: paymentType != null
            ? "${AppConstant.mapPayType.values.firstWhere((element) => element.value == paymentType).label} - Khách đưa: ${AppFunction.formatNum(cashOfCustomer)}đ"
            : "Chọn phương thức thanh toán",
        isBlueText: false,
        isArrow: true,
      ),
    );
  }

  bool _validateOrder(BuildContext context) {
    if (Provider.of<SellProvider>(context, listen: false).listOrder.isEmpty) {
      AppFunction.showDialogError(context, "Vui lòng chọn sản phẩm");
      return false;
    }
    if (paymentType == null) {
      AppFunction.showDialogError(context, "Vui lòng chọn phương thức thanh toán");
      return false;
    } else {
      return true;
    }
  }

  _resetPageWhenComplete(BuildContext context) {
    context.read<SellProvider>().resetData();
    customerModel = null;
    cashOfCustomer = null;
    paymentType = null;
    discount = null;
    discountType = null;
    noteController.clear();
    discountController.clear();
    setState(() {});
  }

  void _pay(BuildContext context, SellModel sellModel) async {
    AppFunction.hideKeyboard(context);
    if (_validateOrder(context)) {
      AppFunction.showLoading(context);
      var res = await ApiRequest.sellDirect(sellModel: sellModel);
      if (res.result == true && context.mounted) {
        _resetPageWhenComplete(context);
        AppFunction.hideLoading(context);
        AppFunction.showDialogSuccess(context, content: "Thanh toán thành công!");
      } else if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    discountController.dispose();
    super.dispose();
  }
}
