// ignore_for_file: file_names

import 'package:project_1_v2/helper/Constant.dart';
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
    permissions.clear();
    token = '';
    profile = null;
    return res.statusCode;
  }
}
