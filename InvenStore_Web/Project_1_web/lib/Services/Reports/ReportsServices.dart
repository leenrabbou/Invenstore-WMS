import 'dart:convert';
import 'dart:ui';

import 'package:buymore/Models/Reports/ProductReportResponseModel.dart';
import 'package:buymore/Models/Reports/ReportResponseModel.dart';
import 'package:buymore/Models/Reports/SpecificProductReportResposeModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

class ReportsServices {
  Future<ReportsRequestModel> getOrdersReportService(String? startDate,
      String? endDate, String? frequency, String type, Locale locale) async {
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
      Uri.parse('$basicurl/reports/order'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final res = ReportsRequestModel.fromjson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }

  Future<ProductReportsRequestModel> getProductReportService(
      String? startDate, String? endDate, Locale locale) async {
    Map<String, dynamic> data = {};
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

    var response = await http.post(
      Uri.parse('$basicurl/reports/product'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final res = ProductReportsRequestModel.fromjson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }

  Future<SpecificProductReportResposeModel> getSpecificProductReportService(
      int id,
      String? startDate,
      String? endDate,
      String? frequency,
      Locale locale) async {
    Map<String, dynamic> data = {};
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
      Uri.parse('$basicurl/reports/product/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
      body: data,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final res = SpecificProductReportResposeModel.fromjson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }
}
