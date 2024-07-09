class ProvinceModel {
  int? id;
  String? name;

  ProvinceModel({this.id, this.name});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? json["fullName"];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProvinceModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
