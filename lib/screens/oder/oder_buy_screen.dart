import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/card_detail_product.dart';
import 'package:mephar_app/widgets/item_setting_account.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';

class OderBuyScreen extends StatelessWidget {
  const OderBuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MepharWhiteAppbar(
      elevation: 4,
      title: "Chi tiết đơn mua",
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [CardDetailProduct(listData: [])],
          ),
        ),
      ),
    );
  }
}
