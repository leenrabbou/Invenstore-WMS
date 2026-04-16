// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Shipment%20Models/ShipmentDataModel.dart';

class ShipmentResponseModel {
  int status;
  String message;
  ShipmentDataModel data;
  ShipmentResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ShipmentResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return ShipmentResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ShipmentDataModel.fromjson(jsonData['data']),
    );
  }
}
