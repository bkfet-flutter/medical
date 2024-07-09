class RevenuesReportModel {
  String? label;
  int? revenue;

  RevenuesReportModel({this.label, this.revenue});

  RevenuesReportModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['revenue'] = revenue;
    return data;
  }
}
