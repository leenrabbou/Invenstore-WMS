// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:buymore/Models/Manager/Distribution%20Center/CenterModel.dart';
import 'package:buymore/Models/Manager/Distribution%20Center/CenterResponseModel.dart';
import 'package:buymore/Models/Manager/Warehouse/WarehouseModel.dart';
import 'package:buymore/Models/Manager/Warehouse/WarehouseRequestModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

List<WarehouseModel> warehousesList = [];
List<CenterModel> centersList = [];

class WarehouseServices {
  Future<WarehouseRequestModel> showAllWarehousesService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/warehouses'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      WarehouseRequestModel response = WarehouseRequestModel.fromjson(data);
      warehousesList.addAll(response.data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<CenterResponseModel> showAllCentersService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/distribution-center'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      CenterResponseModel response = CenterResponseModel.fromjson(data);
      centersList.addAll(response.data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
