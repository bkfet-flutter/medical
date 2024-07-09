import 'package:mephar_app/model/batch_model.dart';

class ReturnProductModel {
  int? _branchId;
  int? _totalPrice;
  int? _userId;
  int? _supplierId;
  List<ProductReturns>? _products;
  int? _debt;
  String? _status;

  ReturnProductModel(
      {int? branchId,
      int? totalPrice,
      int? userId,
      int? supplierId,
      List<ProductReturns>? products,
      int? debt,
      String? status}) {
    if (branchId != null) {
      this._branchId = branchId;
    }
    if (totalPrice != null) {
      this._totalPrice = totalPrice;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (supplierId != null) {
      this._supplierId = supplierId;
    }
    if (products != null) {
      this._products = products;
    }
    if (debt != null) {
      this._debt = debt;
    }
    if (status != null) {
      this._status = status;
    }
  }

  int? get branchId => _branchId;

  set branchId(int? branchId) => _branchId = branchId;

  int? get totalPrice => _totalPrice;

  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;

  int? get userId => _userId;

  set userId(int? userId) => _userId = userId;

  int? get supplierId => _supplierId;

  set supplierId(int? supplierId) => _supplierId = supplierId;

  List<ProductReturns>? get products => _products;

  set products(List<ProductReturns>? products) => _products = products;

  int? get debt => _debt;

  set debt(int? debt) => _debt = debt;

  String? get status => _status;

  set status(String? status) => _status = status;

  ReturnProductModel.fromJson(Map<String, dynamic> json) {
    _branchId = json['branchId'];
    _totalPrice = json['totalPrice'];
    _userId = json['userId'];
    _supplierId = json['supplierId'];
    if (json['products'] != null) {
      _products = <ProductReturns>[];
      json['products'].forEach((v) {
        _products!.add(new ProductReturns.fromJson(v));
      });
    }
    _debt = json['debt'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchId'] = this._branchId;
    data['totalPrice'] = this._totalPrice;
    data['userId'] = this._userId;
    data['supplierId'] = this._supplierId;
    if (this._products != null) {
      data['products'] = this._products!.map((v) => v.toJson()).toList();
    }
    data['debt'] = this._debt;
    data['status'] = this._status;
    return data;
  }
}

class ProductReturns {
  int? _productId;
  int? _importPrice;
  int? _totalQuantity;
  int? _totalPrice;
  int? _discount;
  int? _productUnitId;
  List<BatchModel>? _batches;

  ProductReturns(
      {int? productId,
      int? importPrice,
      int? totalQuantity,
      int? totalPrice,
      int? discount,
      int? productUnitId,
      List<BatchModel>? batches}) {
    if (productId != null) {
      this._productId = productId;
    }
    if (importPrice != null) {
      this._importPrice = importPrice;
    }
    if (totalQuantity != null) {
      this._totalQuantity = totalQuantity;
    }
    if (totalPrice != null) {
      this._totalPrice = totalPrice;
    }
    if (discount != null) {
      this._discount = discount;
    }
    if (productUnitId != null) {
      this._productUnitId = productUnitId;
    }
    if (batches != null) {
      this._batches = batches;
    }
  }

  int? get productId => _productId;

  set productId(int? productId) => _productId = productId;

  int? get importPrice => _importPrice;

  set importPrice(int? importPrice) => _importPrice = importPrice;

  int? get totalQuantity => _totalQuantity;

  set totalQuantity(int? totalQuantity) => _totalQuantity = totalQuantity;

  int? get totalPrice => _totalPrice;

  set totalPrice(int? totalPrice) => _totalPrice = totalPrice;

  int? get discount => _discount;

  set discount(int? discount) => _discount = discount;

  int? get productUnitId => _productUnitId;

  set productUnitId(int? productUnitId) => _productUnitId = productUnitId;

  List<BatchModel>? get batches => _batches;

  set batches(List<BatchModel>? batches) => _batches = batches;

  ProductReturns.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _importPrice = json['importPrice'];
    _totalQuantity = json['totalQuantity'];
    _totalPrice = json['totalPrice'];
    _discount = json['discount'];
    _productUnitId = json['productUnitId'];
    if (json['batches'] != null) {
      _batches = <BatchModel>[];
      json['batches'].forEach((v) {
        _batches!.add(new BatchModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['importPrice'] = this._importPrice;
    data['totalQuantity'] = this._totalQuantity;
    data['totalPrice'] = this._totalPrice;
    data['discount'] = this._discount;
    data['productUnitId'] = this._productUnitId;
    if (this._batches != null) {
      data['batches'] = this._batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
