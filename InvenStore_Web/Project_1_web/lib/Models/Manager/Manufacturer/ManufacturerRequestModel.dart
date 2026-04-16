// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';

class ManufacturerRequestModel {
  int status;
  String message;
  List<ManufacturerModel> data;
  ManufacturerRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ManufacturerRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return ManufacturerRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => ManufacturerModel.fromjson(val))
          .toList(),
    );
  }
}
