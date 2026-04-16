// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';
import 'package:buymore/Models/Manager/Product/ProductRequestModel.dart';
import 'package:buymore/Models//Responses/ResponseModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryResponseModel.dart';
import 'package:buymore/Models/Responses/ResponseModel2.dart';
import 'package:buymore/Models/Manager/Subcategory/SubategoriesRequestModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'dart:ui';

List<SubCategoryModel> allSubcategoryList = [];

class SubcategoriesService {
  Future<SubategoriesRequestModel> showAllSubcategoriesService(
      int id, int page, String? search, Locale locale) async {
    String url;
    search == null
        ? url = 'categories/$id/subcategories/?page=$page'
        : url = 'categories/$id/subcategories/?page=$page&search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      SubategoriesRequestModel data =
          SubategoriesRequestModel.fromjson(response);
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<SubategoryResponseModel> getAllSubcategoriesService(
      Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/subcategories'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    allSubcategoryList.clear();
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      SubategoryResponseModel data = SubategoryResponseModel.fromjson(response);
      allSubcategoryList.addAll(data.data);
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addSubcategoryService(
    String nameEn,
    String nameAr,
    Uint8List? image,
    String categoryId,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/subcategories');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(
        {'Authorization': 'Bearer $token', 'locale': locale.languageCode});

    if (image != null) {
      var mimeType = lookupMimeType('', headerBytes: image) ?? 'image/jpeg';
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        image,
        filename: 'upload.jpg',
        contentType: MediaType.parse(mimeType),
      ));
    }

    request.fields['name_en'] = nameEn;
    request.fields['name_ar'] = nameAr;
    request.fields['category_id'] = categoryId;

    var response = await request.send();

    if (response.statusCode == 201) {
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

  Future<ProductRequestModel> showSubcategoriesProductsService(
    int id,
    int page,
    String? search,
    Locale locale,
  ) async {
    String url;
    search == null
        ? url = 'subcategories/$id/products/?page=$page'
        : url = 'subcategories/$id/products/?page=$page&search=$search';
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return ProductRequestModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> editSubcategoryService(
    String? nameEn,
    String? nameAr,
    Uint8List? image,
    String? categoryId,
    int id,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/subcategories/$id');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(
        {'Authorization': 'Bearer $token', 'locale': locale.languageCode});

    if (image != null) {
      var mimeType = lookupMimeType('', headerBytes: image) ?? 'image/jpeg';
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        image,
        filename: 'upload.jpg',
        contentType: MediaType.parse(mimeType),
      ));
    }
    if (nameEn.toString().isNotEmpty) {
      request.fields['name_en'] = nameEn!;
    }
    if (nameAr.toString().isNotEmpty) {
      request.fields['name_ar'] = nameAr!;
    }
    if (categoryId.toString().isNotEmpty) {
      request.fields['category_id'] = categoryId!;
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
