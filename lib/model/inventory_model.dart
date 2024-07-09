class InventoryModel {
  int? id;
  int? quantity;
  int? productId;
  int? branchId;
  Branch? branch;

  InventoryModel(
      {this.id, this.quantity, this.productId, this.branchId, this.branch});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productId = json['productId'];
    branchId = json['branchId'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['productId'] = this.productId;
    data['branchId'] = this.branchId;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? code;

  Branch({this.id, this.name, this.code});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
