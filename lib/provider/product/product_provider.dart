import 'package:flutter/material.dart';
import 'package:mephar_app/model/product_model.dart';
import 'package:mephar_app/model/unit_product_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/screens/product/product/detail_product_screen.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  // get all product
  List<ProductModel> _listAllProduct = [];

  List<ProductModel> get listAllProduct => _listAllProduct;

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

  Future<void> fetchProducts(BuildContext context,
      {bool? firstCall, String? status, String? type, String? keyword}) async {
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    if (branchId != null) {
      _listAllProduct.clear();
      if (firstCall == true) {
        page = 1;
        total = 1;
        keywordController.clear();
        notifyListeners();
      }
      loadingStatus(true);
      var res = await ApiRequest.products(
          page: page,
          limit: limit,
          keyword: keyword,
          branchId: branchId,
          status: status,
          type: type);
      if (res.result == true) {
        final List<ProductModel> items = [];
        for (var e in res.data['items']) {
          items.add(ProductModel.fromJson(e));
        }
        total = res.data["totalItem"];
        _listAllProduct = items;
        notifyListeners();
        loadingStatus(false);
      } else {
        loadingStatus(false);
        if (context.mounted) AppFunction.showDialogError(context, res.message);
      }
    }
  }

  prevPage(BuildContext context) {
    if (page > 1) {
      page = page - 1;
      notifyListeners();
      fetchProducts(
        context,
      );
    }
  }

  nextPage(BuildContext context) {
    if (page < totalPage) {
      page = page + 1;
      notifyListeners();
      fetchProducts(
        context,
      );
    }
  }

  List<UnitProductsModel> listUnitProducts = [];
  //get detail product
  ProductModel detailProductModel = ProductModel();

  getDetailProduct(BuildContext context, int? index) async {
    if (index != null) {
      detailProductModel = listAllProduct[index];
      notifyListeners();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DetailProductScreen()));
    }
  }

  Future<void> getDetail(int id) async {
    detailProductModel = _listAllProduct.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
