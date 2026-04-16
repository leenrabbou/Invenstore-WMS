import 'dart:convert';
import 'dart:ui';

import 'package:buymore/Models/Warehouse/Orders%20Models/OrderRequestModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

class Filtersservices {
  Future<OrderRequestModel> sortSellOrdersService(
    int page,
    String sort,
    Locale locale,
  ) async {
    String url = 'orders/sell?sort=$sort&page=$page';

    final http.Response res = await http.get(
      Uri.parse('$basicurl/$url'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      OrderRequestModel response = OrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }
}
