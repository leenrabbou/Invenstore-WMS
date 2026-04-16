// ignore_for_file: file_names
import 'package:buymore/Models/Responses/MessageModel.dart';

class ResponseModel2 {
  final int status;
  final List<dynamic> data;
  MessageModel? message;

  ResponseModel2({required this.status, required this.data, this.message});

  factory ResponseModel2.fromJson(Map<String, dynamic> json) {
    return ResponseModel2(
      status: json['status'],
      data: json['data'] as List<dynamic>,
      message: json['message'] != null
          ? MessageModel.fromJson(json['message'])
          : null,
    );
  }
}
