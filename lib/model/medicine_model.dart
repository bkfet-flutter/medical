class MedicineModel {
  int? id;
  String? name;
  String? type;
  String? code;
  String? registerNumber;
  String? activeElement;
  String? content;
  String? packingSpecification;
  int? manufactureId;
  int? countryId;
  int? unitId;
  int? storeId;
  // Null? unit;
  Manufacture? manufacture;
  Manufacture? country;

  MedicineModel(
      {this.id,
      this.name,
      this.type,
      this.code,
      this.registerNumber,
      this.activeElement,
      this.content,
      this.packingSpecification,
      this.manufactureId,
      this.countryId,
      this.unitId,
      this.storeId,
      // this.unit,
      this.manufacture,
      this.country});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    code = json['code'];
    registerNumber = json['registerNumber'];
    activeElement = json['activeElement'];
    content = json['content'];
    packingSpecification = json['packingSpecification'];
    manufactureId = json['manufactureId'];
    countryId = json['countryId'];
    unitId = json['unitId'];
    storeId = json['storeId'];
    // unit = json['unit'];
    manufacture = json['manufacture'] != null
        ? new Manufacture.fromJson(json['manufacture'])
        : null;
    country = json['country'] != null
        ? new Manufacture.fromJson(json['country'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['code'] = this.code;
    data['registerNumber'] = this.registerNumber;
    data['activeElement'] = this.activeElement;
    data['content'] = this.content;
    data['packingSpecification'] = this.packingSpecification;
    data['manufactureId'] = this.manufactureId;
    data['countryId'] = this.countryId;
    data['unitId'] = this.unitId;
    data['storeId'] = this.storeId;
    // data['unit'] = this.unit;
    if (this.manufacture != null) {
      data['manufacture'] = this.manufacture!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Manufacture {
  int? id;
  String? name;

  Manufacture({this.id, this.name});

  Manufacture.fromJson(Map<String, dynamic> json) {
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
