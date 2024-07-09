import 'package:flutter/material.dart';
import 'package:mephar_app/model/purchase_history_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class PurchaseHistoryProvider extends ChangeNotifier {
  final List<PurchaseHistoryModel> _listPurchaseHistory = [];
  List<PurchaseHistoryModel> get listPurchaseHistory => _listPurchaseHistory;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListPurchaseHistory({
    int? limit,
    int? page,
    int? branchId,
    int? customerId,
  }) async {
    _listPurchaseHistory.clear();

    ApiResponse response = await ApiRequest.getListPurchaseHistory(
      page: page,
      limit: limit,
      branchId: branchId,
      customerId: customerId,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listPurchaseHistory.add(PurchaseHistoryModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }
}
