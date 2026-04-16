// ignore_for_file: file_names

import 'package:project_1_v2/Models/Address/CityModel.dart';

class CityResponseModel {
  int status;
  String message;
  List<CityModel> data;
  CityResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory CityResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return CityResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(
        jsonData['data'],
      ).map((val) => CityModel.fromjson(val)).toList(),
    );
  }
}
