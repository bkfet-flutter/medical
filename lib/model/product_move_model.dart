class ProductMoveModel {
  int? productId;
  int? price;
  int? quantity;
  int? id;
  int? productUnitId;
  List<Batches>? batches;

  ProductMoveModel(
      {this.productId,
      this.price,
      this.quantity,
      this.id,
      this.productUnitId,
      this.batches});

  ProductMoveModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'];
    id = json['id'];
    productUnitId = json['productUnitId'];
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(new Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    data['productUnitId'] = this.productUnitId;
    if (this.batches != null) {
      data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int? id;
  int? quantity;

  Batches({this.id, this.quantity});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    return data;
  }
}
