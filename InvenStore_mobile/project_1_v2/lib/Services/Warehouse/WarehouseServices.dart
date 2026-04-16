// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductRequestModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class WarehouseServices {
  Future<StoredProductRequestModel> showWarehousesService(
    Locale locale,
    int page,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/stored-products/warehouse?page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      StoredProductRequestModel response = StoredProductRequestModel.fromjson(
        data,
      );
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
