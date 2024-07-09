import 'package:flutter/material.dart';
import 'package:mephar_app/model/product_report_revenue_model.dart';
import 'package:mephar_app/model/revenues_report_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/utils/app_function.dart';

class HomeProvider extends ChangeNotifier {


  List<ProductReportRevenueModel> _listProductReportRevenue = [];

  List<ProductReportRevenueModel> get listProductReportRevenue => _listProductReportRevenue;

  num get quantity =>
      _listProductReportRevenue.fold(0, (previousValue, element) => previousValue + (element.revenue ?? 0));

  bool loading = false;

  loadingStatus(bool status) {
    loading = status;
    notifyListeners();
  }

  Future<void> fetchProductReportInMonth(BuildContext context) async {
    loadingStatus(true);
    var res = await ApiRequest.productReport(context);
    if (res.result == true) {
      final List<ProductReportRevenueModel> items = [];
      for (var e in res.data['items']) {
        items.add(ProductReportRevenueModel.fromJson(e));
      }
      items.sort((a, b) => (b.revenue ?? 0).compareTo(a.revenue ?? 0));
      if (items.length > 5) {
        final List<ProductReportRevenueModel> fiveItems = [];
        for (int i = 0; i < 4; i++) {
          fiveItems.add(items[i]);
        }
        int sumOther = 0;
        for (int i = 4; i < items.length; i++) {
          sumOther = sumOther + (items[i].revenue ?? 0);
        }
        fiveItems.add(ProductReportRevenueModel(name: "Các sản phẩm khác", revenue: sumOther));
        items.clear();
        items.addAll(fiveItems);
      }
      _listProductReportRevenue = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }

  List<RevenuesReportModel> _listRevenuesReport = [];

  List<RevenuesReportModel> get listRevenuesReport => _listRevenuesReport;

  Future<void> fetchProductReportByDay(BuildContext context) async {
    loadingStatus(true);
    var res = await ApiRequest.productReportByDay(context);
    if (res.result == true) {
      final List<RevenuesReportModel> items = [];
      for (var e in res.data['items']) {
        items.add(RevenuesReportModel.fromJson(e));
      }
      _listRevenuesReport = items;
      notifyListeners();
      loadingStatus(false);
    } else {
      loadingStatus(false);
      if (context.mounted) AppFunction.showDialogError(context, res.message);
    }
  }
}
