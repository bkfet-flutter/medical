import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isShowApi = false;

  get isShowApi => _isShowApi;

  void showLoading() {
    _isShowApi = true;

    notifyListeners();
  }

  void hideLoading() {
    _isShowApi = false;

    notifyListeners();
  }
}
