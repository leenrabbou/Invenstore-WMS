// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Shipment%20Models/ShipmentModel.dart';

class ShipmentDataModel {
  int currentPage, lastPage;
  List<ShipmentModel> data;
  ShipmentDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory ShipmentDataModel.fromjson(Map<String, dynamic> jsonData) {
    return ShipmentDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => ShipmentModel.fromjson(val)).toList(),
    );
  }
}
