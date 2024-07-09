import 'package:mephar_app/model/dosage_model.dart';
import 'package:mephar_app/model/image_model.dart';

class SampleProductModel {
  int? id;
  String? name;
  String? shortName;
  String? code;
  String? barCode;
  int? groupProductId;
  int? productCategoryId;
  int? imageId;
  int? dosageId;
  int? manufactureId;
  int? positionId;
  int? countryId;
  int? primePrice;
  int? price;
  String? weight;
  // Null? warningExpiryDate;
  // Null? warningExpiryText;
  bool? isDirectSale;
  // Null? registerNumber;
  // Null? activeElement;
  // Null? content;
  // Null? packingSpecification;
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
  ImageModel? image;
  Store? store;
  Branch? branch;
  ProductManufacture? productManufacture;
  DosageModel? productDosage;
  ProductManufacture? productPosition;
  // Null? country;
  ProductManufacture? groupProduct;
  // Null? productCategory;
  List<ProductUnit>? productUnit;
  // List<Null>? batches;

  SampleProductModel({
    this.id,
    this.name,
    this.shortName,
    this.code,
    this.barCode,
    this.groupProductId,
    this.productCategoryId,
    this.imageId,
    this.dosageId,
    this.manufactureId,
    this.positionId,
    this.countryId,
    this.primePrice,
    this.price,
    this.weight,
    // this.warningExpiryDate,
    // this.warningExpiryText,
    this.isDirectSale,
    // this.registerNumber,
    // this.activeElement,
    // this.content,
    // this.packingSpecification,
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
    this.image,
    this.store,
    this.branch,
    this.productManufacture,
    this.productDosage,
    this.productPosition,
    // this.country,
    this.groupProduct,
    // this.productCategory,
    this.productUnit,
    // this.batches
  });

  SampleProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    code = json['code'];
    barCode = json['barCode'];
    groupProductId = json['groupProductId'];
    productCategoryId = json['productCategoryId'];
    imageId = json['imageId'];
    dosageId = json['dosageId'];
    manufactureId = json['manufactureId'];
    positionId = json['positionId'];
    countryId = json['countryId'];
    primePrice = json['primePrice'];
    price = json['price'];
    weight = json['weight'];
    // warningExpiryDate = json['warningExpiryDate'];
    // warningExpiryText = json['warningExpiryText'];
    isDirectSale = json['isDirectSale'];
    // registerNumber = json['registerNumber'];
    // activeElement = json['activeElement'];
    // content = json['content'];
    // packingSpecification = json['packingSpecification'];
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
    image =
        json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    productManufacture = json['productManufacture'] != null
        ? new ProductManufacture.fromJson(json['productManufacture'])
        : null;
    productDosage = json['productDosage'];
    productPosition = json['productPosition'] != null
        ? new ProductManufacture.fromJson(json['productPosition'])
        : null;
    // country = json['country'];
    groupProduct = json['groupProduct'] != null
        ? new ProductManufacture.fromJson(json['groupProduct'])
        : null;
    // productCategory = json['productCategory'];
    if (json['productUnit'] != null) {
      productUnit = <ProductUnit>[];
      json['productUnit'].forEach((v) {
        productUnit!.add(new ProductUnit.fromJson(v));
      });
    }
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
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['groupProductId'] = this.groupProductId;
    data['productCategoryId'] = this.productCategoryId;
    data['imageId'] = this.imageId;
    data['dosageId'] = this.dosageId;
    data['manufactureId'] = this.manufactureId;
    data['positionId'] = this.positionId;
    data['countryId'] = this.countryId;
    data['primePrice'] = this.primePrice;
    data['price'] = this.price;
    data['weight'] = this.weight;
    // data['warningExpiryDate'] = this.warningExpiryDate;
    // data['warningExpiryText'] = this.warningExpiryText;
    data['isDirectSale'] = this.isDirectSale;
    // data['registerNumber'] = this.registerNumber;
    // data['activeElement'] = this.activeElement;
    // data['content'] = this.content;
    // data['packingSpecification'] = this.packingSpecification;
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
    data['image'] = this.image;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.productManufacture != null) {
      data['productManufacture'] = this.productManufacture!.toJson();
    }
    data['productDosage'] = this.productDosage;
    if (this.productPosition != null) {
      data['productPosition'] = this.productPosition!.toJson();
    }
    // data['country'] = this.country;
    if (this.groupProduct != null) {
      data['groupProduct'] = this.groupProduct!.toJson();
    }
    // data['productCategory'] = this.productCategory;
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.map((v) => v.toJson()).toList();
    }
    // if (this.batches != null) {
    //   data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    // }
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

class ProductManufacture {
  int? id;
  String? name;

  ProductManufacture({this.id, this.name});

  ProductManufacture.fromJson(Map<String, dynamic> json) {
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

class ProductUnit {
  int? id;
  String? unitName;
  int? exchangeValue;
  int? price;
  int? productId;
  int? quantity;
  String? code;
  String? barCode;
  bool? isDirectSale;
  bool? isBaseUnit;
  int? point;

  ProductUnit(
      {this.id,
      this.unitName,
      this.exchangeValue,
      this.price,
      this.productId,
      this.quantity,
      this.code,
      this.barCode,
      this.isDirectSale,
      this.isBaseUnit,
      this.point});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unitName'];
    exchangeValue = json['exchangeValue'];
    price = json['price'];
    productId = json['productId'];
    quantity = json['quantity'];
    code = json['code'];
    barCode = json['barCode'];
    isDirectSale = json['isDirectSale'];
    isBaseUnit = json['isBaseUnit'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitName'] = this.unitName;
    data['exchangeValue'] = this.exchangeValue;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['isDirectSale'] = this.isDirectSale;
    data['isBaseUnit'] = this.isBaseUnit;
    data['point'] = this.point;
    return data;
  }
}
