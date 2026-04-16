// ignore_for_file: file_namtant_identifier_names, file_names

import 'dart:convert';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Models/Responses/ResponseModel2.dart';
import 'package:buymore/Models/Manager/category/CategoriesRequestModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

List<CategoryModel> allCategoriesList = [];

class CategoriesService {
  Future<CategoriesRequestModel> showAllCategoriesService(
      String? search, Locale locale) async {
    String url;
    search == null ? url = 'categories' : url = 'categories?search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);

      CategoriesRequestModel req = CategoriesRequestModel.fromjson(data);
      allCategoriesList = req.data;

      return req;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addCategoryService(
      String nameEn, String nameAr, Locale locale) async {
    var response = await http.post(Uri.parse('$basicurl/categories'), headers: {
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode
    }, body: {
      'name_en': nameEn,
      'name_ar': nameAr
    });

    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);

      return res;
    } else if (response.statusCode == 422) {
      final data = json.decode(response.body);

      final res = ResponseModel2.fromJson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }

  Future<ResponseModel> showAnCategory(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/categories/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return ResponseModel.fromJson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> editCategoryService(
      String? nameEn, String? nameAr, int id, Locale locale) async {
    Object? data;
    if (nameAr != null && nameEn != null) {
      data = {'name_en': nameEn, 'name_ar': nameAr};
    } else if (nameAr == null && nameEn != null) {
      data = {
        'name_en': nameEn,
      };
    } else if (nameAr != null && nameEn == null) {
      data = {
        'name_ar': nameAr,
      };
    }

    var response = await http.patch(Uri.parse('$basicurl/categories/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'locale': locale.languageCode
        },
        body: data);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final res = ResponseModel.fromJson(data);

      return res;
    } else if (response.statusCode == 422) {
      final data = json.decode(response.body);

      final res = ResponseModel2.fromJson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }
}
