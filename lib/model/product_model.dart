import 'package:mephar_app/model/config/province_model.dart';

import 'config/branch_model.dart';
import 'config/store_model.dart';
import 'image_model.dart';

class ProductModel {
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
  String? warningExpiryDate;
  String? warningExpiryText;
  bool? isDirectSale;
  String? registerNumber;
  String? activeElement;
  String? content;
  String? packingSpecification;
  int? minInventory;
  int? maxInventory;
  String? description;
  String? note;
  String? baseUnit;
  int? inventory;
  int? quantitySold;
  int? storeId;
  int? branchId;
  int? type;
  int? expiryPeriod;
  bool? isLoyaltyPoint;
  bool? isBatchExpireControl;
  int? status;
  String? createdAt;
  ImageModel? image;
  StoreModel? store;
  BranchModel? branch;
  ProductManufacture? productManufacture;
  ProvinceModel? country;
  ProductManufacture? productDosage;
  ProductManufacture? productPosition;
  ProductManufacture? groupProduct;

  // Null? productCategory;
  List<ProductUnit>? productUnit;

  ProductModel(
      {this.id,
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
      this.warningExpiryDate,
      this.warningExpiryText,
      this.isDirectSale,
      this.registerNumber,
      this.activeElement,
      this.content,
      this.packingSpecification,
      this.minInventory,
      this.maxInventory,
      this.description,
      this.note,
      this.baseUnit,
      this.inventory,
      this.quantitySold,
      this.storeId,
      this.branchId,
      this.type,
      this.isLoyaltyPoint,
      this.status,
      this.createdAt,
      this.image,
      this.store,
      this.branch,
      this.isBatchExpireControl,
      this.productManufacture,
      this.productDosage,
      this.productPosition,
      this.country,
      this.groupProduct,
      this.expiryPeriod,
      // this.productCategory,
      this.productUnit});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isBatchExpireControl = json['isBatchExpireControl'];
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
    expiryPeriod = json['expiryPeriod'];
    warningExpiryDate = json['warningExpiryDate'];
    warningExpiryText = json['warningExpiryText'];
    isDirectSale = json['isDirectSale'];
    registerNumber = json['registerNumber'];
    activeElement = json['activeElement'];
    content = json['content'];
    packingSpecification = json['packingSpecification'];
    minInventory = json['minInventory'];
    maxInventory = json['maxInventory'];
    description = json['description'];
    note = json['note'];
    baseUnit = json['baseUnit'];
    inventory = json['inventory'];
    quantitySold = json['quantitySold'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    type = json['type'];
    isLoyaltyPoint = json['isLoyaltyPoint'];
    status = json['status'];
    createdAt = json['createdAt'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    productManufacture =
        json['productManufacture'] != null ? ProductManufacture.fromJson(json['productManufacture']) : null;
    productDosage = json['productDosage'] != null ? ProductManufacture.fromJson(json['productDosage']) : null;
    productPosition = json['productPosition'] != null ? ProductManufacture.fromJson(json['productPosition']) : null;
    groupProduct = json['groupProduct'] != null ? ProductManufacture.fromJson(json['groupProduct']) : null;
    country = json['country'] != null ? ProvinceModel.fromJson(json['country']) : null;
    //productCategory = json['productCategory'];
    if (json['productUnit'] != null) {
      productUnit = <ProductUnit>[];
      json['productUnit'].forEach((v) {
        productUnit!.add(ProductUnit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['code'] = code;
    data['barCode'] = barCode;
    data['groupProductId'] = groupProductId;
    data['productCategoryId'] = productCategoryId;
    data['imageId'] = imageId;
    data['dosageId'] = dosageId;
    data['manufactureId'] = manufactureId;
    data['positionId'] = positionId;
    data['countryId'] = countryId;
    data['primePrice'] = primePrice;
    data['price'] = price;
    data['expiryPeriod'] = expiryPeriod;
    data['weight'] = weight;
    data['warningExpiryDate'] = warningExpiryDate;
    data['warningExpiryText'] = warningExpiryText;
    data['isDirectSale'] = isDirectSale;
    data['registerNumber'] = registerNumber;
    data['activeElement'] = activeElement;
    data['content'] = content;
    data['packingSpecification'] = packingSpecification;
    data['minInventory'] = minInventory;
    data['maxInventory'] = maxInventory;
    data['description'] = description;
    data['note'] = note;
    data['baseUnit'] = baseUnit;
    data['inventory'] = inventory;
    data['quantitySold'] = quantitySold;
    data['storeId'] = storeId;
    data['branchId'] = branchId;
    data['type'] = type;
    data['isLoyaltyPoint'] = isLoyaltyPoint;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['isBatchExpireControl'] = isBatchExpireControl;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (productManufacture != null) {
      data['productManufacture'] = productManufacture!.toJson();
    }
    if (productDosage != null) {
      data['productDosage'] = productDosage!.toJson();
    }
    if (productPosition != null) {
      data['productPosition'] = productPosition!.toJson();
    }
    if (groupProduct != null) {
      data['groupProduct'] = groupProduct!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    // data['productCategory'] = this.productCategory;
    if (productUnit != null) {
      data['productUnit'] = productUnit!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProductUnit {
  int? id;
  String? unitName;
  int? exchangeValue;
  int? price;
  int? productId;
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
    code = json['code'];
    barCode = json['barCode'];
    isDirectSale = json['isDirectSale'];
    isBaseUnit = json['isBaseUnit'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unitName'] = unitName;
    data['exchangeValue'] = exchangeValue;
    data['price'] = price;
    data['productId'] = productId;
    data['code'] = code;
    data['barCode'] = barCode;
    data['isDirectSale'] = isDirectSale;
    data['isBaseUnit'] = isBaseUnit;
    data['point'] = point;
    return data;
  }
}
