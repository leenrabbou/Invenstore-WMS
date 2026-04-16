// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';
import 'package:project_1_v2/Models/Manager/Employee/AnEmployeeModel.dart';
import 'package:project_1_v2/Models/Manager/Employee/EmployeeRequestModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel2.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:ui';

class EmployeesServices {
  Future<EmployeeRequestModel> showAllEmployeesService(
    int page,
    Locale locale,
  ) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/employees/?page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      EmployeeRequestModel s = EmployeeRequestModel.fromjson(data);

      return s;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<dynamic> addEmployeeService(
    Uint8List? image,
    String? address,
    String userName,
    String fullName,
    String email,
    String password,
    String gender,
    String birthDate,
    String phoneNumber,
    String ssn,
    String employeableType,
    String employable,
    int stateId,
    int roleId,
    int employeableId,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/employees');
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
    if (address != null) {
      request.fields['address'] = address;
    }
    request.fields['username'] = userName;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['full_name'] = fullName;
    request.fields['gender'] = gender;
    request.fields['birthday'] = birthDate;
    request.fields['phone_number'] = phoneNumber;
    request.fields['state_id'] = stateId.toString();
    request.fields['role_id'] = roleId.toString();
    request.fields['employable_type'] = employeableType;
    request.fields['employable_id'] = employeableId.toString();
    request.fields['employable'] = employable;
    request.fields['ssn'] = ssn;

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

  Future<dynamic> editEmployeeService(
    int id,
    Uint8List? image,
    String? address,
    String? userName,
    String? fullName,
    String? email,
    String? password,
    String? gender,
    String? birthDate,
    String? phoneNumber,
    String? ssn,
    String? employeableType,
    String? employable,
    int? stateId,
    int? roleId,
    int? employeableId,
    Locale locale,
  ) async {
    var uri = Uri.parse('$basicurl/employees/$id');
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
    if (address.toString().isNotEmpty) {
      request.fields['address'] = address!;
    } else {}
    if (userName.toString().isNotEmpty) {
      request.fields['username'] = userName!;
    }
    if (email.toString().isNotEmpty) {
      request.fields['email'] = email!;
    }
    if (password.toString().isNotEmpty) {
      request.fields['password'] = password!;
    }
    if (fullName.toString().isNotEmpty) {
      request.fields['full_name'] = fullName!;
    }
    if (gender.toString().isNotEmpty) {
      request.fields['gender'] = gender!;
    }
    if (birthDate.toString().isNotEmpty) {
      request.fields['birthday'] = birthDate!;
    }
    if (phoneNumber.toString().isNotEmpty) {
      request.fields['phone_number'] = phoneNumber!;
    }
    if (stateId.toString().isNotEmpty) {
      request.fields['state_id'] = stateId.toString();
    }
    if (roleId.toString().isNotEmpty) {
      request.fields['role_id'] = roleId.toString();
    }
    if (employeableType.toString().isNotEmpty) {
      request.fields['employable_type'] = employeableType!;
    }
    if (employeableId.toString().isNotEmpty) {
      request.fields['employable_id'] = employeableId.toString();
    }
    if (employable.toString().isNotEmpty) {
      request.fields['employable'] = employable!;
    }
    if (ssn.toString().isNotEmpty) {
      request.fields['ssn'] = ssn!;
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

  Future<AnEmployeeModel> showAnEmployeeService(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/employees/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      return AnEmployeeModel.fromjson(data);
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
