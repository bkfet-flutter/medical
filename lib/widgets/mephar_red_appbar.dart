import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/resource/images/app_images.dart';

class MepharRedAppbar extends StatelessWidget {
  const MepharRedAppbar({
    super.key,
    this.body,
    this.backgroundColor,
    this.title,
    this.isCheck = false,
    this.onTapCheck,
    this.floatingActionButton,
  });
  final Widget? body;
  final Color? backgroundColor;
  final String? title;
  final bool isCheck;
  final Function()? onTapCheck;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            Image.asset(
              AppImages.backgroundHome,
              width: width,
              height: 120,
              fit: BoxFit.fill,
            ),
            Container(
              margin: const EdgeInsets.only(top: 27, right: 20, left: 20),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              AppImages.iconArrowLeft,
                              height: 16,
                              width: 7,
                              fit: BoxFit.fill,
                              color: Colors.white,
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          title ?? "Sản phẩm",
                          textAlign: TextAlign.center,
                          style: AppFonts.normalBold(
                            18,
                            Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                          child: isCheck
                              ? Image.asset(
                                  AppImages.iconTick,
                                  width: 15,
                                  height: 12,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.white,
                                )
                              : const SizedBox.shrink())
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: onTapCheck,
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
