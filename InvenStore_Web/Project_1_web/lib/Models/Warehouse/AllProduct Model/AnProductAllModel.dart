// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';

class AnProductAllModel {
  int status;
  String message;
  AllProductModel data;
  AnProductAllModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory AnProductAllModel.fromjson(Map<String, dynamic> jsonData) {
    return AnProductAllModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: AllProductModel.fromjson(jsonData['data']),
    );
  }
}
