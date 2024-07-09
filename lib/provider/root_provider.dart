import 'package:flutter/material.dart';
import 'package:mephar_app/screens/home/add_setting_screen.dart';
import 'package:mephar_app/screens/home/home_page_screen.dart';
import 'package:mephar_app/screens/oder/list_oder_screen.dart';
import 'package:mephar_app/screens/product/list_of_products_screen.dart';

class RootProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  pageChange(int page) {
    _currentPage = page;
    notifyListeners();
  }

  List<Widget> tabs = <Widget>[
    const HomePageScreen(),
    const ListOfProductScreen(),
    const SizedBox.shrink(),
    const ListOderPage(),
    const AddSettingScreen(),
  ];

}
