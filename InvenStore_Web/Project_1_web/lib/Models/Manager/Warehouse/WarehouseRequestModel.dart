// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Warehouse/WarehouseModel.dart';

class WarehouseRequestModel {
  int status;
  String message;
  List<WarehouseModel> data;
  WarehouseRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory WarehouseRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return WarehouseRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => WarehouseModel.fromjson(val))
          .toList(),
    );
  }
}
