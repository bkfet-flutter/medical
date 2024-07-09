import 'package:flutter/material.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/box_product.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
      title: 'Tìm kiếm',
      iconRight: AppImages.iconCart,
      haveFilterBar: true,
      haveSearchbar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Wrap(
          runSpacing: 16,
          children: List.generate(1, (index) => const BoxProduct()),
        ),
      ),
    );
  }
}
