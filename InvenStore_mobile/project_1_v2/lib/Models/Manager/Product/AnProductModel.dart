// ignore_for_file: file_names

import 'package:project_1_v2/Models/Manager/Product/ProductModel.dart';

class AnProductModel {
  int status;
  String message;
  ProductModel data;
  AnProductModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnProductModel.fromjson(Map<String, dynamic> jsonData) {
    return AnProductModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ProductModel.fromjson(jsonData['data']),
    );
  }
}
