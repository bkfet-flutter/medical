import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/network/api_base/api_response.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/shipping_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/dropdown_filter.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/mephar_picker_datetime.dart';
import 'package:provider/provider.dart';

class FilterTransactionScreen extends BaseScreen {
  const FilterTransactionScreen({super.key});

  @override
  FilterTransactionScreenState createState() => FilterTransactionScreenState();
}

class FilterTransactionScreenState extends BaseState<FilterTransactionScreen>
    with BaseScreenMixin {
  @override
  String setTitle() => 'Bộ lọc chuyển hàng';

  @override
  TextStyle? setTextStyleTitle() => AppFonts.normalBold(18, AppThemes.dark1);

  @override
  Color? setHeaderBackgroundColor() => Colors.white;

  @override
  Color? setColorLeftWidget() => AppThemes.dark1;

  @override
  Color setMainBackgroundColor() => AppThemes.white;
  Future<void> _firstData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().fetchStaffs(context),
      context.read<BranchProvider>().initBranch(context),
      // context.read<OrderPageProvider>().getOrderPage(context),
    ]).whenComplete(() {
      // context.read<HomeProvider>().fetchProductReportInMonth(context);
      // context.read<HomeProvider>().fetchProductReportByDay(context);
      AppFunction.hideLoading(context);
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    _firstData(context);
  }

  List<ProvinceModel> statusDropdown = [
    ProvinceModel(id: 1, name: "Đã nhận"),
    ProvinceModel(id: 2, name: "Đang vận chuyển"),
  ];
  DateTime? startTime;
  String? timeStart;
  String? timeEnd;
  DateTime? endTime;
  int? fromBranchId;
  int? toBranchId;
  int? receivedBy;
  String? keyword;
  int? branchId;
  String? status;

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                FilterDropdown(
                  hinText: "Trạng thái",
                  listItems: statusDropdown,
                  onChange: (value) {
                    setState(() {
                      if (value?.id == 1) {
                        status = "RECEIVED";
                      } else if (value?.id == 2) {
                        status = "MOVING";
                      } else {
                        status = "";
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                FilterDropdown(
                  hinText: "Người nhận",
                  listItems: context.read<UserProvider>().userDropDown,
                  onChange: (value) {
                    setState(() {
                      receivedBy = value?.id;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FilterDropdown(
                  hinText: "Từ chi nhánh",
                  listItems: context.read<BranchProvider>().branchDropdown,
                  onChange: (value) {
                    setState(() {
                      fromBranchId = value?.id;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FilterDropdown(
                  hinText: "Tới chi nhánh",
                  listItems: context.read<BranchProvider>().branchDropdown,
                  onChange: (value) {
                    setState(() {
                      toBranchId = value?.id;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Thời gian',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFonts.laTo,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8C8C8C),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Ngày chuyển",
                        dateTimeByText: AppFunction.formatDateRange(startTime),
                        onDateTimeChanged: (value) {
                          setState(() {
                            timeStart = AppFunction.getYearMonthDay(value);
                          });

                          // AppFunction.getYearMonthDay(startTime!),
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Ngày nhận",
                        dateTimeByText: AppFunction.formatDateRange(endTime),
                        onDateTimeChanged: (value) {
                          setState(() {
                            timeEnd = AppFunction.getYearMonthDay(value);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
          child: Row(
            children: [
              Expanded(
                child: MepharButton(
                  onPressed: () {
                    // startTime = null;
                    // setState(() {});
                  },
                  titleButton: "Đặt lại",
                  isButtonWhite: true,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: MepharButton(
                  onPressed: () async {
                    context.read<ShippingProvider>().getListShippingByFilter(
                          context,
                          status: status,
                          fromBranchId: fromBranchId,
                          toBranchId: toBranchId,
                          receivedAt: timeEnd,
                          receivedBy: receivedBy,
                          movedAt: timeStart,
                          page: 1,
                          limit: 20,
                        );
                  },
                  titleButton: "Lọc",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
