import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/provider/product/price_setting_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/screens/price/list_price_setting.dart';
import 'package:mephar_app/widgets/app_number_paging.dart';
import 'package:mephar_app/widgets/mephar_big_appbar.dart';
import 'package:provider/provider.dart';

class PriceSettingScreen extends BaseScreen {
  const PriceSettingScreen({super.key});

  @override
  PriceSettingScreenState createState() => PriceSettingScreenState();
}

class PriceSettingScreenState extends BaseState<PriceSettingScreen> with BaseScreenMixin {
  @override
  Widget buildHeader() {
    return const SizedBox.shrink();
  }

  @override
  void afterFirstLayout(BuildContext context) =>
      context.read<PriceSettingProvider>().fetchPriceSettings(context, firstCall: true);

  @override
  Widget buildBody(BuildContext context) {
    return MepharBigAppbar(
      haveSuffixSearch: false,
      controllerSearch: context.watch<PriceSettingProvider>().keywordController,
      onFieldSubmitted: (value) => context.read<PriceSettingProvider>().changePage(context, 1),
      onChanged: (value) => context.read<PriceSettingProvider>().changePage(context, 1),
      title: "Thiết lập giá",
      body: Column(
        children: [
          Expanded(child: Container(color: const Color(0xffF3FAFF), child: const ListPriceSetting())),
          Container(
              decoration: const BoxDecoration(
                  color: AppThemes.white, border: Border(top: BorderSide(color: Color(0xffF5F5F5)))),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng: ${context.watch<PriceSettingProvider>().total}",
                    style: const TextStyle(
                        fontFamily: AppFonts.laTo, fontWeight: FontWeight.w500, fontSize: 14, color: AppThemes.dark2),
                  ),
                  AppNumberPaging(
                      currentPage: context.watch<PriceSettingProvider>().page,
                      totalPage: context.watch<PriceSettingProvider>().totalPage,
                      onTap: (value) => context.read<PriceSettingProvider>().changePage(context, value)),
                ],
              ))
        ],
      ),
    );
  }
}
