import 'package:mephar_app/model/product_model.dart';

class PriceSettingsModel {
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
  ProductModel? product;

  PriceSettingsModel(
      {this.id,
      this.unitName,
      this.exchangeValue,
      this.price,
      this.productId,
      this.code,
      this.barCode,
      this.isDirectSale,
      this.isBaseUnit,
      this.point,
      this.product});

  PriceSettingsModel.fromJson(Map<String, dynamic> json) {
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
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
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
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
