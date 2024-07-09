import 'package:flutter/material.dart';
import 'package:mephar_app/model/inbound_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class SellProvider extends ChangeNotifier {
  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  int page = 1;
  int limit = 20;
  int total = 1;
  int productUnitId = 0;
  TextEditingController keywordController = TextEditingController();

  String get keyword => keywordController.text;

  int get totalPage => (total / limit).ceil();

  //danh sach nhap san pham ban

  List<InboundModel> _listProductSell = [];

  List<InboundModel> get listProductSell => _listProductSell;

  Future<void> fetchProductsSell(BuildContext context, {bool? firstCall}) async {
    if (firstCall == true) {
      page = 1;
      total = 1;
      keywordController.clear();
      notifyListeners();
    }
    int? branchId = Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    if (branchId != null) {
      loadingStatus(true);
      var res = await ApiRequest.productsMasterForSale(brandId: branchId, page: page, limit: limit, keyword: keyword);
      if (res.result == true) {
        final List<InboundModel> items = [];
        for (var e in res.data['items']) {
          items.add(InboundModel.fromJson(e));
        }
        total = res.data["totalItem"];
        _listProductSell = items;
        notifyListeners();
        loadingStatus(false);
      } else {
        loadingStatus(false);
        if (context.mounted) AppFunction.showDialogError(context, res.message);
      }
    }
  }

  resetData() {
    listOrder.clear();
    _totalMoney = 0;
    notifyListeners();
  }

  List<InboundModel> listOrder = [];

  double _totalMoney = 0;

  int getTotalPrice({int? discountValue, int? discountType}) {
    int dis = discountValue ?? 0;
    int money;
    switch (discountType) {
      case 1:
        money = (_totalMoney * (1 - dis / 100)).toInt();
      case 2:
        money = (_totalMoney - dis).toInt();
      default:
        money = _totalMoney.toInt();
    }
    return money < 0 ? 0 : money;
  }

  double get totalMoney => _totalMoney;
  int _totalItem = 0;

  int get totalItem => _totalItem;

  getTotal() {
    _totalMoney = listOrder.fold(
        0,
        (previousValue, element) =>
            previousValue + (AppFunction.textToInt(element.quantityController) * (element.price ?? 0)));
    notifyListeners();
  }

  getTotalItem() {
    _totalItem = listOrder.fold(
        0, (previousValue, element) => previousValue + (AppFunction.textToInt(element.quantityController)));
    notifyListeners();
  }

  addToListOrder(InboundModel? value) {
    if (value != null) {
      if (listOrder.isEmpty || !listOrder.any((e) => e.id == value.id)) {
        listOrder.add(value);
      }
      getTotal();
      notifyListeners();
    }
  }

  removeValue(InboundModel value) {
    listOrder.remove(value);
    getTotal();
    notifyListeners();
  }

  selectBatch(BatchForSale value) {
    if (value.isSelected == true) {
      value.isSelected = false;
    } else {
      value.isSelected = true;
    }
    notifyListeners();
  }
}
