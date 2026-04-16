// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';

class SubategoryResponseModel {
  int status;
  String message;
  List<SubCategoryModel> data;
  SubategoryResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory SubategoryResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return SubategoryResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => SubCategoryModel.fromjson(val))
          .toList(),
    );
  }
}
