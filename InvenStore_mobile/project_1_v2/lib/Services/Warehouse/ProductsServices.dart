// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductRequestModel.dart';
import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AnProductAllModel.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/AnStoredProductModel.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductRequestModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  Future<dynamic> editMinimumService(int? min, int id, Locale locale) async {
    var uri = Uri.parse('$basicurl/products/$id/min');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode,
    });

    if (min.toString().isNotEmpty && min != null) {
      request.fields['min_quantity'] = min.toString();
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

  Future<StoredProductRequestModel> searchStoredProductsService(
    int page,
    String url,
    String? name,
    String? subCategory,
    String? cheaperThan,
    String? moreExpensiveThan,
    String? manufacturer,
    String? status,
    String? expireBefore,
    String? expireAfter,
    String? quantityLessThan,
    String? quantityMoreThan,
    String? sort,
    Locale locale,
  ) async {
    status != null ? url = '$url&filter[status]=$status' : null;
    name != null ? url = '$url&filter[name]=$name' : null;
    manufacturer != null
        ? url = '$url&filter[manufacturer]=$manufacturer'
        : null;
    subCategory != null ? url = '$url&filter[sub_category]=$subCategory' : null;
    expireBefore != null
        ? url = '$url&filter[expire_before]=$expireBefore'
        : null;
    expireAfter != null ? url = '$url&filter[expire_after]=$expireAfter' : null;

    quantityLessThan != null
        ? url = '$url&filter[quantity_less_than]=$quantityLessThan'
        : null;
    quantityMoreThan != null
        ? url = '$url&filter[quantity_more_than]=$quantityMoreThan'
        : null;
    cheaperThan != null && cheaperThan.toString().isNotEmpty
        ? url = '$url&filter[cheaper_than]=$cheaperThan'
        : null;
    moreExpensiveThan != null && moreExpensiveThan.toString().isNotEmpty
        ? url = '$url&filter[more_expensive_than]=$moreExpensiveThan'
        : null;

    sort != null ? url = '$url&sort=$sort' : null;
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return StoredProductRequestModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnProductAllModel> showAnProductsService(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/products/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return AnProductAllModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AllProductRequestModel> searchAllProductsService(
    int page,
    String url,
    String? name,
    String? subCategory,
    String? cheaperThan,
    String? moreExpensiveThan,
    String? manufacturer,
    String? status,
    String? expireBefore,
    String? expireAfter,
    String? quantityLessThan,
    String? quantityMoreThan,
    String? sort,
    Locale locale,
  ) async {
    status != null ? url = '$url&filter[status]=$status' : null;
    name != null ? url = '$url&filter[name]=$name' : null;
    manufacturer != null
        ? url = '$url&filter[manufacturer]=$manufacturer'
        : null;
    subCategory != null ? url = '$url&filter[sub_category]=$subCategory' : null;
    expireBefore != null
        ? url = '$url&filter[expire_before]=$expireBefore'
        : null;
    expireAfter != null ? url = '$url&filter[expire_after]=$expireAfter' : null;

    quantityLessThan != null
        ? url = '$url&filter[quantity_less_than]=$quantityLessThan'
        : null;
    quantityMoreThan != null
        ? url = '$url&filter[quantity_more_than]=$quantityMoreThan'
        : null;
    cheaperThan != null && cheaperThan.toString().isNotEmpty
        ? url = '$url&filter[cheaper_than]=$cheaperThan'
        : null;
    moreExpensiveThan != null && moreExpensiveThan.toString().isNotEmpty
        ? url = '$url&filter[more_expensive_than]=$moreExpensiveThan'
        : null;

    sort != null ? url = '$url&sort=$sort' : null;

    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return AllProductRequestModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnStoredProductModel> showAnStoredProductsService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/stored-products/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return AnStoredProductModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AllProductRequestModel> showAllProductsService(
    int page,
    String? search,
    String? sort,
    Locale locale,
  ) async {
    String url;
    search == null
        ? url = 'products/?page=$page'
        : url = 'products/?page=$page&search=$search';
    sort != null ? url = '$url&sort=$sort' : url = url;
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AllProductRequestModel response = AllProductRequestModel.fromjson(data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<StoredProductRequestModel> showStoredProductsService(
    int page,
    String status,
    String? search,
    String? sort,
    Locale locale,
  ) async {
    String url;
    search == null
        ? url = 'stored-products?page=$page&status=$status'
        : url = 'stored-products?page=$page&status=$status&search=$search';
    sort != null ? url = '$url&sort=$sort' : url = url;
    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      StoredProductRequestModel response = StoredProductRequestModel.fromjson(
        data,
      );
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> editStoredProductService(
    int? max,
    int? active,
    int id,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/stored-products/$id');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode,
    });

    if (active.toString().isNotEmpty && active != null) {
      request.fields['active'] = active.toString();
    }
    if (max.toString().isNotEmpty && max != null) {
      request.fields['max'] = max.toString();
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
