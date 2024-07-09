import 'package:flutter/material.dart';
import 'package:mephar_app/model/price_settings_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/price_adjustment.dart';

class PriceSettingProvider extends ChangeNotifier {
  List<PriceSettingsModel> _listSetting = [];

  List<PriceSettingsModel> get listSetting => _listSetting;

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  int page = 1;
  int limit = 5;
  int total = 1;

  TextEditingController keywordController = TextEditingController();

  String get keyword => keywordController.text;

  int get totalPage => (total / limit).ceil();

  Future<void> fetchPriceSettings(BuildContext context, {bool? firstCall}) async {
    if (firstCall == true) {
      page = 1;
      total = 1;
      keywordController.clear();
      notifyListeners();
    }
    loadingStatus(true);
    var res = await ApiRequest.priceSettings(page: page, limit: limit, keyword: keyword);
    if (res.result == true) {
      final List<PriceSettingsModel> items = [];
      for (var e in res.data['items']) {
        items.add(PriceSettingsModel.fromJson(e));
      }
      total = res.data["totalItem"];
      _listSetting = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  changePage(BuildContext context, int value) {
    page = value;
    notifyListeners();
    fetchPriceSettings(context);
  }

  String newPrice = "";

  TextEditingController basePriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  String get basePrice => basePriceController.text;

  String get discountValue => discountController.text;

  void changePrice() {
    int? value;

    if (discountValue.isNotEmpty) {
      if (unit == Unit.vnd) {
        value = calculateValue(math, int.parse(basePrice), int.parse(discountValue));
      } else if (unit == Unit.percent) {
        double discountMultiplier =
            (math == Math.plus) ? (1 + int.parse(discountValue) / 100) : (1 - int.parse(discountValue) / 100);
        value = (int.parse(basePrice) * discountMultiplier).round();
      }
    } else {
      value = int.parse(basePrice);
    }
    setPrice(value);
  }

  int calculateValue(Math operation, int base, int discount) {
    if (operation == Math.plus) {
      return base + discount;
    } else if (operation == Math.minus) {
      return base - discount;
    }
    throw ArgumentError('Invalid operation: $operation');
  }

  setBasePrice(int? value) {
    if (value != null) {
      basePriceController.text = value.toString();
      notifyListeners();
    }
  }

  setPrice(int? value) {
    if (value != null) {
      newPrice = value.toString();
      notifyListeners();
    }
  }

  Math math = Math.plus;

  setMath(Math value) {
    math = value;
    notifyListeners();
    changePrice();
  }

  Unit unit = Unit.vnd;

  setUnit(Unit value) {
    unit = value;
    notifyListeners();
    changePrice();
  }

  bool isApplyForAll = false;

  setApply() {
    isApplyForAll = !isApplyForAll;
    notifyListeners();
  }

  resetData() {
    isApplyForAll = false;
    discountController.clear();
    setUnit(Unit.vnd);
    setMath(Math.plus);
  }

  Map typeSetting = {Unit.vnd: 2, Unit.percent: 1};

  Future<bool> edit(BuildContext context, {int? id}) async {
    int? value;
    if (discountValue.isEmpty) {
      value = 0;
    } else {
      if (math == Math.plus) {
        value = int.parse(discountValue);
      }
      if (math == Math.minus) {
        value = -int.parse(discountValue);
      }
    }
    if (id != null && value != null) {
      var res = await ApiRequest.editPriceSettings(
          id: id, type: typeSetting[unit], value: value, isApplyForAll: isApplyForAll, branchId: 10);
      if (res.result == true) {
        if (context.mounted) {
          resetData();
          AppFunction.showDialogSuccess(context, content: "Chỉnh sửa thành công");
        }
        return true;
      } else {
        if (context.mounted) AppFunction.showDialogError(context, res.message);
        return false;
      }
    }
    return false;
  }
}
