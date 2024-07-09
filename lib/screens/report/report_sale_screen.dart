import 'package:flutter/material.dart';
import 'package:mephar_app/model/report/sale_report.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/report/paging_bottom_widget.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/blank_page.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class ReportSaleScreen extends BaseScreen {
  const ReportSaleScreen({super.key});

  @override
  State<ReportSaleScreen> createState() => _ReportSaleScreenState();
}

class _ReportSaleScreenState extends BaseState<ReportSaleScreen>
    with BaseScreenMixin {
  final NumberPaginatorController _controller = NumberPaginatorController();
  List<SaleReportModel> listSale = [];
  int page = 0;
  int total = 0;
  int size = 10;
  String startTime = DateTime(
          DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)
      .toString();
  String endTime = DateTime.now().toString();
  UserProvider user = UserProvider();

  num sumProductPrice = 0;
  num sumDiscount = 0;
  num sumCost = 0;
  num sumReceived = 0;
  num sumProfit = 0;

  Future<void> _callApiList() async {
    listSale.clear();
    showLoading();
    var res = await ApiRequest.getReportSale(
        page: page,
        startTime: startTime,
        endTime: endTime,
        branchId: "",
        size: size);
    if (res.result == true) {
      for (var e in res.data) {
        listSale.add(SaleReportModel.fromJson(e));
      }
      _sum();
      setState(() {
        total = res.total ?? 0;
      });
      hideLoading();
    } else {
      hideLoading();
      if (mounted) {
        AppFunction.showDialogError(
            context, res.message ?? "Có lỗi bất ngờ xảy ra");
      }
    }
  }

  void _sum() {
    sumProductPrice = listSale.fold(
        0, (sum, report) => sum + (report.totalProductPrice ?? 0));
    sumCost = listSale.fold(0, (sum, report) => sum + (report.totalCost ?? 0));
    sumReceived =
        listSale.fold(0, (sum, report) => sum + (report.receivedRevenue ?? 0));
    sumDiscount = listSale.fold(0, (sum, report) => sum + (report.profit ?? 0));
    setState(() {});
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.initState();
    _callApiList();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      title: "Báo cáo bán hàng",
      haveSuffixSearch: false,
      haveIconNearSearch: true,
      haveOneIcon: true,
      body: (listSale.isEmpty)
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
                            "titleLeft": "Tổng",
                            "titleRight": listSale.length.toString(),
                          },
                          {
                            "titleLeft": "Tổng tiền hàng",
                            "titleRight": sumProductPrice.toString(),
                          },
                          {
                            "titleLeft": "Giảm giá",
                            "titleRight": sumDiscount.toString(),
                          },
                          {
                            "titleLeft": "Doanh thu",
                            "titleRight": sumReceived.toString(),
                          },
                          {
                            "titleLeft": "Tổng giá vốn:",
                            "titleRight": sumCost.toString(),
                          },
                          {
                            "titleLeft": "Lợi nhuận",
                            "titleRight": sumProfit.toString(),
                            "isFinal": true,
                          },
                        ], onPressed: () {}),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: List.generate(
                              listSale.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: CardDetailProduct(
                                  listData: [
                                    // {
                                    //   "titleLeft": "Nhân viên",
                                    //   "titleRight": context
                                    //       .watch<UserProvider>()
                                    //       .listAllUser
                                    //       .firstWhere((element) => element.uuid == listSale[index].sellerId,
                                    //           orElse: () => User())
                                    //       .fullName,
                                    // },
                                    {
                                      "titleLeft": "Thời gian",
                                      "titleRight": listSale[index].time,
                                    },
                                    {
                                      "titleLeft": "Tổng tiền hàng",
                                      "titleRight": listSale[index]
                                          .totalProductPrice
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Giảm giá",
                                      "titleRight":
                                          listSale[index].discount.toString(),
                                    },
                                    {
                                      "titleLeft": "Doanh thu",
                                      "titleRight": listSale[index]
                                          .receivedRevenue
                                          .toString(),
                                    },
                                    {
                                      "titleLeft": "Tổng giá vốn",
                                      "titleRight":
                                          listSale[index].totalCost.toString(),
                                    },
                                    {
                                      "titleLeft": "Lợi nhuận gộp",
                                      "titleRight":
                                          listSale[index].profit.toString(),
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
                    _callApiList();
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
