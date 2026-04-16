// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Shipment%20Models/ShipmentModel.dart';

class AnShipmentResponseModel {
  int status;
  String message;
  ShipmentModel data;
  AnShipmentResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnShipmentResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return AnShipmentResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ShipmentModel.fromjson(jsonData['data']),
    );
  }
}
