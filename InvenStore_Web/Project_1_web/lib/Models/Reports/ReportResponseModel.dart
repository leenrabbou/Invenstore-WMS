// ignore_for_file: file_names

import 'package:buymore/Models/Reports/OrderReportModel.dart';

class ReportsRequestModel {
  int status;
  String message;
  List<OrderReportModel> data;
  ReportsRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ReportsRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return ReportsRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => OrderReportModel.fromjson(val))
          .toList(),
    );
  }
}
