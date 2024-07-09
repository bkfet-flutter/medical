class ReportSupplierModel {
  String? id;
  String? name;
  String? code;
  String? address;
  String? taxCode;
  String? group;
  double? beginOfPeroidDebt;
  double? endOfPeroidDebt;
  double? totalPayment;

  ReportSupplierModel(
      {this.id,
      this.name,
      this.code,
      this.address,
      this.taxCode,
      this.group,
      this.beginOfPeroidDebt,
      this.endOfPeroidDebt,
      this.totalPayment});

  ReportSupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    address = json['address'];
    taxCode = json['taxCode'];
    group = json['group'];
    beginOfPeroidDebt = json['beginOfPeroidDebt'];
    endOfPeroidDebt = json['endOfPeroidDebt'];
    totalPayment = json['totalPayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['address'] = this.address;
    data['taxCode'] = this.taxCode;
    data['group'] = this.group;
    data['beginOfPeroidDebt'] = this.beginOfPeroidDebt;
    data['endOfPeroidDebt'] = this.endOfPeroidDebt;
    data['totalPayment'] = this.totalPayment;
    return data;
  }
}
