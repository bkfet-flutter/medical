import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/customer_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/model/product_move_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/sell_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/card_order_count.dart';
import 'package:mephar_app/widgets/dropdown_filter.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';
import 'package:provider/provider.dart';

class CreateTransactionBillScreen extends StatefulWidget {
  const CreateTransactionBillScreen({super.key});

  @override
  State<CreateTransactionBillScreen> createState() =>
      _CreateTransactionBillScreenState();
}

class _CreateTransactionBillScreenState
    extends State<CreateTransactionBillScreen> {
  CustomerModel? customerModel;
  int? cashOfCustomer;
  String? paymentType;
  TextEditingController noteController = TextEditingController();
  int? movedBy;
  int? toBranchId;
  int? receivedBy;
  List<ProductMoveModel>? products;
  Future<void> _firstData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().fetchStaffs(context),
      context.read<BranchProvider>().initBranch(context),
    ]).whenComplete(() {
      AppFunction.hideLoading(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _firstData(context);
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => context.read<SellProvider>().getDiscount(0));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BranchProvider>(
      builder: (context, branchProvider, child) {
        return MepharBigAppbar(
          haveIconNearSearch: true,
          noFilter: true,
          // iconNearSearch: AppImages.iconBook,
          title: "Tạo đơn chuyển hàng",
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
                            movedBy = value?.id;
                          });
                        },
                      ),
                      FilterDropdown(
                        hinText: "Tới chi nhánh",
                        listItems: context
                            .read<BranchProvider>()
                            .branchDropdown
                            .where((element) =>
                                element.id !=
                                context
                                    .read<BranchProvider>()
                                    .defaultBranch!
                                    .id)
                            .toList(),
                        onChange: (value) {
                          setState(() {
                            toBranchId = value?.id;
                          });
                        },
                      ),
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
            titleButton: "Tạo đơn chuyển hàng",
            onPressed: () {
              products = providerSell.listOrder
                  .map((e) => ProductMoveModel(
                        productId: e.productId,
                        id: e.id,
                        price: e.product?.price,
                        productUnitId: e.productUnit?.id,
                        quantity: AppFunction.textToInt(e.quantityController),
                        batches: e.batches
                            ?.map((batch) => Batches(
                                  id: batch.id,
                                  quantity: batch.quantity,
                                ))
                            .toList(),
                      ))
                  .toList();
              context.read<SellProvider>().getTotalItem();
              _create(context, products!);
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
    noteController.clear();
    setState(() {});
  }

  void _create(
    BuildContext context,
    List<ProductMoveModel> products,
  ) async {
    AppFunction.hideKeyboard(context);
    if (true) {
      // AppFunction.showLoading(context);
      var res = await ApiRequest.createMove(
        toBranchId: toBranchId,
        movedBy: movedBy,
        fromBranchId: context.read<BranchProvider>().defaultBranch?.id,
        products: products,
        totalItem: context.read<SellProvider>().totalItem,
      );
      if (res.result == true && context.mounted) {
        _resetPageWhenComplete(context);
        AppFunction.hideLoading(context);
        AppFunction.showDialogSuccess(context, content: "Tạo đơn thành công!");
      } else if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}
