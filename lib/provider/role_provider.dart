import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/permission_model.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/config/role_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class RoleProvider extends ChangeNotifier {
  List<RoleModel> _listRole = [];

  List<RoleModel> get listRole => _listRole;

  List<ProvinceModel> get roleDropdown => _listRole.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<void> fetchRoles(BuildContext context) async {
    loadingStatus(true);
    var res = await ApiRequest.roles();
    if (res.result == true) {
      final List<RoleModel> items = [];
      for (var e in res.data['items']) {
        items.add(RoleModel.fromJson(e));
      }
      _listRole = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  findRole(int? id) {
    if (id != null) {
      for (var e in _listRole) {
        if (e.id == id) {
          return ProvinceModel(id: e.id, name: e.name);
        }
      }
    }
  }

  List<ProvinceModel> positions = [
    ProvinceModel(id: 1, name: "Admin"),
    ProvinceModel(id: 2, name: "Quản lý"),
    ProvinceModel(id: 3, name: "Nhân viên"),
  ];

  Map positionMap = {
    "admin": ProvinceModel(id: 1, name: "Admin"),
    "management": ProvinceModel(id: 2, name: "Quản lý"),
    "staff": ProvinceModel(id: 3, name: "Nhân viên"),
  };
  String selectKey = "";

  findKey(ProvinceModel? targetValue) {
    if (targetValue != null) {
      positionMap.forEach((key, value) {
        if (value == targetValue) {
          selectKey = key;
        }
      });
    }
    notifyListeners();
    return selectKey;
  }

  Future<bool> deleteRole(BuildContext context, int? id) async {
    if (id != null) {
      var res = await ApiRequest.roleDelete(id: id);
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.showDialogSuccess(context, content: "Xoá vai trò thành công");
        }
        return true;
      } else {
        if (context.mounted) AppFunction.showDialogError(context, res.message);
        return false;
      }
    }
    return false;
  }

  //profile staff
  PermissionModel roleDetails = PermissionModel();

  Future<void> getRoleDetails(BuildContext context, int? id) async {
    if (id != null) {
      ApiResponse res = await ApiRequest.roleDetails(id);
      if (res.result == true) {
        PermissionModel data = PermissionModel.fromJson(res.data);
        roleDetails = data;
        notifyListeners();
      } else {
        if (context.mounted) {
          AppFunction.showDialogError(context, res.message);
        }
      }
      notifyListeners();
    }
  }
}
