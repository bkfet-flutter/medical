import 'package:flutter/material.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/model/config/store_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class StoreProvider extends ChangeNotifier {
  //get - store
  StoreModel storeModel = StoreModel();

  changeLogo() async {
    var logo = await AppFunction.pickImage();
    if (logo != null) {
      storeModel.logo = ImageModel(id: logo.id, path: logo.path);
    }
    notifyListeners();
  }

  Future<void> getStore(BuildContext context) async {
    ApiResponse res = await ApiRequest.store();
    if (res.result == true) {
      StoreModel data = StoreModel.fromJson(res.data["items"][0]);
      storeModel = data;
      notifyListeners();
    } else {
      if (context.mounted) {
        AppFunction.showDialogError(context, res.message);
      }
    }
    notifyListeners();
  }

  bool isNullOrEmpty(dynamic value) {
    return value == null || value == "";
  }

  //edit-store

  Future<void> updateStore(BuildContext context, {required StoreModel data}) async {
    AppFunction.hideKeyboard(context);
    if (isNullOrEmpty(data.name)) {
      return AppFunction.showDialogError(context, "Tên cửa hàng là trường bắt buộc");
    }
    if (isNullOrEmpty(data.email)) {
      return AppFunction.showDialogError(context, "Email là trường bắt buộc");
    }
    if (isNullOrEmpty(data.phone)) {
      return AppFunction.showDialogError(context, "Số điện thoại là trường bắt buộc");
    }
    if (isNullOrEmpty(data.businessRegistrationNumber)) {
      return AppFunction.showDialogError(context, "Số đăng ký kinh doanh là trường bắt buộc");
    }
    if (isNullOrEmpty(data.provinceId)) {
      return AppFunction.showDialogError(context, "Tỉnh/Thành phố là trường bắt buộc");
    }
    if (isNullOrEmpty(data.districtId)) {
      return AppFunction.showDialogError(context, "Quận/Huyện là trường bắt buộc");
    }
    if (isNullOrEmpty(data.wardId)) {
      return AppFunction.showDialogError(context, "Xã/Phường là trường bắt buộc");
    }
    if (isNullOrEmpty(data.address)) {
      return AppFunction.showDialogError(context, "Địa chỉ là trường bắt buộc");
    } else {
      AppFunction.showLoading(context);
      ApiResponse res = await ApiRequest.updateStore(
          id: storeModel.id!,
          name: data.name ?? "",
          email: data.email ?? "",
          phone: data.phone ?? "",
          businessRegistrationNumber: data.businessRegistrationNumber ?? "",
          provinceId: data.provinceId,
          districtId: data.districtId,
          wardId: data.wardId,
          address: data.address,
          businessRegistrationImageId: storeModel.businessRegistrationImage?.id,
          logoId: storeModel.logo?.id);
      if (res.result == true) {
        if (context.mounted) {
          AppFunction.hideLoading(context);
          getStore(context);
          AppFunction.showDialogSuccess(context, content: "Cập nhật cửa hàng thành công");
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
}
