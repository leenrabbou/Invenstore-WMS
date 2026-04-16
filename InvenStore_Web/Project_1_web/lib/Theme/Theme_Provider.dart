// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:buymore/Theme/Theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  ThemeData get currentTheme => _darkTheme ? darkMode : lightMode;
  void toggleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _darkTheme = isDark;
    notifyListeners();
  }
}
