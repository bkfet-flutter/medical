import 'package:flutter/material.dart';

class DataUnitProvider extends ChangeNotifier {
  List<Map<String, dynamic>> listUnit = [];
  void dataUnit({
    String? unitName,
    int? salePrice,
    int? exchangeValue,
    String? barCode,
    String? code,
    int? point,
  }) {
    Map<String, dynamic> data = {
      "unitName": unitName,
      "exchangeValue": exchangeValue,
      "isBaseUnit": false,
      "isDirectSale": false,
      "barCode": barCode,
      "point": point,
      "code": code,
      "price": exchangeValue! * salePrice!,
    };
    listUnit.add(data);
    notifyListeners();

    //   return data;
  }
}
