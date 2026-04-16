// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Orders%20Models/AnOrderModel.dart';

class AnOrderRequestModel {
  int status;
  String message;
  AnOrderModel data;
  AnOrderRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnOrderRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return AnOrderRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: AnOrderModel.fromjson(jsonData['data']),
    );
  }
}
