// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:buymore/Models/Manager/Employee/AnEmployeeModel.dart';
import 'package:buymore/Models/Manager/Profile/ProfileResponseModel.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Models/Responses/ResponseModel2.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileServices {
  Future<AnEmployeeModel> showProfileWarehouseService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/employees/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnEmployeeModel responseData = AnEmployeeModel.fromjson(data);
      userAccount = responseData.data;
      if (userAccount!.gender == 'male') {
        defaultImage = 'images/male3.jpg';
      } else if (userAccount!.gender == 'female') {
        defaultImage = 'images/female2.jpg';
      }

      return responseData;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> editProfileWarehouseService(
      Uint8List? image,
      String? address,
      String? userName,
      String? fullName,
      String? email,
      String? gender,
      String? birthDate,
      String? phoneNumber,
      int? stateId,
      Locale locale) async {
    var uri = Uri.parse('$basicurl/employees/profile');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(
        {'Authorization': 'Bearer $token', 'locale': locale.languageCode});

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
    if (address.toString().isNotEmpty && address != null) {
      request.fields['address'] = address;
    } else {}
    if (userName.toString().isNotEmpty && userName != null) {
      request.fields['username'] = userName;
    }
    if (email.toString().isNotEmpty && email != null) {
      request.fields['email'] = email;
    }

    if (fullName.toString().isNotEmpty && fullName != null) {
      request.fields['full_name'] = fullName;
    }
    if (gender.toString().isNotEmpty && gender != null) {
      request.fields['gender'] = gender;
    }
    if (birthDate.toString().isNotEmpty && birthDate != null) {
      request.fields['birthday'] = birthDate;
    }
    if (phoneNumber.toString().isNotEmpty && phoneNumber != null) {
      request.fields['phone_number'] = phoneNumber;
    }
    if (stateId.toString().isNotEmpty && stateId != null) {
      request.fields['state_id'] = stateId.toString();
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

  Future<ProfileResponseModel> showProfileManagerService(Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      ProfileResponseModel responseData = ProfileResponseModel.fromjson(data);
      managerAccount = responseData.data;
      defaultImage = 'images/male3.jpg';

      return responseData;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> editProfileManagerService(
      Uint8List? image, String? userName, String? email, Locale locale) async {
    var uri = Uri.parse('$basicurl/user/profile');
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(
        {'Authorization': 'Bearer $token', 'locale': locale.languageCode});

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

    if (userName.toString().isNotEmpty && userName != null) {
      request.fields['username'] = userName;
    }
    if (email.toString().isNotEmpty && email != null) {
      request.fields['email'] = email;
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
