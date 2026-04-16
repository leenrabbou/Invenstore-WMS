// ignore_for_file: file_names

import 'package:buymore/helper/Constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogOutService {
  Future<int> logOut(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    role = '';
    permissionsMap.updateAll((key, value) => false);
    token = '';
    userAccount = null;
    managerAccount = null;
    return res.statusCode;
  }
}
