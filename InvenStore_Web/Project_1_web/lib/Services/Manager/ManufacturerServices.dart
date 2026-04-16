// ignore_for_file: file_names

import 'dart:convert';

import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:buymore/Models/Manager/Manufacturer/ManufacturerRequestModel.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Models//Responses/ResponseModel2.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:ui';

List<ManufacturerModel> allManufacturerList = [];

class ManufacturerServices {
  Future<ManufacturerRequestModel> showAllManufacturersService(
      String? search, Locale locale) async {
    String url;
    search == null ? url = 'manufacturer' : url = 'manufacturer?search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    allManufacturerList.clear();
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);

      ManufacturerRequestModel req = ManufacturerRequestModel.fromjson(data);
      allManufacturerList = req.data;

      return req;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addManufactureeService(String nameEn, String nameAr,
      String stateId, String streetEn, String streetAr, Locale locale) async {
    var response =
        await http.post(Uri.parse('$basicurl/manufacturer'), headers: {
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode
    }, body: {
      'name_en': nameEn,
      'name_ar': nameAr,
      'state_id': stateId,
      'street_address_en': streetEn,
      'street_address_ar': streetAr
    });
    if (kDebugMode) {
      print(response);
    }
    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);
      if (kDebugMode) {
        print(res);
      }

      return res;
    } else if (response.statusCode == 422) {
      final data = json.decode(response.body);

      final res = ResponseModel2.fromJson(data);
      if (kDebugMode) {
        print(res);
      }
      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }

  Future<dynamic> editManufactureeService(
      String? nameEn,
      String? nameAr,
      int? stateId,
      String? streetEn,
      String? streetAr,
      int id,
      Locale locale) async {
    var uri = Uri.parse('$basicurl/manufacturer/$id');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(
        {'Authorization': 'Bearer $token', 'locale': locale.languageCode});

    if (nameEn.toString().isNotEmpty && nameEn != null) {
      request.fields['name_en'] = nameEn;
    }
    if (nameAr.toString().isNotEmpty && nameAr != null) {
      request.fields['name_ar'] = nameAr;
    }
    if (stateId.toString().isNotEmpty && stateId != null) {
      request.fields['state_id'] = stateId.toString();
    }
    if (streetEn.toString().isNotEmpty && streetEn != null) {
      request.fields['street_address_en'] = streetEn;
    }
    if (streetAr.toString().isNotEmpty && streetAr != null) {
      request.fields['street_address_ar'] = streetAr;
    }
    request.fields['_method'] = 'patch';
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      final res = ResponseModel.fromJson(data);
      return res;
    } else if (response.statusCode == 422) {
      var responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      final res = ResponseModel2.fromJson(data);
      return res;
    } else {
      var responseBody = await response.stream.bytesToString();
      throw Exception('${response.statusCode} with $responseBody');
    }
  }
}
