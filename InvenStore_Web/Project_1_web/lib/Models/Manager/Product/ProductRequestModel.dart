// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Product/ProductDataModel.dart';

class ProductRequestModel {
  int status;
  String message;
  ProductDataModel data;
  ProductRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ProductRequestModel.fromjson(Map<String, dynamic> jsonData) {
    return ProductRequestModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ProductDataModel.fromjson(jsonData['data']),
    );
  }
}
