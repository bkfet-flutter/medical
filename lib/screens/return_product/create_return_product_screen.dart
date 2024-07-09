// CreateReturnProductScreen
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/customer_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/model/product_return.dart';
import 'package:mephar_app/model/product_return_purchase_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/product/product_return_provider.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/card_order_count.dart';
import 'package:mephar_app/widgets/dropdown_filter.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_textfield.dart';
import 'package:mephar_app/widgets/object_dropdown_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class CreateReturnProductScreen extends StatefulWidget {
  const CreateReturnProductScreen({super.key});

  @override
  State<CreateReturnProductScreen> createState() =>
      _CreateReturnProductScreenState();
}

class _CreateReturnProductScreenState extends State<CreateReturnProductScreen> {
  CustomerModel? customerModel;
  int? cashOfCustomer;
  String? paymentType;
  TextEditingController discountController = TextEditingController();
  int? movedBy;
  int? branchId;
  int totalPrice = 0;
  int debt = 0;
  String? status;
  int? supplierId;
  int? userId;
  // List<ProductMoveModel>? products;
  Future<void> _firstData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().fetchStaffs(context),
      context.read<SupplierProvider>().getDataSupplier(context, "", 1, 20),
    ]).whenComplete(() {
      AppFunction.hideLoading(context);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<SellProvider>().getDiscount(0);
      _firstData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BranchProvider>(
      builder: (context, branchProvider, child) {
        return MepharBigAppbar(
          haveIconNearSearch: true,
          noFilter: true,
          // iconNearSearch: AppImages.iconBook,
          title: "Tạo đơn trả hàng nhập",
          haveSuffixSearch: false,
          backgroundColor: AppThemes.blue4,
          customAppBar: true,
          customWidget:
              _buildHeaderSearch(branchProvider.defaultBranch?.id, context),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSellProducts(context),
                      FilterDropdown(
                        hinText: "Người tạo",
                        listItems: context.read<UserProvider>().userDropDown,
                        onChange: (value) {
                          setState(() {
                            userId = value?.id;
                          });
                        },
                      ),
                      ObjectDropdownButton(
                          hinText: "Nhà cung cấp",
                          listItems:
                              context.read<SupplierProvider>().supplierDropdown,
                          onChange: (value) {
                            setState(() {
                              supplierId = value?.id;
                            });
                          }),
                      MepharTextfield(
                        hintText: "Giảm giá",
                        controller: discountController,
                        onChanged: (value) {
                          discountController.text =
                              AppFunction.formatStringNum(value);
                        },
                      ),
                      // FilterDropdown(
                      //   hinText: "Nhà cung cấp",
                      //   listItems:
                      //       context.read<SupplierProvider>().supplierDropdown,
                      //   onChange: (value) {
                      //     setState(() {
                      //       supplierId = value?.id;
                      //     });
                      //   },
                      // ),
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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: MepharButton(
            titleButton: "Tạo đơn trả hàng nhập",
            onPressed: () {
              var products = providerSell.listOrder
                  .map((e) => ProductReturn(
                        productId: e.productId,
                        importPrice: e.price,
                        discount: e.discountController!.text.isNotEmpty
                            ? int.parse(e.discountController!.text)
                            : 0,
                        totalPrice: e.price! *
                            AppFunction.textToInt(e.quantityController),
                        productUnitId: e.productUnit?.id,
                        totalQuantity:
                            AppFunction.textToInt(e.quantityController),
                      ))
                  .toList();
              context.read<SellProvider>().getTotalItem();

              totalPrice = providerSell.totalMoney.toInt() -
                  AppFunction.formatStringToNum(discountController.text);
              _create(context, products);
            },
          ),
        );
      },
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
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 50),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          fillColor: Colors.white,
          filled: true,
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
                          isShowUnit: true,
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

  bool _validateOrder(BuildContext context) {
    if (Provider.of<SellProvider>(context, listen: false).listOrder.isEmpty) {
      AppFunction.showDialogError(context, "Vui lòng chọn sản phẩm");
      return false;
    }
    if (customerModel?.id == null) {
      AppFunction.showDialogError(context, "Vui lòng chọn khách hàng");
      return false;
    }
    if (paymentType == null) {
      AppFunction.showDialogError(
          context, "Vui lòng chọn phương thức thanh toán");
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

    setState(() {});
  }

  void _create(
    BuildContext context,
    List<ProductReturn> products,
  ) async {
    AppFunction.hideKeyboard(context);
    if (true) {
      // AppFunction.showLoading(context);
      var res = await ApiRequest.createReturnProduct(
        branchId: context.read<BranchProvider>().defaultBranch?.id,
        totalPrice: totalPrice,
        products: products,
        userId: userId,
        discount: AppFunction.formatStringToNum(discountController.text),
        debt: totalPrice,
        status: "SUCCEED",
        supplierId: supplierId,
      );
      if (res.result == true && context.mounted) {
        _resetPageWhenComplete(context);
        AppFunction.hideLoading(context);
        context
            .read<ProductReturnProvider>()
            .fetchProductReturn(context, firstCall: true);
        AppFunction.showDialogSuccess(context, content: "Tạo đơn thành công!");
      } else if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
    }
  }

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }
}
