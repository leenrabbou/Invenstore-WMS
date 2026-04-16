// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Product/ProductModel.dart';

class ProductDataModel {
  int currentPage, lastPage;
  List<ProductModel> data;
  ProductDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory ProductDataModel.fromjson(Map<String, dynamic> jsonData) {
    return ProductDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(jsonData['data'])
          .map((val) => ProductModel.fromjson(val))
          .toList(),
    );
  }
}
