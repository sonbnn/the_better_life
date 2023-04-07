import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageProvider extends ChangeNotifier {
  int currentIndexPage = 0;
  int currentQuestPage = 0;
  bool isHideBottomNavbar = false;

  static PageProvider of(BuildContext context) => Provider.of<PageProvider>(context, listen: false);

  void setCurrentIndexPage(int index) {
    currentIndexPage = index;
    notifyListeners();
  }

  void setCurrentQuestPage(int index) {
    currentQuestPage = index;
  }

  void setBottomNavbar(bool isHideNavbar) {
    isHideBottomNavbar = isHideNavbar;
    notifyListeners();
  }
}
