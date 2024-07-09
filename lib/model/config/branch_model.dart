import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/config/store_model.dart';

class BranchModel {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? zipCode;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? storeId;
  String? address1;
  String? address2;
  bool? isDefaultBranch;
  int? status;
  String? createdAt;
  StoreModel? store;
  ProvinceModel? province;
  ProvinceModel? district;
  ProvinceModel? ward;

  BranchModel(
      {this.id,
      this.name,
      this.phone,
      this.code,
      this.zipCode,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.storeId,
      this.address1,
      this.address2,
      this.isDefaultBranch,
      this.status,
      this.createdAt,
      this.store,
      this.province,
      this.district,
      this.ward});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    zipCode = json['zipCode'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    storeId = json['storeId'];
    address1 = json['address1'];
    address2 = json['address2'];
    isDefaultBranch = json['isDefaultBranch'];
    status = json['status'];
    createdAt = json['createdAt'];
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    province = json['province'] != null ? ProvinceModel.fromJson(json['province']) : null;
    district = json['district'] != null ? ProvinceModel.fromJson(json['district']) : null;
    ward = json['ward'] != null ? ProvinceModel.fromJson(json['ward']) : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BranchModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['code'] = code;
    data['zipCode'] = zipCode;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
    data['storeId'] = storeId;
    data['address1'] = address1;
    data['address2'] = address2;
    data['isDefaultBranch'] = isDefaultBranch;
    data['status'] = status;
    data['createdAt'] = createdAt;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (ward != null) {
      data['ward'] = ward!.toJson();
    }
    return data;
  }
}
