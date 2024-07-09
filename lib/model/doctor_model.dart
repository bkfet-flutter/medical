class DoctorModel {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? email;
  String? gender;
  int? specialistId;
  int? levelId;
  int? workPlaceId;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? storeId;
  String? address;
  String? note;
  int? status;
  String? createdAt;
  Avatar? avatar;
  Store? store;
  Province? specialist;
  Province? level;
  Province? workPlace;
  Province? province;
  Province? district;
  Province? ward;

  DoctorModel(
      {this.id,
      this.name,
      this.phone,
      this.code,
      this.email,
      this.gender,
      this.specialistId,
      this.levelId,
      this.workPlaceId,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.storeId,
      this.address,
      this.note,
      this.status,
      this.createdAt,
      this.avatar,
      this.store,
      this.specialist,
      this.level,
      this.workPlace,
      this.province,
      this.district,
      this.ward});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    email = json['email'];
    gender = json['gender'];
    specialistId = json['specialistId'];
    levelId = json['levelId'];
    workPlaceId = json['workPlaceId'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    storeId = json['storeId'];
    address = json['address'];
    note = json['note'];
    status = json['status'];
    createdAt = json['createdAt'];
    avatar =
        json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    specialist = json['specialist'] != null
        ? new Province.fromJson(json['specialist'])
        : null;
    level = json['level'] != null ? new Province.fromJson(json['level']) : null;
    workPlace = json['workPlace'] != null
        ? new Province.fromJson(json['workPlace'])
        : null;
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new Province.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['specialistId'] = this.specialistId;
    data['levelId'] = this.levelId;
    data['workPlaceId'] = this.workPlaceId;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['storeId'] = this.storeId;
    data['address'] = this.address;
    data['note'] = this.note;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.specialist != null) {
      data['specialist'] = this.specialist!.toJson();
    }
    if (this.level != null) {
      data['level'] = this.level!.toJson();
    }
    if (this.workPlace != null) {
      data['workPlace'] = this.workPlace!.toJson();
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

class Avatar {
  String? filePath;
  int? id;
  String? originalName;
  String? fileName;
  String? path;

  Avatar({this.filePath, this.id, this.originalName, this.fileName, this.path});

  Avatar.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    id = json['id'];
    originalName = json['originalName'];
    fileName = json['fileName'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filePath'] = this.filePath;
    data['id'] = this.id;
    data['originalName'] = this.originalName;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
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
  String? createdAt;
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
      this.createdAt,
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
    createdAt = json['createdAt'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new Province.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
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
