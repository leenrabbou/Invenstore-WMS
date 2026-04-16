// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Subcategory/SubDataModel.dart';

class SubategoriesRequestModel {
  int status;
  String message;
  SubDatatModel data;
  SubategoriesRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory SubategoriesRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return SubategoriesRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: SubDatatModel.fromjson(jsonData['data']),
    );
  }
}
