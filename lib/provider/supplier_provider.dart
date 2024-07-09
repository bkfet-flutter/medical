import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/group_supplier_model.dart';
import 'package:mephar_app/model/supplier_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class SupplierProvider extends ChangeNotifier {
  // Supplier
  final List<SupplierModel> _listSupplier = [];
  int total = 0;
  int _currentPage = 1;
  int totalGroup = 0;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  List<SupplierModel> get listSupplier => _listSupplier;

  List<String> nameGroupSupplierModel = [];

  void clearList() {
    _listSupplier.clear();
    listGroupSupplier.clear();
    notifyListeners();
  }

  Future<void> getDataSupplier(
      BuildContext context, String? search, int? page, int? limit) async {
    _listSupplier.clear();
    _listGroupSupplier.clear();
    AppFunction.showLoading(context);
    ApiResponse resSupplier = await ApiRequest.getSupplier(search, limit, page);
    if (resSupplier.result == true && context.mounted) {
      for (var e in resSupplier.data['items']) {
        _listSupplier.add(SupplierModel.fromJson(e));
      }
      total = resSupplier.data['totalItem'];

      AppFunction.hideLoading(context);
    } else if (context.mounted) {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(
          context, resSupplier.message ?? "Lỗi không xác định");
    }
    notifyListeners();
  }

  // Group Supplier
  final List<GroupSupplierModel> _listGroupSupplier = [];

  List<GroupSupplierModel> get listGroupSupplier => _listGroupSupplier;

  void clearListGroup() {
    _listGroupSupplier.clear();

    notifyListeners();
  }

  Future<void> getDataGroupSupplier(
      BuildContext context, String? search, int? page, int? limit) async {
    _listGroupSupplier.clear();

    ApiResponse resGroupSupplier =
        await ApiRequest.getGroupSupplier(search, limit, page);
    if (resGroupSupplier.result == true) {
      for (var e in resGroupSupplier.data['items']) {
        _listGroupSupplier.add(GroupSupplierModel.fromJson(e));
      }

      totalGroup = resGroupSupplier.data['totalItem'];
    } else if (context.mounted) {
      AppFunction.showDialogError(
          context, resGroupSupplier.message ?? "Lỗi không xác định");
    }

    notifyListeners();
  }

  Future<void> addGroupSupplier(
    BuildContext context,
    String nameGroupCustomer,
    int branchId,
    String detail,
  ) async {
    ApiResponse resAddSupplier =
        await ApiRequest.addSupplierGroup(nameGroupCustomer, branchId, detail);
    if (resAddSupplier.result == true && context.mounted) {
      AppFunction.showDialogSuccess(
        context,
        content: 'Thêm mới thành công',
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, resAddSupplier.message);
      }
      notifyListeners();
    }
  }

  Future<void> editGroupSupplier(
    BuildContext context,
    int id,
    String nameGroupCustomer,
    int branchId,
    String detail,
  ) async {
    ApiResponse resAddSupplier = await ApiRequest.editSupplierGroup(
        id, nameGroupCustomer, branchId, detail);
    if (resAddSupplier.result == true && context.mounted) {
      AppFunction.showDialogSuccess(
        context,
        content: 'Chỉnh sửa thành công',
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, resAddSupplier.message);
      }
      notifyListeners();
    }
  }

  Future<void> addSupplier(
    BuildContext context,
    String address,
    int branchId,
    String code,
    String companyName,
    int districtId,
    String email,
    int groupSupplierId,
    String name,
    String note,
    String phone,
    int provinceId,
    String taxCode,
    int wardId,
  ) async {
    ApiResponse res = await ApiRequest.addSupplier(
      address,
      branchId,
      code,
      companyName,
      districtId,
      email,
      groupSupplierId,
      name,
      note,
      phone,
      provinceId,
      taxCode,
      wardId,
    );
    if (res.result == true && context.mounted) {
      AppFunction.showDialogSuccess(
        context,
        content: 'Thêm mới thành công',
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
      notifyListeners();
    }
  }

  Future<void> editSupplier(
    BuildContext context,
    int id,
    String address,
    int branchId,
    String code,
    String companyName,
    int districtId,
    String email,
    int groupSupplierId,
    String name,
    String note,
    String phone,
    int provinceId,
    String taxCode,
    int wardId,
  ) async {
    ApiResponse res = await ApiRequest.editSupplier(
      id,
      address,
      branchId,
      code,
      companyName,
      districtId,
      email,
      groupSupplierId,
      name,
      note,
      phone,
      provinceId,
      taxCode,
      wardId,
    );
    if (res.result == true && context.mounted) {
      AppFunction.showDialogSuccess(
        context,
        content: 'Cập nhật thông tin thành công',
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        AppFunction.hideLoading(context);
        AppFunction.showDialogError(context, res.message);
      }
      notifyListeners();
    }
  }

  Future<void> refreshList() async {
    _listGroupSupplier.clear();

    notifyListeners();
  }

  List<ProvinceModel> get supplierDropdown =>
      _listSupplier.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();
  SupplierModel? supplier;

  Future<void> getDetailSupplier(int id) async {
    supplier = _listSupplier.firstWhere((data) => data.id == id);
    notifyListeners();
  }

  GroupSupplierModel? groupSupplier;

  Future<void> getGroupSupplier(int id) async {
    groupSupplier = _listGroupSupplier.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
