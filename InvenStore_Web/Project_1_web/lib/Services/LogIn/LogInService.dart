// ignore_for_file: file_names

import 'dart:convert';

import 'package:buymore/Models/LogIn/LogInResponsetModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

class LogInService {
  Future<int> logInService(String email, String password, Locale locale) async {
    var response = await http.post(Uri.parse('$basicurl/login'),
        headers: {'locale': locale.languageCode, "Accept": "application/json"},
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final LogInResponsetModel res = LogInResponsetModel.fromjson(data);
      if (res.data != null) {
        role = res.data!.roles!.first;
        token = res.data!.token!;
        userId = res.data!.id;
        res.data!.emailVerifiedAt == null ? verified = false : verified = true;
        if (kDebugMode) {
          print(token);
        }

        if (res.data!.permissions != null) {
          permissions = res.data!.permissions!;
          for (int i = 0; i < permissions.length; i++) {
            permissionsMap[permissions[i]] = true;
          }
        }
      } else {
        throw Exception('${response.statusCode} with ${response.body}');
      }
    }
    return response.statusCode;
  }
}
