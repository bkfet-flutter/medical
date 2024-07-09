import 'package:mephar_app/model/supplier_model.dart';

class ProductInboundModel {
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
  Store? store;
  Branch? branch;
  User? user;
  Creator? creator;
  SupplierModel? supplier;

  ProductInboundModel(
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

  ProductInboundModel.fromJson(Map<String, dynamic> json) {
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
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    creator = json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    supplier = json['supplier'] != null ? SupplierModel.fromJson(json['supplier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['userId'] = userId;
    data['storeId'] = storeId;
    data['branchId'] = branchId;
    data['totalPrice'] = totalPrice;
    data['paid'] = paid;
    data['debt'] = debt;
    data['discount'] = discount;
    data['supplierId'] = supplierId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? phone;
  String? address;

  Store({this.id, this.name, this.phone, this.address});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? zipCode;
  bool? isDefaultBranch;

  Branch({this.id, this.name, this.phone, this.code, this.zipCode, this.isDefaultBranch});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    zipCode = json['zipCode'];
    isDefaultBranch = json['isDefaultBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['code'] = code;
    data['zipCode'] = zipCode;
    data['isDefaultBranch'] = isDefaultBranch;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? fullName;
  int? avatarId;
  String? phone;

  User({this.id, this.username, this.email, this.fullName, this.avatarId, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['fullName'] = fullName;
    data['avatarId'] = avatarId;
    data['phone'] = phone;
    return data;
  }
}

class Creator {
  int? id;
  String? username;
  String? email;
  String? fullName;
  int? avatarId;
  String? phone;

  Creator({this.id, this.username, this.email, this.fullName, this.avatarId, this.phone});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['fullName'] = fullName;
    data['avatarId'] = avatarId;
    data['phone'] = phone;
    return data;
  }
}

class GroupSupplier {
  int? id;
  String? name;
  String? description;
  int? storeId;

  GroupSupplier({this.id, this.name, this.description, this.storeId});

  GroupSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['storeId'] = storeId;
    return data;
  }
}
