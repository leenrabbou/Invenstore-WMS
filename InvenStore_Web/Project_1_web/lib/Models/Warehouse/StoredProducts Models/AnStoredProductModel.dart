// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';

class AnStoredProductModel {
  int status;
  String message;
  StoredProductModel data;
  AnStoredProductModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnStoredProductModel.fromjson(Map<String, dynamic> jsonData) {
    return AnStoredProductModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: StoredProductModel.fromjson(jsonData['data']),
    );
  }
}
