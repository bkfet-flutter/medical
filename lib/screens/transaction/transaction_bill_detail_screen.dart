import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/shipping_provider.dart';
import 'package:mephar_app/screens/transaction/transaction_bill_information.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class TransactionBillDetailScreen extends StatefulWidget {
  const TransactionBillDetailScreen({super.key});

  @override
  State<TransactionBillDetailScreen> createState() =>
      _TransactionBillDetailScreenState();
}

class _TransactionBillDetailScreenState
    extends State<TransactionBillDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingProvider>(builder: (context, ship, child) {
      return const MepharWhiteAppbar(
        backgroundColor:  Color(0xffF3FAFF),
        isCheck: false,
        title: "Chi tiết chuyển hàng",
        body: TransactionBillInformation(),
      );
    });
  }
}
