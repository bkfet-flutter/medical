import 'package:flutter/material.dart';
import 'package:mephar_app/model/product_return_detail_model.dart';
import 'package:mephar_app/model/product_return_model.dart';
import 'package:mephar_app/model/return_product_details_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/screens/return_product/return_product_detail_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class ProductReturnProvider extends ChangeNotifier {
  List<ProductReturnModel> _listProductReturn = [];

  List<ProductReturnModel> get listProductReturn => _listProductReturn;

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  int page = 1;
  int limit = 10;
  int total = 1;

  TextEditingController keywordController = TextEditingController();

  String get keyword => keywordController.text;

  int get totalPage => (total / limit).ceil();

  Future<void> fetchProductReturn(BuildContext context, {bool? firstCall}) async {
    if (firstCall == true) {
      page = 1;
      total = 1;
      keywordController.clear();
      notifyListeners();
    }
    int? branchId = Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    if (branchId != null) {
      loadingStatus(true);
      var res = await ApiRequest.productReturn(branchId: branchId, page: page, limit: limit, keyword: keyword);
      if (res.result == true) {
        final List<ProductReturnModel> items = [];
        for (var e in res.data['items']) {
          items.add(ProductReturnModel.fromJson(e));
        }
        total = res.data["totalItem"];
        _listProductReturn = items;
        notifyListeners();
        loadingStatus(false);
      } else {
        loadingStatus(false);
        if (context.mounted) AppFunction.showDialogError(context, res.message);
      }
    }
  }

  changePage(BuildContext context, int value) {
    page = value;
    notifyListeners();
    fetchProductReturn(context);
  }

  navigateDetails(BuildContext context, int? id) async {
    AppFunction.hideKeyboard(context);
    if (id != null) {
      final result =
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReturnProductDetailScreen(id)));
      if (result == true && context.mounted) {
        // fetchProductsInbound(context, firstCall: true);
      }
    }
  }

  Map<String, String> mapStatus = {"DRAFT": "Lưu tạm", "SUCCEED": "Hoàn thành"};

  ReturnProductDetailsModel _returnProductDetailsModel = ReturnProductDetailsModel();

  ReturnProductDetailsModel get returnProductDetailsModel => _returnProductDetailsModel;

  Future getDetails(BuildContext context, int? id) async {
    if (id != null) {
      AppFunction.showLoading(context);
      var res = await ApiRequest.productReturnDetails(id: id);
      if (res.result == true) {
        _returnProductDetailsModel = ReturnProductDetailsModel.fromJson(res.data);
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
  }
}
