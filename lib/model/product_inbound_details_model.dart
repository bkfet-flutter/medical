import 'package:mephar_app/model/batch_model.dart';
import 'package:mephar_app/model/image_model.dart';

class ProductInboundDetailsModel {
  Inbound? inbound;
  List<Products>? products;

  ProductInboundDetailsModel({this.inbound, this.products});

  ProductInboundDetailsModel.fromJson(Map<String, dynamic> json) {
    inbound = json['inbound'] != null ? Inbound.fromJson(json['inbound']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (inbound != null) {
      data['inbound'] = inbound!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inbound {
  int? id;
  String? code;
  String? description;
  int? userId;
  int? storeId;
  int? branchId;
  int? totalPrice;
  int? paid;
  int? debt;
  int? discount;
  int? supplierId;
  String? status;
  String? createdAt;
  Store? store;
  Branch? branch;
  User? user;
  User? creator;
  Supplier? supplier;

  Inbound(
      {this.id,
      this.code,
      this.description,
      this.userId,
      this.storeId,
      this.branchId,
      this.totalPrice,
      this.paid,
      this.debt,
      this.discount,
      this.supplierId,
      this.status,
      this.createdAt,
      this.store,
      this.branch,
      this.user,
      this.creator,
      this.supplier});

  Inbound.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    userId = json['userId'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    totalPrice = json['totalPrice'];
    paid = json['paid'];
    debt = json['debt'];
    discount = json['discount'];
    supplierId = json['supplierId'];
    status = json['status'];
    createdAt = json['createdAt'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    creator = json['creator'] != null ? User.fromJson(json['creator']) : null;
    supplier = json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['userId'] = userId;
    data['storeId'] = storeId;
    data['branchId'] = branchId;
    data['totalPrice'] = totalPrice;
    data['paid'] = paid;
    data['debt'] = debt;
    data['discount'] = discount;
    data['supplierId'] = supplierId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? phone;
  String? address;

  Store({this.id, this.name, this.phone, this.address});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? phone;
  String? code;
  String? zipCode;
  bool? isDefaultBranch;

  Branch({this.id, this.name, this.phone, this.code, this.zipCode, this.isDefaultBranch});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    zipCode = json['zipCode'];
    isDefaultBranch = json['isDefaultBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['code'] = code;
    data['zipCode'] = zipCode;
    data['isDefaultBranch'] = isDefaultBranch;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? fullName;
  int? avatarId;
  String? phone;

  User({this.id, this.username, this.email, this.fullName, this.avatarId, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['fullName'] = fullName;
    data['avatarId'] = avatarId;
    data['phone'] = phone;
    return data;
  }
}

class Supplier {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? code;
  String? taxCode;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? address;
  String? companyName;
  int? groupSupplierId;
  int? storeId;
  String? note;
  String? createdAt;
  GroupSupplier? groupSupplier;
  Province? province;
  Province? district;
  Province? ward;

  Supplier(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.code,
      this.taxCode,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.address,
      this.companyName,
      this.groupSupplierId,
      this.storeId,
      this.note,
      this.createdAt,
      this.groupSupplier,
      this.province,
      this.district,
      this.ward});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    code = json['code'];
    taxCode = json['taxCode'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    address = json['address'];
    companyName = json['companyName'];
    groupSupplierId = json['groupSupplierId'];
    storeId = json['storeId'];
    note = json['note'];
    createdAt = json['createdAt'];
    groupSupplier = json['groupSupplier'] != null ? GroupSupplier.fromJson(json['groupSupplier']) : null;
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
    district = json['district'] != null ? Province.fromJson(json['district']) : null;
    ward = json['ward'] != null ? Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['code'] = code;
    data['taxCode'] = taxCode;
    data['provinceId'] = provinceId;
    data['districtId'] = districtId;
    data['wardId'] = wardId;
    data['address'] = address;
    data['companyName'] = companyName;
    data['groupSupplierId'] = groupSupplierId;
    data['storeId'] = storeId;
    data['note'] = note;
    data['createdAt'] = createdAt;
    if (groupSupplier != null) {
      data['groupSupplier'] = groupSupplier!.toJson();
    }
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (ward != null) {
      data['ward'] = ward!.toJson();
    }
    return data;
  }
}

class GroupSupplier {
  int? id;
  String? name;
  String? description;
  int? storeId;

  GroupSupplier({this.id, this.name, this.description, this.storeId});

  GroupSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['storeId'] = storeId;
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Products {
  int? id;
  int? productId;
  int? inboundId;
  int? discount;
  int? price;
  int? quantity;
  Product? product;
  List<ProductBatchHistories>? productBatchHistories;

  Products({this.id, this.productId, this.inboundId, this.product, this.productBatchHistories});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = json['discount'];
    quantity = json['quantity'];
    price = json['price'];
    productId = json['productId'];
    inboundId = json['inboundId'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['productBatchHistories'] != null) {
      productBatchHistories = <ProductBatchHistories>[];
      json['productBatchHistories'].forEach((v) {
        productBatchHistories!.add(ProductBatchHistories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['inboundId'] = inboundId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (productBatchHistories != null) {
      data['productBatchHistories'] = productBatchHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? name;
  String? shortName;
  String? code;
  String? barCode;
  int? imageId;
  bool? isBatchExpireControl;
  ImageModel? image;

  Product({this.name, this.shortName, this.code, this.barCode, this.imageId, this.isBatchExpireControl, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['shortName'];
    code = json['code'];
    barCode = json['barCode'];
    imageId = json['imageId'];
    isBatchExpireControl = json['isBatchExpireControl'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['shortName'] = shortName;
    data['code'] = code;
    data['barCode'] = barCode;
    data['imageId'] = imageId;
    data['isBatchExpireControl'] = isBatchExpireControl;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class ProductBatchHistories {
  int? id;
  int? storeId;
  int? branchId;
  int? productId;
  int? batchId;
  int? productUnitId;
  int? quantity;
  String? expiryDate;
  int? importPrice;
  int? discount;
  int? totalPrice;
  BatchModel? batch;
  ProductUnit? productUnit;

  ProductBatchHistories(
      {this.id,
      this.storeId,
      this.branchId,
      this.productId,
      this.batchId,
      this.productUnitId,
      this.quantity,
      this.expiryDate,
      this.importPrice,
      this.discount,
      this.totalPrice,
      this.batch,
      this.productUnit});

  ProductBatchHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    productId = json['productId'];
    batchId = json['batchId'];
    productUnitId = json['productUnitId'];
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
    importPrice = json['importPrice'];
    discount = json['discount'];
    totalPrice = json['totalPrice'];
    batch = json['batch'] != null ? BatchModel.fromJson(json['batch']) : null;
    productUnit = json['productUnit'] != null ? ProductUnit.fromJson(json['productUnit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['branchId'] = branchId;
    data['productId'] = productId;
    data['batchId'] = batchId;
    data['productUnitId'] = productUnitId;
    data['quantity'] = quantity;
    data['expiryDate'] = expiryDate;
    data['importPrice'] = importPrice;
    data['discount'] = discount;
    data['totalPrice'] = totalPrice;
    if (batch != null) {
      data['batch'] = batch!.toJson();
    }
    if (productUnit != null) {
      data['productUnit'] = productUnit!.toJson();
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

  ProductUnit({this.id, this.unitName, this.exchangeValue, this.price, this.isBaseUnit});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unitName'];
    exchangeValue = json['exchangeValue'];
    price = json['price'];
    isBaseUnit = json['isBaseUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unitName'] = unitName;
    data['exchangeValue'] = exchangeValue;
    data['price'] = price;
    data['isBaseUnit'] = isBaseUnit;
    return data;
  }
}
