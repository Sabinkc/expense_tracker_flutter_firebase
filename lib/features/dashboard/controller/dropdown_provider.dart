import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String? value;

  void updateValue(String? value) {
    this.value = value;
    notifyListeners();
  }
}
