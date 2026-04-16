// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';

class AllProductDataModel {
  int currentPage, lastPage;
  List<AllProductModel> data;
  AllProductDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory AllProductDataModel.fromjson(Map<String, dynamic> jsonData) {
    return AllProductDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => AllProductModel.fromjson(val)).toList(),
    );
  }
}
