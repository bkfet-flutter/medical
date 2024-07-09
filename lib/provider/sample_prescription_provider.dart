import 'package:flutter/material.dart';
import 'package:mephar_app/model/sample_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:provider/provider.dart';

class SampleProvider extends ChangeNotifier {
  final List<SampleModel> _listSample = [];
  int total = 0;
  int _currentPage = 1;
  int totalGroup = 0;

  get currentPage => _currentPage;

  void updatePage(int index) async {
    _currentPage = index;
    notifyListeners();
  }

  List<SampleModel> get listSample => _listSample;

  List<String> nameGroupSupplierModel = [];

  void clearList() {
    _listSample.clear();
    listSample.clear();
    notifyListeners();
  }

  Future<void> getListSample({
    required BuildContext context,
    String? search,
    int? page,
    int? limit,
    int? branchId,
  }) async {
    _listSample.clear();
    listSample.clear();
    int? branchId =
        Provider.of<BranchProvider>(context, listen: false).defaultBranch?.id;

    ApiResponse resSample = await ApiRequest.getListSample(
      limit: limit,
      page: page,
      search: search,
      branchId: branchId,
    );
    if (resSample.result == true && context.mounted) {
      for (var e in resSample.data['items']) {
        _listSample.add(SampleModel.fromJson(e));
      }
      total = resSample.data['totalItem'];

      AppFunction.hideLoading(context);
    } else if (context.mounted) {
      AppFunction.showDialogError(
          context, resSample.message ?? "Lỗi không xác định");
    }
    notifyListeners();
  }

  SampleModel? sample;

  Future<void> getDetailSample(int id) async {
    sample = _listSample.firstWhere((data) => data.id == id);
    notifyListeners();
  }
}
