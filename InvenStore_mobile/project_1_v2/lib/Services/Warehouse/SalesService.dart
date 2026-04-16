// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/AnSalesRequestModel.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/SalesRequestModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class SalesServices {
  Future<SalesRequestModel> showAllSalesOrdersService(
    int page,
    String? search,
    Locale locale,
  ) async {
    String url;
    search == null
        ? url = 'sales?page=$page'
        : url = 'sales?page=$page&&search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      SalesRequestModel response = SalesRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnSaleRequestModel> showAnSalesOrdersService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/sales/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnSaleRequestModel response = AnSaleRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addSaleOrderService(Locale locale, String buyerName) async {
    Map<String, dynamic> data = {'buyer_name': buyerName};
    for (int i = 0; i < salesProductsList.length; i++) {
      data.addAll({
        'products[$i][id]': salesProductsList[i].product.id.toString(),
        'products[$i][quantity]': salesProductsList[i].quantity.toString(),
      });
    }
    var response = await http.post(
      Uri.parse('$basicurl/sales'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
      body: data,
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);

      return res;
    } else if (response.statusCode == 422) {
      final data = json.decode(response.body);

      final res = ResponseModel2.fromJson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }
}
