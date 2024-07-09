

class SearchProductModel {
  String? id;
  String? productCode;
  String? barCode;
  Medicine? medicine;
  String? abbreviations;
  GroupProduct? groupProduct;
  UseWay? useWay;
  List<Site>? site;
  String? imageUrl;
  int? cost;
  String? name;
  int? price;
  double? weight;
  String? manufacturer;
  String? country;
  String? unit;
  List<ListUnits>? listUnits;
  dynamic minInventory;
  int? lastImportPrice;
  dynamic maxInventory;
  dynamic description;
  String? status;
  String? note;
  int? type;
  bool? isNoDate;
  String? parentId;
  String? storeId;
  String? packing;
  dynamic attributeProduct;
  int? inventoryQuantity;
  int? inventory;
  String? content;
  String? regisNumber;
  String? active;
  dynamic expirationDay;
  bool? hasChild;
  bool _isBatched = false;
  dynamic ingredients;
  // late Set<BatchProductModel> listBatch;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SearchProductModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
  // bool get isBatched => listBatch.isEmpty;

  SearchProductModel(
      {this.id,
      this.productCode,
      this.barCode,
      this.medicine,
      this.abbreviations,
      this.groupProduct,
      this.useWay,
      this.site,
      this.imageUrl,
      this.cost,
      this.name,
      this.price,
      this.weight,
      this.manufacturer,
      this.country,
      this.unit,
      this.listUnits,
      this.minInventory,
      this.lastImportPrice,
      this.maxInventory,
      this.description,
      this.status,
      this.note,
      this.type,
      this.isNoDate,
      this.parentId,
      this.storeId,
      this.packing,
      this.attributeProduct,
      this.inventoryQuantity,
      this.inventory,
      this.content,
      this.regisNumber,
      this.active,
      this.expirationDay,
      this.hasChild,
      this.ingredients}){
      // listBatch = {};
  }

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productCode = json["productCode"];
    barCode = json["barCode"];
    medicine = json["medicine"] == null ? null : Medicine.fromJson(json["medicine"]);
    abbreviations = json["abbreviations"];
    groupProduct = json["groupProduct"] == null ? null : GroupProduct.fromJson(json["groupProduct"]);
    useWay = json["useWay"] == null ? null : UseWay.fromJson(json["useWay"]);
    site = json["site"] == null ? null : (json["site"] as List).map((e) => Site.fromJson(e)).toList();
    imageUrl = json["imageUrl"];
    cost = json["cost"];
    name = json["name"];
    price = json["price"];
    weight = json["weight"];
    manufacturer = json["manufacturer"];
    country = json["country"];
    unit = json["unit"];
    listUnits =
        json["listUnits"] == null ? null : (json["listUnits"] as List).map((e) => ListUnits.fromJson(e)).toList();
    minInventory = json["minInventory"];
    lastImportPrice = json["lastImportPrice"];
    maxInventory = json["maxInventory"];
    description = json["description"];
    status = json["status"];
    note = json["note"];
    type = json["type"];
    isNoDate = json["isNoDate"];
    parentId = json["parentId"];
    storeId = json["storeId"];
    packing = json["packing"];
    attributeProduct = json["attributeProduct"];
    inventoryQuantity = json["inventoryQuantity"];
    inventory = json["inventory"];
    content = json["content"];
    regisNumber = json["regisNumber"];
    active = json["active"];
    expirationDay = json["expirationDay"];
    hasChild = json["hasChild"];
    ingredients = json["ingredients"];
    // listBatch = {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["productCode"] = productCode;
    _data["barCode"] = barCode;
    if (medicine != null) {
      _data["medicine"] = medicine?.toJson();
    }
    _data["abbreviations"] = abbreviations;
    if (groupProduct != null) {
      _data["groupProduct"] = groupProduct?.toJson();
    }
    if (useWay != null) {
      _data["useWay"] = useWay?.toJson();
    }
    if (site != null) {
      _data["site"] = site?.map((e) => e.toJson()).toList();
    }
    _data["imageUrl"] = imageUrl;
    _data["cost"] = cost;
    _data["name"] = name;
    _data["price"] = price;
    _data["weight"] = weight;
    _data["manufacturer"] = manufacturer;
    _data["country"] = country;
    _data["unit"] = unit;
    if (listUnits != null) {
      _data["listUnits"] = listUnits?.map((e) => e.toJson()).toList();
    }
    _data["minInventory"] = minInventory;
    _data["lastImportPrice"] = lastImportPrice;
    _data["maxInventory"] = maxInventory;
    _data["description"] = description;
    _data["status"] = status;
    _data["note"] = note;
    _data["type"] = type;
    _data["isNoDate"] = isNoDate;
    _data["parentId"] = parentId;
    _data["storeId"] = storeId;
    _data["packing"] = packing;
    _data["attributeProduct"] = attributeProduct;
    _data["inventoryQuantity"] = inventoryQuantity;
    _data["inventory"] = inventory;
    _data["content"] = content;
    _data["regisNumber"] = regisNumber;
    _data["active"] = active;
    _data["expirationDay"] = expirationDay;
    _data["hasChild"] = hasChild;
    _data["ingredients"] = ingredients;
    return _data;
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
    id = json["id"];
    name = json["name"];
    exchangeValue = json["exchangeValue"];
    price = json["price"];
    productCode = json["productCode"];
    barCode = json["barCode"];
    productId = json["productId"];
    baseUnit = json["baseUnit"];
    storeId = json["storeId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["exchangeValue"] = exchangeValue;
    _data["price"] = price;
    _data["productCode"] = productCode;
    _data["barCode"] = barCode;
    _data["productId"] = productId;
    _data["baseUnit"] = baseUnit;
    _data["storeId"] = storeId;
    return _data;
  }
}

