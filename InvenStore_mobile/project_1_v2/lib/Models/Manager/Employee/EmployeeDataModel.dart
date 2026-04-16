// ignore_for_file: file_names

import 'package:project_1_v2/Models/Manager/Employee/EmployeeModel.dart';

class EmployeeDataModel {
  int currentPage, lastPage;
  List<EmployeeModel> data;
  EmployeeDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory EmployeeDataModel.fromjson(Map<String, dynamic> jsonData) {
    return EmployeeDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => EmployeeModel.fromjson(val)).toList(),
    );
  }
}
