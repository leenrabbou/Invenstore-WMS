// ignore_for_file: file_names

import 'package:buymore/Models/Reports/SpecificDataModel.dart';

class SpecificProductReportResposeModel {
  int status;
  String message;
  SpecificDataModel data;
  SpecificProductReportResposeModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory SpecificProductReportResposeModel.fromjson(
      Map<String, dynamic> jsonData) {
    return SpecificProductReportResposeModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: SpecificDataModel.fromjson(jsonData['data']),
    );
  }
}
