import 'package:flutter/material.dart';
import 'package:mephar_app/model/config/permission_model.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _listStaff = [];

  List<UserModel> get listStaff => _listStaff;

  //profile staff
  UserModel staffDetails = UserModel();

  Future<void> getStaffDetails(BuildContext context, int? id) async {
    if (id != null) {
      ApiResponse res = await ApiRequest.userDetails(id);
      if (res.result == true) {
        UserModel data = UserModel.fromJson(res.data);
        staffDetails = data;
        notifyListeners();
      } else {
        if (context.mounted) {
          AppFunction.showDialogError(context, res.message);
        }
      }
      notifyListeners();
    }
  }

  Future<void> updateProfile(
    BuildContext context,
    String fullName,
    String email,
    String birthDay,
    int avatarId,
    String gender,
  ) async {
    AppFunction.hideKeyboard(context);
    if (isNullOrEmpty(fullName)) {
      return AppFunction.showDialogError(
          context, "Vui lòng điền đẩy đủ tên người dùng");
    }
    if (isNullOrEmpty(email)) {
      return AppFunction.showDialogError(context, "Vui lòng điền đầy đủ email");
    } else {
      AppFunction.showLoading(context);
      ApiResponse res = await ApiRequest.updateUser(
        fullname: fullName,
        email: email,
        avatarId: avatarId,
        gender: gender,
        birthDay: birthDay,
      );
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          getUser(context);
          AppFunction.showDialogSuccess(context,
              content: 'Cập nhật thành công');
        }
        notifyListeners();
      } else {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          AppFunction.showDialogError(context, res.message);
        }
        notifyListeners();
      }
    }
  }

  //profile account
  UserModel userModel = UserModel();

  final List<Permissions> _userPermission = [];

  List<Permissions> get userPermission => _userPermission;

  Future<bool> getUser(BuildContext context) async {
    _userPermission.clear();
    ApiResponse res = await ApiRequest.getUserProfile();
    if (res.result == true) {
      UserModel data = UserModel.fromJson(res.data);
      userModel = data;
      for (var e in res.data['role']['permissions']) {
        _userPermission.add(Permissions.fromJson(e));
      }
      notifyListeners();
      return true;
    } else {
      if (context.mounted) {
        AppFunction.showDialogError(context, res.message);
      }
      return false;
    }
  }

  bool isNullOrEmpty(dynamic value) {
    return value == null || value == "";
  }

  Future<void> fetchStaffs(BuildContext context) async {
    loadingStatus(true);
    var res = await ApiRequest.users();
    if (res.result == true) {
      final List<UserModel> items = [];
      for (var e in res.data['items']) {
        items.add(UserModel.fromJson(e));
      }
      _listStaff = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  Future<bool> deleteStaff(BuildContext context, int? id) async {
    if (id != null) {
      var res = await ApiRequest.userDelete(id);
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.showDialogSuccess(context,
              content: "Xoá nhân viên thành công");
        }
        return true;
      } else {
        if (context.mounted) AppFunction.showDialogError(context, res.message);
        return false;
      }
    }
    return false;
  }

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<void> updateUser(
    BuildContext context,
    String fullName,
    String email,
    String birthDay,
    int avatarId,
    String gender,
  ) async {
    AppFunction.hideKeyboard(context);
    if (isNullOrEmpty(fullName)) {
      return AppFunction.showDialogError(
          context, "Vui lòng điền đẩy đủ tên người dùng");
    }
    if (isNullOrEmpty(email)) {
      return AppFunction.showDialogError(context, "Vui lòng điền đầy đủ email");
    } else {
      AppFunction.showLoading(context);
      ApiResponse res = await ApiRequest.updateUser(
        fullname: fullName,
        email: email,
        avatarId: avatarId,
        gender: gender,
        birthDay: birthDay,
      );
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          getUser(context);
          AppFunction.showDialogSuccess(context,
              content: 'Cập nhật thành công');
        }
        notifyListeners();
      } else {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          AppFunction.showDialogError(context, res.message);
        }
        notifyListeners();
      }
    }
  }

  Future<void> editStaff(BuildContext context,
      {required UserModel userModel,
      required String? password,
      required String? checkPass,
      required String? address}) async {
    if (userModel.id != null) {
      final check = validateUser(
          userModel: userModel, password: password, checkPass: checkPass);
      if (check == true) {
        var res = await ApiRequest.staffEdit(
            userModel: userModel, password: password!, address: address);
        if (res.result == true) {
          if (context.mounted) Navigator.pop(context, true);
          notifyListeners();
        } else {
          if (context.mounted)
            AppFunction.showDialogError(context, res.message);
        }
      } else {
        showError(context);
      }
    }
  }

  String errorText = "";

  setError(String error) {
    errorText = error;
    notifyListeners();
  } //get-all-user

  validateUser(
      {required String? password,
      required String? checkPass,
      required UserModel userModel}) {
    String error = "là trường bắt buộc";
    if (AppFunction.isNullOrEmpty(userModel.fullName)) {
      return setError("Tên nhân viên $error");
    }
    if (AppFunction.isNullOrEmpty(userModel.username))
      return setError("Tên đăng nhập $error");
    if (AppFunction.isNullOrEmpty(userModel.phone))
      return setError("Số điện thoại $error");
    if (AppFunction.isNullOrEmpty(userModel.branch?.id))
      return setError("Chi nhánh $error");
    if (AppFunction.isNullOrEmpty(userModel.roleId))
      return setError("Vai trò $error");
    if (AppFunction.isNullOrEmpty(password)) return setError("Mật khẩu $error");
    if (AppFunction.isNullOrEmpty(checkPass)) {
      return setError("Nhập lại mật khẩu $error");
    } else if (checkPass!.length < 6 || password!.length < 6) {
      return setError("Độ dài tối thiểu của mật khẩu là 6");
    }
    if (checkPass != password) return setError("Mật khẩu không trùng khớp");
    return true;
  }

  void showError(BuildContext context) {
    AppFunction.showDialogError(context, errorText);
  }

  Future<void> createStaff(BuildContext context,
      {required UserModel userModel,
      required String? password,
      required String? checkPass,
      required String? address}) async {
    final check = validateUser(
        userModel: userModel, password: password, checkPass: checkPass);
    if (check == true) {
      var res = await ApiRequest.userCreate(
          userModel: userModel, password: password!, address: address);
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

// changeLogo() async {
//   var logo = await AppFunction.pickImage();
//   if (logo != null) {
//     userModel.avatar = Avatar(id: logo.id, path: logo.path);
//   }
//   notifyListeners();
// }

  List<ProvinceModel> get userDropDown => _listStaff
      .map((e) => ProvinceModel(
            id: e.id,
            name: e.username,
          ))
      .toList();
}
