import 'package:mephar_app/model/move_items_model.dart';

class ShippingModel {
  int? id;
  String? code;
  int? fromBranchId;
  int? toBranchId;
  String? movedAt;
  int? movedBy;
  String? receivedAt;
  int? receivedBy;
  String? status;
  int? totalPrice;
  String? note;
  int? totalItem;
  FromBranch? fromBranch;
  FromBranch? toBranch;
  List<Items>? items;
  MovedByUser? movedByUser;
  ShippingModel(
      {this.id,
      this.code,
      this.fromBranchId,
      this.toBranchId,
      this.movedAt,
      this.movedBy,
      this.receivedAt,
      this.receivedBy,
      this.status,
      this.totalPrice,
      this.note,
      this.totalItem,
      this.fromBranch,
      this.toBranch,
      this.movedByUser,
      this.items});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    fromBranchId = json['fromBranchId'];
    toBranchId = json['toBranchId'];
    movedAt = json['movedAt'];
    movedBy = json['movedBy'];
    receivedAt = json['receivedAt'];
    receivedBy = json['receivedBy'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    note = json['note'];
    totalItem = json['totalItem'];
    fromBranch = json['fromBranch'] != null
        ? new FromBranch.fromJson(json['fromBranch'])
        : null;
    movedByUser = json['movedByUser'] != null
        ? new MovedByUser.fromJson(json['movedByUser'])
        : null;
    toBranch = json['toBranch'] != null
        ? new FromBranch.fromJson(json['toBranch'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['fromBranchId'] = this.fromBranchId;
    data['toBranchId'] = this.toBranchId;
    data['movedAt'] = this.movedAt;
    data['movedBy'] = this.movedBy;
    data['receivedAt'] = this.receivedAt;
    data['receivedBy'] = this.receivedBy;
    data['status'] = this.status;
    data['totalPrice'] = this.totalPrice;
    data['note'] = this.note;
    data['totalItem'] = this.totalItem;
    if (this.fromBranch != null) {
      data['fromBranch'] = this.fromBranch!.toJson();
    }
    if (this.toBranch != null) {
      data['toBranch'] = this.toBranch!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FromBranch {
  int? id;
  String? name;

  FromBranch({this.id, this.name});

  FromBranch.fromJson(Map<String, dynamic> json) {
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

class MovedByUser {
  int? id;
  String? userName;
  String? fullName;

  MovedByUser({
    this.id,
    this.userName,
    this.fullName,
  });

  MovedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.userName;
    data['fullName'] = this.fullName;
    return data;
  }
}

class Items {
  int? id;
  int? quantity;
  // Null? toQuantity;
  int? price;
  ProductUnit? productUnit;
  Product? product;
  List<FromBatches>? fromBatches;
  List<ToBatches>? toBatches;

  Items(
      {this.id,
      this.quantity,
      // this.toQuantity,
      this.price,
      this.productUnit,
      this.product,
      this.fromBatches,
      this.toBatches});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    // toQuantity = json['toQuantity'];
    price = json['price'];
    productUnit = json['productUnit'] != null
        ? new ProductUnit.fromJson(json['productUnit'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['fromBatches'] != null) {
      fromBatches = <FromBatches>[];
      json['fromBatches'].forEach((v) {
        fromBatches!.add(new FromBatches.fromJson(v));
      });
    }
    if (json['toBatches'] != null) {
      toBatches = <ToBatches>[];
      json['toBatches'].forEach((v) {
        toBatches!.add(new ToBatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    // data['toQuantity'] = this.toQuantity;
    data['price'] = this.price;
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.fromBatches != null) {
      data['fromBatches'] = this.fromBatches!.map((v) => v.toJson()).toList();
    }
    if (this.toBatches != null) {
      data['toBatches'] = this.toBatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductUnit {
  int? id;
  String? unitName;
  int? exchangeValue;
  bool? isBaseUnit;

  ProductUnit({this.id, this.unitName, this.exchangeValue, this.isBaseUnit});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unitName'];
    exchangeValue = json['exchangeValue'];
    isBaseUnit = json['isBaseUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitName'] = this.unitName;
    data['exchangeValue'] = this.exchangeValue;
    data['isBaseUnit'] = this.isBaseUnit;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? shortName;
  String? code;
  String? barCode;
  // Null? groupProductId;
  // Null? productCategoryId;
  // Null? imageId;
  int? dosageId;
  int? manufactureId;
  // Null? positionId;
  int? countryId;
  int? primePrice;
  int? price;
  String? weight;
  // Null? warningExpiryDate;
  // Null? warningExpiryText;
  bool? isDirectSale;
  String? registerNumber;
  String? activeElement;
  String? content;
  String? packingSpecification;
  // Null? minInventory;
  // Null? maxInventory;
  String? description;
  String? note;
  String? baseUnit;
  int? inventory;
  int? quantitySold;
  int? storeId;
  int? branchId;
  int? type;
  bool? isLoyaltyPoint;
  bool? isBatchExpireControl;
  int? expiryPeriod;
  int? status;
  String? createdAt;
  String? drugCode;
  // Null? image;
  Store? store;
  FromBranch? productManufacture;
  FromBranch? productDosage;
  // Null? productPosition;
  FromBranch? country;
  // Null? groupProduct;
  // Null? productCategory;
  List<ProductUnit>? productUnit;

  Product(
      {this.id,
      this.name,
      this.shortName,
      this.code,
      this.barCode,
      // this.groupProductId,
      // this.productCategoryId,
      // this.imageId,
      this.dosageId,
      this.manufactureId,
      // this.positionId,
      this.countryId,
      this.primePrice,
      this.price,
      this.weight,
      // this.warningExpiryDate,
      // this.warningExpiryText,
      this.isDirectSale,
      this.registerNumber,
      this.activeElement,
      this.content,
      this.packingSpecification,
      // this.minInventory,
      // this.maxInventory,
      this.description,
      this.note,
      this.baseUnit,
      this.inventory,
      this.quantitySold,
      this.storeId,
      this.branchId,
      this.type,
      this.isLoyaltyPoint,
      this.isBatchExpireControl,
      this.expiryPeriod,
      this.status,
      this.createdAt,
      this.drugCode,
      // this.image,
      this.store,
      this.productManufacture,
      this.productDosage,
      // this.productPosition,
      this.country,
      // this.groupProduct,
      // this.productCategory,
      this.productUnit});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    code = json['code'];
    barCode = json['barCode'];
    // groupProductId = json['groupProductId'];
    // productCategoryId = json['productCategoryId'];
    // imageId = json['imageId'];
    dosageId = json['dosageId'];
    manufactureId = json['manufactureId'];
    // positionId = json['positionId'];
    countryId = json['countryId'];
    primePrice = json['primePrice'];
    price = json['price'];
    weight = json['weight'];
    // warningExpiryDate = json['warningExpiryDate'];
    // warningExpiryText = json['warningExpiryText'];
    isDirectSale = json['isDirectSale'];
    registerNumber = json['registerNumber'];
    activeElement = json['activeElement'];
    content = json['content'];
    packingSpecification = json['packingSpecification'];
    // minInventory = json['minInventory'];
    // maxInventory = json['maxInventory'];
    description = json['description'];
    note = json['note'];
    baseUnit = json['baseUnit'];
    inventory = json['inventory'];
    quantitySold = json['quantitySold'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    type = json['type'];
    isLoyaltyPoint = json['isLoyaltyPoint'];
    isBatchExpireControl = json['isBatchExpireControl'];
    expiryPeriod = json['expiryPeriod'];
    status = json['status'];
    createdAt = json['createdAt'];
    drugCode = json['drugCode'];
    // image = json['image'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    productManufacture = json['productManufacture'] != null
        ? new FromBranch.fromJson(json['productManufacture'])
        : null;
    productDosage = json['productDosage'] != null
        ? new FromBranch.fromJson(json['productDosage'])
        : null;
    // productPosition = json['productPosition'];
    country = json['country'] != null
        ? new FromBranch.fromJson(json['country'])
        : null;
    // groupProduct = json['groupProduct'];
    // productCategory = json['productCategory'];
    if (json['productUnit'] != null) {
      productUnit = <ProductUnit>[];
      json['productUnit'].forEach((v) {
        productUnit!.add(new ProductUnit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    // data['groupProductId'] = this.groupProductId;
    // data['productCategoryId'] = this.productCategoryId;
    // data['imageId'] = this.imageId;
    data['dosageId'] = this.dosageId;
    data['manufactureId'] = this.manufactureId;
    // data['positionId'] = this.positionId;
    data['countryId'] = this.countryId;
    data['primePrice'] = this.primePrice;
    data['price'] = this.price;
    data['weight'] = this.weight;
    // data['warningExpiryDate'] = this.warningExpiryDate;
    // data['warningExpiryText'] = this.warningExpiryText;
    data['isDirectSale'] = this.isDirectSale;
    data['registerNumber'] = this.registerNumber;
    data['activeElement'] = this.activeElement;
    data['content'] = this.content;
    data['packingSpecification'] = this.packingSpecification;
    // data['minInventory'] = this.minInventory;
    // data['maxInventory'] = this.maxInventory;
    data['description'] = this.description;
    data['note'] = this.note;
    data['baseUnit'] = this.baseUnit;
    data['inventory'] = this.inventory;
    data['quantitySold'] = this.quantitySold;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['type'] = this.type;
    data['isLoyaltyPoint'] = this.isLoyaltyPoint;
    data['isBatchExpireControl'] = this.isBatchExpireControl;
    data['expiryPeriod'] = this.expiryPeriod;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['drugCode'] = this.drugCode;
    // data['image'] = this.image;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.productManufacture != null) {
      data['productManufacture'] = this.productManufacture!.toJson();
    }
    if (this.productDosage != null) {
      data['productDosage'] = this.productDosage!.toJson();
    }
    // data['productPosition'] = this.productPosition;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    // data['groupProduct'] = this.groupProduct;
    // data['productCategory'] = this.productCategory;
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.map((v) => v.toJson()).toList();
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

  Store(
      {this.id,
      this.name,
      this.phone,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.address,
      this.createdAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    address = json['address'];
    createdAt = json['createdAt'];
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
    return data;
  }
}
