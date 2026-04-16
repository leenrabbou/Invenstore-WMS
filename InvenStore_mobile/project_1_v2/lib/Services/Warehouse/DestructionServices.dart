// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/AnDestructionResponseModel.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionCausesModel.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionCausesResponseModel.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionResponseModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

List<DestructionCausesModel> destructionCausesList = [];

class DestructionServices {
  Future<DestructionCausesResponseModel> getAllDestructionCausesService(
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/destruction-causes'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      DestructionCausesResponseModel data =
          DestructionCausesResponseModel.fromjson(req);
      destructionCausesList = data.data;
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<DestructionResponseModel> showAllDestructionsService(
    int page,
    String? search,
    Locale locale,
  ) async {
    String url;
    search == null
        ? url = 'destruction?page=$page'
        : url = 'destruction?page=$page&&search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      DestructionResponseModel data = DestructionResponseModel.fromjson(req);
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnDestructionCausesResponseModel> showAnDestructionsService(
    Locale locale,
    int id,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/destruction/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      AnDestructionCausesResponseModel data =
          AnDestructionCausesResponseModel.fromjson(req);
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addDestructionService(
    int id,
    int quantity,
    int causeId,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/stored-products/$id/destruction'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
      body: {'quantity': quantity.toString(), 'cause_id': causeId.toString()},
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
