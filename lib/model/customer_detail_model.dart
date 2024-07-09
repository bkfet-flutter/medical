import 'package:mephar_app/model/image_model.dart';

class CustomerDetailModel {
  int? id;
  String? code;
  String? phone;
  String? email;
  String? fullName;
  String? address;
  int? avatarId;
  String? birthday;
  String? gender;
  int? groupCustomerId;

  // Null? position;
  String? taxCode;
  int? type;
  String? status;
  int? point;
  int? debt;
  String? createdAt;
  ImageModel? avatar;
  GroupCustomer? groupCustomer;
  Province? province;
  Province? district;
  Province? ward;

  CustomerDetailModel(
      {this.id,
      this.code,
      this.phone,
      this.email,
      this.fullName,
      this.address,
      this.avatarId,
      this.birthday,
      this.gender,
      this.groupCustomerId,
      // this.position,
      this.taxCode,
      this.type,
      this.status,
      this.point,
      this.debt,
      this.createdAt,
      this.avatar,
      this.groupCustomer,
      this.province,
      this.district,
      this.ward});

  CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    phone = json['phone'];
    email = json['email'];
    fullName = json['fullName'];
    address = json['address'];
    avatarId = json['avatarId'];
    birthday = json['birthday'];
    gender = json['gender'];
    groupCustomerId = json['groupCustomerId'];
    // position = json['position'];
    taxCode = json['taxCode'];
    type = json['type'];
    status = json['status'];
    point = json['point'];
    debt = json['debt'];
    createdAt = json['createdAt'];
    avatar = json['avatar'] != null ? new ImageModel.fromJson(json['avatar']) : null;
    groupCustomer = json['groupCustomer'] != null ? new GroupCustomer.fromJson(json['groupCustomer']) : null;
    province = json['province'] != null ? new Province.fromJson(json['province']) : null;
    district = json['district'] != null ? new Province.fromJson(json['district']) : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['avatarId'] = this.avatarId;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['groupCustomerId'] = this.groupCustomerId;
    // data['position'] = this.position;
    data['taxCode'] = this.taxCode;
    data['type'] = this.type;
    data['status'] = this.status;
    data['point'] = this.point;
    data['debt'] = this.debt;
    data['createdAt'] = this.createdAt;
    data['avatar'] = this.avatar;
    if (this.groupCustomer != null) {
      data['groupCustomer'] = this.groupCustomer!.toJson();
    }
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.ward != null) {
      data['ward'] = this.ward!.toJson();
    }
    return data;
  }
}

class GroupCustomer {
  int? id;
  String? name;
  String? description;
  String? type;
  int? discount;

  GroupCustomer({this.id, this.name, this.description, this.type, this.discount});

  GroupCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['discount'] = this.discount;
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
