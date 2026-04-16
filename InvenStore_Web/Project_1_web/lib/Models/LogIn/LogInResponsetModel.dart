// ignore_for_file: file_names

import 'package:buymore/Models/LogIn/UserModel.dart';

class LogInResponsetModel {
  int status;
  String message;
  UserModel? data;
  LogInResponsetModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory LogInResponsetModel.fromjson(Map<String, dynamic> jsonData) {
    return LogInResponsetModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: UserModel.fromjson(jsonData['data']),
    );
  }
}
