import 'package:flutter/material.dart';
import 'package:mephar_app/model/oder_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class OderCustomerProvider extends ChangeNotifier {
  final List<OderCustomerModel> _listOderCustomer = [];

  List<OderCustomerModel> get listOderCustomer => _listOderCustomer;
  int total = 0;

  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListOderCustomer(
      String? keyword, int? page, int? limit, int branchId) async {
    _listOderCustomer.clear();
    listOderCustomer.clear();

    ApiResponse resOderCustomer =
        await ApiRequest.getOrder(keyword, limit, page, branchId);
    if (resOderCustomer.result == true) {
      for (var e in resOderCustomer.data['items']) {
        _listOderCustomer.add(OderCustomerModel.fromJson(e));
        total = resOderCustomer.data['totalItem'];
        notifyListeners();
      }

      notifyListeners();

      return "success";
    } else {
      notifyListeners();
      return resOderCustomer.message ?? "Lỗi";
    }
  }

  OderCustomerModel? oder;
  Future<void> getDetailOderCustomer(int id) async {
    oder = _listOderCustomer.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
