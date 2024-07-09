import 'package:flutter/material.dart';
import 'package:mephar_app/model/shipping_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:provider/provider.dart';

class ShippingProvider extends ChangeNotifier {
  final List<ShippingModel> _listShipping = [];
  List<ShippingModel> get listShipping => _listShipping;
  int total = 0;
  int _currentPage = 1;
  get currentPage => _currentPage;
  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListShippingByFilter(
    BuildContext context, {
    int? page,
    int? limit,
    int? fromBranchId,
    int? toBranchId,
    int? receivedBy,
    String? movedAt,
    String? receivedAt,
    String? keyword,
    int? branchId,
    String? status,
  }) async {
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    _listShipping.clear();

    ApiResponse response = await ApiRequest.getListShippingByFilter(
      page: page,
      limit: limit,
      branchId: branchId,
      keyword: keyword,
      status: status,
      movedAt: movedAt,
      toBranchId: toBranchId,
      fromBranchId: fromBranchId,
      receivedAt: receivedAt,
      receivedBy: receivedBy,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listShipping.add(ShippingModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future<String> getListShipping(
    BuildContext context, {
    int? limit,
    int? page,
    String? keyword,
    String? status,
  }) async {
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    _listShipping.clear();

    ApiResponse response = await ApiRequest.getListShipping(
      page: page,
      limit: limit,
      branchId: branchId,
      keyword: keyword,
      status: status,
    );

    if (response.result == true) {
      for (var e in response.data['items']) {
        _listShipping.add(ShippingModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }

  ShippingModel detailShippingModel = ShippingModel();

  Future<void> getDetail(int id) async {
    detailShippingModel = _listShipping.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
