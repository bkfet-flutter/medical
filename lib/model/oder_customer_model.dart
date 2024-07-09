class OderCustomerModel {
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
  int? discountType;
  bool? isVatInvoice;
  String? status;
  String? createdAt;
  // Null? prescription;
  Store? store;
  Branch? branch;
  User? user;
  Customer? customer;
  List<Products>? products;
  int? totalProducts;
  int? totalQuantities;

  OderCustomerModel({
    this.id,
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
    this.discountType,
    this.isVatInvoice,
    this.status,
    this.createdAt,
    // this.prescription,
    this.store,
    this.branch,
    this.user,
    this.customer,
    this.products,
    this.totalProducts,
    this.totalQuantities,
  });

  OderCustomerModel.fromJson(Map<String, dynamic> json) {
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
    discountType = json['discountType'];
    isVatInvoice = json['isVatInvoice'];
    status = json['status'];
    createdAt = json['createdAt'];
    // prescription = json['prescription'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
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
    data['discountType'] = this.discountType;
    data['isVatInvoice'] = this.isVatInvoice;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    // data['prescription'] = this.prescription;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? phone;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? address;
  String? createdAt;
  Province? province;
  Province? district;
  Province? ward;

  Store(
      {this.id,
      this.name,
      this.phone,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.address,
      this.createdAt,
      this.province,
      this.district,
      this.ward});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    address = json['address'];
    createdAt = json['createdAt'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new Province.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.ward != null) {
      data['ward'] = this.ward!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
  Province? province;
  Province? district;
  Province? ward;

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
      this.createdAt,
      this.province,
      this.district,
      this.ward});

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
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new Province.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
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
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.ward != null) {
      data['ward'] = this.ward!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? fullName;
  // Null? avatarId;
  // Null? birthday;
  String? gender;
  String? phone;
  int? roleId;
  String? position;
  String? lastLoginAt;
  String? status;
  // Null? avatar;

  User({
    this.id,
    this.username,
    this.email,
    this.fullName,
    // this.avatarId,
    // this.birthday,
    this.gender,
    this.phone,
    this.roleId,
    this.position,
    this.lastLoginAt,
    this.status,
    // this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    // avatarId = json['avatarId'];
    // birthday = json['birthday'];
    gender = json['gender'];
    phone = json['phone'];
    roleId = json['roleId'];
    position = json['position'];
    lastLoginAt = json['lastLoginAt'];
    status = json['status'];
    // avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    // data['avatarId'] = this.avatarId;
    // data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['position'] = this.position;
    data['lastLoginAt'] = this.lastLoginAt;
    data['status'] = this.status;
    // data['avatar'] = this.avatar;
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
  Province? province;
  Province? district;
  Province? ward;

  Customer(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.address,
      this.groupCustomerId,
      this.province,
      this.district,
      this.ward});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    groupCustomerId = json['groupCustomerId'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new Province.fromJson(json['district'])
        : null;
    ward = json['ward'] != null ? new Province.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['groupCustomerId'] = this.groupCustomerId;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.ward != null) {
      data['ward'] = this.ward!.toJson();
    }
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
  // Null? comboId;
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
      // this.comboId,
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
    // comboId = json['comboId'];
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
    // data['comboId'] = this.comboId;
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
  Image? image;

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
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['imageId'] = this.imageId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  String? filePath;
  int? id;
  String? originalName;
  String? fileName;
  String? path;

  Image({this.filePath, this.id, this.originalName, this.fileName, this.path});

  Image.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    id = json['id'];
    originalName = json['originalName'];
    fileName = json['fileName'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filePath'] = this.filePath;
    data['id'] = this.id;
    data['originalName'] = this.originalName;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    return data;
  }
}
