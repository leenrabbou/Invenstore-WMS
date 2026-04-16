// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LocalizationProvider with ChangeNotifier {
  Locale? _language = const Locale('en');

  Locale? get language => _language;
  void setLanguage(Locale? lang) {
    _language = lang;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_language == const Locale('en')) {
      _language = const Locale('ar');
    } else if (_language == const Locale('ar')) {
      _language == const Locale('en');
    }
    notifyListeners();
  }
}
