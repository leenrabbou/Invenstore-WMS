// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductDataModel.dart';

class AllProductRequestModel {
  int status;
  String message;
  AllProductDataModel data;
  AllProductRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AllProductRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return AllProductRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: AllProductDataModel.fromjson(jsonData['data']),
    );
  }
}
