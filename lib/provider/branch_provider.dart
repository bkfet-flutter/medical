import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class BranchProvider extends ChangeNotifier {
  List<BranchModel> _listBranch = [];

  List<BranchModel> get listBranch => _listBranch;

  BranchModel? _defaultBranch;

  BranchModel? get defaultBranch => _defaultBranch;

  List<ProvinceModel> get branchDropdown => _listBranch.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();

  changeCurrentBranch({BranchModel? branchModel}) {
    _defaultBranch = branchModel;
    notifyListeners();
  }

  Future<void> initBranch(BuildContext context) async {
    await fetchBranches(context)
        .whenComplete(() => _defaultBranch = listBranch.firstWhere((element) => element.isDefaultBranch == true));
    notifyListeners();
  }

  bool loading = false;

  bool isDefault = true;

  changeDefault({bool? value}) {
    if (value == null) {
      isDefault = !isDefault;
      notifyListeners();
    } else {
      isDefault = value;
      notifyListeners();
    }
  }

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<void> fetchBranches(BuildContext context) async {
    loadingStatus(true);
    var res = await ApiRequest.branches();
    if (res.result == true) {
      final List<BranchModel> items = [];
      for (var e in res.data['items']) {
        items.add(BranchModel.fromJson(e));
      }
      _listBranch = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  void showError(BuildContext context) {
    AppFunction.showDialogError(context, errorText);
  }

  String errorText = "";

  setError(String error) {
    errorText = error;
    notifyListeners();
    return false;
  }

  validateBranch(BranchModel branchModel) {
    String error = "là trường bắt buộc";
    if (AppFunction.isNullOrEmpty(branchModel.name)) return setError("Tên chi nhánh $error");
    if (AppFunction.isNullOrEmpty(branchModel.phone)) return setError("Số điện thoại $error");
    if (AppFunction.isNullOrEmpty(branchModel.address1)) return setError("Địa chỉ $error");
    if (AppFunction.isNullOrEmpty(branchModel.provinceId)) return setError("Tỉnh/Thành phố $error");
    if (AppFunction.isNullOrEmpty(branchModel.districtId)) return setError("Quận/Huyện $error");
    if (AppFunction.isNullOrEmpty(branchModel.wardId)) return setError("Xã/Phường $error");
    if (!AppFunction.checkValidPhone(branchModel.phone)) return setError("Số điện thoại không hợp lệ");
    return true;
  }

  Future<void> createBranch(BuildContext context, {required BranchModel branchModel}) async {
    final check = validateBranch(branchModel);
    if (check == true) {
      var res = await ApiRequest.branchCreate(branchModel);
      if (res.result == true) {
        if (context.mounted) {
          Navigator.pop(context, true);
        }
      } else {
        if (context.mounted) AppFunction.showDialogError(context, res.message);
      }
    } else {
      showError(context);
    }
  }

  Future<bool> deleteBranch(BuildContext context, int? id) async {
    if (id != null) {
      var res = await ApiRequest.branchDelete(id);
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.showDialogSuccess(context, content: "Xoá chi nhánh thành công");
        }
        return true;
      } else {
        if (context.mounted) AppFunction.showDialogError(context, res.message);
        return false;
      }
    }
    return false;
  }

  BranchModel _branchModel = BranchModel();

  BranchModel get branchModel => _branchModel;

  Future<void> detailsBranch(BuildContext context, int? id) async {
    if (id != null) {
      loadingStatus(true);
      var res = await ApiRequest.branchDetails(id);
      if (res.result == true) {
        _branchModel = BranchModel.fromJson(res.data);
        notifyListeners();
        loadingStatus(false);
      } else {
        loadingStatus(false);
        if (context.mounted) AppFunction.showDialogError(context, res.message);
      }
    }
  }

  Future<void> editBranch(BuildContext context, {int? id, required BranchModel branchModel}) async {
    if (id != null) {
      final check = validateBranch(branchModel);
      if (check == true) {
        var res = await ApiRequest.branchEdit(branchModel, id);
        if (res.result == true) {
          if (context.mounted) {
            Navigator.pop(context, true);
          }
        } else {
          if (context.mounted) AppFunction.showDialogError(context, res.message);
        }
      } else {
        showError(context);
      }
    }
  }

  findBranch(int? id) {
    if (id != null) {
      for (var e in _listBranch) {
        if (e.id == id) {
          return ProvinceModel(id: e.id, name: e.name);
        }
      }
    }
  }
}
