// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Sales/SalesModel.dart';

class SaleDataModel {
  int currentPage, lastPage;
  List<SalesModel> data;
  SaleDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory SaleDataModel.fromjson(Map<String, dynamic> jsonData) {
    return SaleDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(
        jsonData['data'],
      ).map((val) => SalesModel.fromjson(val)).toList(),
    );
  }
}
