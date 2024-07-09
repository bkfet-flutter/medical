import 'package:flutter/material.dart';
import 'package:mephar_app/model/payment_history_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class PaymentHistoryProvider extends ChangeNotifier {
  final List<PaymentHistoryModel> _listPaymentHistory = [];
  List<PaymentHistoryModel> get listPaymentHistory => _listPaymentHistory;
  int total = 0;

  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<void> getListPaymentHistory({
    int? id,
    int? page,
    int? limit,
  }) async {
    _listPaymentHistory.clear();

    ApiResponse resPaymentHistory = await ApiRequest.getPaymentHistory(
      id: id,
      page: page,
      limit: limit,
    );
    if (resPaymentHistory.result == true) {
      for (var e in resPaymentHistory.data) {
        _listPaymentHistory.add(PaymentHistoryModel.fromJson(e));
      }
      notifyListeners();

      // return "success";
    } else {
      notifyListeners();
      // return "error";
    }
  }

  PaymentHistoryModel? paymentHistory;
  Future<void> getDetailPayCustomer(int id) async {
    paymentHistory = _listPaymentHistory.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
