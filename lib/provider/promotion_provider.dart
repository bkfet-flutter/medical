import 'package:flutter/material.dart';
import 'package:mephar_app/model/promotion_model.dart';
import 'package:mephar_app/model/promotion_program_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';

class PromotionProvider extends ChangeNotifier {
  final List<PromotionProgramModel> _listPromotionProgram = [];

  List<PromotionProgramModel> get listPromotionProgram => _listPromotionProgram;
  int total = 0;
  int _currentPage = 1;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  Future<String> getListPromotion(
      {String? search, int? limit, int? page}) async {
    _listPromotionProgram.clear();
    listPromotionProgram.clear();
    ApiResponse response = await ApiRequest.getListPromotion(
      keyword: search,
      limit: limit,
      page: page,
    );

    if (response.result == true) {
      for (var e in response.data['list_promotion_program']) {
        _listPromotionProgram.add(PromotionProgramModel.fromJson(e));
        total = response.data['totalItem'];
        notifyListeners();
      }
      print("ok");
      return "success";
    } else {
      notifyListeners();
      return response.message ?? "Lỗi";
    }
  }

  PromotionModel promotionDetail = PromotionModel();

  String idsGiven = '';
  void getDetailPromotion(PromotionModel detail) {
    List<String> list = [];
    promotionDetail = detail;
    for (var e in promotionDetail.listPolicy!) {
      if (e.givenProductIds != null && e.givenProductIds != '') {
        list.add(e.givenProductIds!);
      }
      if (e.purchaseProductIds != null && e.purchaseProductIds != '') {
        list.add(e.purchaseProductIds!);
      }
      if (e.discountProductIds != null && e.discountProductIds != '') {
        list.add(e.discountProductIds!);
      }
    }
    idsGiven = list.join(",");
    notifyListeners();
  }
}
