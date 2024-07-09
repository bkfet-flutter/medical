import 'package:flutter/material.dart';
import 'package:mephar_app/model/report/report_supplier.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/report/paging_bottom_widget.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class ReportSupplierScreen extends BaseScreen {
  const ReportSupplierScreen({super.key});

  @override
  State<ReportSupplierScreen> createState() => _ReportSupplierScreenState();
}

class _ReportSupplierScreenState extends BaseState<ReportSupplierScreen> with BaseScreenMixin {
  final NumberPaginatorController _controller = NumberPaginatorController();
  List<ReportSupplierModel> listReport = [];
  int page = 0;
  int total = 0;
  num sumBegin = 0;
  num sumEnd = 0;
  num sumPayment = 0;
  int size = 10;
  String startTime = DateTime(DateTime.now().year, DateTime.now().month - 2, DateTime.now().day).toString();
  String endTime = DateTime.now().toString();
  UserProvider user = UserProvider();

  Future<void> _callApi() async {
    listReport.clear();
    showLoading();
    var res = await ApiRequest.getReportSupplier(
        page: page, size: size, branchId: "", startTime: startTime, endTime: endTime);
    if (res.result == true) {
      for (var e in res.data) {
        listReport.add(ReportSupplierModel.fromJson(e));
      }
      _sum();
      setState(() {
        total = res.total ?? 0;
      });
      hideLoading();
    } else {
      hideLoading();
      if (mounted) {
        AppFunction.showDialogError(context, res.message ?? "Có lỗi bất ngờ xảy ra");
      }
    }
  }

  void _sum() {
    sumBegin = listReport.fold(0, (sum, report) => sum + (report.beginOfPeroidDebt ?? 0));
    sumEnd = listReport.fold(0, (sum, report) => sum + (report.endOfPeroidDebt ?? 0));
    sumPayment = listReport.fold(0, (sum, report) => sum + (report.totalPayment ?? 0));
    setState(() {});
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.initState();
    _callApi();
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      title: "Báo cáo nhà cung cấp",
      haveSuffixSearch: false,
      haveIconNearSearch: false,
      haveOneIcon: false,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardDetailProduct(listData: [
                    {
                      "titleLeft": "Số lượng NCC",
                      "titleRight": listReport.length.toString(),
                    },
                    {
                      "titleLeft": "Nợ kỳ đầu",
                      "titleRight": sumBegin.toString(),
                    },
                    {
                      "titleLeft": "Tổng thanh toán",
                      "titleRight": sumPayment.toString(),
                    },
                    {
                      "titleLeft": "Nợ kỳ cuối",
                      "titleRight": sumEnd.toString(),
                      "isFinal": true,
                    },
                  ], onPressed: () {}),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: List.generate(
                        listReport.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CardDetailProduct(
                            listData: [
                              {
                                "titleLeft": "Mã nhà cung cấp",
                                "titleRight": listReport[index].code,
                              },
                              {
                                "titleLeft": "Tên nhà cung cấp",
                                "titleRight": listReport[index].name,
                              },
                              {
                                "titleLeft": "Nợ đầu kỳ",
                                "titleRight": (listReport[index].beginOfPeroidDebt ?? "---").toString(),
                              },
                              {
                                "titleLeft": "Tổng thanh toán",
                                "titleRight": (listReport[index].totalPayment ?? "---").toString(),
                              },
                              {
                                "titleLeft": "Nợ kỳ cuối",
                                "titleRight": (listReport[index].endOfPeroidDebt ?? "---").toString(),
                                "isFinal": true,
                              },
                            ],
                            onPressed: () {},
                            haveBorder: true,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          PagingBottomWidget(
            controller: _controller,
            total: total,
            size: size,
            onChanged: (index) {
              setState(() {
                page = index;
              });
              _callApi();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
