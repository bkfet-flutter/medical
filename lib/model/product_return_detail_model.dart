class ProductReturnDetailModel {
  PurchaseReturn? purchaseReturn;
  List<Products>? products;

  ProductReturnDetailModel({this.purchaseReturn, this.products});

  ProductReturnDetailModel.fromJson(Map<String, dynamic> json) {
    purchaseReturn = json['purchaseReturn'] != null
        ? new PurchaseReturn.fromJson(json['purchaseReturn'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchaseReturn != null) {
      data['purchaseReturn'] = this.purchaseReturn!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseReturn {
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

  PurchaseReturn(
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

  PurchaseReturn.fromJson(Map<String, dynamic> json) {
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
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    creator =
        json['creator'] != null ? new User.fromJson(json['creator']) : null;
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['totalPrice'] = this.totalPrice;
    data['paid'] = this.paid;
    data['debt'] = this.debt;
    data['discount'] = this.discount;
    data['supplierId'] = this.supplierId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
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

  Branch(
      {this.id,
      this.name,
      this.phone,
      this.code,
      this.zipCode,
      this.isDefaultBranch});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    zipCode = json['zipCode'];
    isDefaultBranch = json['isDefaultBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['zipCode'] = this.zipCode;
    data['isDefaultBranch'] = this.isDefaultBranch;
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

  User(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.avatarId,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['avatarId'] = this.avatarId;
    data['phone'] = this.phone;
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
  // Null? province;
  // Null? district;
  // Null? ward;

  Supplier({
    this.id,
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
    // this.province,
    // this.district,
    // this.ward,
  });

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
    groupSupplier = json['groupSupplier'] != null
        ? new GroupSupplier.fromJson(json['groupSupplier'])
        : null;
    // province = json['province'];
    // district = json['district'];
    // ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['code'] = this.code;
    data['taxCode'] = this.taxCode;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['address'] = this.address;
    data['companyName'] = this.companyName;
    data['groupSupplierId'] = this.groupSupplierId;
    data['storeId'] = this.storeId;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    if (this.groupSupplier != null) {
      data['groupSupplier'] = this.groupSupplier!.toJson();
    }
    // data['province'] = this.province;
    // data['district'] = this.district;
    // data['ward'] = this.ward;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['storeId'] = this.storeId;
    return data;
  }
}

class Products {
  int? id;
  int? productId;
  int? purchaseReturnId;
  int? quantity;
  String? importPrice;
  int? discount;
  int? totalPrice;
  int? productUnitId;
  Product? product;
  ProductUnit? productUnit;
  // List<Null>? batches;

  Products({
    this.id,
    this.productId,
    this.purchaseReturnId,
    this.quantity,
    this.importPrice,
    this.discount,
    this.totalPrice,
    this.productUnitId,
    this.product,
    this.productUnit,
    // this.batches,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    purchaseReturnId = json['purchaseReturnId'];
    quantity = json['quantity'];
    importPrice = json['importPrice'];
    discount = json['discount'];
    totalPrice = json['totalPrice'];
    productUnitId = json['productUnitId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productUnit = json['productUnit'] != null
        ? new ProductUnit.fromJson(json['productUnit'])
        : null;
    // if (json['batches'] != null) {
    //   batches = <Null>[];
    //   json['batches'].forEach((v) {
    //     batches!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['purchaseReturnId'] = this.purchaseReturnId;
    data['quantity'] = this.quantity;
    data['importPrice'] = this.importPrice;
    data['discount'] = this.discount;
    data['totalPrice'] = this.totalPrice;
    data['productUnitId'] = this.productUnitId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.toJson();
    }
    // if (this.batches != null) {
    //   data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? shortName;
  String? code;
  String? barCode;
  // Null? imageId;
  bool? isBatchExpireControl;
  // Null? image;

  Product({
    this.id,
    this.name,
    this.shortName,
    this.code,
    this.barCode,
    // this.imageId,
    this.isBatchExpireControl,
    // this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    code = json['code'];
    barCode = json['barCode'];
    // imageId = json['imageId'];
    isBatchExpireControl = json['isBatchExpireControl'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    // data['imageId'] = this.imageId;
    data['isBatchExpireControl'] = this.isBatchExpireControl;
    // data['image'] = this.image;
    return data;
  }
}

class ProductUnit {
  int? id;
  int? exchangeValue;
  String? unitName;
  int? price;
  String? code;
  String? barCode;
  bool? isBaseUnit;

  ProductUnit(
      {this.id,
      this.exchangeValue,
      this.unitName,
      this.price,
      this.code,
      this.barCode,
      this.isBaseUnit});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exchangeValue = json['exchangeValue'];
    unitName = json['unitName'];
    price = json['price'];
    code = json['code'];
    barCode = json['barCode'];
    isBaseUnit = json['isBaseUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exchangeValue'] = this.exchangeValue;
    data['unitName'] = this.unitName;
    data['price'] = this.price;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['isBaseUnit'] = this.isBaseUnit;
    return data;
  }
}
