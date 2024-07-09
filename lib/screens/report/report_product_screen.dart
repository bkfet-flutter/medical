import 'package:flutter/material.dart';
import 'package:mephar_app/model/report/report_product.dart';
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

class ReportProductScreen extends BaseScreen {
  const ReportProductScreen({super.key});

  @override
  State<ReportProductScreen> createState() => _ReportProductScreenState();
}

class _ReportProductScreenState extends BaseState<ReportProductScreen> with BaseScreenMixin {
  final NumberPaginatorController _controller = NumberPaginatorController();
  List<ReportProductModel> listReport = [];
  int page = 0;
  int total = 0;
  int size = 10;
  int type = 1;
  UserProvider user = UserProvider();

  Future<void> _callApiList() async {
    listReport.clear();
    showLoading();
    var res = await ApiRequest.getReportProduct(branchId: "", type: type, page: page, size: size);
    if (res.result == true) {
      for (var e in res.data) {
        listReport.add(ReportProductModel.fromJson(e));
      }
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

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.initState();
    _callApiList();
  }

  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      title: "Báo cáo sản phẩm",
      haveSuffixSearch: false,
      haveIconNearSearch: false,
      haveOneIcon: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                    children: List.generate(
                  listReport.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Text(
                            (index + 1).toString(),
                          ),
                        ),
                        CardDetailProduct(
                          listData: [
                            {
                              "titleLeft": "Mã hàng hóa",
                              "titleRight": listReport[index].productCode,
                            },
                            {
                              "titleLeft": "Tên hàng hóa",
                              "titleRight": listReport[index].name,
                            },
                            {
                              "titleLeft": "Giá vốn",
                              "titleRight": listReport[index].cost.toString(),
                            },
                            {
                              "titleLeft": "Giá trị kho",
                              "titleRight": listReport[index].lastImportPrice.toString(),
                            },
                            {
                              "titleLeft": "Giá bán",
                              "titleRight": listReport[index].price.toString(),
                              "isFinal": true,
                            },
                          ],
                          onPressed: () {},
                          haveBorder: true,
                        ),
                        const SizedBox(height: 8),
                        (listReport[index].listBatchs != null && listReport[index].listBatchs!.isNotEmpty)
                            ? SingleChildScrollView(
                                padding: const EdgeInsets.all(4),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      (listReport[index].listBatchs ?? []).length,
                                      (i) => Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: SizedBox(
                                              width: (MediaQuery.of(context).size.width - 20) * 0.8,
                                              child: CardDetailProduct(haveBorder: true, listData: [
                                                {
                                                  "titleLeft": "Số lô",
                                                  "titleRight": listReport[index].listBatchs?[i].name,
                                                },
                                                {
                                                  "titleLeft": "Hạn dùng",
                                                  "titleRight":
                                                      listReport[index].listBatchs?[i].expirationDate?.substring(0, 10),
                                                },
                                                {
                                                  "titleLeft": "Số ngày còn lại",
                                                  "titleRight": DateTime.parse(
                                                          listReport[index].listBatchs?[i].expirationDate ??
                                                              DateTime.now().toString())
                                                      .difference(DateTime.now())
                                                      .inDays
                                                      .toString(),
                                                },
                                                {
                                                  "titleLeft": "Số lượng",
                                                  "titleRight": listReport[index].listBatchs?[i].quantity.toString(),
                                                  "isFinal": true,
                                                },
                                              ]),
                                            ),
                                          )),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                )),
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