class Site {
  String? id;
  String? name;
  String? storeId;
  String? branchId;

  Site({this.id, this.name, this.storeId, this.branchId});

  Site.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    storeId = json["storeId"];
    branchId = json["branchId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["storeId"] = storeId;
    _data["branchId"] = branchId;
    return _data;
  }
}

class UseWay {
  String? id;
  String? name;
  String? storeId;
  String? branchId;

  UseWay({this.id, this.name, this.storeId, this.branchId});

  UseWay.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    storeId = json["storeId"];
    branchId = json["branchId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["storeId"] = storeId;
    _data["branchId"] = branchId;
    return _data;
  }
}

class GroupProduct {
  String? id;
  String? name;
  dynamic parentId;
  String? storeId;
  dynamic branchId;
  dynamic rank;

  GroupProduct({this.id, this.name, this.parentId, this.storeId, this.branchId, this.rank});

  GroupProduct.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    parentId = json["parentId"];
    storeId = json["storeId"];
    branchId = json["branchId"];
    rank = json["rank"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["parentId"] = parentId;
    _data["storeId"] = storeId;
    _data["branchId"] = branchId;
    _data["rank"] = rank;
    return _data;
  }
}

class Medicine {
  String? code;
  String? name;
  String? active;
  String? content;
  String? packing;
  String? unit;
  String? country;
  String? manufacture;
  String? regisNumber;

  Medicine(
      {this.code,
      this.name,
      this.active,
      this.content,
      this.packing,
      this.unit,
      this.country,
      this.manufacture,
      this.regisNumber});

  Medicine.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
    active = json["active"];
    content = json["content"];
    packing = json["packing"];
    unit = json["unit"];
    country = json["country"];
    manufacture = json["manufacture"];
    regisNumber = json["regisNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["name"] = name;
    _data["active"] = active;
    _data["content"] = content;
    _data["packing"] = packing;
    _data["unit"] = unit;
    _data["country"] = country;
    _data["manufacture"] = manufacture;
    _data["regisNumber"] = regisNumber;
    return _data;
  }
}
