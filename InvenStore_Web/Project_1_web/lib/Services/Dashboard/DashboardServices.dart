import 'dart:convert';
import 'dart:ui';

import 'package:buymore/Models/DashBoard/DashboardResponseModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

class DashboardServices {
  Future<DashboardResponseModel> getDataService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/dashboard'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      DashboardResponseModel data = DashboardResponseModel.fromjson(req);

      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
