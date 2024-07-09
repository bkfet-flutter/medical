import 'package:flutter/material.dart';
import 'package:mephar_app/resource/fonts/app_fonts.dart';
import 'package:mephar_app/screens/base_screen/base_screen.dart';
import 'package:mephar_app/screens/base_screen/base_screen_mixin.dart';

class DemoScreen extends BaseScreen {
  const DemoScreen({super.key});

  @override
  DemoScreenState createState() => DemoScreenState();
}

class DemoScreenState extends BaseState<DemoScreen> with BaseScreenMixin {
  @override
  String setTitle() {
    // TODO: implement setTitle
    return "Thêm ";
  }

  @override
  TextStyle setTextStyleTitle() {
    return AppFonts.bold(16, Colors.black);
  }

  @override
  Color? setHeaderBackgroundColor() {
    // TODO: implement setHeaderBackgroundColor
    return Colors.white;
  }

  @override
  Widget? buildLeftWidget() {
    // TODO: implement buildLeftWidget
    return super.buildLeftWidget();
  }

  @override
  setOnPressLeftButton() {
    // TODO: implement setOnPressLeftButton
    return super.setOnPressLeftButton();
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    return super.showLoading();
  }

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Container();
  }
}
