// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Sales/AnSaleModel.dart';

class AnSaleRequestModel {
  int status;
  String message;
  AnSaleModel data;
  AnSaleRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnSaleRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return AnSaleRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: AnSaleModel.fromjson(jsonData['data']),
    );
  }
}
