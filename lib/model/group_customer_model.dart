class GroupCustomerModel {
  int? id;
  String? name;
  String? description;
  String? type;
  int? discount;

  GroupCustomerModel(
      {this.id, this.name, this.description, this.type, this.discount});

  GroupCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['discount'] = this.discount;
    return data;
  }
}
