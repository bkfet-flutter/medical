class DebtCustomerModel {
  int? id;
  int? totalAmount;
  int? customerId;
  int? orderId;
  String? debtAmount;
  String? type;
  String? createdAt;
  String? updatedAt;
  // Null? deletedAt;

  DebtCustomerModel({
    this.id,
    this.totalAmount,
    this.customerId,
    this.orderId,
    this.debtAmount,
    this.type,
    this.createdAt,
    this.updatedAt,
    // this.deletedAt
  });

  DebtCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    customerId = json['customerId'];
    orderId = json['orderId'];
    debtAmount = json['debtAmount'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['customerId'] = this.customerId;
    data['orderId'] = this.orderId;
    data['debtAmount'] = this.debtAmount;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['deletedAt'] = this.deletedAt;
    return data;
  }
}
