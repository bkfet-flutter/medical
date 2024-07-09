import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mephar_app/app/app_routes.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/touchable_widget.dart';

class OderScreen extends StatelessWidget {
  final String? title;
  final String? iconRight;
  final String? iconLeft;
  final String? hintSearch;
  final Widget? rightWidget;
  final Widget body;
  final bool? haveSearchbar;
  final bool? haveBack;
  final bool? haveFilterBar;
  final void Function()? cancelSearch;
  final void Function()? onTapIconRight;

  const OderScreen(
      {super.key,
      this.title,
      this.rightWidget,
      this.iconRight,
      required this.body,
      this.haveSearchbar,
      this.cancelSearch,
      this.haveFilterBar,
      this.iconLeft,
      this.onTapIconRight,
      this.hintSearch,
      this.haveBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppThemes.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppThemes.white,
        leading: haveBack == false
            ? const SizedBox.shrink()
            : HeaderButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconWidth: 24,
                iconHeight: 24,
                mini: true,
                icon: iconLeft ?? AppImages.iconArrowBack,
                iconColor: AppThemes.dark1,
              ),
        centerTitle: true,
        title: Text(
          title ?? "",
          style: const TextStyle(
              fontFamily: AppFonts.laTo, fontWeight: FontWeight.w700, fontSize: 18, color: AppThemes.dark1),
        ),
        actions: [
          iconRight != null
              ? HeaderButton(
                  mini: true,
                  onPressed: onTapIconRight,
                  icon: iconRight,
                  iconHeight: 24,
                  iconWidth: 24,
                )
              : TouchableWidget(
                  onPressed: onTapIconRight,
                  child: (rightWidget != null) ? rightWidget! : const SizedBox.shrink(),
                )
        ],
      ),
      body: haveSearchbar == true
          ? Column(
              children: [
                (cancelSearch != null)
                    ? TouchableWidget(
                        onPressed: cancelSearch,
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(33), color: AppThemes.light2),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Image.asset(
                                AppImages.iconSearch,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                                child: TextFormField(
                              readOnly: true,
                              style: const TextStyle(
                                  fontFamily: AppFonts.laTo,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppThemes.dark2,
                                  height: 1.25),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Tìm kiếm",
                                  hintStyle: TextStyle(
                                      fontFamily: AppFonts.laTo,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppThemes.dark2,
                                      height: 1.25)),
                            ))
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(33), color: AppThemes.light2),
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      AppImages.iconSearch,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: AppFonts.laTo,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: AppThemes.dark2,
                                        height: 1.25),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: hintSearch ?? "Tìm kiếm",
                                        hintStyle: const TextStyle(
                                            fontFamily: AppFonts.laTo,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppThemes.dark2,
                                            height: 1.25)),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          haveFilterBar == true
                              ? TouchableWidget(
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.filterMarketPage);
                                  },
                                  margin: const EdgeInsets.only(right: 20, left: 8),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    AppImages.filterRed,
                                    width: 20,
                                    height: 20,
                                  ),
                                )
                              : const SizedBox(width: 20)
                        ],
                      ),
                Expanded(child: body)
              ],
            )
          : body,
    );
  }
}
