// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Destruction%20Models/DestructionCausesModel.dart';

class DestructionCausesResponseModel {
  int status;
  String message;
  List<DestructionCausesModel> data;
  DestructionCausesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory DestructionCausesResponseModel.fromjson(
      Map<String, dynamic> jsonData) {
    return DestructionCausesResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => DestructionCausesModel.fromjson(val))
          .toList(),
    );
  }
}
