// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Orders%20Models/OrderDataModel.dart';

class OrderRequestModel {
  int status;
  String message;
  OrderDataModel data;
  OrderRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory OrderRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return OrderRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: OrderDataModel.fromjson(jsonData['data']),
    );
  }
}
