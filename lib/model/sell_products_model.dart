class SellModel {
  String? paymentType;
  int? userId;
  int? customerId;
  int? cashOfCustomer;
  String? description;
  List<Products>? products;
  int? totalPrice;
  int? discount;
  int? discountType;
  int? branchId;

  SellModel(
      {this.paymentType,
      this.userId,
      this.customerId,
      this.cashOfCustomer,
      this.description,
      this.products,
      this.totalPrice,
      this.discount,
      this.discountType,
      this.branchId});

  SellModel.fromJson(Map<String, dynamic> json) {
    paymentType = json['paymentType'];
    discount = json['discount'];
    discountType = json['discountType'];
    userId = json['userId'];
    customerId = json['customerId'];
    cashOfCustomer = json['cashOfCustomer'];
    description = json['description'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    branchId = json['branchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentType'] = paymentType;
    data['discountType'] = discountType;
    data['discount'] = discount;
    data['userId'] = userId;
    data['customerId'] = customerId;
    data['cashOfCustomer'] = cashOfCustomer;
    data['description'] = description;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['branchId'] = branchId;
    return data;
  }
}

class Products {
  int? productId;
  int? productUnitId;
  int? originProductUnitId;
  int? productType;
  int? quantity;
  List<Batches>? batches;

  Products(
      {this.productId, this.productUnitId, this.originProductUnitId, this.productType, this.quantity, this.batches});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productUnitId = json['productUnitId'];
    originProductUnitId = json['originProductUnitId'];
    productType = json['productType'];
    quantity = json['quantity'];
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
    data['productUnitId'] = productUnitId;
    data['originProductUnitId'] = originProductUnitId;
    data['productType'] = productType;
    data['quantity'] = quantity;
    if (batches != null) {
      data['batches'] = batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int? id;
  int? quantity;

  Batches({this.id, this.quantity});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }
}
