class GroupSupplierModel {
  int? id;
  String? name;
  String? description;
  int? storeId;

  GroupSupplierModel({this.id, this.name, this.description, this.storeId});

  GroupSupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['storeId'] = this.storeId;
    return data;
  }
}
