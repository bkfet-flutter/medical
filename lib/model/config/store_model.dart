import 'package:mephar_app/model/image_model.dart';
import 'package:mephar_app/model/config/province_model.dart';

class StoreModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? logoId;
  String? address;
  String? createdAt;
  String? businessRegistrationNumber;
  ImageModel? businessRegistrationImage;
  ImageModel? logo;
  ProvinceModel? province;
  ProvinceModel? district;
  ProvinceModel? ward;

  StoreModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.logoId,
      this.address,
      this.createdAt,
      this.businessRegistrationNumber,
      this.businessRegistrationImage,
      this.logo,
      this.province,
      this.district,
      this.ward});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    logoId = json['logoId'];
    address = json['address'];
    createdAt = json['createdAt'];
    businessRegistrationNumber = json['businessRegistrationNumber'];
    businessRegistrationImage =
        json['businessRegistrationImage'] != null ? ImageModel.fromJson(json['businessRegistrationImage']) : null;
    logo = json['logo'] != null ? ImageModel.fromJson(json['logo']) : null;
    province = json['province'] != null ? ProvinceModel.fromJson(json['province']) : null;
    district = json['district'] != null ? ProvinceModel.fromJson(json['district']) : null;
    ward = json['ward'] != null ? ProvinceModel.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
    data['logoId'] = logoId;
    data['address'] = address;
    data['createdAt'] = createdAt;
    data['businessRegistrationNumber'] = businessRegistrationNumber;
    if (businessRegistrationImage != null) {
      data['businessRegistrationImage'] = businessRegistrationImage!.toJson();
    }
    if (logo != null) {
      data['logo'] = logo!.toJson();
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
