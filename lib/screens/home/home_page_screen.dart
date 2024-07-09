import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/model/daily_report_model.dart';
import 'package:mephar_app/model/revenues_report_model.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/branch_provider.dart';
import 'package:mephar_app/provider/home_provider.dart';
import 'package:mephar_app/provider/order_page_provider.dart';
import 'package:mephar_app/provider/user_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/doctor/list_doctor_screen.dart';
import 'package:mephar_app/screens/template_medicine/list_sample_medicine.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/button_dropdown_home.dart';
import 'package:mephar_app/widgets/custom_shape.dart';
import 'package:mephar_app/widgets/item_home_page.dart';
import 'package:mephar_app/widgets/my_bar_graph.dart';
import 'package:mephar_app/widgets/normal_text.dart';
import 'package:mephar_app/widgets/pie_chart.dart';
import 'package:mephar_app/widgets/sales_results_today.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends BaseScreen {
  const HomePageScreen({super.key});

  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends BaseState<HomePageScreen>
    with BaseScreenMixin {
  DailyReport? dailyReport;

  @override
  Widget buildHeader() => const SizedBox.shrink();

  Future<void> _firstData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().getUser(context),
      context.read<BranchProvider>().initBranch(context),
      context.read<OrderPageProvider>().getOrderPage(context),
    ]).whenComplete(() {
      context.read<HomeProvider>().fetchProductReportInMonth(context);
      context.read<HomeProvider>().fetchProductReportByDay(context);
      AppFunction.hideLoading(context);
    });
  }

  _resetData(BuildContext context) async {
    AppFunction.showLoading(context);
    await Future.wait([
      context.read<UserProvider>().getUser(context),
      context.read<BranchProvider>().fetchBranches(context),
      context.read<HomeProvider>().fetchProductReportInMonth(context),
      context.read<HomeProvider>().fetchProductReportByDay(context),
      context.read<OrderPageProvider>().getOrderPage(context),
    ]).whenComplete(() => AppFunction.hideLoading(context));
  }

  @override
  void afterFirstLayout(BuildContext context) => _firstData(context);

  @override
  Color setMainBackgroundColor() => const Color(0xffF3FAFF);

  @override
  Widget buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, user, child) {
      return RefreshIndicator(
        onRefresh: () => _resetData(context),
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF3FAFF),
            child: Column(
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          AppImages.backgroundUnder,
                          width: size.width,
                          height: 195,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          AppImages.backgroundHomePage,
                          width: size.width,
                          height: 195,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 65),
                          SizedBox(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: (user.userModel.avatar?.path != null &&
                                          user.userModel.avatar?.path != "")
                                      ? InkWell(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRoutes.editProfileScreen),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.network(
                                              '${ApiRequest.domain}${user.userModel.avatar?.path}',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRoutes.editProfileScreen),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle),
                                            child: Text(
                                              (user.userModel.fullName?[0] ??
                                                  ""),
                                              style: AppFonts.bold(
                                                  20, Colors.white),
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.userModel.fullName ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: AppFonts.bold(14, Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Image.asset(
                                              AppImages.iconLocation,
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: ButtonDropdownHome(
                                                onUpdate: (value) {
                                                  context
                                                      .read<BranchProvider>()
                                                      .changeCurrentBranch(
                                                          branchModel: value);
                                                  _resetData(context);
                                                },
                                                value: context
                                                    .watch<BranchProvider>()
                                                    .defaultBranch,
                                                listBranch: context
                                                    .watch<BranchProvider>()
                                                    .listBranch),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Flexible(
                                //   flex: 1,
                                //   child: Container(
                                //     alignment: Alignment.centerRight,
                                //     child: Image.asset(
                                //       AppImages.iconNotify,
                                //       width: 24,
                                //       height: 24,
                                //       fit: BoxFit.fill,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Container(
                            height: 242,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                ClipPath(
                                  clipper: CustomShape(),
                                  child: Container(
                                    height: 99,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF70033),
                                          Color(0xFF6600CC)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 37, left: 37, top: 24),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topCenter,
                                              child: Image.asset(
                                                AppImages.iconDiamond,
                                                width: 32,
                                                height: 32,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: NormalText(
                                                "KẾT QUẢ BÁN HÀNG HÔM NAY",
                                                minFontSize: 10,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFonts.ultraBold(
                                                        14, Colors.white)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: SalesResultsToday(
                                      number: context
                                          .read<OrderPageProvider>()
                                          .totalItem,
                                      title: "Đơn hàng mới",
                                    )),
                                    Expanded(
                                        child: SalesResultsToday(
                                      icon: AppImages.iconBoxReturn,
                                      number:
                                          dailyReport?.numberOfReturnOrder ?? 0,
                                      title: "Đơn hàng trả",
                                    )),

                                    ///đoạn này cần đợi report từ backend để chỉnh sửa
                                    Expanded(
                                        child: SalesResultsToday(
                                      icon: AppImages.iconArrowSwap,
                                      percent: dailyReport != null
                                          ? dailyReport!.revenue! /
                                                  dailyReport!.lastMonthVenue! -
                                              1
                                          : 0,
                                      title: "Cùng kỳ",
                                      colorText: AppThemes.green0,
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 1,
                                  width: size.width - 50,
                                  color: const Color(0xffeeeeee),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Doanh thu:",
                                          style: AppFonts.regular(
                                              14, AppThemes.dark2),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: RichText(
                                              textAlign: TextAlign.right,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: AppFunction.formatNum(
                                                      int.parse(context
                                                          .read<
                                                              OrderPageProvider>()
                                                          .totalPrice
                                                          .toString())),
                                                  style: AppFonts.ultraBold(
                                                      16, AppThemes.dark1),
                                                ),
                                                TextSpan(
                                                    text: " VND",
                                                    style: AppFonts.ultraBold(
                                                        14, AppThemes.dark3))
                                              ])))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: ItemHomePage(
                                      image: AppImages.iconMedicine,
                                      title: "Thuốc",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.medicineCategoryScreen,
                                        );
                                      })),
                              Expanded(
                                  child: ItemHomePage(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.transactionScreen);
                                },
                                image: AppImages.iconExchange,
                                title: "Giao dịch",
                              )),
                              Expanded(
                                  child: ItemHomePage(
                                      image: AppImages.iconAccount,
                                      title: "Khách hàng",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.customerScreen,
                                        );
                                      })),
                              Expanded(
                                  child: ItemHomePage(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.supplierScreen,
                                  );
                                },
                                image: AppImages.iconSupplier,
                                title: "Nhà cung cấp",
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: ItemHomePage(
                                      image: AppImages.enterProduct,
                                      title: "Nhập sp",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.enterProductScreen,
                                        );
                                      })),
                              Expanded(
                                child: ItemHomePage(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.returnProductScreen,
                                    );
                                  },
                                  image: AppImages.returnProduct,
                                  title: "Trả hàng nhập",
                                ),
                              ),
                              Expanded(
                                  child: ItemHomePage(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.priceSettingScreen,
                                  );
                                },
                                image: AppImages.priceSetting,
                                title: "Thiết lập giá",
                              )),
                              Expanded(
                                child: ItemHomePage(
                                    image: AppImages.iconConfig,
                                    title: "Thuốc mẫu",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListTemplateMedicineScreen()),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ItemHomePage(
                                    image: AppImages.iconAccount,
                                    title: "Bác sĩ",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListDoctorScreen()),
                                      );
                                    }),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(),
                              ),

                              // Expanded(
                              //   child: ItemHomePage(
                              //     image: AppImages.iconMarket,
                              //     title: "Chợ thuốc",
                              //     onPressed: () {
                              //       // Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(
                              //       //       builder: (context) =>
                              //       //           const ListMarketPage()),
                              //       // );
                              //       Navigator.pushNamed(
                              //         context,
                              //         AppRoutes.test,
                              //       );
                              //     },
                              //   ),
                              // ),
                              // Expanded(
                              //     child: ItemHomePage(
                              //         image: AppImages.inventoryControl,
                              //         title: "Kiểm kho",
                              //         onPressed: () {
                              //           // Navigator.pushNamed(
                              //           //   context,
                              //           //   AppRoutes.inventoryControlScreen,
                              //           // );
                              //           Navigator.pushNamed(
                              //             context,
                              //             AppRoutes.test,
                              //           );
                              //         })),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Consumer<HomeProvider>(
                              builder: (context, home, child) {
                            return home.loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppThemes.red0,
                                    ),
                                  )
                                : home.listProductReportRevenue.isEmpty
                                    ? const SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Top hàng hóa bán chạy tháng này",
                                            textAlign: TextAlign.left,
                                            style: AppFonts.bold(
                                                16, AppThemes.dark1),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 24,
                                                      horizontal: 8),
                                              child: PieChartSample2(
                                                  listDataReport: home
                                                      .listProductReportRevenue)),
                                        ],
                                      );
                          }),
                          Text(
                            "Doanh thu thuần tuần này (triệu đồng)",
                            textAlign: TextAlign.left,
                            style: AppFonts.bold(16, AppThemes.dark1),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Consumer<HomeProvider>(
                            builder: (context, home, child) {
                              return home.loading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : home.listRevenuesReport.isEmpty
                                      ? const SizedBox.shrink()
                                      : buildBarChart(home.listRevenuesReport);
                            },
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildBarChart(List<RevenuesReportModel> listRevenuesReport) {
    double getValueByLabel(String label) {
      final report = listRevenuesReport.firstWhere(
        (element) => element.label == label,
        orElse: () => RevenuesReportModel(label: label, revenue: 0),
      );
      return (report.revenue ?? 0).toDouble();
    }

    return BarChartHome(
      mon: getValueByLabel("T2"),
      tue: getValueByLabel("T3"),
      wed: getValueByLabel("T4"),
      thus: getValueByLabel("T5"),
      fri: getValueByLabel("T6"),
      sat: getValueByLabel("T7"),
      sun: getValueByLabel("CN"),
    );
  }
}
