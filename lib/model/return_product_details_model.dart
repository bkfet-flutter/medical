import 'package:mephar_app/model/config/branch_model.dart';
import 'package:mephar_app/model/config/store_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/model/product_model.dart';
import 'package:mephar_app/model/supplier_model.dart';

import 'batch_model.dart';

class ReturnProductDetailsModel {
  PurchaseReturn? _purchaseReturn;
  List<ProductReturnDetails>? _products;

  ReturnProductDetailsModel({PurchaseReturn? purchaseReturn, List<ProductReturnDetails>? products}) {
    if (purchaseReturn != null) {
      _purchaseReturn = purchaseReturn;
    }
    if (products != null) {
      _products = products;
    }
  }

  PurchaseReturn? get purchaseReturn => _purchaseReturn;

  set purchaseReturn(PurchaseReturn? purchaseReturn) => _purchaseReturn = purchaseReturn;

  List<ProductReturnDetails>? get products => _products;

  set products(List<ProductReturnDetails>? products) => _products = products;

  ReturnProductDetailsModel.fromJson(Map<String, dynamic> json) {
    _purchaseReturn = json['purchaseReturn'] != null ? PurchaseReturn.fromJson(json['purchaseReturn']) : null;
    if (json['products'] != null) {
      _products = <ProductReturnDetails>[];
      json['products'].forEach((v) {
        _products!.add(ProductReturnDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_purchaseReturn != null) {
      data['purchaseReturn'] = _purchaseReturn!.toJson();
    }
    if (_products != null) {
      data['products'] = _products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseReturn {
  int? _id;
  String? _code;
  String? _description;
  int? _userId;
  int? _storeId;
  int? _branchId;
  int? _totalPrice;
  int? _paid;
  int? _debt;
  int? _discount;
  int? _supplierId;
  String? _status;
  String? _createdAt;
  StoreModel? _store;
  BranchModel? _branch;
  UserModel? _user;
  UserModel? _creator;
  SupplierModel? _supplier;

  PurchaseReturn(
      {int? id,
      String? code,
      String? description,
      int? userId,
      int? storeId,
      int? branchId,
      int? totalPrice,
      int? paid,
      int? debt,
      int? discount,
      int? supplierId,
      String? status,
      String? createdAt,
      StoreModel? store,
      BranchModel? branch,
      UserModel? user,
      UserModel? creator,
      SupplierModel? supplier}) {
    if (id != null) {
      _id = id;
    }
    if (code != null) {
      _code = code;
    }
    if (description != null) {
      _description = description;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (storeId != null) {
      _storeId = storeId;
    }
    if (branchId != null) {
      _branchId = branchId;
    }
    if (totalPrice != null) {
      _totalPrice = totalPrice;
    }
    if (paid != null) {
      _paid = paid;
    }
    if (debt != null) {
      _debt = debt;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (supplierId != null) {
      _supplierId = supplierId;
    }
    if (status != null) {
      _status = status;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (store != null) {
      _store = store;
    }
    if (branch != null) {
      _branch = branch;
    }
    if (user != null) {
      _user = user;
    }
    if (creator != null) {
      _creator = creator;
    }
    if (supplier != null) {
      _supplier = supplier;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get code => _code;

  set code(String? code) => _code = code;

  String? get description => _description;

  set description(String? description) => _description = description;

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  int? get storeId => _storeId;

  set storeId(int? storeId) => _storeId = storeId;

  int? get branchId => _branchId;

  set branchId(int? branchId) => _branchId = branchId;

  int? get totalPrice => _totalPrice;

  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;

  int? get paid => _paid;

  set paid(int? paid) => _paid = paid;

  int? get debt => _debt;

  set debt(int? debt) => _debt = debt;

  int? get discount => _discount;

  set discount(int? discount) => _discount = discount;

  int? get supplierId => _supplierId;

  set supplierId(int? supplierId) => _supplierId = supplierId;

  String? get status => _status;

  set status(String? status) => _status = status;

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  StoreModel? get store => _store;

  set store(StoreModel? store) => _store = store;

  BranchModel? get branch => _branch;

  set branch(BranchModel? branch) => _branch = branch;

  UserModel? get user => _user;

  set user(UserModel? user) => _user = user;

  UserModel? get creator => _creator;

  set creator(UserModel? creator) => _creator = creator;

  SupplierModel? get supplier => _supplier;

  set supplier(SupplierModel? supplier) => _supplier = supplier;

  PurchaseReturn.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _code = json['code'];
    _description = json['description'];
    _userId = json['userId'];
    _storeId = json['storeId'];
    _branchId = json['branchId'];
    _totalPrice = json['totalPrice'];
    _paid = json['paid'];
    _debt = json['debt'];
    _discount = json['discount'];
    _supplierId = json['supplierId'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    _branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    _creator = json['creator'] != null ? UserModel.fromJson(json['creator']) : null;
    _supplier = json['supplier'] != null ? SupplierModel.fromJson(json['supplier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['code'] = _code;
    data['description'] = _description;
    data['userId'] = _userId;
    data['storeId'] = _storeId;
    data['branchId'] = _branchId;
    data['totalPrice'] = _totalPrice;
    data['paid'] = _paid;
    data['debt'] = _debt;
    data['discount'] = _discount;
    data['supplierId'] = _supplierId;
    data['status'] = _status;
    data['createdAt'] = _createdAt;
    if (_store != null) {
      data['store'] = _store!.toJson();
    }
    if (_branch != null) {
      data['branch'] = _branch!.toJson();
    }
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    if (_creator != null) {
      data['creator'] = _creator!.toJson();
    }
    if (_supplier != null) {
      data['supplier'] = _supplier!.toJson();
    }
    return data;
  }
}

class ProductReturnDetails {
  int? _id;
  int? _productId;
  int? _purchaseReturnId;
  int? _quantity;
  String? _importPrice;
  int? _discount;
  int? _totalPrice;
  int? _productUnitId;
  ProductModel? _product;
  ProductUnit? _productUnit;
  List<Batches>? _batches;

  ProductReturnDetails(
      {int? id,
      int? productId,
      int? purchaseReturnId,
      int? quantity,
      String? importPrice,
      int? discount,
      int? totalPrice,
      int? productUnitId,
      ProductModel? product,
      ProductUnit? productUnit,
      List<Batches>? batches}) {
    if (id != null) {
      _id = id;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (purchaseReturnId != null) {
      _purchaseReturnId = purchaseReturnId;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (importPrice != null) {
      _importPrice = importPrice;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (totalPrice != null) {
      _totalPrice = totalPrice;
    }
    if (productUnitId != null) {
      _productUnitId = productUnitId;
    }
    if (product != null) {
      _product = product;
    }
    if (productUnit != null) {
      _productUnit = productUnit;
    }
    if (batches != null) {
      _batches = batches;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  int? get productId => _productId;

  set productId(int? productId) => _productId = productId;

  int? get purchaseReturnId => _purchaseReturnId;

  set purchaseReturnId(int? purchaseReturnId) => _purchaseReturnId = purchaseReturnId;

  int? get quantity => _quantity;

  set quantity(int? quantity) => _quantity = quantity;

  String? get importPrice => _importPrice;

  set importPrice(String? importPrice) => _importPrice = importPrice;

  int? get discount => _discount;

  set discount(int? discount) => _discount = discount;

  int? get totalPrice => _totalPrice;

  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;

  int? get productUnitId => _productUnitId;

  set productUnitId(int? productUnitId) => _productUnitId = productUnitId;

  ProductModel? get product => _product;

  set product(ProductModel? product) => _product = product;

  ProductUnit? get productUnit => _productUnit;

  set productUnit(ProductUnit? productUnit) => _productUnit = productUnit;

  List<Batches>? get batches => _batches;

  set batches(List<Batches>? batches) => _batches = batches;

  ProductReturnDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['productId'];
    _purchaseReturnId = json['purchaseReturnId'];
    _quantity = json['quantity'];
    _importPrice = json['importPrice'];
    _discount = json['discount'];
    _totalPrice = json['totalPrice'];
    _productUnitId = json['productUnitId'];
    _product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    _productUnit = json['productUnit'] != null ? ProductUnit.fromJson(json['productUnit']) : null;
    if (json['batches'] != null) {
      _batches = <Batches>[];
      json['batches'].forEach((v) {
        _batches!.add(Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['productId'] = _productId;
    data['purchaseReturnId'] = _purchaseReturnId;
    data['quantity'] = _quantity;
    data['importPrice'] = _importPrice;
    data['discount'] = _discount;
    data['totalPrice'] = _totalPrice;
    data['productUnitId'] = _productUnitId;
    if (_product != null) {
      data['product'] = _product!.toJson();
    }
    if (_productUnit != null) {
      data['productUnit'] = _productUnit!.toJson();
    }
    if (_batches != null) {
      data['batches'] = _batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int? _id;
  int? _batchId;
  int? _quantity;
  BatchModel? _batch;

  Batches({int? id, int? batchId, int? quantity, BatchModel? batch}) {
    if (id != null) {
      _id = id;
    }
    if (batchId != null) {
      _batchId = batchId;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (batch != null) {
      _batch = batch;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  int? get batchId => _batchId;

  set batchId(int? batchId) => _batchId = batchId;

  int? get quantity => _quantity;

  set quantity(int? quantity) => _quantity = quantity;

  BatchModel? get batch => _batch;

  set batch(BatchModel? batch) => _batch = batch;

  Batches.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _batchId = json['batchId'];
    _quantity = json['quantity'];
    _batch = json['batch'] != null ? BatchModel.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['batchId'] = _batchId;
    data['quantity'] = _quantity;
    if (_batch != null) {
      data['batch'] = _batch!.toJson();
    }
    return data;
  }
}
