import 'package:flutter/material.dart';
import 'package:mephar_app/model/setting_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class SettingProvider extends ChangeNotifier {
  SettingModel? setting;

  Future<String> getSetting() async {
    ApiResponse resSetting = await ApiRequest.getSetting();
    if (resSetting.result == true) {
      setting = resSetting.data;
      notifyListeners();
      return "success";
    } else {
      notifyListeners();
      return resSetting.message ?? "Lỗi";
    }
  }
}
