import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/oder/oder_screen.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class ListOderPage extends StatelessWidget {
  const ListOderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OderScreen(
        title: 'Đơn hàng',
        haveBack: false,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TouchableWidget(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const DealerMarketPage(type: 0)),
                  // );
                  Navigator.pushNamed(context, AppRoutes.customerPayScreen);
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
                        "Đơn hàng bán",
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
              // TouchableWidget(
              //   padding: const EdgeInsets.all(0),
              //   onPressed: () {
              //     Navigator.pushNamed(
              //       context,
              //       AppRoutes.oderBuy,
              //     );
              //   },
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         AppImages.iconOrderDown,
              //         width: 45,
              //         height: 45,
              //       ),
              //       const SizedBox(width: 6),
              //       const Expanded(
              //         child: Text(
              //           "Đơn hàng mua",
              //           style: TextStyle(
              //               fontFamily: AppFonts.laTo,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //               color: AppThemes.dark1),
              //         ),
              //       ),
              //       const SizedBox(width: 16),
              //       Image.asset(
              //         AppImages.iconArrowNext,
              //         width: 20,
              //         height: 20,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
