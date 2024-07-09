class PaymentHistoryModel {
  int? id;
  String? code;
  String? amount;
  int? totalAmount;
  int? customerId;
  int? orderId;
  String? paymentMethod;
  String? status;
  String? createdAt;
  String? updatedAt;
  // String? deletedAt;

  PaymentHistoryModel({
    this.id,
    this.code,
    this.amount,
    this.totalAmount,
    this.customerId,
    this.orderId,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.deletedAt
  });

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    totalAmount = json['totalAmount'];
    customerId = json['customerId'];
    orderId = json['orderId'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['totalAmount'] = this.totalAmount;
    data['customerId'] = this.customerId;
    data['orderId'] = this.orderId;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['deletedAt'] = this.deletedAt;
    return data;
  }
}
