// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Distribution%20Center/CenterModel.dart';

class CenterResponseModel {
  int status;
  String message;
  List<CenterModel> data;
  CenterResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory CenterResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return CenterResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => CenterModel.fromjson(val))
          .toList(),
    );
  }
}
