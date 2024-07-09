class SearchCustomerModel {
  String? id;
  String? name;
  double? reducePer;
  String? note;
  String? storeId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SearchCustomerModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  SearchCustomerModel({this.id, this.name, this.reducePer, this.note, this.storeId});

  SearchCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reducePer = json['reducePer'];
    note = json['note'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['reducePer'] = reducePer;
    data['note'] = note;
    data['storeId'] = storeId;
    return data;
  }
}
