import 'package:flutter/material.dart';
import 'package:mephar_app/model/debt_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:provider/provider.dart';

class DebtCustomerProvider extends ChangeNotifier {
  final List<DebtCustomerModel> _listDebt = [];
  List<DebtCustomerModel> get listDebt => _listDebt;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDebt(
      {int? limit, int? page, int? branchId, int? id}) async {
    _listDebt.clear();

    ApiResponse response = await ApiRequest.getDebt(
        page: page, limit: limit, branchId: branchId, id: id);

    if (response.result == true) {
      for (var e in response.data) {
        _listDebt.add(DebtCustomerModel.fromJson(e));

        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }
}
