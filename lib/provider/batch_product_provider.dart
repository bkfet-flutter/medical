import 'package:flutter/material.dart';
import 'package:mephar_app/model/batch_product_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class BatchProductProvider extends ChangeNotifier {
  final List<BatchProductModel> _listBatch = [];
  List<BatchProductModel> get listBatch => _listBatch;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDebt(
      {int? limit, int? page, int? branchId, int? productId}) async {
    _listBatch.clear();

    ApiResponse response = await ApiRequest.getBatch(
        page: page, limit: limit, branchId: branchId, productId: productId);

    if (response.result == true) {
      for (var e in response.data["items"]) {
        _listBatch.add(BatchProductModel.fromJson(e));

        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }

  BatchProductModel? detail;
  Future<void> getDetail(int id) async {
    detail = _listBatch.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
