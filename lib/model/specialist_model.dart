class SpecialistModel {
  int? id;
  String? name;
  int? storeId;

  SpecialistModel({this.id, this.name, this.storeId});

  SpecialistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['storeId'] = this.storeId;
    return data;
  }
}
