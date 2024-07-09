class DailyReport {
  int? numberOfInvoice;
  double? revenue;
  int? numberOfReturnOrder;
  double? totalReturnValue;
  double? lastDayVenue;
  double? lastMonthVenue;

  DailyReport(
      {this.numberOfInvoice,
        this.revenue,
        this.numberOfReturnOrder,
        this.totalReturnValue,
        this.lastDayVenue,
        this.lastMonthVenue});

  DailyReport.fromJson(Map<String, dynamic> json) {
    numberOfInvoice = json['numberOfInvoice'];
    revenue = json['revenue'];
    numberOfReturnOrder = json['numberOfReturnOrder'];
    totalReturnValue = json['totalReturnValue'];
    lastDayVenue = json['lastDayVenue'];
    lastMonthVenue = json['lastMonthVenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberOfInvoice'] = this.numberOfInvoice;
    data['revenue'] = this.revenue;
    data['numberOfReturnOrder'] = this.numberOfReturnOrder;
    data['totalReturnValue'] = this.totalReturnValue;
    data['lastDayVenue'] = this.lastDayVenue;
    data['lastMonthVenue'] = this.lastMonthVenue;
    return data;
  }
}
