class ReportCustomModel {
  String? customerId;
  String? customerCode;
  String? customerName;
  double? totalAmount;
  double? totalDiscount;
  double? totalReturn;
  double? totalCost;

  ReportCustomModel(
      {this.customerId,
        this.customerCode,
        this.customerName,
        this.totalAmount,
        this.totalDiscount,
        this.totalReturn,
        this.totalCost});

  ReportCustomModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    totalAmount = json['totalAmount'];
    totalDiscount = json['totalDiscount'];
    totalReturn = json['totalReturn'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['totalAmount'] = this.totalAmount;
    data['totalDiscount'] = this.totalDiscount;
    data['totalReturn'] = this.totalReturn;
    data['totalCost'] = this.totalCost;
    return data;
  }
}
