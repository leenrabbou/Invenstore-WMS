// ignore_for_file: file_names

import 'dart:convert';

import 'package:project_1_v2/Models/Role/RoleModel.dart';
import 'package:project_1_v2/Models/Role/RolesRequest.dart';
import 'package:project_1_v2/helper/Constant.dart';
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
}
