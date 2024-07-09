import 'package:flutter/material.dart';
import 'package:mephar_app/model/inventory_model.dart';
import 'package:mephar_app/model/warehouse_card_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class InventoryProvider extends ChangeNotifier {
  final List<InventoryModel> _listInventory = [];
  List<InventoryModel> get listInventory => _listInventory;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDebt({int? id}) async {
    _listInventory.clear();

    ApiResponse response = await ApiRequest.getInventory(id: id);

    if (response.result == true) {
      for (var e in response.data) {
        _listInventory.add(InventoryModel.fromJson(e));
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }
}
