import 'package:flutter/material.dart';
import 'package:mephar_app/model/warehouse_card_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class WareHouseCradProvider extends ChangeNotifier {
  final List<WareHouseCardModel> _listWareHouse = [];
  List<WareHouseCardModel> get listWareHouse => _listWareHouse;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDebt(
      {int? limit, int? page, int? branchId, int? productId}) async {
    _listWareHouse.clear();

    ApiResponse response = await ApiRequest.getWareHouse(
        page: page, limit: limit, branchId: branchId, productId: productId);

    if (response.result == true) {
      for (var e in response.data["items"]) {
        _listWareHouse.add(WareHouseCardModel.fromJson(e));

        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }
}
