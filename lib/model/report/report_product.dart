class ReportProductModel {
  String? id;
  String? productCode;
  String? barCode;
  String? name;
  GroupProduct? groupProduct;
  String? imageUrl;
  int? cost;
  int? price;
  String? manufacturer;
  String? unit;
  List<ListUnits>? listUnits;
  int? lastImportPrice;
  int? type;
  bool? isNoDate;
  Null? attributeProduct;
  int? inventoryQuantity;
  int? inventory;
  List<ListBatchs>? listBatchs;

  ReportProductModel(
      {this.id,
      this.productCode,
      this.barCode,
      this.name,
      this.groupProduct,
      this.imageUrl,
      this.cost,
      this.price,
      this.manufacturer,
      this.unit,
      this.listUnits,
      this.lastImportPrice,
      this.type,
      this.isNoDate,
      this.attributeProduct,
      this.inventoryQuantity,
      this.inventory,
      this.listBatchs});

  ReportProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['productCode'];
    barCode = json['barCode'];
    name = json['name'];
    groupProduct = json['groupProduct'] != null
        ? new GroupProduct.fromJson(json['groupProduct'])
        : null;
    imageUrl = json['imageUrl'];
    cost = json['cost'];
    price = json['price'];
    manufacturer = json['manufacturer'];
    unit = json['unit'];
    if (json['listUnits'] != null) {
      listUnits = <ListUnits>[];
      json['listUnits'].forEach((v) {
        listUnits!.add(new ListUnits.fromJson(v));
      });
    }
    lastImportPrice = json['lastImportPrice'];
    type = json['type'];
    isNoDate = json['isNoDate'];
    attributeProduct = json['attributeProduct'];
    inventoryQuantity = json['inventoryQuantity'];
    inventory = json['inventory'];
    if (json['listBatchs'] != null) {
      listBatchs = <ListBatchs>[];
      json['listBatchs'].forEach((v) {
        listBatchs!.add(new ListBatchs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productCode'] = this.productCode;
    data['barCode'] = this.barCode;
    data['name'] = this.name;
    if (this.groupProduct != null) {
      data['groupProduct'] = this.groupProduct!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['manufacturer'] = this.manufacturer;
    data['unit'] = this.unit;
    if (this.listUnits != null) {
      data['listUnits'] = this.listUnits!.map((v) => v.toJson()).toList();
    }
    data['lastImportPrice'] = this.lastImportPrice;
    data['type'] = this.type;
    data['isNoDate'] = this.isNoDate;
    data['attributeProduct'] = this.attributeProduct;
    data['inventoryQuantity'] = this.inventoryQuantity;
    data['inventory'] = this.inventory;
    if (this.listBatchs != null) {
      data['listBatchs'] = this.listBatchs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupProduct {
  String? id;
  String? name;
  Null? parentId;
  String? storeId;
  Null? branchId;
  Null? rank;

  GroupProduct(
      {this.id,
      this.name,
      this.parentId,
      this.storeId,
      this.branchId,
      this.rank});

  GroupProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parentId'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['rank'] = this.rank;
    return data;
  }
}

class ListUnits {
  String? id;
  String? name;
  int? exchangeValue;
  int? price;
  String? productCode;
  String? barCode;
  String? productId;
  bool? baseUnit;
  String? storeId;

  ListUnits(
      {this.id,
      this.name,
      this.exchangeValue,
      this.price,
      this.productCode,
      this.barCode,
      this.productId,
      this.baseUnit,
      this.storeId});

  ListUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    exchangeValue = json['exchangeValue'];
    price = json['price'];
    productCode = json['productCode'];
    barCode = json['barCode'];
    productId = json['productId'];
    baseUnit = json['baseUnit'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['exchangeValue'] = this.exchangeValue;
    data['price'] = this.price;
    data['productCode'] = this.productCode;
    data['barCode'] = this.barCode;
    data['productId'] = this.productId;
    data['baseUnit'] = this.baseUnit;
    data['storeId'] = this.storeId;
    return data;
  }
}

class ListBatchs {
  String? name;
  String? expirationDate;
  int? quantity;
  String? id;
  String? productId;
  String? branchId;
  String? createdBy;
  Null? lastImportPrice;
  String? createdDate;

  ListBatchs(
      {this.name,
      this.expirationDate,
      this.quantity,
      this.id,
      this.productId,
      this.branchId,
      this.createdBy,
      this.lastImportPrice,
      this.createdDate});

  ListBatchs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expirationDate = json['expirationDate'];
    quantity = json['quantity'];
    id = json['id'];
    productId = json['productId'];
    branchId = json['branchId'];
    createdBy = json['createdBy'];
    lastImportPrice = json['lastImportPrice'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['expirationDate'] = this.expirationDate;
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['branchId'] = this.branchId;
    data['createdBy'] = this.createdBy;
    data['lastImportPrice'] = this.lastImportPrice;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
