import 'package:flutter/material.dart';
import 'package:mephar_app/model/batch_model.dart';
import 'package:mephar_app/model/enter_product_model.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/model/product_inbound_details_model.dart';
import 'package:mephar_app/model/product_inbound_model.dart';
import 'package:mephar_app/model/return_product_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/screens/enter_product/enter_product_detail_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class ImportProductProvider extends ChangeNotifier {
  Map<String, String> mapStatus = {"DRAFT": "Lưu tạm", "SUCCEED": "Hoàn thành"};

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  int page = 1;
  int limit = 5;
  int total = 1;

  TextEditingController keywordController = TextEditingController();

  String get keyword => keywordController.text;

  int get totalPage => (total / limit).ceil();

  //danh sach nhap san pham

  List<ProductInboundModel> _listProductInbound = [];

  List<ProductInboundModel> get listProductInbound => _listProductInbound;

  Future<void> fetchProductsInbound(BuildContext context,
      {bool? firstCall}) async {
    if (firstCall == true) {
      page = 1;
      total = 1;
      keywordController.clear();
      notifyListeners();
    }
    loadingStatus(true);
    var res = await ApiRequest.inboundProducts(context,
        page: page, limit: limit, keyword: keyword);
    if (res.result == true) {
      final List<ProductInboundModel> items = [];
      for (var e in res.data['items']) {
        items.add(ProductInboundModel.fromJson(e));
      }
      total = res.data["totalItem"];
      _listProductInbound = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  Future<void> fetchProductsInboundByFilter(
    BuildContext context, {
    bool? firstCall,
    int? userId,
    int? supplierId,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    if (firstCall == true) {
      page = 1;
      total = 1;
      keywordController.clear();
      notifyListeners();
    }
    loadingStatus(true);
    var res = await ApiRequest.inboundProductsByFilter(
      context,
      page: page,
      limit: limit,
      keyword: keyword,
      userId: userId,
      status: status,
      supplierId: supplierId,
      startDate: startDate,
      endDate: endDate,
    );
    if (res.result == true) {
      final List<ProductInboundModel> items = [];
      for (var e in res.data['items']) {
        items.add(ProductInboundModel.fromJson(e));
      }
      total = res.data["totalItem"];
      _listProductInbound = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  changePage(BuildContext context, int value) {
    page = value;
    notifyListeners();
    fetchProductsInbound(context);
  }

  //chi tiết nhập hàng
  ProductInboundDetailsModel _productInboundModel =
      ProductInboundDetailsModel();

  ProductInboundDetailsModel get productInboundModel => _productInboundModel;

  navigateDetails(BuildContext context, int? id) async {
    AppFunction.hideKeyboard(context);
    if (id != null) {
      final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EnterProductDetailScreen(id: id)));
      if (result == true && context.mounted) {
        // AppFunction.showDialogAlert(context,
        //     customImage: Image.asset(
        //       AppImages.notiSuccess,
        //       width: 116,
        //       height: 120,
        //       fit: BoxFit.cover,
        //     ),
        //     noDivider: true,
        //     showBtnClose: true,
        //     hideBtnBottom: true, onPressedClose: () {
        //   Navigator.of(context, rootNavigator: true).pop();
        //   // callApi(null);
        // },
        //     styleTitle: AppFonts.normalBoldInter(
        //       20,
        //       AppThemes.green0,
        //     ),
        //     title: "Thành công",
        //     styleDescription: AppFonts.light(
        //       16,
        //       AppThemes.dark1,
        //     ),
        //     imageClose: AppImages.closeNormal,
        //     description: "Đã xóa thành công");
        fetchProductsInbound(context, firstCall: true);
      }
    }
  }

  Future getDetails(BuildContext context, int id) async {
    AppFunction.showLoading(context);
    var res = await ApiRequest.inboundDetails(id);
    if (res.result == true) {
      _productInboundModel = ProductInboundDetailsModel.fromJson(res.data);
      notifyListeners();
      if (context.mounted) {
        AppFunction.hideLoading(context);
      }
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
    }
  }

  //Tìm kiếm hàng
  final List<InboundModel> _searchList = [];

  List<InboundModel> get searchList => _searchList;

  void addToSearchList(InboundModel? model) {
    if (model != null) {
      if (_searchList.isEmpty || !_searchList.any((e) => e.id == model.id)) {
        _searchList.add(model);
        notifyListeners();
      }
    }
  }

  void removeIndex(int index) {
    _searchList.removeAt(index);
    notifyListeners();
  }

  void removeBatch(int index, BatchModel value) {
    _searchList[index].batches?.remove(value);
    notifyListeners();
  }

  addBatch({required int index, List<BatchModel>? list}) {
    if (list != null) {
      searchList[index].batches?.clear();
      searchList[index].batches?.addAll(list);
    }
    notifyListeners();
  }

  List<ProductsImport> get products => _searchList
      .map((e) => ProductsImport(
          productId: e.productId,
          totalQuantity: AppFunction.textToInt(e.quantityController),
          importPrice: e.price,
          totalPrice: e.totalAmount,
          discount: AppFunction.textToInt(e.discountController),
          productUnitId: e.id,
          batches: e.batches
              ?.map((e) => Batches(
                  id: e.id,
                  quantity: AppFunction.textToInt(e.quantityController),
                  expiryDate: e.expiryDate))
              .toList()))
      .toList();

  num get totalPrice => _searchList.fold(0,
      (previousValue, element) => previousValue + (element.totalAmount ?? 0));

  totalAmount(int? index) {
    if (index != null) {
      _searchList[index].totalAmount = AppFunction.totalAmount(
          _searchList[index].quantityController,
          _searchList[index].priceController,
          _searchList[index].discountController);
      notifyListeners();
    }
  }

  Future<bool> enter(BuildContext context,
      {int? userId,
      int? supplierId,
      String? description,
      required int discount,
      required int paid,
      required String status}) async {
    var branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    if (userId == null || supplierId == null || branchId == null) {
      AppFunction.showDialogError(context, "Empty Data");
      return false;
    } else {
      var res = await ApiRequest.inbound(EnterProductModel(
          branchId: branchId,
          userId: userId,
          supplierId: supplierId,
          totalPrice: (totalPrice - discount),
          discount: discount,
          paid: paid,
          debt: (totalPrice - discount - paid).toInt(),
          description: description,
          status: status,
          products: products));
      if (res.result == true) {
        _searchList.clear();
        return true;
      } else if (context.mounted) {
        AppFunction.showDialogError(context, res.message);
        return false;
      }
      return false;
    }
  }

  //xoa
  Future<bool> delete(BuildContext context, int id) async {
    var res = await ApiRequest.inboundDelete(id);
    if (res.result == true) {
      if (context.mounted) {}
    } else {
      if (context.mounted) {
        AppFunction.showDialogError(context, res.message);
      }
    }
    return res.result == true;
  }

  //tra hang
  productReturn(BuildContext context, {required String status}) async {
    var branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    if (branchId == null) {
      AppFunction.showDialogError(context, "Empty Data");
      return false;
    } else {
      var res = await ApiRequest.productReturnCreate(
          returnProductModel: ReturnProductModel(
              branchId: branchId,
              userId: _productInboundModel.inbound?.userId,
              supplierId: _productInboundModel.inbound?.supplierId,
              totalPrice: _productInboundModel.inbound?.totalPrice,
              debt: _productInboundModel.inbound?.debt,
              status: status,
              products: _productInboundModel.products
                  ?.map((e) => ProductReturns(
                      productId: e.productBatchHistories?[0].productId,
                      productUnitId: e.productBatchHistories?[0].productUnitId,
                      importPrice: e.productBatchHistories?[0].importPrice,
                      totalQuantity: e.productBatchHistories
                          ?.fold(0, (pre, e) => (pre ?? 0) + (e.quantity ?? 0)),
                      totalPrice: e.productBatchHistories?[0].totalPrice,
                      discount: e.productBatchHistories?[0].discount,
                      batches: e.productBatchHistories
                          ?.where((element) => element.batch != null)
                          .map((batch) => batch.batch!)
                          .toList()))
                  .toList()));
      if (res.result == true) {
        return true;
      } else if (context.mounted) {
        AppFunction.showDialogError(context, res.message);
        return false;
      }
      return false;
    }
  }
}
