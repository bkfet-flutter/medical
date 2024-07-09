class SettingModel {
  Order? order;

  SettingModel({this.order});

  SettingModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  OrderStatuses? orderStatuses;
  List<OrderStatusOptions>? orderStatusOptions;
  PaymentTypes? paymentTypes;
  DiscountTypes? discountTypes;

  Order(
      {this.orderStatuses,
      this.orderStatusOptions,
      this.paymentTypes,
      this.discountTypes});

  Order.fromJson(Map<String, dynamic> json) {
    orderStatuses = json['orderStatuses'] != null
        ? new OrderStatuses.fromJson(json['orderStatuses'])
        : null;
    if (json['orderStatusOptions'] != null) {
      orderStatusOptions = <OrderStatusOptions>[];
      json['orderStatusOptions'].forEach((v) {
        orderStatusOptions!.add(new OrderStatusOptions.fromJson(v));
      });
    }
    paymentTypes = json['paymentTypes'] != null
        ? new PaymentTypes.fromJson(json['paymentTypes'])
        : null;
    discountTypes = json['discountTypes'] != null
        ? new DiscountTypes.fromJson(json['discountTypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderStatuses != null) {
      data['orderStatuses'] = this.orderStatuses!.toJson();
    }
    if (this.orderStatusOptions != null) {
      data['orderStatusOptions'] =
          this.orderStatusOptions!.map((v) => v.toJson()).toList();
    }
    if (this.paymentTypes != null) {
      data['paymentTypes'] = this.paymentTypes!.toJson();
    }
    if (this.discountTypes != null) {
      data['discountTypes'] = this.discountTypes!.toJson();
    }
    return data;
  }
}

class OrderStatuses {
  String? dRAFT;
  String? pENDING;
  String? cONFIRMING;
  String? sHIPPING;
  String? dELIVERING;
  String? pAID;
  String? cANCELLED;
  String? sUCCEED;

  OrderStatuses(
      {this.dRAFT,
      this.pENDING,
      this.cONFIRMING,
      this.sHIPPING,
      this.dELIVERING,
      this.pAID,
      this.cANCELLED,
      this.sUCCEED});

  OrderStatuses.fromJson(Map<String, dynamic> json) {
    dRAFT = json['DRAFT'];
    pENDING = json['PENDING'];
    cONFIRMING = json['CONFIRMING'];
    sHIPPING = json['SHIPPING'];
    dELIVERING = json['DELIVERING'];
    pAID = json['PAID'];
    cANCELLED = json['CANCELLED'];
    sUCCEED = json['SUCCEED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DRAFT'] = this.dRAFT;
    data['PENDING'] = this.pENDING;
    data['CONFIRMING'] = this.cONFIRMING;
    data['SHIPPING'] = this.sHIPPING;
    data['DELIVERING'] = this.dELIVERING;
    data['PAID'] = this.pAID;
    data['CANCELLED'] = this.cANCELLED;
    data['SUCCEED'] = this.sUCCEED;
    return data;
  }
}

class OrderStatusOptions {
  int? value;
  String? text;
  String? type;

  OrderStatusOptions({this.value, this.text, this.type});

  OrderStatusOptions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['type'] = this.type;
    return data;
  }
}

class PaymentTypes {
  String? bANK;
  String? cOD;
  String? cASH;
  String? dEBT;

  PaymentTypes({this.bANK, this.cOD, this.cASH, this.dEBT});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    bANK = json['BANK'];
    cOD = json['COD'];
    cASH = json['CASH'];
    dEBT = json['DEBT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BANK'] = this.bANK;
    data['COD'] = this.cOD;
    data['CASH'] = this.cASH;
    data['DEBT'] = this.dEBT;
    return data;
  }
}

class DiscountTypes {
  int? mONEY;
  int? pERCENT;

  DiscountTypes({this.mONEY, this.pERCENT});

  DiscountTypes.fromJson(Map<String, dynamic> json) {
    mONEY = json['MONEY'];
    pERCENT = json['PERCENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MONEY'] = this.mONEY;
    data['PERCENT'] = this.pERCENT;
    return data;
  }
}
