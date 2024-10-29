import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier{
  bool searchBarTapped = false;
  switchToExpanded(val) {
    searchBarTapped = val;
    notifyListeners();
  }
}