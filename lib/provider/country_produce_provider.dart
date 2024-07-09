import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/country_produce_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class CountryProduceProvider extends ChangeNotifier {
  final List<CountryProduceModel> _listCountryProduce = [];
  List<CountryProduceModel> get listCountryProduce => _listCountryProduce;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListCountryProduce({int? limit, int? page,String ?keyword}) async {
    _listCountryProduce.clear();
    listCountryProduce.clear();
    ApiResponse response = await ApiRequest.getCountryProduce(
      page: page,
      limit: limit,
      keyword:keyword,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listCountryProduce.add(CountryProduceModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  List<ProvinceModel> get countryProduceDropdown => _listCountryProduce
      .map((e) => ProvinceModel(id: e.id, name: e.name))
      .toList();
}
