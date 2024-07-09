import 'package:flutter/material.dart';
import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';
import 'package:mephar_app/utils/app_function.dart';
import 'package:mephar_app/widgets/button_dialog.dart';

class MepharDialog extends StatelessWidget {
  final Widget? imageNotification;
  final String? title;
  final String? content;
  final double? horizontalWithScreen;
  final double? height;
  final bool? twoButton;
  final String? titleButton1;
  final String? titleButton2;

  final bool? isClose;
  final dynamic Function()? onTapButton1;
  final dynamic Function()? onTapButton2;
  final Widget? widgetContent;

  const MepharDialog({
    super.key,
    this.imageNotification,
    this.title,
    this.horizontalWithScreen,
    this.height,
    this.twoButton,
    this.titleButton1,
    this.titleButton2,
    this.isClose = false,
    this.content,
    this.onTapButton1,
    this.onTapButton2,
    this.widgetContent,
  });

  closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onWillPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: horizontalWithScreen ?? 40),
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (AppFunction.checkNullAndFalse(isClose) &&
                            imageNotification != null)
                        ? imageNotification!
                        : Stack(children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: imageNotification),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      AppImages.iconClose,
                                      height: 14,
                                      width: 14,
                                    )),
                              ),
                            ),
                          ]),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "Thông báo",
                          textAlign: TextAlign.center,
                          style: AppFonts.bold(20, AppThemes.dark0)
                              .copyWith(height: 24 / 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 100,
                          color: AppThemes.dark4,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        widgetContent ?? const SizedBox.shrink(),
                      ],
                    ),
                    Text(
                      content ?? "",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 18 / 14,
                          color: Color(0xff555770)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    !AppFunction.checkNullAndFalse(twoButton)
                        ? ButtonDialog(
                            onTap: onTapButton1 ??
                                onTapButton2 ??
                                () => closePopup(context),
                            title: titleButton1 ?? titleButton2,
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: ButtonDialog(
                                  isButtonWhite: true,
                                  onTap:
                                      onTapButton1 ?? () => closePopup(context),
                                  title: titleButton1,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: ButtonDialog(
                                  onTap:
                                      onTapButton2 ?? () => closePopup(context),
                                  title: titleButton2,
                                ),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
