// ignore_for_file: file_names

import 'package:buymore/Models/DashBoard/DataDashboardModel.dart';

class DashboardResponseModel {
  int status;
  String message;
  DataDashboardModel data;
  DashboardResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory DashboardResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return DashboardResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: DataDashboardModel.fromJson(jsonData['data']),
    );
  }
}
