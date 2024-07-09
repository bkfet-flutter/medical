import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';
import 'package:mephar_app/utils/extension.dart';
import 'package:mephar_app/widgets/mephar_button.dart';
import 'package:mephar_app/widgets/normal_text.dart';

class OnboardingScreen extends BaseScreen {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends BaseState<OnboardingScreen> with BaseScreenMixin {
  int currentIndex = 0;

  late Timer _timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (currentIndex < 4) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      controller.animateToPage(
        currentIndex,
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

  @override
  Widget buildHeader() => const SizedBox.shrink();

  @override
  Color setMainBackgroundColor() => AppThemes.white;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset(
                AppImages.logoMephar,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: controller,
              children: [
                _buildContent(
                    image: AppImages.imageOnboarding3,
                    title: "Ứng dụng quản lý bán hàng hoàn toàn miễn phí",
                    description: "Chuyên biệt dành riêng cho nhà thuốc, quầy thuốc"),
                _buildContent(
                  image: AppImages.imageOnboarding1,
                  title: "Quản lý nhà thuốc, quầy thuốc chuẩn GPP",
                  description: "Liên thông cơ sở dữ liệu dược quốc gia",
                ),
                _buildContent(
                  image: AppImages.imageOnboarding4,
                  title: "Tạo đơn cắt liều nhanh chóng chỉ với 5 giây",
                  description: "Giúp bán thuốc, cắt liều nhanh chóng tiện lợi",
                ),
                _buildContent(
                  image: AppImages.imageOnboarding5,
                  title: "Báo cáo bán hàng chi tiết rõ ràng",
                  description: "Cập nhập nhanh chóng theo thời gian thực trên mọi thiết bị",
                ),
                _buildContent(
                  image: AppImages.imageOnboarding2,
                  title: "Kiểm soát hàng tồn kho, hàng cận date chính xác",
                  description: "Theo giõi cảnh báo số lượng hàng tồn, cận date liên tục kịp thời",
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          if (index == 1) {
                            controller.animateToPage(1,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else if (index == 2) {
                            controller.animateToPage(2,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else if (index == 3) {
                            controller.animateToPage(3,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else if (index == 4) {
                            controller.animateToPage(4,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          } else if (index == 0) {
                            controller.animateToPage(0,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          }
                        },
                        child: AnimatedContainer(
                            curve: Curves.easeIn,
                            height: 8,
                            width: index == currentIndex ? 28 : 9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: index == currentIndex ? AppThemes.red0 : AppThemes.red4,
                            ),
                            duration: const Duration(milliseconds: 500)),
                      ),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                MepharButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.loginScreen,
                    );
                  },
                  titleButton: "Đăng nhập ngay",
                ),
                const SizedBox(
                  height: 12,
                ),
                MepharButton(
                  isButtonWhite: true,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.registerScreen,
                      arguments: false,
                    );
                  },
                  titleButton: "Đăng ký",
                ),
              ],
            ),
          ),
        ].addBetween(const SizedBox(height: 20), bound: true),
      ),
    );
  }

  Widget _buildContent({required String image, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 15,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NormalText(
                title,
                minFontSize: 12,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppFonts.ultraBold(22, const Color(0xff1F1F39)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NormalText(
                description,
                minFontSize: 8,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppFonts.light(16, const Color(0xff858597)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
