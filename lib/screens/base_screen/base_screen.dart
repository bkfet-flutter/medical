import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mephar_app/app/app_theme.dart';
import 'package:mephar_app/widgets/loading_widget.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseState<Screen extends BaseScreen> extends State<Screen> {
  // abstract functions
  Widget buildBody(BuildContext context);

  // other functions and Variable
  Widget buildHeader() => Container(); //header of screen

  bool blankPage() => false; // true: use function only

  bool fixSizeHeader() =>
      false; // true: màn hình có kiểu header dài, content phía dưới dè lên header
  bool fixExpanded() => true;
  Color setMainBackgroundColor() => AppThemes.backgroundLight;

  Color setStatusBarColor() => AppThemes.transparent; // Android only

  void setStatusBarStyle(StyleOfStatusBarContent styleOfStatusBarContent) {
    SystemChrome.setSystemUIOverlayStyle(styleOfStatusBarContent.androidStyle!
        .copyWith(
            statusBarColor: setStatusBarColor(),
            statusBarBrightness: styleOfStatusBarContent.iosStyle));
  } // light or dark

  void afterFirstLayout(BuildContext context) =>
      () {}; // hàm gọi 1 lần duy nhất sau khi build widget lần đầu

  bool _isLoading = false;
  Timer? timerLoading;

  // String getString(String key) {
  //   return NPSaleLocalizations.of(context).getStringLabel(context, key);
  // }

  showLoading() {
    if (timerLoading != null) timerLoading?.cancel();
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    timerLoading = Timer(const Duration(seconds: 30), hideLoading);
  }

  hideLoading() {
    if (timerLoading != null) timerLoading?.cancel();
    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setStatusBarStyle(StyleOfStatusBarContent(StatusBarStyle.light));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  @override
  void dispose() {
    //hideLoading();
    super.dispose();
  }

  // build UI

  buildLoading() {
    return _isLoading ? const LoadingWidget() : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        blankPage()
            ? buildBody(context) // nhận context của cả widget
            : GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: fixExpanded(),
                  body: Builder(
                    builder: (context) => Container(
                      color: setMainBackgroundColor(),
                      child: (fixSizeHeader()
                          ? Stack(
                              children: <Widget>[
                                Container(child: buildHeader()),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ((MediaQuery.of(context).size.width /
                                                  15) *
                                              3.2) +
                                          (MediaQuery.of(context).padding.top >
                                                  24
                                              ? 15
                                              : 0)),
                                  child: buildBody(
                                      context), // nhận context của Scaffold không phải của cả widget
                                ),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                buildHeader(),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: buildBody(
                                        context), // nhận context của Scaffold không phải của cả widget
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                ),
              ),
        buildLoading(),
      ],
    );
  }
}

class StyleOfStatusBarContent {
  SystemUiOverlayStyle? androidStyle;
  Brightness? iosStyle;

  StyleOfStatusBarContent(StatusBarStyle statusBarStyle) {
    switch (statusBarStyle) {
      case StatusBarStyle.dark:
        androidStyle = SystemUiOverlayStyle.dark;
        iosStyle = Brightness.light;
        break;
      case StatusBarStyle.light:
        androidStyle = SystemUiOverlayStyle.light;
        iosStyle = Brightness.dark;
        break;
    }
  }
}

enum StatusBarStyle {
  dark,
  light,
}
