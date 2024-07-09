import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/base/status_order_widget.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';

class PurchaseOrderPage extends StatefulWidget {
  const PurchaseOrderPage({super.key});

  @override
  State<PurchaseOrderPage> createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 9, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Đơn hàng mua',
        haveSearchbar: true,
        body: Column(
          children: [
            TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: const Color(0xffEE0033),
                labelColor: const Color(0xffEE0033),
                unselectedLabelColor: AppThemes.dark1,
                labelStyle: const TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffEE0033)),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: AppFonts.laTo, fontSize: 14, fontWeight: FontWeight.w500, color: AppThemes.dark3),
                indicator: const CustomTabIndicator(color: Color(0xffEE0033)),
                tabs: const [
                  Tab(
                    text: 'Tất cả',
                  ),
                  Tab(
                    text: 'Chờ xác nhận',
                  ),
                  Tab(
                    text: 'Đã xác nhận',
                  ),
                  Tab(
                    text: 'Đã Giao cho ĐVCC',
                  ),
                  Tab(
                    text: 'Đang giao hàng',
                  ),
                  Tab(
                    text: 'Thành công',
                  ),
                  Tab(
                    text: 'Đã huỷ',
                  ),
                  Tab(
                    text: 'Giao hàng thất bại',
                  ),
                  Tab(
                    text: 'Đã thanh toán',
                  ),
                ]),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        8,
                        (index) => Container(
                              alignment: Alignment.center,
                              child: StatusOrderWidget(
                                code: 'ĐH 13225',
                                status: index,
                                timeOrder: "12/07/2023",
                                price: "335.000đ",
                                countProduct: 3,
                                seller: 'Đại lý 1',
                                shipping: 'Giao hàng tiết kiệm',
                              ),
                            )),
                  ),
                ),
                ...List.generate(
                    8,
                    (index) => Container(
                          alignment: Alignment.center,
                          child: StatusOrderWidget(
                            code: 'ĐH 13225',
                            status: index,
                            timeOrder: "12/07/2023",
                            price: "335.000đ",
                            countProduct: 3,
                            seller: 'Đại lý 1',
                            shipping: 'Giao hàng tiết kiệm',
                          ),
                        ))
              ],
            ))
          ],
        ));
  }
}
