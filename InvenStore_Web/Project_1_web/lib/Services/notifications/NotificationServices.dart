import 'dart:convert';
import 'dart:ui';

import 'package:buymore/Models/Notifications/NotificationResponseModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  Future<NotificationResponseModel> getAllnotificationsService(
      Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      NotificationResponseModel data = NotificationResponseModel.fromjson(req);

      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<int> markAsReadnotificationsService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/notifications/mark-all'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    json.decode(res.body);
    return res.statusCode;
  }
}
