import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/model/config/permission_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/model/enter_product_model.dart';
import 'package:mephar_app/model/product_move_model.dart';
import 'package:mephar_app/model/product_return.dart';
import 'package:mephar_app/model/product_return_purchase_model.dart';
import 'package:mephar_app/model/promotion_model.dart';
import 'package:mephar_app/model/return_product_model.dart';
import 'package:mephar_app/model/search_customer_model.dart';
import 'package:mephar_app/model/search_product_model.dart';
import 'package:mephar_app/model/search_supplier_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mephar_app/model/sell_products_model.dart';
import 'package:mephar_app/model/supplier_model.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:provider/provider.dart';

import 'api_base/api_client.dart';
import 'api_base/api_response.dart';

class ApiRequest {
  static const String domain = "http://157.10.44.228:8000";

  static String query(int? limit, int? page, String? keyword) =>
      "limit=${limit ?? 20}&page=${page ?? 1}&keyword=${keyword ?? ""}";

  //login
  static Future<ApiResponse> userLogin(String passWord, String userName) async {
    Map data = {
      "username": userName,
      "password": passWord,
    };
    return await ApiClient().request(
        url: "$domain/mp/api/auth/login",
        data: json.encode(data),
        method: ApiClient.POST);
  }

  // register store
  static Future<ApiResponse> storeRegister(
    String name,
    String phone,
    String email,
    int warId,
    int districtId,
    int provinceId,
    String address,
    int businessRegistrationImageId,
    String businessRegistrationNumber,
  ) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "wardId": warId,
      "districtId": districtId,
      "provinceId": provinceId,
      "businessRegistrationNumber": businessRegistrationNumber,
      "businessRegistrationImageId": businessRegistrationImageId,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/store",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  // register user
  static Future<ApiResponse> userRegister(
    String username,
    String fullname,
    String password,
    String email,
    String phone,
    int storeId,
  ) async {
    Map data = {
      "username": username,
      "fullName": fullname,
      "password": password,
      "email": email,
      "phone": phone,
      "storeId": storeId,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/auth/register",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //new
  //config
  //Thông tin cửa hàng
  static Future<ApiResponse> store() async {
    return await ApiClient()
        .request(url: "$domain/mp/api/store", method: ApiClient.GET);
  }

// GetDosage
  static Future<ApiResponse> getDosage({int? page, int? limit}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/dosage?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  //GetPosition
  static Future<ApiResponse> getPosition({int? page, int? limit}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/position?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  //GetGroupProduct
  static Future<ApiResponse> getGroupProduct({int? page, int? limit}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/group-product?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  //GetManufacture

  static Future<ApiResponse> getManufacture(
      {int? page, int? limit, String? keyword = ""}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/manufacture?page=$page&limit=$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getDebt(
      {int? id, int? page, int? limit, int? branchId}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/customer/$id/total-debt?page=$page&limit=$limit&customerId=$id&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getWareHouse(
      {int? productId, int? page, int? limit, int? branchId}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/warehouse/card?productId=$productId&page=$page&limit=$limit&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getInventory({int? id}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/product/$id/inventory",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getOrderPage({
    int? branchId,
  }) async {
    DateTime now = DateTime.now();
    String dateNow = DateFormat('yyyy-MM-dd').format(now);
    Map dateRange = {"startDate": dateNow, "endDate": dateNow};
    String data = jsonEncode(dateRange);
    return await ApiClient().request(
      url:
          "$domain/mp/api/order?page=1&limit=20&keyword=&dateRange=$data&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getBatch({
    int? productId,
    int? page,
    int? limit,
    int? branchId,
  }) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/batch?productId=$productId&page=$page&limit=$limit&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

//GetCountryProduce

  static Future<ApiResponse> getCountryProduce(
      {int? page, int? limit, String? keyword = ""}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/country-produce?page=$page&limit=$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  //getSpecialist
  static Future<ApiResponse> getSpecialist(
      {int? page, int? limit, String? keyword = ""}) async {
    page ??= 1;
    limit ??= 20;
    return await ApiClient().request(
      url: "$domain/mp/api/specialist?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  //getLevelDoctor
  static Future<ApiResponse> getLevelDoctor(
      {int? page, int? limit, String? keyword = ""}) async {
    page ??= 1;
    limit ??= 20;
    return await ApiClient().request(
      url: "$domain/mp/api/level?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getMoveById(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/move/$id",
      method: ApiClient.GET,
    );
  }

  //getWork-palce
  static Future<ApiResponse> getWorkPlaceDoctor(
      {int? page, int? limit, String? keyword = ""}) async {
    page ??= 1;
    limit ??= 20;
    return await ApiClient().request(
      url: "$domain/mp/api/work-place?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  //getCustomerId
  static Future<ApiResponse> getCustomerId(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/customer/$id",
      method: ApiClient.GET,
    );
  }

  //add new level
  static Future<ApiResponse> addNewLevel({String? name}) async {
    Map data = {"name": name};
    return await ApiClient().request(
      url: "$domain/mp/api/level",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //add new specialist

  static Future<ApiResponse> addNewSpecialist({String? name}) async {
    Map data = {"name": name};
    return await ApiClient().request(
      url: "$domain/mp/api/specialist",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //add new work_place
  static Future<ApiResponse> addNewWorkPlace({String? name}) async {
    Map data = {"name": name};
    return await ApiClient().request(
      url: "$domain/mp/api/work-place",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> updateStore({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String businessRegistrationNumber,
    required int? provinceId,
    required int? districtId,
    required int? wardId,
    required String? address,
    required int? logoId,
    required int? businessRegistrationImageId,
  }) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "businessRegistrationNumber": businessRegistrationNumber,
      "businessRegistrationImageId": businessRegistrationImageId,
      "provinceId": provinceId,
      "districtId": districtId,
      "wardId": wardId,
      "address": address,
      "logoId": logoId
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/store/$id",
      method: ApiClient.PATCH,
    );
  }

  static Future<ApiResponse> editCustomer(
    int? id,
    String? fullname,
    String? phone,
    String? birthday,
    String? gender,
    int? type,
    String? email,
    String? status,
    int? avatarId,
    int? wardId,
    int? districtId,
    int? provinceId,
    String? address,
    String? taxCode,
    // String facebook,
    int? groupCustomerId,
    String? note,
  ) async {
    Map data = {
      "fullName": fullname,
      "phone": phone,
      "birthday": birthday,
      "gender": gender,
      "type": type,
      "email": email,
      "avatarId": avatarId,
      "wardId": wardId,
      "status": status,
      "districtId": districtId,
      "provinceId": provinceId,
      "address": address,
      "taxCode": taxCode,
      "facebook": "facebook",
      "groupCustomerId": groupCustomerId,
      "note": note,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/customer/$id",
      method: ApiClient.PUT,
    );
  }

// chi tiết user
  static Future<ApiResponse> customerDetail(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/customer/$id",
      method: ApiClient.GET,
    );
  }

  //danh sách nhân viên
  static Future<ApiResponse> users({String? keyword = ""}) async {
    return await ApiClient().request(
        url: "$domain/mp/api/user?keyword=$keyword", method: ApiClient.GET);
  }

  //thêm mới nhân viên
  static Future<ApiResponse> userCreate({
    required UserModel userModel,
    required String password,
    String? address,
  }) async {
    Map data = {
      "username": userModel.username,
      "fullName": userModel.fullName,
      "email": userModel.email,
      "phone": userModel.phone,
      "password": password,
      "birthday": userModel.birthday,
      "branchId": userModel.branch?.id,
      "position": userModel.position,
      "roleId": userModel.roleId,
      "address": address
    };
    return await ApiClient().request(
        url: "$domain/mp/api/user",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  //chi tiết nhân viên
  static Future<ApiResponse> userDetails(int id) async {
    return await ApiClient()
        .request(url: "$domain/mp/api/user/$id", method: ApiClient.GET);
  }

  //chinh sua nhân viên
  static Future<ApiResponse> staffEdit({
    required UserModel userModel,
    required String password,
    String? address,
  }) async {
    Map data = {
      "username": userModel.username,
      "fullName": userModel.fullName,
      "email": userModel.email,
      "phone": userModel.phone,
      "password": password,
      "birthday": userModel.birthday,
      "branchId": userModel.branch?.id,
      "position": userModel.position,
      "roleId": userModel.roleId,
      "address": address
    };
    return await ApiClient().request(
        url: "$domain/mp/api/user/${userModel.id}",
        method: ApiClient.PATCH,
        data: json.encode(data));
  }

  //xoa nhan vien
  static Future<ApiResponse> userDelete(int id) async {
    return await ApiClient()
        .request(url: "$domain/mp/api/user/$id", method: ApiClient.DELETE);
  }

  //danh sách chi nhánh
  static Future<ApiResponse> branches() async {
    return await ApiClient()
        .request(url: "$domain/mp/api/branch", method: ApiClient.GET);
  }

  //chi tiết chi nhánh
  static Future<ApiResponse> branchDetails(int id) async {
    return await ApiClient()
        .request(url: "$domain/mp/api/branch/$id", method: ApiClient.GET);
  }

  //thêm mới chi nhánh
  static Future<ApiResponse> branchCreate(BranchModel branchModel) async {
    Map data = {
      "name": branchModel.name,
      "phone": branchModel.phone,
      "code": branchModel.code,
      "zipCode": branchModel.zipCode,
      "wardId": branchModel.wardId,
      "districtId": branchModel.districtId,
      "provinceId": branchModel.provinceId,
      "address1": branchModel.address1,
      "address2": branchModel.address2,
      "isDefaultBranch": branchModel.isDefaultBranch
    };
    return await ApiClient().request(
        url: "$domain/mp/api/branch",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  //chỉnh sửa chi nhánh
  static Future<ApiResponse> branchEdit(BranchModel branchModel, int id) async {
    Map data = {
      "name": branchModel.name,
      "phone": branchModel.phone,
      "code": branchModel.code,
      "zipCode": branchModel.zipCode,
      "wardId": branchModel.wardId,
      "districtId": branchModel.districtId,
      "provinceId": branchModel.provinceId,
      "address1": branchModel.address1,
      "address2": branchModel.address2,
      "isDefaultBranch": branchModel.isDefaultBranch
    };
    return await ApiClient().request(
        url: "$domain/mp/api/branch/$id",
        method: ApiClient.PATCH,
        data: json.encode(data));
  }

  //xoa chi nhánh
  static Future<ApiResponse> branchDelete(int id) async {
    return await ApiClient()
        .request(url: "$domain/mp/api/branch/$id", method: ApiClient.DELETE);
  }

  static Future<ApiResponse> updateUser({
    required String fullname,
    required String email,
    int? avatarId,
    required birthDay,
    required String? gender,
  }) async {
    Map data = {
      "fullName": fullname,
      "email": email,
      "avatarId": avatarId,
      "birthDay": birthDay,
      "gender": gender,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/auth/profile",
      method: ApiClient.POST,
    );
  }

  //nhập sản phẩm
  static Future<ApiResponse> inbound(
      EnterProductModel enterProductModel) async {
    Map data = enterProductModel.toJson();
    return await ApiClient().request(
        url: "$domain/mp/api/inbound",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  static Future<ApiResponse> getSupplier(
    String? search,
    int? limit,
    int? page,
  ) async {
    return await ApiClient().request(
      url: "$domain/mp/api/supplier?page=$page&limit=$limit&keyword=$search",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getListSample({
    String? search,
    int? limit = 10,
    int? page = 1,
    int? branchId,
  }) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/sample-prescription?page=$page&limit=$limit&keyword=$search&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

// thêm mới đơn thuốc mẫu
  static Future<ApiResponse> addNewSampleMedicine(
      {int? branchId,
      String? description,
      int? imageId,
      List<Map<String, dynamic>>? ingredientProducts,
      String? name,
      int? positionId,
      int? status,
      String? weight}) async {
    Map data = {
      "branchId": branchId,
      "description": description,
      "imageId": imageId,
      "ingredientProducts": ingredientProducts,
      "name": name,
      "positionId": positionId,
      "status": status,
      "weight": weight,
    };
    return await ApiClient().request(
        url: "$domain/mp/api/sample-prescription",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  //thêm mới lô
  static Future<ApiResponse> batchCreate({
    required int branchId,
    required int productId,
    required int quantity,
    required String name,
    required String expiryDate,
  }) async {
    Map data = {
      "branchId": branchId,
      "productId": productId,
      "name": name,
      "expiryDate": expiryDate,
      "quantity": quantity
    };
    return await ApiClient().request(
        url: "$domain/mp/api/batch",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  static Future<ApiResponse> createMove({
    int? fromBranchId,
    int? movedBy,
    int? toBranchId,
    List<ProductMoveModel>? products,
    int? totalItem,
  }) async {
    Map data = {
      "fromBranchId": fromBranchId,
      "movedBy": movedBy,
      "toBranchId": toBranchId,
      "products": products,
      "totalItem": totalItem,
    };
    return await ApiClient().request(
        url: "$domain/mp/api/move",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  static Future<ApiResponse> createPurchaseReturn({
    int? branchId,
    int? totalPrice,
    int? userId,
    List<ProductReturnPurchaseModel>? products,
    int? debt,
    String? status,
    int? supplierId,
  }) async {
    Map data = {
      "branchId": branchId,
      "totalPrice": totalPrice,
      "userId": userId,
      "products": products,
      "debt": debt,
      "status": status,
      "supplierId": supplierId
    };
    return await ApiClient().request(
        url: "$domain/mp/api/purchase-return",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  static Future<ApiResponse> inboundProducts(BuildContext context,
      {int? page, int? limit, String? keyword}) async {
    page ??= 1;
    limit ??= 20;
    keyword ??= "";
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    return await ApiClient().request(
        url:
            "$domain/mp/api/inbound?limit=$limit&page=$page&keyword=$keyword&branchId=$branchId",
        method: ApiClient.GET);
  }

  static Future<ApiResponse> inboundProductsByFilter(
    BuildContext context, {
    int? page,
    int? limit,
    String? keyword,
    int? userId,
    int? supplierId,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    page ??= 1;
    limit ??= 20;
    keyword ??= "";
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    final queryParams = <String, dynamic>{
      'userId': userId.toString(),
      'supplierId': supplierId.toString(),
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
    }..removeWhere((key, value) => value == null);
    print(queryParams);
    final queryString = Uri(queryParameters: queryParams).query;
    final encodedQuery = Uri.encodeFull(queryString);
    return await ApiClient().request(
        url:
            "$domain/mp/api/inbound?limit=$limit&page=$page&keyword=$keyword$encodedQuery&branchId=$branchId",
        method: ApiClient.GET);
  }

  static Future<ApiResponse> inboundDetails(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/inbound/$id",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> inboundDelete(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/inbound/$id",
      method: ApiClient.DELETE,
    );
  }

  //danh sach lô
  static Future<ApiResponse> batches(BuildContext context,
      {String? keyword, required int productId}) async {
    keyword ??= "";
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    return await ApiClient().request(
      url:
          "$domain/mp/api/batch?keyword=$keyword&productId=$productId&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  //sản phẩm bán chạy
  static Future<ApiResponse> productReport(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate =
        DateTime(currentDate.year, currentDate.month + 1, 0, 23, 59, 59);
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    String formattedStartDate = startDate.toIso8601String();
    String formattedEndDate = endDate.toIso8601String();
    String url =
        "$domain/mp/api/report/product-report?type=revenue&dateRange[startDate]=$formattedStartDate&dateRange[endDate]=$formattedEndDate${branchId != null ? '&branchId=$branchId' : ""}";

    return await ApiClient().request(
      url: url,
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getListPurchaseHistory({
    int? page,
    int? limit,
    int? customerId,
    int? branchId,
  }) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/order?page=$page&limit=$limit&customerId=$customerId&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getListShipping({
    int? page,
    int? limit,
    String? keyword,
    int? branchId,
    String? status,
  }) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/move?page=$page&limit=$limit&keyword=$keyword&status=$status&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getListShippingByFilter({
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
    final queryParams = <String, dynamic>{
      'page': page.toString(),
      'limit': limit.toString(),
      'keyword': keyword,
      'fromBranchId': fromBranchId?.toString(),
      'toBranchId': toBranchId?.toString(),
      'receivedBy': receivedBy?.toString(),
      'status': status,
      'movedAt': movedAt,
      'receivedAt': receivedAt,
      'branchId': branchId?.toString(),
    }..removeWhere((key, value) => value == null);
    final queryString = Uri(queryParameters: queryParams).query;
    final encodedQuery = Uri.encodeFull(queryString);

    return await ApiClient().request(
      url: '$domain/mp/api/move?$encodedQuery',
      method: ApiClient.GET,
    );
  }

  //sản phẩm bán chạy
  static Future<ApiResponse> productReportByDay(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate =
        DateTime(currentDate.year, currentDate.month + 1, 0, 23, 59, 59);
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;
    String formattedStartDate = startDate.toIso8601String();
    String formattedEndDate = endDate.toIso8601String();
    String url =
        "$domain/mp/api/report/revenues-report?type=day&dateRange[startDate]=$formattedStartDate&dateRange[endDate]=$formattedEndDate${branchId != null ? '&branchId=$branchId' : ""}";

    return await ApiClient().request(
      url: url,
      method: ApiClient.GET,
    );
  }

  //tra hang nhap
  static Future<ApiResponse> productReturn(
      {int? page, int? limit, String? keyword, required int branchId}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/purchase-return?${query(limit, page, keyword)}&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> productReturnDetail(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/purchase-return/$id",
      method: ApiClient.GET,
    );
  }

  //tra hang nhap
  static Future<ApiResponse> productReturnDetails({required int id}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/purchase-return/$id",
      method: ApiClient.GET,
    );
  }

  //tra hang nhap
  static Future<ApiResponse> productReturnCreate(
      {required ReturnProductModel returnProductModel}) async {
    Map data = returnProductModel.toJson();
    return await ApiClient().request(
        url: "$domain/mp/api/purchase-return",
        method: ApiClient.POST,
        data: json.encode(data));
  }

  //upload-image
  static Future<ApiResponse> uploadImages({
    required XFile imagePaths,
  }) async {
    MultipartFile imageFiles;
    imageFiles = (await MultipartFile.fromFile(
      imagePaths.path,
      filename: imagePaths.path.split('/').last,
      contentType: MediaType('image', 'png'),
    ));
    Map<String, dynamic> data = {"file": imageFiles};
    return await ApiClient().request(
        url: "$domain/mp/api/external/image/upload",
        formData: data,
        method: ApiClient.POST);
  }

  // address
  static Future<ApiResponse> getAddress() async {
    return await ApiClient().request(
      url: "$domain/mp/api/address",
      method: ApiClient.GET,
    );
  }

  //get-ward
  static Future<ApiResponse> getDataWard(int? id1, int? id2) async {
    return await ApiClient().request(
      url: "$domain/mp/api/address/$id1/$id2",
      method: ApiClient.GET,
    );
  }

  //get-district
  static Future<ApiResponse> getDataDistrict(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/address/$id",
      method: ApiClient.GET,
    );
  }

  //danh sách thiết lập giá
  static Future<ApiResponse> priceSettings(
      {int? page, int? limit, String? keyword}) async {
    page ??= 1;
    limit ??= 20;
    keyword ??= "";
    return await ApiClient().request(
        url:
            "$domain/mp/api/product/price/setting?page=$page&limit=$limit&keyword=$keyword",
        method: ApiClient.GET);
  }

  //danh sách thiết lập giá
  static Future<ApiResponse> editPriceSettings(
      {required int id,
      required int type,
      required int value,
      required bool isApplyForAll,
      required int branchId}) async {
    Map data = {
      "type": type,
      "value": value,
      "isApplyForAll": isApplyForAll,
      "branchId": branchId
    };
    return await ApiClient().request(
        url: "$domain/mp/api/product/price/setting/$id",
        method: ApiClient.PATCH,
        data: json.encode(data));
  }

  //danh sách sản phẩm
  static Future<ApiResponse> products(
      {int? page,
      int? limit,
      String? keyword,
      String? type,
      String? status,
      int? branchId}) async {
    page ??= 1;
    limit ??= 5;
    keyword ??= "";
    status ??= "";
    type ??= "";
    return await ApiClient().request(
        url:
            "$domain/mp/api/product?page=$page&limit=$limit&keyword=$keyword&type=$type&status=$status&branchId=$branchId",
        method: ApiClient.GET);
  }

  //danh sách sản phẩm
  static Future<ApiResponse> productsMaster(
      {int? page, int? limit, String? keyword, required int brandId}) async {
    page ??= 1;
    limit ??= 20;
    keyword ??= "";
    return await ApiClient().request(
        url:
            "$domain/mp/api/product/inbound/master?page=$page&limit=$limit&keyword=$keyword&branchId=$brandId",
        method: ApiClient.GET);
  }

  //danh sách sản phẩm bán hàng
  static Future<ApiResponse> productsMasterForSale(
      {int? page, int? limit, String? keyword, required int brandId}) async {
    page ??= 1;
    limit ??= 20;
    keyword ??= "";
    return await ApiClient().request(
        url:
            "$domain/mp/api/product/sale/master?page=$page&limit=$limit&keyword=$keyword&branchId=$brandId&isSale=true",
        method: ApiClient.GET);
  }

  static Future<ApiResponse> addMedicineProduct({
    String? activeElement,
    String? baseUnit = "vien",
    int? imageId,
    int? branchId,
    // String? code,
    String? content,
    int? countryId,
    int? dosageId,
    int? expiryPeriod,
    int? groupProductId,
    bool? isBatchExpireControl,
    int? manufactureId,
    String? name,
    String? packingSpecification,
    int? positionId,
    int? price,
    int? primePrice,
    String? barCode,
    List<Map<String, dynamic>>? productUnits,
    int? exchangeValue,
    bool? isBaseUnit,
    bool? isDirectSale,
    String? point,
    int? priceProductUnits,
    String? unitName,
    String? registerNumber,
    String? shortName,
    int? status = 1,
    int? type = 1,
    String? weight,
  }) async {
    Map data = {
      "activeElement": activeElement,
      "baseUnit": baseUnit,
      "branchId": branchId,
      "groupProductId": groupProductId,
      "content": content,
      "countryId": countryId,
      "dosageId": dosageId,
      "positionId": positionId,
      "expiryPeriod": expiryPeriod,
      "isBatchExpireControl": isBatchExpireControl,
      "manufactureId": manufactureId,
      "name": name,
      "packingSpecification": packingSpecification,
      "price": price,
      "primePrice": primePrice,
      "imageId": imageId,
      "productUnits": productUnits,
      "registerNumber": registerNumber,
      "shortName": shortName,
      "status": status,
      "type": 1,
      "weight": weight,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/product",
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> editMedicineProduct({
    int? id,
    String? activeElement,
    String? baseUnit = "vien",
    int? imageId,
    int? branchId,
    String? code,
    String? content,
    int? countryId,
    int? dosageId,
    int? expiryPeriod,
    int? groupProductId,
    bool? isBatchExpireControl,
    int? manufactureId,
    String? name,
    String? packingSpecification,
    int? positionId,
    int? price,
    int? primePrice,
    String? barCode,
    String? codeProductUnits,
    List<Map<String, dynamic>>? productUnits,
    int? exchangeValue,
    bool? isBaseUnit,
    bool? isDirectSale,
    String? point,
    int? priceProductUnits,
    String? unitName,
    String? registerNumber,
    String? shortName,
    int? status = 1,
    int? type = 1,
    String? weight,
  }) async {
    Map data = {
      "barCode": barCode,
      "code": code,
      "activeElement": activeElement,
      "baseUnit": baseUnit,
      "branchId": branchId,
      "groupProductId": groupProductId,
      "positionId": positionId,
      "content": content,
      "countryId": countryId,
      "dosageId": dosageId,
      "expiryPeriod": expiryPeriod,
      "isBatchExpireControl": isBatchExpireControl,
      "manufactureId": manufactureId,
      "name": name,
      "packingSpecification": packingSpecification,
      "price": price,
      "primePrice": primePrice,
      "imageId": imageId,
      "productUnits": productUnits,
      "registerNumber": registerNumber,
      "shortName": shortName,
      "status": status,
      "type": 1,
      "weight": weight,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/product/$id",
      method: ApiClient.PATCH,
    );
  }

  static Future<ApiResponse> addProduct({
    String? barCode,
    String? baseUnit = "viên",
    int? branchId,
    // String? code,
    int? countryId,
    String? content,
    int? expiryPeriod,
    int? groupProductId,
    int? imageId,
    int? inventory,
    bool? isBatchExpireControl,
    bool? isLoyaltyPoint,
    int? manufactureId,
    String? name,
    String? packingSpecification,
    int? positionId,
    int? price = 0,
    int? primePrice,
    int? exchangeValue = 1,
    bool? isBaseUnit = true,
    bool? isDirectSale = false,
    String? point,
    String? unitName,
    List<Map<String, dynamic>>? productUnits,
    String? codeProductUnits,
    String? shortName,
    int? status = 1,
    int? type = 2,
    String? weight,
  }) async {
    Map data = {
      "barCode": barCode,
      "baseUnit": baseUnit,
      "branchId": branchId,
      // "code": code,
      "countryId": countryId,
      "expiryPeriod": expiryPeriod,
      "groupProductId": groupProductId,
      "imageId": imageId,
      "inventory": inventory,
      "isBatchExpireControl": isBatchExpireControl,
      "isLoyaltyPoint": isLoyaltyPoint,
      "manufactureId": manufactureId,
      "name": name,
      "packingSpecification": packingSpecification,
      "positionId": positionId,
      "price": price,
      "primePrice": primePrice,
      "productUnits": productUnits,
      "shortName": shortName,
      "status": status,
      "type": 2,
      "weight": weight
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/product",
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> editProduct({
    int? id,
    String? barCode,
    String? baseUnit = "viên",
    int? branchId,
    String? code,
    int? countryId,
    String? content,
    int? expiryPeriod,
    int? groupProductId,
    int? imageId,
    int? inventory = 180,
    bool? isBatchExpireControl,
    bool? isLoyaltyPoint,
    int? manufactureId,
    String? name,
    String? packingSpecification,
    int? positionId,
    int? price = 0,
    int? primePrice = 10,
    int? exchangeValue = 1,
    bool? isBaseUnit = true,
    bool? isDirectSale = false,
    String? point,
    String? unitName,
    List<Map<String, dynamic>>? productUnits,
    String? codeProductUnits,
    String? shortName,
    int? status = 1,
    int? type = 2,
    String? weight,
  }) async {
    Map data = {
      "barCode": barCode,
      "baseUnit": baseUnit,
      "branchId": branchId,
      "code": barCode,
      "countryId": countryId,
      "expiryPeriod": expiryPeriod,
      "groupProductId": groupProductId,
      "imageId": imageId,
      "inventory": inventory,
      "isBatchExpireControl": isBatchExpireControl,
      "isLoyaltyPoint": isLoyaltyPoint,
      "manufactureId": manufactureId,
      "name": name,
      "packingSpecification": packingSpecification,
      "positionId": positionId,
      "price": price,
      "primePrice": primePrice,
      "productUnits": productUnits,
      "shortName": shortName,
      "status": status,
      "type": 2,
      "weight": weight
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/product/$id",
      method: ApiClient.PATCH,
    );
  }

  //old
  //bar-chart

  //add new group product
  static Future<ApiResponse> addNewGroupProduct({String? name}) async {
    Map data = {
      "name": name,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/group-product",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  // add new dosage
  static Future<ApiResponse> addNewDosage({String? name}) async {
    Map data = {
      "name": name,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/dosage",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  // add new manufacture
  static Future<ApiResponse> addNewManufacture({String? name}) async {
    Map data = {
      "name": name,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/manufacture",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  // add new position
  static Future<ApiResponse> addNewPosition({String? name}) async {
    Map data = {
      "name": name,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/position",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //medicine
  static Future<ApiResponse> getMedicine({
    String? search,
    int? limit,
    int? page,
  }) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/medication-category/?page=$page&limit=$limit&keyword=$search",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getMedicineByCode({String? code}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/medication-category/code/$code",
      method: ApiClient.GET,
    );
  }

  //customer
  static Future<ApiResponse> getCustomer({
    String? search,
    int? limit,
    int? page,
  }) async {
    return await ApiClient().request(
      url: "$domain/mp/api/customer?page=$page&limit=$limit&keyword=$search",
      method: ApiClient.GET,
    );
  }

  //detail-customer
  static Future<ApiResponse> getDetailCustomer(String? id) async {
    return await ApiClient().request(
      url: "$domain/product/customer/$id",
      method: ApiClient.GET,
    );
  }

  //creat-customer
  static Future<ApiResponse> creatNewCustomer(
    String? fullname,
    String? phone,
    String? birthday,
    String? gender,
    int? type,
    String? email,
    String? status,
    int? avatarId,
    int? wardId,
    int? districtId,
    int? provinceId,
    String? address,
    String? taxCode,
    // String facebook,
    int? groupCustomerId,
    String? note,
  ) async {
    Map data = {
      "fullName": fullname,
      "phone": phone,
      "birthday": birthday,
      "gender": gender,
      "type": type,
      "email": email,
      "avatarId": avatarId,
      "wardId": wardId,
      "districtId": districtId,
      "provinceId": provinceId,
      "address": address,
      "taxCode": taxCode,
      "facebook": "facebook",
      "groupCustomerId": 1,
      "note": note,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/customer",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //create Doctor
  static Future<ApiResponse> creatNewDoctor({
    String? address,
    String? code,
    int? districtId,
    String? email,
    String? gender,
    int? levelId,
    String? name,
    String? note,
    String? phone,
    int? provinceId,
    int? specialistId,
    int? status,
    int? wardId,
    int? workPlaceId,
  }) async {
    Map data = {
      "address": address,
      "code": code,
      "districtId": districtId,
      "email": email,
      "gender": gender,
      "levelId": levelId,
      "name": name,
      "note": note,
      "phone": phone,
      "provinceId": provinceId,
      "specialistId": specialistId,
      "status": status,
      "wardId": wardId,
      "workPlaceId": workPlaceId
    };
    return await ApiClient().request(
      url: "$domain/mp/api/doctor",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> editDoctor({
    int? id,
    String? address,
    String? code,
    int? districtId,
    String? email,
    String? gender,
    int? levelId,
    String? name,
    String? note,
    String? phone,
    int? provinceId,
    int? specialistId,
    int? status,
    int? wardId,
    int? workPlaceId,
  }) async {
    Map data = {
      "address": address,
      "code": code,
      "districtId": districtId,
      "email": email,
      "gender": gender,
      "levelId": levelId,
      "name": name,
      "note": note,
      "phone": phone,
      "provinceId": provinceId,
      "specialistId": specialistId,
      "status": status,
      "wardId": wardId,
      "workPlaceId": workPlaceId
    };
    return await ApiClient().request(
      url: "$domain/mp/api/doctor/$id",
      data: json.encode(data),
      method: ApiClient.PATCH,
    );
  }

  //get- group-customer
  static Future<ApiResponse> getGroupCustomer(
    String? keyword,
    int? page,
    int? limit,
  ) async {
    return await ApiClient().request(
      url: keyword == null
          ? "$domain/mp/api/group-customer?page=$page&limit=$limit&keyword="
          : "$domain/mp/api/group-customer?page=$page&limit=$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  //create-group-customer
  static Future<ApiResponse> creatGroupCustomer(
    String? name,
    String? reducePer,
    String? note,
  ) async {
    Map data = {
      "name": name,
      "discount": reducePer,
      "description": note,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/group-customer",
      method: ApiClient.POST,
    );
  }

  //delete-group-customer
  static Future<ApiResponse> deleteGroupCustomer(String? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/group-customer/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> getDataProductById(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/product/$id",
      method: ApiClient.GET,
    );
  }

  //edit-group-customer
  static Future<ApiResponse> editGroupCustomer(
    int? id,
    String? name,
    int? reducePer,
    String? note,
  ) async {
    Map data = {
      "name": name,
      "description": note,
      "discount": reducePer,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/group-customer/$id",
      method: ApiClient.PATCH,
    );
  }

  //oder
  static Future<ApiResponse> getOrder(
    String? search,
    int? limit,
    int? page,
    int? branchId,
  ) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/order?page=$page&limit=$limit&keyword=$search&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  //oder
  static Future<ApiResponse> sellDirect({required SellModel sellModel}) async {
    Map data = sellModel.toJson();
    return await ApiClient().request(
      url: "$domain/mp/api/order",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //setting
  static Future<ApiResponse> getSetting() async {
    return await ApiClient().request(
      url: "$domain/mp/api/configuration",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> editSupplierGroup(
    int? id,
    String? nameGroupCustomer,
    int? branchId,
    String? detail,
  ) async {
    Map data = {
      "name": nameGroupCustomer,
      "branchId": branchId,
      "description": detail,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/group-supplier/$id",
      data: json.encode(data),
      method: ApiClient.PATCH,
    );
  }

  static Future<ApiResponse> getListPayCustomer(
    String? keyword,
    int? page,
    int? limit,
    String? status,
    int? branchId,
  ) async {
    return await ApiClient().request(
      url: keyword == null
          ? "$domain/mp/api/order?page=$page&limit=$limit&keyword=&status=$status&branchId=$branchId"
          : "$domain/mp/api/order?page=$page&limit=$limit&keyword=$keyword&status=$status&branchId=$branchId",
      method: ApiClient.GET,
    );
  }

  //get-detail-group-customer
  static Future<ApiResponse> getDetailGroupCustomer(String? id) async {
    return await ApiClient().request(
      url: "$domain/sale/group-customer/$id",
      method: ApiClient.GET,
    );
  }

//oder

  //group-supplier
  static Future<ApiResponse> getGroupSupplier(
    String? search,
    int? limit,
    int? page,
  ) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/group-supplier?page=$page&limit=$limit&keyword=$search",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> addSupplierGroup(
    String? nameGroupSupplier,
    int? branchId,
    String? detail,
  ) async {
    Map data = {
      "name": nameGroupSupplier,
      "branchId": branchId,
      "description": detail,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/group-supplier",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> addSupplier(
    String? address,
    int? branchId,
    String? code,
    String companyName,
    int? districId,
    String? email,
    int? groupSupplierId,
    String? name,
    String? note,
    String? phone,
    int? provinceId,
    String? taxCode,
    int? wardId,
  ) async {
    Map data = {
      "address": address,
      "branchId": branchId,
      "code": code,
      "companyName": companyName,
      "districtId": districId,
      "email": email,
      "groupSupplierId": groupSupplierId,
      "name": name,
      "note": note,
      "phone": phone,
      "provinceId": provinceId,
      "taxCode": taxCode,
      "wardId": wardId,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/supplier",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

//editSupplier
  static Future<ApiResponse> editSupplier(
    int? id,
    String? address,
    int? branchId,
    String? code,
    String companyName,
    int? districId,
    String? email,
    int? groupSupplierId,
    String? name,
    String? note,
    String? phone,
    int? provinceId,
    String? taxCode,
    int? wardId,
  ) async {
    Map data = {
      "address": address,
      "branchId": branchId,
      "code": code,
      "companyName": companyName,
      "districtId": districId,
      "email": email,
      "groupSupplierId": groupSupplierId,
      "name": name,
      "note": note,
      "phone": phone,
      "provinceId": provinceId,
      "taxCode": taxCode,
      "wardId": wardId,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/supplier/$id",
      data: json.encode(data),
      method: ApiClient.PATCH,
    );
  }

  //delete product
  static Future<ApiResponse> deleteProductById(int? id) async {
    return ApiClient().request(
      url: "$domain/mp/api/product/$id",
      method: ApiClient.DELETE,
    );
  }

  //get user profile
  static Future<ApiResponse> getUserProfile() async {
    return ApiClient().request(
      url: "$domain/mp/api/auth/profile",
      method: ApiClient.GET,
    );
  }

  //get dailyreport
  static Future<ApiResponse> getDailyReport() async {
    return ApiClient()
        .request(url: "$domain/sale/report/daily", method: ApiClient.GET);
  }

  //get list sold product
  static Future<ApiResponse> getListSoldProduct() async {
    return ApiClient().request(
      url: "$domain/sale/report/sold-product?filterType=month",
      method: ApiClient.GET,
    );
  }

  //get this week revenue
  static Future<ApiResponse> getThisWeekRevenue() async {
    return ApiClient().request(
      url:
          "$domain/sale/report/revenue-by-day?filterTime=thisMonth&filterType=dayOfWeek",
      method: ApiClient.GET,
    );
  }

  //get-all-user
  static Future<ApiResponse> getDataAllUser() async {
    return await ApiClient().request(
      url: "$domain/user",
      method: ApiClient.GET,
    );
  }

  //create-user
  static Future<ApiResponse> creatNewUser(
    String? userName,
    String? email,
    String? mobile,
    String? fullName,
    String? birthDay,
    String? roleId,
    String? listBranch,
    String? password,
    String? matchingPassword,
    String? address,
  ) async {
    Map data = {
      "userName": userName,
      "email": email,
      "mobile": mobile,
      "fullName": fullName,
      "birthDay": birthDay,
      "roleId": roleId,
      "listBranch": listBranch,
      "password": password,
      "matchingPassword": matchingPassword,
      "address": address,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/user",
      method: ApiClient.POST,
    );
  }

// change pasword
  static Future<ApiResponse> changePassword(
    String oldPassword,
    String newPassword,
    String reNewPassword,
  ) async {
    Map data = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "reNewPassword": reNewPassword
    };
    return await ApiClient().request(
      url: "$domain/mp/api/auth/change-password",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //
  static Future<ApiResponse> deleteGroupSupplier(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/group-supplier/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> deleteCustomer(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/customer/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> deleteOrder(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/order/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> createReturnProduct({
    int? branchId,
    int? totalPrice,
    int? userId,
    int? supplierId,
    int? discount,
    String? status,
    List<ProductReturn>? products,
    int? debt,
  }) async {
    Map data = {
      "branchId": branchId,
      "totalPrice": totalPrice,
      "userId": userId,
      "supplierId": supplierId,
      "products": products,
      "status": status,
      "discount": discount,
      "debt": debt,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/purchase-return",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> deleteDoctor(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/doctor/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> deleteSupplier(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/supplier/$id",
      method: ApiClient.DELETE,
    );
  }

  static Future<ApiResponse> deleteSampleMedicine(int? id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/sample-prescription/$id",
      method: ApiClient.DELETE,
    );
  }

  //get-page promotion

  static Future<ApiResponse> getListPromotion(
      {int? page = 1, int? limit = 5, String? keyword = ''}) async {
    return await ApiClient().request(
      url:
          "$domain/mp/api/promotion-program?page=$page&limit=$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  //get-all-role
  static Future<ApiResponse> roles() async {
    return await ApiClient().request(
      url: "$domain/mp/api/role",
      method: ApiClient.GET,
    );
  }

  //get-all-role
  static Future<ApiResponse> roleDetails(int id) async {
    return await ApiClient().request(
      url: "$domain/mp/api/role/$id",
      method: ApiClient.GET,
    );
  }

  //role-create
  static Future<ApiResponse> roleCreate(
      {required PermissionModel permissionModel}) async {
    Map data = permissionModel.toJson();
    return await ApiClient().request(
      url: "$domain/mp/api/role",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  //role-update
  static Future<ApiResponse> roleUpdate(
      {required int id, required PermissionModel permissionModel}) async {
    Map data = permissionModel.toJson();
    return await ApiClient().request(
      url: "$domain/mp/api/role/$id",
      data: json.encode(data),
      method: ApiClient.PATCH,
    );
  }

  //role-delete
  static Future<ApiResponse> roleDelete({required int id}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/role/$id",
      method: ApiClient.DELETE,
    );
  }

  //get- product for promotion
  static Future<ApiResponse> getProductForPromotion({
    String? keyword = "",
    int? page,
    int? limit,
  }) async {
    return await ApiClient().request(
      url: "$domain/promotion-program?page=$page&limit=$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  //delete- promotion
  static Future<ApiResponse> deletePromotion(String? id) async {
    return await ApiClient().request(
      url: "$domain/promotion/$id",
      method: ApiClient.DELETE,
    );
  }

  //create- promotion
  static Future<ApiResponse> createPromotion(
      {String? code,
      String? name,
      String? status = "ACTIVATED",
      String? note,
      String? type,
      String? method = "DISCOUNT_BILL",
      String? startTime,
      String? endTime = "",
      String? listMonths,
      String? listDays,
      String? listDayOfWeek,
      String? listHours,
      String? birthdayPromotionType = "DAY",
      bool? isBirthdayPromotion = false,
      String? branchIds,
      String? sellerIds,
      String? groupCustomerIds,
      bool? multiplyByQuantity = false,
      List<ListPolicy> listPolicy = const []}) async {
    Map data = {
      "code": code,
      "name": name,
      "status": status,
      "note": note,
      "type": type,
      "method": method,
      "startTime": startTime ?? DateTime.now().toString(),
      "endTime": endTime,
      "listMonths": listMonths,
      "listDays": listDays,
      "listDayOfWeek": listDayOfWeek,
      "listHours": listHours,
      "isBirthdayPromotion": isBirthdayPromotion,
      "birthdayPromotionType": birthdayPromotionType,
      "branchIds": branchIds,
      "sellerIds": sellerIds,
      "groupCustomerIds": groupCustomerIds,
      "multiplyByQuantity": multiplyByQuantity,
      "listPolicy": listPolicy
    };

    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/promotion",
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> createNewSampleMedicine(
      {int? status,
      int? branchId,
      String? code,
      String? name,
      int? positonId,
      String? weight,
      int? imageId,
      String? description,
      List<Map<String, dynamic>>? ingredientProducts}) async {
    Map data = {
      "status": status,
      "branchId": branchId,
      "code": code,
      "name": name,
      "positionId": positonId,
      "weight": weight,
      "imageId": imageId,
      "description": description,
      "ingredientProducts": ingredientProducts,
    };
    return await ApiClient().request(
      data: json.encode(data),
      url: "$domain/mp/api/sample-prescription",
      method: ApiClient.POST,
    );
  }

  static Future<List<SearchProductModel?>> searchProductByKeyword(
    String? keyword,
  ) async {
    String newUrl = "$domain/product/search?page=0&size=10&keyword=$keyword";
    ApiResponse response = await ApiClient().request(
      url: newUrl,
      method: ApiClient.GET,
    ); // Assuming the ApiResponse contains a list of products or their names.
    List<dynamic> responseData = response
        .data; //Replace 'dynamic' with the actual type of data in your ApiResponse.
    List<SearchProductModel?> productList = responseData
        .map((product) => SearchProductModel.fromJson(product))
        .toList();
    return productList;
  }

  static Future<ApiResponse> getListDoctor({
    String? keyword,
    int? limit,
    int? page,
  }) async {
    keyword ??= "";
    limit = 10;
    page = 1;
    return await ApiClient().request(
      url: "$domain/mp/api/doctor?page=$page&limit$limit&keyword=$keyword",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> getPaymentHistory(
      {int? id, int? page, int? limit}) async {
    return await ApiClient().request(
      url: "$domain/mp/api/order/$id/payment-history?page=$page&limit=$limit",
      method: ApiClient.GET,
    );
  }

  static Future<ApiResponse> changeStatusProduct({
    int? status,
    int? id,
  }) async {
    Map data = {
      "status": status,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/product/$id/status",
      data: json.encode(data),
      method: ApiClient.PATCH,
    );
  }

  static Future<ApiResponse> payForDebt({
    int? id,
    int? amount,
    String? paymentMethod,
    int? totalAmount,
  }) async {
    Map data = {
      "amount": amount,
      "paymentMethod": paymentMethod,
      "totalAmount": totalAmount,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/order/$id/payment",
      data: json.encode(data),
      method: ApiClient.POST,
    );
  }

  static Future<ApiResponse> changeStatusCustomer({
    String? status,
    int? id,
  }) async {
    Map data = {
      "status": status,
    };
    return await ApiClient().request(
      url: "$domain/mp/api/customer/$id",
      data: json.encode(data),
      method: ApiClient.PUT,
    );
  }

  static Future<List<SearchCustomerModel>> searchCustomerPromotion(
    String? keyword,
  ) async {
    String newUrl =
        "http://45.119.84.221:8680/v1.0/sale/group-customer?keyword==$keyword";
    ApiResponse response = await ApiClient().request(
      url: newUrl,
      method: ApiClient.GET,
    ); // Assuming the ApiResponse contains a list of products or their names.
    List<dynamic> responseData = response
        .data; //Replace 'dynamic' with the actual type of data in your ApiResponse.
    List<SearchCustomerModel> customerList = responseData
        .map((product) => SearchCustomerModel.fromJson(product))
        .toList();
    return customerList;
  }

  static Future<List<SearchSupplierModel>> searchSupplierPromotion(
    String? keyword,
    String? branchId,
  ) async {
    String newUrl =
        "$domain/product/supplier/search?page=0&size=10&keyword=$keyword&branchId=$branchId";
    ApiResponse response = await ApiClient().request(
      url: newUrl,
      method: ApiClient.GET,
    ); // Assuming the ApiResponse contains a list of products or their names.
    List<dynamic> responseData = response
        .data; // Replace 'dynamic' with the actual type of data in your ApiResponse.
    List<SearchSupplierModel> supplierList = responseData
        .map((product) => SearchSupplierModel.fromJson(product))
        .toList();
    return supplierList;
  }

  //report
  //customer
  static Future<ApiResponse> getReportCustomer(
      {int? page = 0, int? size = 10}) async {
    return await ApiClient().request(
      url: "$domain/sale/customer-report?page=$page&size=$size",
      method: ApiClient.GET,
    );
  }

//otp
  static Future<ApiResponse> getOtp({int? page = 0, int? size = 10}) async {
    return await ApiClient().request(
      url: "$domain/sale/customer-report?page=$page&size=$size",
      method: ApiClient.GET,
    );
  }

  //supplier
  static Future<ApiResponse> getReportSupplier(
      {int? page = 0,
      int? size = 10,
      String? branchId,
      String? startTime,
      String? endTime}) async {
    return await ApiClient().request(
      url:
          "$domain/product/supplier/report?branchId=$branchId&startTime=$startTime&endTime=$endTime&page=$page&size=$size",
      method: ApiClient.GET,
    );
  }

  //sell
  static Future<ApiResponse> getReportSale(
      {int? page = 0,
      int? size = 10,
      String? branchId,
      String? startTime,
      String? endTime}) async {
    return await ApiClient().request(
      url:
          "$domain/sale/sale-report?page=$page&size=$size&startTime=$startTime&endTime=$endTime&branchId=${branchId ?? ""}",
      method: ApiClient.GET,
    );
  }

  //product
  static Future<ApiResponse> getReportProduct(
      {int? page = 0, int? size = 10, String? branchId, int? type}) async {
    return await ApiClient().request(
      url:
          "$domain/product/report?type=$type&page=$page&size=$size&branchId=${branchId ?? ""}",
      method: ApiClient.GET,
    );
  }

  static Future<List<SupplierModel?>> searchSupplier(
    String? keyword,
    String? branchId,
  ) async {
    String newUrl =
        "$domain/product/supplier/search?page=0&size=100&keyword=$keyword&branchId=$branchId";
    ApiResponse response = await ApiClient().request(
      url: newUrl,
      method: ApiClient.GET,
    );

    // Assuming the ApiResponse contains a list of products or their names.
    List<dynamic> responseData = response
        .data; // Replace 'dynamic' with the actual type of data in your ApiResponse.

    List<SupplierModel?> supplierList =
        responseData.map((product) => SupplierModel.fromJson(product)).toList();

    return supplierList;
  }
}
