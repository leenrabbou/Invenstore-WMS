// ignore_for_file: file_names

import 'package:buymore/Models/Address/StateModel.dart';

class StateResponseModel {
  int status;
  String message;
  List<StateModel> data;
  StateResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory StateResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return StateResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => StateModel.fromjson(val))
          .toList(),
    );
  }
}
