import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/position_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class PositionProvider extends ChangeNotifier {
  final List<PositionModel> _listPosition = [];
  List<PositionModel> get listPosition => _listPosition;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListPosition({int? limit, int? page}) async {
    _listPosition.clear();
    listPosition.clear();
    ApiResponse response = await ApiRequest.getPosition(
      page: page,
      limit: limit,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listPosition.add(PositionModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get positionDropdown =>
      _listPosition.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();
}
