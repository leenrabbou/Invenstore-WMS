// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionModel.dart';

class DestructionDataModel {
  int currentPage, lastPage;
  List<DestructionModel> data;
  DestructionDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory DestructionDataModel.fromjson(Map<String, dynamic> jsonData) {
    return DestructionDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => DestructionModel.fromjson(val)).toList(),
    );
  }
}
