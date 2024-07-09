import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/medicine_detail.dart';
import 'package:mephar_app/model/medicine_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class MedicineProvider extends ChangeNotifier {
  final List<MedicineModel> _listMedicine = [];

  List<MedicineModel> get listMedicine => _listMedicine;
  int total = 0;
  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getDataMedicine(String? search, int limit, int page) async {
    _listMedicine.clear();
    listMedicine.clear();
    ApiResponse response = await ApiRequest.getMedicine(
      search: search,
      limit: limit,
      page: page,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listMedicine.add(MedicineModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get medicineDropdown =>
      _listMedicine.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();
  MedicineDetail? dataMedicine;
  Future<String> getDataMedicineByCode(String? code) async {
    ApiResponse response = await ApiRequest.getMedicineByCode(code: code);

    if (response.result == true) {
      dataMedicine = response.data;
      notifyListeners();
      print(dataMedicine);
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }
}
