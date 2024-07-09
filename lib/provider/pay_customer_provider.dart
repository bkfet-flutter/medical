import 'package:flutter/material.dart';
import 'package:mephar_app/model/pay_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class PayCustomerProvider extends ChangeNotifier {
  final List<PayCustomerModel> _listPayCustomer = [];

  List<PayCustomerModel> get listPayCustomer => _listPayCustomer;
  int total = 0;

  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListPayCustomer(String? keyword, int? page, int? limit,
      String status, int branchId) async {
    _listPayCustomer.clear();
    listPayCustomer.clear();

    ApiResponse resPayCustomer = await ApiRequest.getListPayCustomer(
        keyword, page, limit, status, branchId);
    if (resPayCustomer.result == true) {
      for (var e in resPayCustomer.data['items']) {
        _listPayCustomer.add(PayCustomerModel.fromJson(e));
        total = resPayCustomer.data['totalItem'];
        notifyListeners();
      }

      notifyListeners();

      return "success";
    } else {
      notifyListeners();
      return resPayCustomer.message ?? "Lỗi";
    }
  }

  PayCustomerModel? pay;
  Future<void> getDetailPayCustomer(int id) async {
    pay = _listPayCustomer.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
