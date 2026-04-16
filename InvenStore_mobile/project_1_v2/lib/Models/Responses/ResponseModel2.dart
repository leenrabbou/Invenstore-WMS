// ignore_for_file: file_names
import 'package:project_1_v2/Models/Responses/MessageModel.dart';

class ResponseModel2 {
  final int status;
  final List<dynamic> data;
  final MessageModel? message;

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
