class SupplierModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? code;
  String? taxCode;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? storeId;
  String? address;
  String? companyName;
  int? groupSupplierId;
  String? note;
  String? createdAt;
  GroupSupplier? groupSupplier;
  Store? store;
  Branch? branch;
  Province? province;
  Province? district;
  Province? ward;

  SupplierModel(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.code,
      this.taxCode,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.storeId,
      this.address,
      this.companyName,
      this.groupSupplierId,
      this.note,
      this.createdAt,
      this.groupSupplier,
      this.store,
      this.branch,
      this.province,
      this.district,
      this.ward});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    code = json['code'];
    taxCode = json['taxCode'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    storeId = json['storeId'];
    address = json['address'];
    companyName = json['companyName'];
    groupSupplierId = json['groupSupplierId'];
    note = json['note'];
    createdAt = json['createdAt'];
    groupSupplier = json['groupSupplier'] != null ? GroupSupplier.fromJson(json['groupSupplier']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
    district = json['district'] != null ? Province.fromJson(json['district']) : null;
    ward = json['ward'] != null ? Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['code'] = code;
    data['taxCode'] = taxCode;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
    data['storeId'] = storeId;
    data['address'] = address;
    data['companyName'] = companyName;
    data['groupSupplierId'] = groupSupplierId;
    data['note'] = note;
    data['createdAt'] = createdAt;
    if (groupSupplier != null) {
      data['groupSupplier'] = groupSupplier!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
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

class Store {
  int? id;
  String? name;
  String? phone;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? address;
  Province? province;
  Province? district;
  Province? ward;

  Store(
      {this.id,
      this.name,
      this.phone,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.address,
      this.province,
      this.district,
      this.ward});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    address = json['address'];
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
    district = json['district'] != null ? Province.fromJson(json['district']) : null;
    ward = json['ward'] != null ? Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
    data['address'] = address;
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

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  int? provinceId;
  int? districtId;
  int? wardId;
  Province? province;
  Province? district;
  Province? ward;

  Branch({this.id, this.name, this.provinceId, this.districtId, this.wardId, this.province, this.district, this.ward});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
    district = json['district'] != null ? Province.fromJson(json['district']) : null;
    ward = json['ward'] != null ? Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
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
