import 'package:flutter/material.dart';
import 'package:mephar_app/model/search_product_model.dart';

class PromotionModel {
  String? id;
  String? code;
  String? name;
  String? status;
  String? note;
  String? type;
  String? method;
  String? startTime;
  String? endTime;
  String? listMonths;
  String? listDays;
  String? listDayOfWeek;
  String? listHours;
  bool? isBirthdayPromotion;
  String? birthdayPromotionType;
  String? branchIds;
  String? storeId;
  String? sellerIds;
  String? groupCustomerIds;
  bool? multiplyByQuantity;
  String? createdBy;
  String? createdDate;
  bool? isDeleted;
  List<ListPolicy>? listPolicy;

  PromotionModel(
      {this.id,
      this.code,
      this.name,
      this.status,
      this.note,
      this.type,
      this.method,
      this.startTime,
      this.endTime,
      this.listMonths,
      this.listDays,
      this.listDayOfWeek,
      this.listHours,
      this.isBirthdayPromotion,
      this.birthdayPromotionType,
      this.branchIds,
      this.storeId,
      this.sellerIds,
      this.groupCustomerIds,
      this.multiplyByQuantity,
      this.createdBy,
      this.createdDate,
      this.isDeleted,
      this.listPolicy});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
    note = json['note'];
    type = json['type'];
    method = json['method'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    listMonths = json['listMonths'];
    listDays = json['listDays'];
    listDayOfWeek = json['listDayOfWeek'];
    listHours = json['listHours'];
    isBirthdayPromotion = json['isBirthdayPromotion'];
    birthdayPromotionType = json['birthdayPromotionType'];
    branchIds = json['branchIds'];
    storeId = json['storeId'];
    sellerIds = json['sellerIds'];
    groupCustomerIds = json['groupCustomerIds'];
    multiplyByQuantity = json['multiplyByQuantity'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    isDeleted = json['isDeleted'];
    if (json['listPolicy'] != null) {
      listPolicy = <ListPolicy>[];
      json['listPolicy'].forEach((v) {
        listPolicy!.add(ListPolicy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['status'] = status;
    data['note'] = note;
    data['type'] = type;
    data['method'] = method;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['listMonths'] = listMonths;
    data['listDays'] = listDays;
    data['listDayOfWeek'] = listDayOfWeek;
    data['listHours'] = listHours;
    data['isBirthdayPromotion'] = isBirthdayPromotion;
    data['birthdayPromotionType'] = birthdayPromotionType;
    data['branchIds'] = branchIds;
    data['storeId'] = storeId;
    data['sellerIds'] = sellerIds;
    data['groupCustomerIds'] = groupCustomerIds;
    data['multiplyByQuantity'] = multiplyByQuantity;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['isDeleted'] = isDeleted;
    if (listPolicy != null) {
      data['listPolicy'] = listPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPolicy {
  String? id;
  int? startPrice;
  int? discountValue;
  String? discountType;
  int? givenProductQuantity;
  String? givenProductGroups;
  String? givenProductIds;
  String? discountProductGroups;
  String? discountProductIds;
  int? discountProductQuantity;
  int? plusPointValue;
  String? plusPointType;
  int? newPrice;
  int? purchaseQuantity;
  String? purchaseProductGroups;
  String? purchaseProductIds;
  String? promotionId;
  TextEditingController? startPriceController;
  TextEditingController? discountController;
  TextEditingController? discountNumController;
  TextEditingController? givenController;
  List<SearchProductModel>? listProductGiven;
  List<SearchProductModel>? listProductPurchase;
  List<SearchProductModel>? listProductDiscount;

  ListPolicy(
      {this.id,
      this.discountNumController,
      this.listProductDiscount,
      this.listProductGiven,
      this.listProductPurchase,
      this.startPriceController,
      this.givenController,
      this.discountController,
      this.startPrice,
      this.discountValue,
      this.discountType,
      this.givenProductQuantity,
      this.givenProductGroups,
      this.givenProductIds,
      this.discountProductGroups,
      this.discountProductIds,
      this.discountProductQuantity,
      this.plusPointValue,
      this.plusPointType,
      this.newPrice,
      this.purchaseQuantity,
      this.purchaseProductGroups,
      this.purchaseProductIds,
      this.promotionId});

  ListPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startPrice = json['startPrice'];
    discountValue = json['discountValue'];
    discountType = json['discountType'];
    givenProductQuantity = json['givenProductQuantity'];
    givenProductGroups = json['givenProductGroups'];
    givenProductIds = json['givenProductIds'];
    discountProductGroups = json['discountProductGroups'];
    discountProductIds = json['discountProductIds'];
    discountProductQuantity = json['discountProductQuantity'];
    plusPointValue = json['plusPointValue'];
    plusPointType = json['plusPointType'];
    newPrice = json['newPrice'];
    purchaseQuantity = json['purchaseQuantity'];
    purchaseProductGroups = json['purchaseProductGroups'];
    purchaseProductIds = json['purchaseProductIds'];
    promotionId = json['promotionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['startPrice'] = startPrice;
    data['discountValue'] = discountValue;
    data['discountType'] = discountType;
    data['givenProductQuantity'] = givenProductQuantity;
    data['givenProductGroups'] = givenProductGroups;
    data['givenProductIds'] = givenProductIds;
    data['discountProductGroups'] = discountProductGroups;
    data['discountProductIds'] = discountProductIds;
    data['discountProductQuantity'] = discountProductQuantity;
    data['plusPointValue'] = plusPointValue;
    data['plusPointType'] = plusPointType;
    data['newPrice'] = newPrice;
    data['purchaseQuantity'] = purchaseQuantity;
    data['purchaseProductGroups'] = purchaseProductGroups;
    data['purchaseProductIds'] = purchaseProductIds;
    data['promotionId'] = promotionId;
    return data;
  }
}
