import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/specialist_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class LevelDoctorProvider extends ChangeNotifier {
  final List<SpecialistModel> _listLevelDoctor = [];
  List<SpecialistModel> get listLevelDoctor => _listLevelDoctor;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListLevelDoctor({int? limit, int? page}) async {
    _listLevelDoctor.clear();
    listLevelDoctor.clear();
    ApiResponse response = await ApiRequest.getLevelDoctor(
      page: page,
      limit: limit,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listLevelDoctor.add(SpecialistModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get levelDoctorDropdown => _listLevelDoctor
      .map((e) => ProvinceModel(id: e.id, name: e.name))
      .toList();
}
