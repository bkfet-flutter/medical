import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/dosage_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class DosageProvider extends ChangeNotifier {
  final List<DosageModel> _listDosage = [];
  List<DosageModel> get listDosage => _listDosage;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDosage({int? limit, int? page}) async {
    _listDosage.clear();
    listDosage.clear();
    ApiResponse response = await ApiRequest.getDosage(
      page: page,
      limit: limit,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listDosage.add(DosageModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get dosageDropdown =>
      _listDosage.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();
}
