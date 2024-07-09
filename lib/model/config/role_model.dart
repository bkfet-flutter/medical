class RoleModel {
  int? id;
  int? storeId;
  String? name;
  String? description;
  String? createdAt;

  RoleModel({this.id, this.storeId, this.createdAt, this.name, this.description});

  RoleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RoleModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
