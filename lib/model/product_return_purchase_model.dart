class ProductReturnPurchaseModel {
  int? productId;
  int? importPrice;
  int? totalQuantity;
  int? totalPrice;
  int? discount;
  int? productUnitId;
  List<Batches>? batches;

  ProductReturnPurchaseModel(
      {this.productId,
      this.importPrice,
      this.totalQuantity,
      this.totalPrice,
      this.discount,
      this.productUnitId,
      this.batches});

  ProductReturnPurchaseModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    importPrice = json['importPrice'];
    totalQuantity = json['totalQuantity'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    productUnitId = json['productUnitId'];
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(new Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['importPrice'] = this.importPrice;
    data['totalQuantity'] = this.totalQuantity;
    data['totalPrice'] = this.totalPrice;
    data['discount'] = this.discount;
    data['productUnitId'] = this.productUnitId;
    if (this.batches != null) {
      data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int? id;
  int? quantity;
  String? expiryDate;

  Batches({this.id, this.quantity, this.expiryDate});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}
