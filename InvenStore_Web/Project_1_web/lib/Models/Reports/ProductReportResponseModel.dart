// ignore_for_file: file_names

import 'package:buymore/Models/Reports/ProductListReportModel.dart';

class ProductReportsRequestModel {
  int status;
  String message;
  ProductListReportModel data;
  ProductReportsRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ProductReportsRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return ProductReportsRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ProductListReportModel.fromjson(jsonData['data']),
    );
  }
}
