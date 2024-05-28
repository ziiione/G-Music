import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void incrementCounter(int index) {
    _index = (index);
    notifyListeners();
  }
}