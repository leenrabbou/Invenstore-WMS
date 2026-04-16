// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Orders%20Models/OrderModel.dart';

class OrderDataModel {
  int currentPage, lastPage;
  List<OrderModel> data;
  OrderDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });
  factory OrderDataModel.fromjson(Map<String, dynamic> jsonData) {
    return OrderDataModel(
      currentPage: jsonData['current_page'],
      lastPage: jsonData['last_page'],
      data: List.from(jsonData['data'])
          .map((val) => OrderModel.fromjson(val))
          .toList(),
    );
  }
}
