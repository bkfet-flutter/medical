import 'package:flutter/cupertino.dart';

class BatchModel {
  int? id;
  String? name;
  int? quantity;
  String? expiryDate;
  TextEditingController? quantityController;

  BatchModel({
    this.id,
    this.name,
    this.quantity,
    this.expiryDate,
  });

  BatchModel.fromJson(Map<String, dynamic> json) {
    quantityController = TextEditingController(text: "1");
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    expiryDate = json['expiryDate'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BatchModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}
