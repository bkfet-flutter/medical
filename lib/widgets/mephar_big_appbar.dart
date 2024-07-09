import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/dimens_scale.dart';
import 'package:mephar_app/widgets/header_button.dart';
import 'package:mephar_app/widgets/mephar_search.dart';

class MepharBigAppbar extends StatelessWidget {
  const MepharBigAppbar({
    super.key,
    this.title,
    required this.body,
    this.backgroundColor,
    this.haveOneIcon = false,
    this.haveTwoIcon = false,
    this.haveIconNearSearch = false,
    this.iconNearSearch,
    this.floatingActionButton,
    this.haveSuffixSearch = true,
    this.onTapIconNearSearch,
    this.icon,
    this.haveBack = true,
    this.onFieldSubmitted,
    this.controllerSearch,
    this.customAppBar = false,
    this.customWidget,
    this.bottomNavigationBar,
    this.onChanged,
    this.resizeToAvoidBottomInset,
    this.hintSearch,
    this.noFilter,
  });

  final String? title;
  final Widget body;
  final Color? backgroundColor;
  final bool haveOneIcon;
  final bool haveTwoIcon;
  final bool haveIconNearSearch;
  final String? iconNearSearch;
  final Widget? bottomNavigationBar;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function()? onTapIconNearSearch;
  final bool haveSuffixSearch;
  final String? icon;
  final String? hintSearch;
  final bool haveBack;
  final TextEditingController? controllerSearch;
  final bool? customAppBar;
  final bool? noFilter;
  final bool? resizeToAvoidBottomInset;
  final Widget? customWidget;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    double? addSizeHeight =
        MediaQuery.of(context).padding.top > 24 ? DimensScale.getInstance(context)?.verticalScale(5) : 0;
    double heightHeaderContent =
        DimensScale.getInstance(context)!.verticalScale(80) - MediaQuery.of(context).padding.top + addSizeHeight!;
    double heightHeader = (DimensScale.getInstance(context)?.verticalScale(80))! + addSizeHeight;
    return Scaffold(
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? const Color(0xffF3FAFF),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                AppImages.backgroundHome,
                width: MediaQuery.of(context).size.width,
                height: heightHeader + 65,
                fit: BoxFit.fill,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: heightHeader,
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: heightHeader - MediaQuery.of(context).padding.top,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: heightHeaderContent,
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: haveBack
                                      ? HeaderButton(
                                          iconColor: Colors.white,
                                          icon: AppImages.iconArrowLeft,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          iconHeight: DimensScale.getInstance(context)?.verticalScale(18),
                                          iconWidth: DimensScale.getInstance(context)?.scale(9),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    title ?? "Thiết lập giá",
                                    textAlign: TextAlign.center,
                                    style: AppFonts.normalBold(
                                      18,
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                haveTwoIcon
                                    ? Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Image.asset(
                                                  AppImages.iconSetting,
                                                  height: 20,
                                                  width: 20,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                child: Image.asset(
                                                  icon ?? AppImages.iconExcel,
                                                  height: 28,
                                                  width: 24,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                    : haveOneIcon
                                        ? Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                icon ?? AppImages.iconExcel,
                                                height: 28,
                                                width: 24,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        : const Expanded(child: SizedBox.shrink())
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 20,
                  left: 20,
                  bottom: 12,
                  child: haveIconNearSearch
                      ? Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: customAppBar == false
                                    ? MepharSearch(
                                        onFieldSubmitted: onFieldSubmitted,
                                        haveSuffix: haveSuffixSearch,
                                        controllerSearch: controllerSearch,
                                        onChanged: onChanged,
                                        hintText: hintSearch,
                                      )
                                    : customWidget!),
                            noFilter == true
                                ? SizedBox.shrink()
                                : Expanded(
                                    child: InkWell(
                                    onTap: onTapIconNearSearch,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          iconNearSearch ?? AppImages.iconSetting2,
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.fill,
                                        )),
                                  ))
                          ],
                        )
                      : MepharSearch(
                          controllerSearch: controllerSearch,
                          onFieldSubmitted: onFieldSubmitted,
                          haveSuffix: haveSuffixSearch,
                          onChanged: onChanged,
                          hintText: hintSearch,
                        ))
            ],
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
