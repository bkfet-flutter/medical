class ManufactureModel {
  int? id;
  String? name;
  int? storeId;
  String? createdAt;

  ManufactureModel({this.id, this.name, this.storeId, this.createdAt});

  ManufactureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['storeId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['storeId'] = this.storeId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
