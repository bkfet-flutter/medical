import 'package:flutter/material.dart';
import 'package:mephar_app/model/order_page_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:provider/provider.dart';

class OrderPageProvider extends ChangeNotifier {
  final List<OrderPageModel> _listOrderPage = [];
  List<OrderPageModel> get listOrderPage => _listOrderPage;
  int total = 0;
  int totalItem = 0;
  dynamic totalPrice = "0";
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getOrderPage(BuildContext context) async {
    _listOrderPage.clear();
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    ApiResponse response = await ApiRequest.getOrderPage(branchId: branchId);

    if (response.result == true) {
      for (var e in response.data["items"]) {
        _listOrderPage.add(OrderPageModel.fromJson(e));
      }
      totalItem = response.data["totalItem"];
      totalPrice = response.data["totalPrice"];
      notifyListeners();
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }
}
