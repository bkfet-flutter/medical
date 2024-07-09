import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/box_store.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';

class ListStorePage extends StatelessWidget {
  const ListStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Danh sách cửa hàng',
        iconRight: AppImages.iconCart,
        haveSearchbar: true,
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
                10,
                (index) => const BoxStore()),
          ),
        ));
  }
}
