// ignore_for_file: file_names

import 'package:project_1_v2/Models/Manager/Subcategory/SubcategoryModel.dart';

class SubDatatModel {
  int currentPage, lastPage;
  List<SubCategoryModel> data;
  SubDatatModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory SubDatatModel.fromjson(Map<String, dynamic> jsonData) {
    return SubDatatModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => SubCategoryModel.fromjson(val)).toList(),
    );
  }
}
