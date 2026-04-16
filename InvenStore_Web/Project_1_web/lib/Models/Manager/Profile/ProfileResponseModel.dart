// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Profile/ProfileModel.dart';

class ProfileResponseModel {
  int status;
  String message;
  ProfileModel data;
  ProfileResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ProfileResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return ProfileResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: ProfileModel.fromjson(jsonData['data']),
    );
  }
}
