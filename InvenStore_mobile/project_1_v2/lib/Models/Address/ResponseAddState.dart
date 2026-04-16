// ignore_for_file: file_names

import 'package:project_1_v2/Models/Address/StateModel.dart';

class ResponseAddStateModel {
  int status;
  String message;
  StateModel data;
  ResponseAddStateModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ResponseAddStateModel.fromjson(Map<String, dynamic> jsonData) {
    return ResponseAddStateModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: StateModel.fromjson(jsonData['data']),
    );
  }
}
