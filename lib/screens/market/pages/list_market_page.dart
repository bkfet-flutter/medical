import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/screens/market/pages/dealer_market_page.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ListMarketPage extends StatelessWidget {
  const ListMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketScreen(
        title: 'Chợ',
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TouchableWidget(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DealerMarketPage(type: 0)),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.iconOrderUp,
                      width: 45,
                      height: 45,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        "Chợ đại lý",
                        style: TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppThemes.dark1),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      AppImages.iconArrowNext,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 16),
                color: const Color(0xffEBEBF0),
              ),
              TouchableWidget(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DealerMarketPage(type: 1)),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.iconOrderDown,
                      width: 45,
                      height: 45,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        "Chợ công ty",
                        style: TextStyle(
                            fontFamily: AppFonts.laTo,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppThemes.dark1),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      AppImages.iconArrowNext,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
