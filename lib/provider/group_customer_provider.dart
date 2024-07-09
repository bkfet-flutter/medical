import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/group_customer_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class GroupCustomerProvider extends ChangeNotifier {
  // get -data
  final List<GroupCustomerModel> _listGroupCustomer = [];

  List<GroupCustomerModel> get listGroupCustomer => _listGroupCustomer;

  final List<bool> _check = [];

  List<bool> get check => _check;
  bool _isChecked = false;

  get isChecked => _isChecked;
  int countTrue = 0;
  int total = 0;

  void changeChecked() {
    _isChecked = false;
    notifyListeners();
  }

  int? _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  void clearList() {
    _listGroupCustomer.clear();
    listGroupCustomer.clear();
    notifyListeners();
  }

  void setChecked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  void setAllChecked() {
    _isChecked = _check.every((value) => value == true);
    notifyListeners();
  }

  Future<String> getDataGroupCustomer(String? keyword, int? page, int? limit) async {
    _listGroupCustomer.clear();
    listGroupCustomer.clear();
    groupCustomerDropdown.clear();
    _check.clear();
    ApiResponse resGroupCustomer = await ApiRequest.getGroupCustomer(keyword, page, limit);
    if (resGroupCustomer.result == true) {
      for (var e in resGroupCustomer.data['items']) {
        _listGroupCustomer.add(GroupCustomerModel.fromJson(e));
        total = resGroupCustomer.data['totalItem'];
        notifyListeners();
      }

      _check.add(false);
      notifyListeners();

      return "success";
    } else {
      notifyListeners();
      return resGroupCustomer.message ?? "Lỗi";
    }
  }

  void checkCountTrue() {
    for (var i = 0; i < _check.length; i++) {
      if (_check[i] == true) {
        countTrue++;
      }
    }
    notifyListeners();
  }

  void resetCheck() {
    for (var i = 0; i < _check.length; i++) {
      _check[i] = false;
    }
    notifyListeners();
  }

  void changeCheck(int index) {
    _check[index] = !_check[index];
    notifyListeners();
  }

  void oneFalse(int index) {
    for (var i = 0; i < _check.length; i++) {
      if (i != index) {
        _check[i] = true;
      } else {
        _check[i] = false;
      }
    }
    notifyListeners();
  }

  // create-group-customer
  Future<String> createGroupCustomer(String? name, String? reducePer, String? note) async {
    ApiResponse resGroupCustomer = await ApiRequest.creatGroupCustomer(name, reducePer, note);
    if (resGroupCustomer.result == true) {
      notifyListeners();
      return "success";
    } else {
      notifyListeners();
      return resGroupCustomer.message ?? "Lỗi";
    }
  }

  // delete-group-customer
  Future<String> deleteGroupCustomer(String? id) async {
    ApiResponse resGroupCustomer = await ApiRequest.deleteGroupCustomer(id);
    if (resGroupCustomer.result == true) {
      notifyListeners();
      return "success";
    } else {
      notifyListeners();
      return resGroupCustomer.message ?? "Lỗi";
    }
  }

  // edit-group-customer
  Future<String> editGroupCustomer(
    BuildContext context,
    int? id,
    String? name,
    int? reducePer,
    String? note,
  ) async {
    ApiResponse resGroupCustomer = await ApiRequest.editGroupCustomer(id, name, reducePer, note);
    if (resGroupCustomer.result == true && context.mounted) {
      AppFunction.showDialogSuccess(
        context,
        content: "Cập nhật thông tin thành công",
      );
      getDataGroupCustomer("", 1, 20);
      notifyListeners();
      return "success";
    } else {
      if (context.mounted) {
        AppFunction.showDialogError(
          context,
          resGroupCustomer.message,
        );
      }
      notifyListeners();
      return resGroupCustomer.message ?? "Lỗi";
    }
  }

  final GroupCustomerModel _groupCustomer = GroupCustomerModel();

  get groupCustomer => _groupCustomer;
  TextEditingController nameGroupCustomerController = TextEditingController();
  TextEditingController reducePerController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GroupCustomerModel? group;

  List<ProvinceModel> get groupCustomerDropdown =>
      _listGroupCustomer.map((e) => ProvinceModel(id: e.id, name: e.name)).toList();

  Future<void> getDetailGroupCustomer(int id) async {
    group = _listGroupCustomer.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
