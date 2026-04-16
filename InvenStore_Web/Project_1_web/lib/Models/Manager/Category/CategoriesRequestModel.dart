// ignore_for_file: file_names

import 'package:buymore/Models/Manager/category/CategoryModel.dart';

class CategoriesRequestModel {
  int status;
  String message;
  List<CategoryModel> data;
  CategoriesRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory CategoriesRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return CategoriesRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => CategoryModel.fromjson(val))
          .toList(),
    );
  }
}
