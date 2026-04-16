// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Sales/SaleDataModel.dart';

class SalesRequestModel {
  int status;
  String message;
  SaleDataModel data;
  SalesRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory SalesRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return SalesRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: SaleDataModel.fromjson(jsonData['data']),
    );
  }
}
