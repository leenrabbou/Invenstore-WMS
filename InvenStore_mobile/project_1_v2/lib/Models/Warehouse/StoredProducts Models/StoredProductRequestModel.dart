// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductDataModel.dart';

class StoredProductRequestModel {
  int status;
  String message;
  StoredProductDataModel data;
  StoredProductRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory StoredProductRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return StoredProductRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: StoredProductDataModel.fromjson(jsonData['data']),
    );
  }
}
