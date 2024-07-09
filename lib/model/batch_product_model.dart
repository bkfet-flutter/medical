class BatchProductModel {
  int? id;
  String? name;
  int? storeId;
  int? branchId;
  int? productId;
  int? quantity;
  String? expiryDate;
  int? inventory;
  double? value;

  BatchProductModel(
      {this.id,
      this.name,
      this.storeId,
      this.branchId,
      this.productId,
      this.quantity,
      this.expiryDate,
      this.value,
      this.inventory});

  BatchProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    productId = json['productId'];
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
    inventory = json['inventory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['expiryDate'] = this.expiryDate;
    data['inventory'] = this.inventory;
    return data;
  }
}
