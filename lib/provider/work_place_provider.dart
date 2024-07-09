import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/specialist_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class WorkPlaceDoctorProvider extends ChangeNotifier {
  final List<SpecialistModel> _listWorkPlaceDoctor = [];
  List<SpecialistModel> get listWorkPlaceDoctor => _listWorkPlaceDoctor;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListWorkPlaceDoctor({int? limit, int? page}) async {
    _listWorkPlaceDoctor.clear();
    listWorkPlaceDoctor.clear();
    ApiResponse response = await ApiRequest.getWorkPlaceDoctor(
      page: page,
      limit: limit,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listWorkPlaceDoctor.add(SpecialistModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get workPlaceDoctorDropdown => _listWorkPlaceDoctor
      .map((e) => ProvinceModel(id: e.id, name: e.name))
      .toList();
}
