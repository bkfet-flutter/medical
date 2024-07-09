import 'package:flutter/material.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/model/config/province_model.dart';

class AddressProvider extends ChangeNotifier {
  //province
  final List<ProvinceModel> _listProvince = [];

  List<ProvinceModel> get listProvince => _listProvince;

  Future<String> getDataListProvince() async {
    _listProvince.clear();
    ApiResponse res = await ApiRequest.getAddress();
    if (res.result == true) {
      for (var e in res.data["items"]) {
        _listProvince.add(ProvinceModel.fromJson(e));
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return res.message ?? "Lỗi";
    }
  }

  //district
  final List<ProvinceModel> _listDistrict = [];

  List<ProvinceModel> get listDistrict => _listDistrict;

  clear() {
    _listDistrict.clear();
    _listWard.clear();
    selectDistrict(null);
    selectWard(null);
    notifyListeners();
  }

  Future<String> getDataListDistrict(int? id) async {
    _listDistrict.clear();
    if (id != null) {
      ApiResponse res = await ApiRequest.getDataDistrict(id);
      if (res.result == true) {
        for (var e in res.data["items"]) {
          _listDistrict.add(ProvinceModel.fromJson(e));
          notifyListeners();
        }
        return "success";
      } else {
        notifyListeners();
        return res.message ?? "Lỗi";
      }
    }
    return "No data";
  }

  //ward
  final List<ProvinceModel> _listWard = [];

  List<ProvinceModel> get listWard => _listWard;

  Future<String> getDataListWard({int? idProvince, int? idDistrict}) async {
    _listWard.clear();
    if (idProvince != null && idDistrict != null) {
      ApiResponse res = await ApiRequest.getDataWard(idProvince, idDistrict);
      if (res.result == true) {
        for (var e in res.data["items"]) {
          _listWard.add(ProvinceModel.fromJson(e));
          notifyListeners();
        }
        return "success";
      } else {
        notifyListeners();
        return res.message ?? "Lỗi";
      }
    }
    return "No data";
  }

  ProvinceModel? provinceValue;
  ProvinceModel? districtValue;
  ProvinceModel? wardValue;

  Future selectProvince(ProvinceModel? provinceModel) async {
    provinceValue = provinceModel;
    clear();
    if (provinceValue != null) {
      await getDataListDistrict(provinceValue?.id);
    }
    notifyListeners();
  }

  Future selectDistrict(ProvinceModel? provinceModel) async {
    selectWard(null);
    districtValue = provinceModel;
    if (districtValue != null && provinceValue != null) {
      await getDataListWard(idDistrict: districtValue?.id, idProvince: provinceValue?.id);
    }
    notifyListeners();
  }

  Future selectWard(ProvinceModel? provinceModel) async {
    wardValue = provinceModel;
    notifyListeners();
  }

  resetData() {
    _listWard.clear();
    _listDistrict.clear();
    _listProvince.clear();
    selectProvince(null);
    selectDistrict(null);
    selectWard(null);
    notifyListeners();
  }
}
