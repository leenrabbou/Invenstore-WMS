// ignore_for_file: file_names

import 'package:buymore/Models/Notifications/NotificationModel.dart';

class NotificationResponseModel {
  int status;
  String message;
  List<NotificationModel> data;
  NotificationResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory NotificationResponseModel.fromjson(Map<String, dynamic> jsonData) {
    return NotificationResponseModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: List.from(jsonData['data'])
          .map((val) => NotificationModel.fromjson(val))
          .toList(),
    );
  }
}
