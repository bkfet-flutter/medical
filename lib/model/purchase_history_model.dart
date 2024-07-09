import 'package:mephar_app/model/image_model.dart';

class PurchaseHistoryModel {
  int? id;
  String? code;
  String? description;
  int? userId;
  int? customerId;
  int? storeId;
  int? branchId;
  String? paymentType;
  int? point;
  int? totalPrice;
  int? cashOfCustomer;
  int? customerOwes;
  int? refund;
  int? discount;
  // Null? discountType;
  bool? isVatInvoice;
  String? status;
  String? createdAt;
  int? createdBy;
  // Null? prescription;
  Branch? branch;
  // User? user;
  // Customer? customer;
  // List<Products>? products;
  int? totalProducts;
  int? totalQuantities;

  PurchaseHistoryModel(
      {this.id,
      this.code,
      this.description,
      this.userId,
      this.customerId,
      this.storeId,
      this.branchId,
      this.paymentType,
      this.point,
      this.totalPrice,
      this.cashOfCustomer,
      this.customerOwes,
      this.refund,
      this.discount,
      // this.discountType,
      this.isVatInvoice,
      this.status,
      this.createdAt,
      this.createdBy,
      // this.prescription,
      this.branch,
      // this.user,
      // this.customer,
      // this.products,
      this.totalProducts,
      this.totalQuantities});

  PurchaseHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    userId = json['userId'];
    customerId = json['customerId'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    paymentType = json['paymentType'];
    point = json['point'];
    totalPrice = json['totalPrice'];
    cashOfCustomer = json['cashOfCustomer'];
    customerOwes = json['customerOwes'];
    refund = json['refund'];
    discount = json['discount'];
    // discountType = json['discountType'];
    isVatInvoice = json['isVatInvoice'];
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    // prescription = json['prescription'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    // user = json['user'] != null ? new User.fromJson(json['user']) : null;
    // customer = json['customer'] != null
    //     ? new Customer.fromJson(json['customer'])
    //     : null;
    // if (json['products'] != null) {
    //   products = <Products>[];
    //   json['products'].forEach((v) {
    //     products!.add(new Products.fromJson(v));
    //   });
    // }
    totalProducts = json['totalProducts'];
    totalQuantities = json['totalQuantities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['paymentType'] = this.paymentType;
    data['point'] = this.point;
    data['totalPrice'] = this.totalPrice;
    data['cashOfCustomer'] = this.cashOfCustomer;
    data['customerOwes'] = this.customerOwes;
    data['refund'] = this.refund;
    data['discount'] = this.discount;
    // data['discountType'] = this.discountType;
    data['isVatInvoice'] = this.isVatInvoice;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    // data['prescription'] = this.prescription;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    // if (this.user != null) {
    //   data['user'] = this.user!.toJson();
    // }
    // if (this.customer != null) {
    //   data['customer'] = this.customer!.toJson();
    // }
    // if (this.products != null) {
    //   data['products'] = this.products!.map((v) => v.toJson()).toList();
    // }
    data['totalProducts'] = this.totalProducts;
    data['totalQuantities'] = this.totalQuantities;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? zipCode;
  int? provinceId;
  int? districtId;
  int? wardId;
  bool? isDefaultBranch;
  String? createdAt;

  Branch(
      {this.id,
      this.name,
      this.phone,
      this.code,
      this.zipCode,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.isDefaultBranch,
      this.createdAt});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    zipCode = json['zipCode'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    isDefaultBranch = json['isDefaultBranch'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['zipCode'] = this.zipCode;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['isDefaultBranch'] = this.isDefaultBranch;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? fullName;
  int? avatarId;
  String? birthday;
  String? gender;
  String? phone;
  int? roleId;
  String? position;
  String? lastLoginAt;
  String? status;

  User(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.avatarId,
      this.birthday,
      this.gender,
      this.phone,
      this.roleId,
      this.position,
      this.lastLoginAt,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    birthday = json['birthday'];
    gender = json['gender'];
    phone = json['phone'];
    roleId = json['roleId'];
    position = json['position'];
    lastLoginAt = json['lastLoginAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['avatarId'] = this.avatarId;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['position'] = this.position;
    data['lastLoginAt'] = this.lastLoginAt;
    data['status'] = this.status;
    return data;
  }
}

class Customer {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? address;
  int? groupCustomerId;

  Customer(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.address,
      this.groupCustomerId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    groupCustomerId = json['groupCustomerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['groupCustomerId'] = this.groupCustomerId;
    return data;
  }
}

class Products {
  int? id;
  int? orderId;
  int? productId;
  int? productUnitId;
  String? productUnitData;
  int? quantity;
  int? quantityBaseUnit;
  int? comboId;
  int? price;
  int? primePrice;
  int? customerId;
  int? groupCustomerId;
  int? userId;
  int? discount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ProductUnit? productUnit;
  Product? product;

  Products(
      {this.id,
      this.orderId,
      this.productId,
      this.productUnitId,
      this.productUnitData,
      this.quantity,
      this.quantityBaseUnit,
      this.comboId,
      this.price,
      this.primePrice,
      this.customerId,
      this.groupCustomerId,
      this.userId,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.productUnit,
      this.product});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    productId = json['productId'];
    productUnitId = json['productUnitId'];
    productUnitData = json['productUnitData'];
    quantity = json['quantity'];
    quantityBaseUnit = json['quantityBaseUnit'];
    comboId = json['comboId'];
    price = json['price'];
    primePrice = json['primePrice'];
    customerId = json['customerId'];
    groupCustomerId = json['groupCustomerId'];
    userId = json['userId'];
    discount = json['discount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    productUnit = json['productUnit'] != null
        ? new ProductUnit.fromJson(json['productUnit'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    data['productUnitId'] = this.productUnitId;
    data['productUnitData'] = this.productUnitData;
    data['quantity'] = this.quantity;
    data['quantityBaseUnit'] = this.quantityBaseUnit;
    data['comboId'] = this.comboId;
    data['price'] = this.price;
    data['primePrice'] = this.primePrice;
    data['customerId'] = this.customerId;
    data['groupCustomerId'] = this.groupCustomerId;
    data['userId'] = this.userId;
    data['discount'] = this.discount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class ProductUnit {
  int? id;
  String? unitName;
  int? exchangeValue;
  int? price;
  bool? isBaseUnit;

  ProductUnit(
      {this.id,
      this.unitName,
      this.exchangeValue,
      this.price,
      this.isBaseUnit});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unitName'];
    exchangeValue = json['exchangeValue'];
    price = json['price'];
    isBaseUnit = json['isBaseUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitName'] = this.unitName;
    data['exchangeValue'] = this.exchangeValue;
    data['price'] = this.price;
    data['isBaseUnit'] = this.isBaseUnit;
    return data;
  }
}

class Product {
  String? name;
  String? shortName;
  String? code;
  String? barCode;
  int? imageId;
  ImageModel? image;

  Product(
      {this.name,
      this.shortName,
      this.code,
      this.barCode,
      this.imageId,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['shortName'];
    code = json['code'];
    barCode = json['barCode'];
    imageId = json['imageId'];
    image = json['image'];
    image =
        json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['imageId'] = this.imageId;
    data['image'] = this.image;
    return data;
  }
}
