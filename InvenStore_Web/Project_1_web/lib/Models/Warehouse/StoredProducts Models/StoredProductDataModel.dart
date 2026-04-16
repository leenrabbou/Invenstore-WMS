// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';

class StoredProductDataModel {
  int currentPage, lastPage;
  List<StoredProductModel> data;
  StoredProductDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory StoredProductDataModel.fromjson(Map<String, dynamic> jsonData) {
    return StoredProductDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(jsonData['data'])
          .map((val) => StoredProductModel.fromjson(val))
          .toList(),
    );
  }
}
