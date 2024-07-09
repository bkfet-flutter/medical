import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/network/api_request.dart';
import 'package:mephar_app/provider/promotion_provider.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_form.dart';
import 'package:mephar_app/screens/configuration/promotion/promotion_information.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/button_delete.dart';
import 'package:mephar_app/widgets/custom_tab_indicator.dart';
import 'package:mephar_app/widgets/mephar_white_appbar.dart';
import 'package:provider/provider.dart';

class PromotionDetailScreen extends StatefulWidget {
  const PromotionDetailScreen({super.key});

  @override
  State<PromotionDetailScreen> createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> with SingleTickerProviderStateMixin {
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
    var promotion = Provider.of<PromotionProvider>(context);
    return MepharWhiteAppbar(
      backgroundColor: const Color(0xffF3FAFF),
      isCheck: false,
      title: context.watch<PromotionProvider>().promotionDetail.code,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffF3FAFF),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Khuyến mại",
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
            alignment: Alignment.centerLeft,
            child: TabBar(
                controller: tabController,
                labelColor: AppThemes.red0,
                unselectedLabelColor: AppThemes.dark3,
                indicator: const CustomTabIndicator(color: AppThemes.red0, indicatorHeight: 4),
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: "Thông tin",
                  ),
                  Tab(
                    text: "Hình thức khuyến mại",
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                PromotionInformation(),
                PromotionForm(),
              ],
            ),
          ),
          ButtonDelete(
            onTap: () {
              AppFunction.showDialogAlert(context,
                  title: "Xóa khuyến mãi",
                  styleTitle: AppFonts.bold(20, AppThemes.dark0),
                  showBtnClose: true,
                  widgetDescription: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Image.asset(
                        AppImages.boyQuestion,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Bạn có chắc chắn muốn xóa khuyến mãi này không?",
                        style: AppFonts.light(
                          16,
                          AppThemes.dark2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                  text1stButton: "Hủy",
                  isTwoButton: true,
                  onPress1stButton: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  text2ndButton: "Xóa",
                  onPress2ndButton: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    ApiRequest.deletePromotion(promotion.promotionDetail.id);
                    Navigator.pop(context, true);
                  });
            },
          ),
        ],
      ),
    );
  }
}
