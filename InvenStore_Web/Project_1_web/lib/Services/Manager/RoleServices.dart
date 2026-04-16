// ignore_for_file: file_names

import 'dart:convert';

import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Models/Role/RoleModel.dart';
import 'package:buymore/Models/Role/RolesRequest.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:ui';

List<RoleModel> warehouseRolesList = [];
List<RoleModel> centersRolesList = [];

class RolesServices {
  Future<RolesRequestModel> warehouseRolesService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/roles/warehouse'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      RolesRequestModel data = RolesRequestModel.fromjson(req);
      warehouseRolesList = data.data;
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<RolesRequestModel> centerRolesService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/roles/distribution-center'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      RolesRequestModel data = RolesRequestModel.fromjson(req);
      centersRolesList = data.data;
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addRoleService(
      String name, String type, List<String> per, Locale locale) async {
    Map<String, dynamic> data = {};
    for (int i = 0; i < per.length; i++) {
      data.addAll({
        'permissions[$i]': per[i],
      });
    }
    data.addAll({
      'name': name,
      'type': type,
    });
    var response = await http.post(
      Uri.parse('$basicurl/roles'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );
    if (kDebugMode) {
      print(response);
    }
    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);

      if (kDebugMode) {
        print(res);
      }
      await warehouseRolesService(locale);
      await centerRolesService(locale);
      return res;
    } else if (response.statusCode == 422) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);
      res.message = 'name has been taken';
      if (kDebugMode) {
        print(res);
      }
      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }
}
