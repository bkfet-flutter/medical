import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/market/base/box_product.dart';
import 'package:mephar_app/screens/market/base/box_store.dart';
import 'package:mephar_app/screens/market/base/market_screen.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class DealerMarketPage extends StatefulWidget {
  final int type;

  const DealerMarketPage({super.key, required this.type});

  @override
  State<DealerMarketPage> createState() => _DealerMarketPageState();
}

class _DealerMarketPageState extends State<DealerMarketPage> {
  late Timer _timer;
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentBanner = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (currentBanner < 2) {
        currentBanner++;
      } else {
        currentBanner = 0;
      }
      pageController.animateToPage(
        currentBanner,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  //final List<MarketProduct> _listProduct = [];

  @override
  Widget build(BuildContext context) {
    List<MarketProduct> _listProduct = [
      MarketProduct(image: AppImages.medi1Pherelive, name: 'Pherelive'),
      MarketProduct(image: AppImages.medi2LaganinPlusQt, name: 'Laganin Plus QT'),
      MarketProduct(image: AppImages.medi3BothanKitonic, name: 'Bổ thận Kitonic'),
      MarketProduct(image: AppImages.medi4HoatHuyetTienDinhT250, name: 'Hoạt huyết tiền đình T250'),
      MarketProduct(image: AppImages.medi5AzMenQt, name: 'Az-Men QT'),
      MarketProduct(image: AppImages.medi6BegaminQt, name: 'Begamin QT'),
      MarketProduct(image: AppImages.medi7BefonicQt, name: 'Befonic QT'),
      MarketProduct(image: AppImages.medi8CalCiAdQt, name: 'CalCi AD QT'),
      MarketProduct(image: AppImages.medi9CalCiMinQt, name: 'CalCi Min QT'),
      MarketProduct(image: AppImages.medi10VienNgamThaoMocDiepAnThanh, name: 'Viên ngậm thảo mộc Diệp An Thanh'),
      MarketProduct(image: AppImages.medi11CalCiNano, name: 'CalCi Nano'),
      MarketProduct(image: AppImages.medi12DaiTrangQt, name: 'Đại Tràng QT'),
      MarketProduct(image: AppImages.medi13CebrainFore, name: 'Cebrain Fore'),
      MarketProduct(image: AppImages.medi14MutinNatureQt, name: 'Mutin Nature QT'),
      MarketProduct(image: AppImages.medi15HollyRectal, name: 'Holly Rectal'),
      MarketProduct(image: AppImages.medi16TheMan, name: 'The Man'),
      MarketProduct(image: AppImages.medi17JointExtra, name: 'JOINT Extra'),
      MarketProduct(image: AppImages.medi18Omega369Qt, name: 'Omega 3-6-9 QT'),
      MarketProduct(image: AppImages.medi19FeFolicQt, name: 'FeFolic QT'),
      MarketProduct(image: AppImages.medi20MumCareQt, name: 'MumCare QT'),
      MarketProduct(image: AppImages.medi21SiroHoCamQt, name: 'Siro HoCam QT'),
      MarketProduct(image: AppImages.medi22EyesGreenQt, name: 'EyesGreen QT'),
      MarketProduct(image: AppImages.medi23MinhTriNaoQt, name: 'Minh Tri Nao QT'),
      MarketProduct(image: AppImages.medi24ProEnzym, name: 'ProEnzym'),
      MarketProduct(image: AppImages.medi25PlusGinSengQt, name: 'Plus Gin Seng QT'),
      MarketProduct(image: AppImages.medi26OligoPlus, name: 'Oligo Plus'),
      MarketProduct(image: AppImages.medi27ProbiosQt, name: 'Probios QT'),
      MarketProduct(image: AppImages.medi28ProBiozyme, name: 'Pro Biozyme'),
      MarketProduct(image: AppImages.medi29QtSkin, name: 'QT Skin'),
      MarketProduct(image: AppImages.medi30SleepingSwishQt, name: 'Sleeping Swish QT'),
      MarketProduct(image: AppImages.medi31StomaxxGel, name: 'STOMAXX Gel'),
    ];
    return MarketScreen(
      title: widget.type == 0 ? 'Chợ đại lý' : 'Chợ công ty',
      iconRight: AppImages.iconCart,
      haveSearchbar: true,
      cancelSearch: () {
        Navigator.pushNamed(context, AppRoutes.searchPage);
      },
      onTapIconRight: () {
        Navigator.pushNamed(context, AppRoutes.cartPage);
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.type == 0)
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        BoxStore(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TouchableWidget(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.productInMarket);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Danh sách sản phẩm trên chợ',
                                    style: TextStyle(
                                        fontFamily: AppFonts.laTo,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppThemes.dark1),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Image.asset(
                                  AppImages.iconArrowNext,
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.45,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentBanner = page;
                  });
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Image.asset(
                    AppImages.bannerDemo,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.45,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: InkWell(
                          onTap: () {},
                          child: AnimatedContainer(
                              curve: Curves.easeIn,
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: index == currentBanner ? const Color(0xffEE0033) : AppThemes.light1,
                              ),
                              duration: const Duration(milliseconds: 500)),
                        ),
                      )),
            ),
            (widget.type == 0)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.listStorePage);
                          },
                          child: SizedBox(
                            width: 80,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.iconPharmacy,
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Danh sách chi nhánh',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: AppFonts.laTo,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppThemes.dark2),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.orderPage);
                          },
                          child: SizedBox(
                            width: 80,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.iconBillDown,
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Đơn hàng',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: AppFonts.laTo,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppThemes.dark2),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Text(
                'Danh sách sản phẩm',
                style: TextStyle(
                    fontFamily: AppFonts.laTo, fontWeight: FontWeight.w700, fontSize: 16, color: AppThemes.dark1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Wrap(
                runSpacing: 16,
                children: List.generate(
                    _listProduct.length,
                    (index) => BoxProduct(
                          urlImage: _listProduct[index].image,
                          name: _listProduct[index].name,
                          soldNumber: (index + 1) * 10,
                          extraDiscount: index % 5 == 0,
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MarketProduct {
  String image;
  String name;

  MarketProduct({required this.image, required this.name});
}
