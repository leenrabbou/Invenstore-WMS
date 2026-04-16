// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Employee/EmployeeModel.dart';

class AnEmployeeModel {
  int status;
  String message;
  EmployeeModel data;
  AnEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnEmployeeModel.fromjson(Map<String, dynamic> jsonData) {
    return AnEmployeeModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: EmployeeModel.fromjson(jsonData['data']),
    );
  }
}
