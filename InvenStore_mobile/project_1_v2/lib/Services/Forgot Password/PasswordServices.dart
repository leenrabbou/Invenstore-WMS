// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class PasswordServices {
  Future<ResponseModel> getResetPasswordCode(
    String email,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/otp/password/forget-password'),
      headers: {'locale': locale.languageCode},
      body: {'email': email},
    );

    final data = json.decode(response.body);
    final ResponseModel res = ResponseModel.fromJson(data);

    return res;
  }

  Future<ResponseModel> sendResetPasswordCode(
    String email,
    String otp,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/otp/check'),
      headers: {'locale': locale.languageCode},
      body: {'email': email, 'otp': otp},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ResponseModel res = ResponseModel.fromJson(data);
      res.status = 2;
      return res;
    } else {
      final data = json.decode(response.body);
      final ResponseModel res = ResponseModel.fromJson(data);
      return res;
    }
  }

  Future<ResponseModel> resetPassword(
    String email,
    String otp,
    String password,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/otp/password/reset'),
      headers: {'locale': locale.languageCode},
      body: {'email': email, 'otp': otp, 'password': password},
    );

    final data = json.decode(response.body);
    final ResponseModel res = ResponseModel.fromJson(data);

    return res;
  }
}
