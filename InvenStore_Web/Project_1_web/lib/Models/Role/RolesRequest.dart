// ignore_for_file: file_names

import 'package:buymore/Models/Role/RoleModel.dart';

class RolesRequestModel {
  int status;
  String message;
  List<RoleModel> data;
  RolesRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory RolesRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return RolesRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => RoleModel.fromjson(val))
          .toList(),
    );
  }
}
