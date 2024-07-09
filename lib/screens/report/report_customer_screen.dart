import 'package:flutter/material.dart';
import 'package:mephar_app/model/report/report_customer.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/report/paging_bottom_widget.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';

class ReportCustomerScreen extends BaseScreen {
  const ReportCustomerScreen({super.key});

  @override
  State<ReportCustomerScreen> createState() => _ReportCustomerScreenState();
}

class _ReportCustomerScreenState extends BaseState<ReportCustomerScreen> with BaseScreenMixin {
  List<ReportCustomModel> listReport = [];
  int page = 0;
  int size = 10;
  int total = 0;
  num sumAmount = 0;
  num sumDiscount = 0;
  num sumCost = 0;
  num sumReturn = 0;

  Future<void> _callApiList() async {
    listReport.clear();
    showLoading();
    var res = await ApiRequest.getReportCustomer(page: page, size: size);
    if (res.result == true) {
      for (var e in res.data) {
        listReport.add(ReportCustomModel.fromJson(e));
      }
      _sum();
      setState(() {
        total = res.total ?? 0;
      });
      hideLoading();
    } else {
      if (mounted) {
        hideLoading();
        AppFunction.showDialogError(context, res.message ?? "Có lỗi bất ngờ xảy ra");
      }
    }
  }

  void _sum() {
    sumReturn = listReport.fold(0, (sum, report) => sum + (report.totalReturn ?? 0));
    sumCost = listReport.fold(0, (sum, report) => sum + (report.totalCost ?? 0));
    sumAmount = listReport.fold(0, (sum, report) => sum + (report.totalAmount ?? 0));
    sumDiscount = listReport.fold(0, (sum, report) => sum + (report.totalDiscount ?? 0));
    setState(() {});
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    _callApiList();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      title: "Báo cáo khách hàng",
      haveSuffixSearch: false,
      haveOneIcon: true,
      body: (listReport.isEmpty)
          ? const Center(
              child: BlankPage(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CardDetailProduct(listData: [
                          {
                            "titleLeft": "SL Khách hàng",
                            "titleRight": listReport.length.toString(),
                          },
                          {
                            "titleLeft": "Tổng tiền hàng",
                            "titleRight": sumAmount.toString(),
                          },
                          {
                            "titleLeft": "Giảm giá HĐ",
                            "titleRight": sumDiscount.toString(),
                          },
                          {
                            "titleLeft": "Doanh thu",
                            "titleRight": sumAmount.toString(),
                          },
                          {
                            "titleLeft": "Giá trị trả",
                            "titleRight": sumReturn.toString(),
                          },
                          {
                            "titleLeft": "Doanh thu thuần",
                            "titleRight": (sumAmount - sumReturn - sumDiscount).toString(),
                          },
                          {
                            "titleLeft": "Tổng giá vốn",
                            "titleRight": sumCost.toString(),
                          },
                          {
                            "titleLeft": "Lợi nhuận gộp",
                            "titleRight": (sumAmount - sumReturn - sumDiscount - sumCost).toString(),
                            "isFinal": true,
                          },
                        ], onPressed: () {}),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: List.generate(
                              listReport.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CardDetailProduct(
                                  listData: [
                                    {
                                      "titleLeft": "Khách hàng",
                                      "titleRight": listReport[index].customerName,
                                    },
                                    {
                                      "titleLeft": "Tổng tiền hàng",
                                      "titleRight": listReport[index].totalAmount.toString(),
                                    },
                                    {
                                      "titleLeft": "Giảm giá HĐ",
                                      "titleRight": listReport[index].totalDiscount.toString(),
                                    },
                                    {
                                      "titleLeft": "Doanh thu",
                                      "titleRight": listReport[index].totalAmount.toString(),
                                    },
                                    {
                                      "titleLeft": "Giá trị trả",
                                      "titleRight": listReport[index].totalReturn.toString(),
                                    },
                                    {
                                      "titleLeft": "Doanh thu thuần",
                                      "titleRight": ((listReport[index].totalAmount ?? 0) -
                                              (listReport[index].totalReturn ?? 0) -
                                              (listReport[index].totalDiscount ?? 0))
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Tổng giá vốn",
                                      "titleRight": listReport[index].totalCost.toString(),
                                    },
                                    {
                                      "titleLeft": "Lợi nhuận gộp",
                                      "titleRight": ((listReport[index].totalAmount ?? 0) -
                                              (listReport[index].totalReturn ?? 0) -
                                              (listReport[index].totalDiscount ?? 0) -
                                              (listReport[index].totalCost ?? 0))
                                          .toString(),
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
                  total: total,
                  size: size,
                  onChanged: (index) {
                    setState(() {
                      page = index;
                    });
                    _callApiList();
                  },
                )
              ],
            ),
    );
  }
}
