class EnterProductModel {
  int? branchId;
  num? totalPrice;
  int? userId;
  List<ProductsImport>? products;
  int? supplierId;
  int? discount;
  int? paid;
  int? debt;
  String? description;
  String? status;


  EnterProductModel(
      {
      this.branchId,
      this.userId,
      this.supplierId,
      this.totalPrice,
      this.discount,
      this.paid,
      this.debt,
      this.description,
      this.status,
      this.products});

  EnterProductModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
    userId = json['userId'];
    supplierId = json['supplierId'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    paid = json['paid'];
    debt = json['debt'];
    description = json['description'];
    status = json['status'];
    if (json['products'] != null) {
      products = <ProductsImport>[];
      json['products'].forEach((v) {
        products!.add(ProductsImport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branchId'] = branchId;
    data['userId'] = userId;
    data['supplierId'] = supplierId;
    data['totalPrice'] = totalPrice;
    data['discount'] = discount;
    data['paid'] = paid;
    data['debt'] = debt;
    data['description'] = description;
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsImport {
  int? productId;
  int? importPrice;
  int? totalQuantity;
  num? totalPrice;
  int? discount;
  int? productUnitId;
  List<Batches>? batches;

  ProductsImport(
      {this.productId,
      this.importPrice,
      this.totalQuantity,
      this.totalPrice,
      this.discount,
      this.productUnitId,
      this.batches});

  ProductsImport.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    importPrice = json['importPrice'];
    totalQuantity = json['totalQuantity'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    productUnitId = json['productUnitId'];
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['importPrice'] = importPrice;
    data['totalQuantity'] = totalQuantity;
    data['totalPrice'] = totalPrice;
    data['discount'] = discount;
    data['productUnitId'] = productUnitId;
    if (batches != null) {
      data['batches'] = batches!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['expiryDate'] = expiryDate;
    return data;
  }
}
