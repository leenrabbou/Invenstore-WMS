// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html; // Use Dart's HTML package for web
import 'package:buymore/helper/Constant.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// استيراد شرطي: إذا كان المشروع يعمل على الويب، استورد html، وإلا فلا تفعل شيئاً
// import 'package:flutter/foundation.dart' show kIsWeb;

// لا تستخدمي import 'dart:html' مباشرة
// استخدمي مكتبات مثل 'url_launcher' أو 'path_provider' للتعامل مع الملفات في الموبايل

class DownloadReportServices {
  Future<int> downloadExcelService(String? startDate, String? endDate,
      String? frequency, String type, Locale locale) async {
    Map<String, dynamic> data = {
      'type': type,
    };
    startDate != null
        ? data.addAll({
            'start_date': startDate,
          })
        : null;
    endDate != null
        ? data.addAll({
            'end_date': endDate,
          })
        : null;
    frequency != null
        ? data.addAll({
            'frequency': frequency,
          })
        : null;
    var response = await http.post(
      Uri.parse('$basicurl/reports/order/excel'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', '${type}ReportExcel.xlsx')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // if (kDebugMode) {
      //   print('ERROR: ${response.statusCode}');
      // }
    }
    return response.statusCode;
  }

  Future<int> downloadPDFService(String? startDate, String? endDate,
      String? frequency, String type, Locale locale) async {
    Map<String, dynamic> data = {
      'type': type,
    };
    startDate != null
        ? data.addAll({
            'start_date': startDate,
          })
        : null;
    endDate != null
        ? data.addAll({
            'end_date': endDate,
          })
        : null;
    frequency != null
        ? data.addAll({
            'frequency': frequency,
          })
        : null;
    var response = await http.post(
      Uri.parse('$basicurl/reports/order/pdf'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes], 'application/pdf');

      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute('download', '${type}ReportPDF.pdf')
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      // if (kDebugMode) {
      //   print('ERROR: ${response.statusCode}');
      // }
    }
    return response.statusCode;
  }
}
