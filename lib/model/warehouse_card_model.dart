class WareHouseCardModel {
  int? id;
  int? productId;
  String? code;
  String? partner;
  int? branchId;
  int? productUnitId;
  int? changeQty;
  int? remainQty;
  int? type;
  String? createdAt;

  WareHouseCardModel(
      {this.id,
      this.productId,
      this.code,
      this.partner,
      this.branchId,
      this.productUnitId,
      this.changeQty,
      this.remainQty,
      this.type,
      this.createdAt});

  WareHouseCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    code = json['code'];
    partner = json['partner'];
    branchId = json['branchId'];
    productUnitId = json['productUnitId'];
    changeQty = json['changeQty'];
    remainQty = json['remainQty'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['code'] = this.code;
    data['partner'] = this.partner;
    data['branchId'] = this.branchId;
    data['productUnitId'] = this.productUnitId;
    data['changeQty'] = this.changeQty;
    data['remainQty'] = this.remainQty;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
