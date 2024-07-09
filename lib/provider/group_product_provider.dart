import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/group_product_model.dart';
import 'package:mephar_app/model/unit_product_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class GroupProductProvider extends ChangeNotifier {
  List<UnitProductsModel> listUnitProducts = [];
  final List<GroupProductModel> _listGroupProduct = [];
  List<GroupProductModel> get listGroupProduct => _listGroupProduct;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListGroupProduct({int? limit, int? page}) async {
    _listGroupProduct.clear();
    listGroupProduct.clear();
    ApiResponse response = await ApiRequest.getGroupProduct(
      page: page,
      limit: limit,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listGroupProduct.add(GroupProductModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get groupProductDropDown => _listGroupProduct
      .map((e) => ProvinceModel(id: e.id, name: e.name))
      .toList();
}
