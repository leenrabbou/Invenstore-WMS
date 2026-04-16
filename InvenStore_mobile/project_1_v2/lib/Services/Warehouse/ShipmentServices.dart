// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/Models/Warehouse/Shipment%20Models/AnShipmentResponseModel.dart';
import 'package:project_1_v2/Models/Warehouse/Shipment%20Models/ShipmentResponseModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class ShipmentServices {
  Future<ShipmentResponseModel> showAllShipmentsService(
    int page,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/shipments/?page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      ShipmentResponseModel response = ShipmentResponseModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnShipmentResponseModel> showAnShipmentService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/shipments/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnShipmentResponseModel response = AnShipmentResponseModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addShipmentService(
    String driverName,
    String cost,
    int shippingCompanyId,
    int orderId,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/shipments'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
      body: {
        'driver_name': driverName,
        'cost': cost,
        'shipping_company_id': shippingCompanyId.toString(),
        'order_id': orderId.toString(),
      },
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
