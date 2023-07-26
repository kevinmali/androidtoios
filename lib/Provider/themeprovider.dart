import 'package:flutter/material.dart';
import 'package:pr_1/utils/thememodel.dart';

class themeprovider extends ChangeNotifier {
  Thememodel theme = Thememodel(isdark: true);
  void changetheme() {
    theme.isdark = !theme.isdark;
    notifyListeners();
  }
}
