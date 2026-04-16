// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class VerificationServices {
  Future<ResponseModel> getVerificationCode(Locale locale) async {
    final http.Response response = await http.get(
      Uri.parse('$basicurl/otp/email-verification'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );

    final data = json.decode(response.body);
    final ResponseModel res = ResponseModel.fromJson(data);

    return res;
  }

  Future<ResponseModel> sendVerificationCode(String otp, Locale locale) async {
    var response = await http.post(
      Uri.parse('$basicurl/otp/email-verification'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
      body: {'otp': otp},
    );

    final data = json.decode(response.body);
    final ResponseModel res = ResponseModel.fromJson(data);

    return res;
  }
}
