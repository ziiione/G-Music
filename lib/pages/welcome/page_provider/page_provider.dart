import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void incrementCounter(int index) {
    _index = index;
    notifyListeners();
  }
}