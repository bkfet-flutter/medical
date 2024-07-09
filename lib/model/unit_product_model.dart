import 'package:flutter/material.dart';

class UnitProductsModel {
  TextEditingController name;
  TextEditingController value;
  TextEditingController point;
  TextEditingController barCode;
  TextEditingController codeUnit;
  TextEditingController salePrice;

  UnitProductsModel({
    required this.name,
    required this.value,
    required this.barCode,
    required this.codeUnit,
    required this.point,
    required this.salePrice,
  });
}
