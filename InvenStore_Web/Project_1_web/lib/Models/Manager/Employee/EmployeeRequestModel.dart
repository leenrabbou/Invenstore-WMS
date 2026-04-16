// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Employee/EmployeeDataModel.dart';

class EmployeeRequestModel {
  int status;
  String message;
  EmployeeDataModel data;
  EmployeeRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory EmployeeRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return EmployeeRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: EmployeeDataModel.fromjson(jsonData['data']),
    );
  }
}
