import 'package:flutter/material.dart';

class BarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  PageController _pageController;
  BarProvider() {
    _pageController = PageController();
  }
  changePage(index) {
    _currentIndex = index;
    _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    notifyListeners();
  }

  PageController get pageController {
    return _pageController;
  }
}
