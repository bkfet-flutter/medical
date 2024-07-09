class SaleReportModel {
  String? sellerId;
  String? time;
  int? totalProductPrice;
  int? discount;
  int? receivedRevenue;
  double? totalCost;
  double? profit;

  SaleReportModel(
      {this.sellerId,
        this.time,
        this.totalProductPrice,
        this.discount,
        this.receivedRevenue,
        this.totalCost,
        this.profit});

  SaleReportModel.fromJson(Map<String, dynamic> json) {
    sellerId = json['sellerId'];
    time = json['time'];
    totalProductPrice = json['totalProductPrice'];
    discount = json['discount'];
    receivedRevenue = json['receivedRevenue'];
    totalCost = json['totalCost'];
    profit = json['profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerId'] = this.sellerId;
    data['time'] = this.time;
    data['totalProductPrice'] = this.totalProductPrice;
    data['discount'] = this.discount;
    data['receivedRevenue'] = this.receivedRevenue;
    data['totalCost'] = this.totalCost;
    data['profit'] = this.profit;
    return data;
  }
}
