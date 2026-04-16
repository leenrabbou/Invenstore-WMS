// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';

import 'package:project_1_v2/Models/Manager/Product/AnProductModel.dart';
import 'package:project_1_v2/Models/Manager/Product/ProductRequestModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'dart:ui';

class ProductsServices {
  Future<ProductRequestModel> showAllProductsService(
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
      return ProductRequestModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<ProductRequestModel> searchProductsService(
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
      return ProductRequestModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addProductService(
    String nameEn,
    String nameAr,
    Uint8List? image,
    String descriptionAr,
    String descriptionEn,
    double price,
    int subcategoryId,
    int manufacturerId,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/products');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode,
    });

    if (image != null) {
      var mimeType = lookupMimeType('', headerBytes: image) ?? 'image/jpeg';
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'upload.jpg',
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    request.fields['name_en'] = nameEn;
    request.fields['name_ar'] = nameAr;
    request.fields['description_ar'] = descriptionAr;
    request.fields['description_en'] = descriptionEn;
    request.fields['manufacturer_id'] = manufacturerId.toString();
    request.fields['price'] = price.toString();
    request.fields['subcategory_id'] = subcategoryId.toString();

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

  Future<dynamic> editProductService(
    String? nameEn,
    String? nameAr,
    Uint8List? image,
    String? descriptionAr,
    String? descriptionEn,
    double? price,
    int? subcategoryId,
    int? manufacturerId,
    Locale locale,
    int id,
  ) async {
    var uri = Uri.parse('$basicurl/products/$id');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'locale': locale.languageCode,
    });

    if (image != null) {
      var mimeType = lookupMimeType('', headerBytes: image) ?? 'image/jpeg';
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'upload.jpg',
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    if (nameEn.toString().isNotEmpty && nameEn != null) {
      request.fields['name_en'] = nameEn;
    }
    if (nameAr.toString().isNotEmpty && nameAr != null) {
      request.fields['name_ar'] = nameAr;
    }
    if (descriptionAr.toString().isNotEmpty && descriptionAr != null) {
      request.fields['description_ar'] = descriptionAr;
    }
    if (descriptionEn.toString().isNotEmpty && descriptionEn != null) {
      request.fields['description_en'] = descriptionEn;
    }
    if (manufacturerId.toString().isNotEmpty && manufacturerId != null) {
      request.fields['manufacturer_id'] = manufacturerId.toString();
    }
    if (price.toString().isNotEmpty && price != null) {
      request.fields['price'] = price.toString();
    }
    if (subcategoryId.toString().isNotEmpty && subcategoryId != null) {
      request.fields['subcategory_id'] = subcategoryId.toString();
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

  Future<AnProductModel> showAnProductsService(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/products/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return AnProductModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
