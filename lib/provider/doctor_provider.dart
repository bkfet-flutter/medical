import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/doctor_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class DoctorProvider extends ChangeNotifier {
  final List<DoctorModel> _listDoctor = [];
  List<DoctorModel> get listDoctor => _listDoctor;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListDoctor({int? limit, int? page, String? keyword}) async {
    _listDoctor.clear();
    listDoctor.clear();
    ApiResponse response = await ApiRequest.getListDoctor(
      page: page,
      limit: limit,
      keyword: keyword,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listDoctor.add(DoctorModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get double =>
      _listDoctor.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();

  DoctorModel? doctor;
  Future<void> getDetailCustomer(int id) async {
    clearDoctor();
    doctor = _listDoctor.firstWhere((data) => data.id == id);
    notifyListeners();
  }

  void clearDoctor() {
    doctor = null;
    notifyListeners();
  }
}
