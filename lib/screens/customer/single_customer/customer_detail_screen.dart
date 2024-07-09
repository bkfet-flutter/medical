import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/customer_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/customer/single_customer/debts_from_customer.dart';
import 'package:mephar_app/screens/customer/single_customer/information_customer_screen.dart';
import 'package:mephar_app/screens/customer/single_customer/purchase_history.dart';
import 'package:mephar_app/screens/customer/single_customer/return_history.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, customer, child) {
        // final data =
        //     ModalRoute.of(context)!.settings.arguments as CustomerModel;
        return MepharWhiteAppbar(
          backgroundColor: const Color(0xffF3FAFF),
          isCheck: false,
          title: "Thông tin chi tiết khách hàng",
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffF3FAFF),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    customer.customer?.fullName ?? "Chu Dung",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.normalBold(
                      16,
                      AppThemes.dark1,
                    ).copyWith(height: 20 / 16),
                  ),
                ),
              ),
              Container(
                color: const Color(0xffF3FAFF),
                child: TabBar(
                    controller: tabController,
                    labelColor: AppThemes.red0,
                    unselectedLabelColor: AppThemes.dark3,
                    indicator: const CustomTabIndicator(
                        color: AppThemes.red0, indicatorHeight: 4),
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        text: "Thông tin",
                      ),
                      // Tab(
                      //   text: "Địa chỉ nhận hàng",
                      // ),
                      Tab(
                        text: "Nợ cần thu từ khách hàng",
                      ),
                      Tab(
                        text: "Lịch sử mua hàng",
                      ),
                      // Tab(
                      //   text: "Lịch sử trả hàng",
                      // ),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const InformationCustomerScreen(),
                    // CardDetailProduct(
                    //   onPressed: () {},
                    //   listData: const [
                    //     {
                    //       "titleLeft": "Chứng từ",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Phương thức",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Thời gian",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Đối tác",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Giá vốn",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Khối lượng",
                    //       "titleRight": "Content",
                    //     },
                    //     {
                    //       "titleLeft": "Tồn cuối",
                    //       "titleRight": "Content",
                    //     },
                    //   ],
                    // ),
                    const DebtsFromCustomer(),
                    const PurchaseHistory(),
                    // const ReturnHistory()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
