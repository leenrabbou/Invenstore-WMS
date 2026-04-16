// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Destruction%20Models/DestructionDataModel.dart';

class DestructionResponseModel {
  int status;
  String message;
  DestructionDataModel data;
  DestructionResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory DestructionResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return DestructionResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: DestructionDataModel.fromjson(jsonData['data']),
    );
  }
}
