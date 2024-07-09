import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mephar_app/model/batch_model.dart';
import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/model/product_model.dart';

import 'config/store_model.dart';

class InboundModel {
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
  int? storeId;
  int? branchId;
  ProductModel? product;
  StoreModel? store;
  BranchModel? branch;
  num? quantity;
  List<BatchModel>? batches;
  List<ProductUnit>? unit;
  List<BatchForSale>? batchesForSale;
  ProductUnit? productUnit;
  num? totalAmount;
  TextEditingController? quantityController;
  TextEditingController? discountController;
  TextEditingController? priceController;
  TextEditingController? dosageController;
  TextEditingController? priceUnitController;
  bool? isSelected;
  int? productUnitId;

  InboundModel({
    this.id,
    this.unitName,
    this.exchangeValue,
    this.price,
    this.productId,
    this.code,
    this.barCode,
    this.isDirectSale,
    this.isBaseUnit,
    this.point,
    this.storeId,
    this.branchId,
    this.product,
    this.store,
    this.branch,
    this.unit,
    this.batchesForSale,
    this.priceUnitController,
    this.quantity,
    this.productUnitId,
    this.productUnit,
  });

  InboundModel.fromJson(Map<String, dynamic> json) {
    batches = [];
    isSelected = false;
    quantityController = TextEditingController(text: "1");
    discountController = TextEditingController(text: "0");
    dosageController = TextEditingController(text: "");
    priceController = TextEditingController(text: (json['product']['primePrice'] ?? "0").toString());
    priceUnitController = TextEditingController(text: "");

    totalAmount = json['product']['primePrice'];
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
    storeId = json['storeId'];
    branchId = json['branchId'];
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    productUnit = json['productUnit'] != null ? ProductUnit.fromJson(json['productUnit']) : null;
    if (json['batches'] != null) {
      batchesForSale = <BatchForSale>[];
      json['batches'].forEach((v) {
        batchesForSale!.add(BatchForSale.fromJson(v));
      });
    }
    if (json['product']['productUnit'] != null) {
      unit = <ProductUnit>[];
      json['product']['productUnit'].forEach((v) {
        unit!.add(ProductUnit.fromJson(v));
      });
    }
    quantity = json['quantity'];
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
    data['storeId'] = storeId;
    data['branchId'] = branchId;
    data['productUnit'] = productUnit;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['quantity'] = quantity;
    return data;
  }
}

class BatchForSale {
  int? id;
  String? name;
  int? quantity;
  String? expiryDate;
  bool? isSelected;
  TextEditingController? batchQuantityController;

  BatchForSale({
    this.id,
    this.name,
    this.quantity,
    this.expiryDate,
  });

  BatchForSale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSelected = false;
    batchQuantityController = TextEditingController();
    name = json['name'];
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}
