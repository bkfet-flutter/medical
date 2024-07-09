import 'package:mephar_app/model/image_model.dart';

class SampleModel {
  int? id;
  String? name;
  String? code;
  String? weight;
  String? description;
  int? status;
  int? positionId;
  User? user;
  ImageModel? image;
  Store? store;
  Branch? branch;
  Position? position;
  List<Products>? products;

  SampleModel(
      {this.id,
      this.name,
      this.code,
      this.weight,
      this.description,
      this.status,
      this.positionId,
      this.user,
      this.image,
      this.store,
      this.branch,
      this.position,
      this.products});

  SampleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    weight = json['weight'];
    description = json['description'];
    status = json['status'];
    positionId = json['positionId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    image =
        json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['status'] = this.status;
    data['positionId'] = this.positionId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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

class Position {
  int? id;
  String? name;

  Position({this.id, this.name});

  Position.fromJson(Map<String, dynamic> json) {
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

class Products {
  int? id;
  int? samplePrescriptionId;
  int? productId;
  int? productUnitId;
  String? dosage;
  int? quantity;
  int? storeId;
  int? branchId;
  String? createdAt;
  Product? product;
  // Null? productUnit;
  // List<Null>? batches;

  Products({
    this.id,
    this.samplePrescriptionId,
    this.productId,
    this.productUnitId,
    this.dosage,
    this.quantity,
    this.storeId,
    this.branchId,
    this.createdAt,
    this.product,
    // this.productUnit,
    // this.batches
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    samplePrescriptionId = json['samplePrescriptionId'];
    productId = json['productId'];
    productUnitId = json['productUnitId'];
    dosage = json['dosage'];
    quantity = json['quantity'];
    storeId = json['storeId'];
    branchId = json['branchId'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    // productUnit = json['productUnit'];
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
    data['samplePrescriptionId'] = this.samplePrescriptionId;
    data['productId'] = this.productId;
    data['productUnitId'] = this.productUnitId;
    data['dosage'] = this.dosage;
    data['quantity'] = this.quantity;
    data['storeId'] = this.storeId;
    data['branchId'] = this.branchId;
    data['createdAt'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    // data['productUnit'] = this.productUnit;
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

  int? imageId;
  // Null? dosageId;
  // Null? manufactureId;
  // Null? positionId;
  // Null? countryId;
  int? primePrice;
  int? price;
  String? weight; // Null? groupProductId;
  // Null? productCategoryId;
  String? warningExpiryDate;
  // Null? warningExpiryText;
  bool? isDirectSale;
  // Null? registerNumber;
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
  // Null? expiryPeriod;
  int? status;
  String? createdAt;
  Image? image;
  Store? store;
  Branch? branch;
  // Null? productManufacture;
  // Null? productDosage;
  // Null? productPosition;
  // Null? country;
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
      this.imageId,
      // this.dosageId,
      // this.manufactureId,
      // this.positionId,
      // this.countryId,
      this.primePrice,
      this.price,
      this.weight,
      this.warningExpiryDate,
      // this.warningExpiryText,
      this.isDirectSale,
      // this.registerNumber,
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
      // this.expiryPeriod,
      this.status,
      this.createdAt,
      this.image,
      this.store,
      this.branch,
      // this.productManufacture,
      // this.productDosage,
      // this.productPosition,
      // this.country,
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
    imageId = json['imageId'];
    // dosageId = json['dosageId'];
    // manufactureId = json['manufactureId'];
    // positionId = json['positionId'];
    // countryId = json['countryId'];
    primePrice = json['primePrice'];
    price = json['price'];
    weight = json['weight'];
    warningExpiryDate = json['warningExpiryDate'];
    // warningExpiryText = json['warningExpiryText'];
    isDirectSale = json['isDirectSale'];
    // registerNumber = json['registerNumber'];
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
    // expiryPeriod = json['expiryPeriod'];
    status = json['status'];
    createdAt = json['createdAt'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    // productManufacture = json['productManufacture'];
    // productDosage = json['productDosage'];
    // productPosition = json['productPosition'];
    // country = json['country'];
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
    data['imageId'] = this.imageId;
    // data['dosageId'] = this.dosageId;
    // data['manufactureId'] = this.manufactureId;
    // data['positionId'] = this.positionId;
    // data['countryId'] = this.countryId;
    data['primePrice'] = this.primePrice;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['warningExpiryDate'] = this.warningExpiryDate;
    // data['warningExpiryText'] = this.warningExpiryText;
    data['isDirectSale'] = this.isDirectSale;
    // data['registerNumber'] = this.registerNumber;
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
    // data['expiryPeriod'] = this.expiryPeriod;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    // data['productManufacture'] = this.productManufacture;
    // data['productDosage'] = this.productDosage;
    // data['productPosition'] = this.productPosition;
    // data['country'] = this.country;
    // data['groupProduct'] = this.groupProduct;
    // data['productCategory'] = this.productCategory;
    if (this.productUnit != null) {
      data['productUnit'] = this.productUnit!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitName'] = this.unitName;
    data['exchangeValue'] = this.exchangeValue;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['code'] = this.code;
    data['barCode'] = this.barCode;
    data['isDirectSale'] = this.isDirectSale;
    data['isBaseUnit'] = this.isBaseUnit;
    data['point'] = this.point;
    return data;
  }
}
