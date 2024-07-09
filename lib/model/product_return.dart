class ProductReturn {
  int? productId;
  int? importPrice;
  int? totalQuantity;
  int? totalPrice;
  int? discount;
  int? productUnitId;

  ProductReturn(
      {this.productId,
      this.importPrice,
      this.totalQuantity,
      this.totalPrice,
      this.discount,
      this.productUnitId});

  ProductReturn.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    importPrice = json['importPrice'];
    totalQuantity = json['totalQuantity'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    productUnitId = json['productUnitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['importPrice'] = this.importPrice;
    data['totalQuantity'] = this.totalQuantity;
    data['totalPrice'] = this.totalPrice;
    data['discount'] = this.discount;
    data['productUnitId'] = this.productUnitId;
    return data;
  }
}