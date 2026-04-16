// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/AnOrderRequestModel.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderRequestModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class OrdersServices {
  Future<dynamic> addBuyOrderService(Locale locale) async {
    Map<String, dynamic> data = {};
    for (int i = 0; i < buyOrderProductsList.length; i++) {
      data.addAll({
        'products[$i][id]': buyOrderProductsList[i].product.id.toString(),
        'products[$i][quantity]': buyOrderProductsList[i].quantity.toString(),
      });
    }
    var response = await http.post(
      Uri.parse('$basicurl/orders/warhouse'),
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

  Future<AnOrderRequestModel> showAnOrderService(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<OrderRequestModel> showAllBuyOrdersService(
    int page,
    String? status,
    Locale locale,
  ) async {
    String url;
    status == null
        ? url = 'orders/buy/?page=$page'
        : url = 'orders/buy/?page=$page&filter[status]=$status';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      OrderRequestModel response = OrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<OrderRequestModel> showAllSupliesOrdersService(
    int page,
    String? status,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse(
        '$basicurl/orders/manufacturer/?page=$page&filter[status]=$status',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      OrderRequestModel response = OrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> deleteBuyOrdersService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.delete(
      Uri.parse('$basicurl/orders/$id/delete'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> recieveBuyOrdersService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id/receive'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> acceptSellOrdersService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id/accept'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> rejectSellOrdersService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.delete(
      Uri.parse('$basicurl/orders/$id/reject'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
