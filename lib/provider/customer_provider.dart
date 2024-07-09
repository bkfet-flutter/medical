import 'package:flutter/material.dart';
import 'package:mephar_app/model/customer_detail_model.dart';
import 'package:mephar_app/model/customer_model.dart';
import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class CustomerProvider extends ChangeNotifier {
  //customer

  final List<CustomerModel> _listAllCustomer = [];

  List<CustomerModel> get listAllCustomer => _listAllCustomer;

  void clearList() {
    _listAllCustomer.clear();
    listAllCustomer.clear();
    notifyListeners();
  }

  int? total;
  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  bool loading = false;

  loadingStatus(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<String> getDataCustomer(String? search, int limit, int page) async {
    loadingStatus(true);
    _listAllCustomer.clear();
    listAllCustomer.clear();
    ApiResponse response = await ApiRequest.getCustomer(
      search: search,
      limit: limit,
      page: page,
    );
    if (response.result == true) {
      for (var e in response.data['items']) {
        _listAllCustomer.add(CustomerModel.fromJson(e));
        total = response.data['totalItem'];
      }
      loadingStatus(false);
      return "success";
    } else {
      loadingStatus(false);
      return response.message ?? "Lỗi";
    }
  }

  Future<void> refreshCustomerList(BuildContext context) async {
    _listAllCustomer.clear();
    listAllCustomer.clear();
    notifyListeners();
    await getDataCustomer("", 5, 1);
  }

//getCustomer
  CustomerDetailModel customerDetail = CustomerDetailModel();

  Future<void> getCustomer(BuildContext context, int id) async {
    AppFunction.showLoading(context);
    ApiResponse res = await ApiRequest.customerDetail(id);
    if (res.result == true && context.mounted) {
      AppFunction.hideLoading(context);
      CustomerDetailModel detail = CustomerDetailModel.fromJson(res.data);
      customerDetail = detail;
    } else if (context.mounted) {
      AppFunction.hideLoading(context);
      AppFunction.showDialogError(
        context,
        res.message,
      );
    }

    notifyListeners();
  }

  Future<void> editCustomer(
      BuildContext context,
      int id,
      String codeCustommer,
      String nameCustomer,
      String phoneCustomer,
      int groupIdCustomer,
      String emailCustomer,
      int typeCustomer,
      String birthDayCustomer,
      String genderCustomer,
      String addressCustomer,
      String statusCustomer,
      int avatarId,
      int wardId,
      int districtId,
      int provinceId,
      String note,
      String taxCode) async {
    ApiResponse res = await ApiRequest.editCustomer(
      id,
      nameCustomer,
      phoneCustomer,
      birthDayCustomer,
      genderCustomer,
      typeCustomer,
      emailCustomer,
      statusCustomer,
      avatarId,
      wardId,
      districtId,
      provinceId,
      addressCustomer,
      taxCode,
      groupIdCustomer,
      note,
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

  CustomerModel? customer;
  ImageModel? avatar;

  Future<void> getDetailCustomer(int id) async {
    clearCustomer();
    customer = _listAllCustomer.firstWhere((data) => data.id == id);

    notifyListeners();
  }

  void clearCustomer() {
    customer = null;
    notifyListeners();
  }
}
