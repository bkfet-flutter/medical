import 'package:mephar_app/model/config/store_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/model/supplier_model.dart';

import 'config/branch_model.dart';

class ProductReturnModel {
  int? id;
  String? code;
  String? description;
  int? userId;
  int? storeId;
  int? branchId;
  int? totalPrice;
  int? paid;
  int? debt;
  int? discount;
  int? supplierId;
  String? status;
  String? createdAt;
  StoreModel? store;
  BranchModel? branch;
  UserModel? user;
  UserModel? creator;
  SupplierModel? supplier;

  ProductReturnModel(
      {this.id,
        this.code,
        this.description,
        this.userId,
        this.storeId,
        this.branchId,
        this.totalPrice,
        this.paid,
        this.debt,
        this.discount,
        this.supplierId,
        this.status,
        this.createdAt,
        this.store,
        this.branch,
        this.user,
        this.creator,
        this.supplier});

  ProductReturnModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    userId = json['userId'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    totalPrice = json['totalPrice'];
    paid = json['paid'];
    debt = json['debt'];
    discount = json['discount'];
    supplierId = json['supplierId'];
    status = json['status'];
    createdAt = json['createdAt'];
    store = json['store'] != null ? new StoreModel.fromJson(json['store']) : null;
    branch =
    json['branch'] != null ? new BranchModel.fromJson(json['branch']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    creator =
    json['creator'] != null ? new UserModel.fromJson(json['creator']) : null;
    supplier = json['supplier'] != null
        ? new SupplierModel.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['totalPrice'] = this.totalPrice;
    data['paid'] = this.paid;
    data['debt'] = this.debt;
    data['discount'] = this.discount;
    data['supplierId'] = this.supplierId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    return data;
  }
}





