class SearchSupplierModel {
  String? id;
  String? name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SearchSupplierModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  SearchSupplierModel({this.id, this.name});

  SearchSupplierModel.fromJson(Map<String, dynamic> json) {
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
