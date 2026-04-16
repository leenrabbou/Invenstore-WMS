// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionModel.dart';

class AnDestructionCausesResponseModel {
  int status;
  String message;
  DestructionModel data;
  AnDestructionCausesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnDestructionCausesResponseModel.fromjson(
    Map<String, dynamic> jsonData,
  ) {
    return AnDestructionCausesResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: DestructionModel.fromjson(jsonData['data']),
    );
  }
}
