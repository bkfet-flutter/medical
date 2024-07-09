import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/manufacture_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class ManufactureProvider extends ChangeNotifier {
  final List<ManufactureModel> _listManufacture = [];
  List<ManufactureModel> get listManufacture => _listManufacture;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListManufacture(
      {int? limit, int? page, String? keyword}) async {
    _listManufacture.clear();
    listManufacture.clear();
    ApiResponse response = await ApiRequest.getManufacture(
        page: page, limit: limit, keyword: keyword);

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listManufacture.add(ManufactureModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get manufactureDropdown => _listManufacture
      .map((e) => ProvinceModel(id: e.id, name: e.name))
      .toList();
}
