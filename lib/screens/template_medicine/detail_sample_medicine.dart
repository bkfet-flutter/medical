import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/supplier_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/supplier/single_supplier/supplier_debts.dart';
import 'package:mephar_app/screens/supplier/single_supplier/supplier_history.dart';
import 'package:mephar_app/screens/supplier/single_supplier/supplier_information.dart';

import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class SampleMedicineDetailScreen extends StatefulWidget {
  const SampleMedicineDetailScreen({super.key});

  @override
  State<SampleMedicineDetailScreen> createState() =>
      _SampleMedicineDetailScreenState();
}

class _SampleMedicineDetailScreenState extends State<SampleMedicineDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // int? id;

  // SupplierModel supplier;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    // final supplier =
    //     ModalRoute.of(context)!.settings.arguments as SupplierModel;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(builder: (context, supplier, child) {
      return MepharWhiteAppbar(
        backgroundColor: const Color(0xffF3FAFF),
        isCheck: false,
        title: supplier.supplier?.code,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffF3FAFF),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  supplier.supplier?.code ?? "Nhà cung cấp dược Hà Nội",
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
                    Tab(
                      text: "Lịch sử nhập/trả hàng",
                    ),
                    Tab(
                      text: "Nợ cần trả NCC",
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SupplierInformation(),
                  SupplierHistory(),
                  SupplierDebts(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
