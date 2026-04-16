// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:project_1_v2/Models/Address/CityModel.dart';
import 'package:project_1_v2/Models/Address/CityResponseModel.dart';
import 'package:project_1_v2/Models/Address/ResponseAddState.dart';
import 'package:project_1_v2/Models/Address/StateModel.dart';
import 'package:project_1_v2/Models/Address/StateResponseModel.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;

List<CityModel> allCitiesList = [];
List<StateModel> statesForCityList = [];
List<StateModel> allStatesList = [];

class AddressServices {
  Future<CityResponseModel> allCitiesService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/cities'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      CityResponseModel data = CityResponseModel.fromjson(req);
      allCitiesList = data.data;
      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<StateResponseModel> allStatesForCityService(
    int id,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/cities/$id/states'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      StateResponseModel data = StateResponseModel.fromjson(req);
      statesForCityList = data.data;

      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<ResponseAddStateModel> addStateService(
    String nameEn,
    String nameAr,
    int cityId,
    Locale locale,
  ) async {
    var response = await http.post(
      Uri.parse('$basicurl/states'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
      body: {
        'name_en': nameEn,
        'name_ar': nameAr,
        'city_id': cityId.toString(),
      },
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      final res = ResponseAddStateModel.fromjson(data);

      return res;
    } else {
      throw Exception('${response.statusCode} with ${response.body}');
    }
  }

  Future<StateResponseModel> allStatesService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/states'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> req = json.decode(res.body);
      StateResponseModel data = StateResponseModel.fromjson(req);
      allStatesList = data.data;

      return data;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
