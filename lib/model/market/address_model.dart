class AddressModel {
  String? name;
  String? phone;
  String? province;
  String? district;
  String? commune;
  String? detail;
  bool? defaultAddress;
  int? createdBy;
  int? createdAt;
  int? updatedBy;
  int? updatedAt;
  int? id;

  AddressModel(
      {this.name,
        this.phone,
        this.province,
        this.district,
        this.commune,
        this.detail,
        this.defaultAddress,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
    district = json['district'];
    commune = json['commune'];
    detail = json['detail'];
    defaultAddress = json['defaultAddress'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedBy = json['updatedBy'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['province'] = province;
    data['district'] = district;
    data['commune'] = commune;
    data['detail'] = detail;
    data['defaultAddress'] = defaultAddress;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedBy'] = updatedBy;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
