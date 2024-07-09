class ProductReportRevenueModel {
  String? name;
  int? revenue;

  ProductReportRevenueModel({this.name, this.revenue});

  ProductReportRevenueModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    revenue = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['revenue'] = this.revenue;
    return data;
  }
}
