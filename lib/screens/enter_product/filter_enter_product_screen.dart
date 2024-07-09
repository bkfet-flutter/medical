import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mephar_app/app/app_dimens.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/config/province_model.dart';
import 'package:mephar_app/model/config/user_model.dart';
import 'package:mephar_app/provider/product/import_product_provider.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
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

class FilterEnterProductScreen extends BaseScreen {
  const FilterEnterProductScreen({super.key, required this.controller});
  final TextEditingController controller;

  @override
  FilterEnterProductScreenState createState() =>
      FilterEnterProductScreenState();
}

class FilterEnterProductScreenState extends BaseState<FilterEnterProductScreen>
    with BaseScreenMixin {
  String startTime = DateTime.now().toString();
  String endTime = DateTime.now().toString();
  UserModel? createdBy;

  @override
  String setTitle() {
    return "Bộ lọc tìm kiếm";
  }

  @override
  Color? setHeaderBackgroundColor() {
    return Colors.white;
  }

  @override
  List<BoxShadow>? buildShadowHeader() {
    return [
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 16,
        spreadRadius: 0,
        color: AppThemes.white.withOpacity(0.12),
      )
    ];
  }

  Future<void> _firstData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().fetchStaffs(context),
      context.read<SupplierProvider>().getDataSupplier(context, "", 1, 20),
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
    ProvinceModel(id: 1, name: "Hoàn thành"),
    ProvinceModel(id: 2, name: "Lưu tạm"),
  ];
  @override
  TextStyle? setTextStyleTitle() {
    return AppFonts.normalBold(18, AppThemes.dark1);
  }

  int? userId;
  int? supplierId;
  String? status;
  @override
  Widget? buildRightWidget() {
    return const SizedBox.shrink();
  }

  @override
  Color? setColorLeftWidget() {
    return AppThemes.dark1;
  }

  String? formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) {
      return null;
    }

    DateTime dateTime;

    // Kiểm tra nếu chuỗi là 'dateTime.now.toString' thì gán giá trị dateTime là thời gian hiện tại
    if (dateTimeString == 'dateTime.now.toString') {
      dateTime = DateTime.now();
    } else {
      // Chuyển chuỗi thành đối tượng DateTime, nhưng đặt giá trị giờ, phút và giây thành 0 (00:00:00)
      dateTime = DateTime.parse(dateTimeString).subtract(Duration(
        hours:
            int.parse(DateFormat('H').format(DateTime.parse(dateTimeString))),
        minutes:
            int.parse(DateFormat('m').format(DateTime.parse(dateTimeString))),
        seconds:
            int.parse(DateFormat('s').format(DateTime.parse(dateTimeString))),
      ));
    }

    // Định dạng datetime thành chuỗi yêu cầu
    String formattedDateTime =
        DateFormat('yyyy-MM-dd+HH:mm:ss').format(dateTime);

    return formattedDateTime;
  }

  static String? formatDateTimeWith235959(String? dateString) {
    if (dateString == null) {
      return null;
    }

    // Chuyển chuỗi thành đối tượng DateTime
    DateTime dateTime = DateTime.parse(dateString);

    // Thiết lập giờ, phút và giây thành 23:59:59
    dateTime = dateTime.add(Duration(
      hours: 23 - dateTime.hour,
      minutes: 59 - dateTime.minute,
      seconds: 59 - dateTime.second,
    ));

    // Định dạng datetime thành chuỗi yêu cầu
    String formattedDateTime =
        DateFormat('yyyy-MM-dd+HH:mm:ss').format(dateTime);

    return formattedDateTime;
  }

  // @override
  // void afterFirstLayout(BuildContext context) {}

  // filterApi() async {
  //   showLoading();
  //   String getFilter = await Provider.of<ProductProvider>(context, listen: false)
  //       .filterByDateTime('0', formatDateTime(startTime), formatDateTimeWith235959(endTime), createdBy?.uuid , context);
  //   if (getFilter == "success" && context.mounted) {
  //     hideLoading();
  //     Navigator.pop(context, true);
  //   } else {
  //     if (context.mounted) {
  //       hideLoading();
  //       AppFunction.showDialogError(context, getFilter, textButton: "Đóng", title: "Thông báo lỗi");
  //     }
  //   }
  // }

  @override
  Widget buildBody(BuildContext context) {
    return Consumer2<ImportProductProvider, UserProvider>(
        builder: (context, product, user, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.spaceMediumLarge),
                  child: Column(
                    children: [
                      MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Từ ngày",
                        onDateTimeChanged: (value) {
                          startTime = value.toString();
                        },
                      ),
                      MepharPickerDatetime(
                        icon: AppImages.iconCalendar,
                        labelText: "Đến ngày",
                        onDateTimeChanged: (value) {
                          endTime = value.toString();
                        },
                      ),
                      FilterDropdown(
                        hinText: "Người tạo",
                        listItems: context.read<UserProvider>().userDropDown,
                        onChange: (value) {
                          setState(() {
                            userId = value?.id;
                          });
                        },
                      ),
                      FilterDropdown(
                        hinText: "Nhà cung cấp",
                        listItems:
                            context.read<SupplierProvider>().supplierDropdown,
                        onChange: (value) {
                          setState(() {
                            supplierId = value?.id;
                          });
                        },
                      ),
                      FilterDropdown(
                        hinText: "Trạng thái",
                        listItems: statusDropdown,
                        onChange: (value) {
                          setState(() {
                            if (value?.id == 1) {
                              status = "SUCCEED";
                            } else if (value?.id == 2) {
                              status = "DRAFT";
                            } else {
                              status = null;
                            }
                          });
                        },
                      ),
                      // MepharObjectDropDownButton(
                      //     hintText: "Tạo bởi",
                      //     items: user.listAllUser,
                      //     haveBorder: false,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         createdBy = value;
                      //       });
                      //     })
                    ],
                  ),
                ),
              ),
            ),
            Container(
                color: const Color(0xffF5F5F5),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.spaceXSmall10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: MepharButton(
                          onPressed: () {},
                          titleButton: "Đặt lại",
                          isButtonWhite: true,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: MepharButton(
                          onPressed: () async {
                            // filterApi();
                            setState(() {
                              widget.controller.clear();
                            });
                            context
                                .read<ImportProductProvider>()
                                .fetchProductsInboundByFilter(
                                  context,
                                  firstCall: true,
                                  userId: userId,
                                  supplierId: supplierId,
                                  status: status,
                                );
                          },
                          titleButton: "Lọc",
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
