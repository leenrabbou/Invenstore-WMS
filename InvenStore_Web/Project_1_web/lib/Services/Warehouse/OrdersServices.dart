// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';

import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Models/Responses/ResponseModel2.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/AnOrderRequestModel.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderProductModel.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderRequestModel.dart';
import 'package:buymore/Screens/Warehouse/Products/AllProductDetailsScreen.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:http/http.dart' as http;

class OrdersServices {
  Future<OrderRequestModel> showAllSellOrdersService(
      int page, String? status, Locale locale, String? sort) async {
    String url;
    status == null
        ? url = 'orders/sell/?page=$page'
        : url = 'orders/sell/?page=$page&filter[status]=$status';
    sort != null ? url = '$url&sort=$sort' : url = url;
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

  Future<AnOrderRequestModel> showAnOrderService(int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<OrderRequestModel> showAllBuyOrdersService(
      int page, String? status, Locale locale, String? sort) async {
    String url;
    status == null
        ? url = 'orders/buy/?page=$page'
        : url = 'orders/buy/?page=$page&filter[status]=$status';
    sort != null ? url = '$url&sort=$sort' : url = url;
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

  Future<OrderRequestModel> showAllSupliesOrdersService(
      int page, String? status, Locale locale, String? sort) async {
    String url;
    status == null
        ? url = 'orders/manufacturer/?page=$page'
        : url = 'orders/manufacturer/?page=$page&filter[status]=$status';
    sort != null ? url = '$url&sort=$sort' : url = url;
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

  Future<AnOrderRequestModel> deleteBuyOrdersService(
      int id, Locale locale) async {
    final http.Response res = await http.delete(
      Uri.parse('$basicurl/orders/$id/delete'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);
      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> recieveBuyOrdersService(
      int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id/receive'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> acceptSellOrdersService(
      int id, Locale locale) async {
    final http.Response res = await http.get(
      Uri.parse('$basicurl/orders/$id/accept'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<AnOrderRequestModel> rejectSellOrdersService(
      int id, Locale locale) async {
    final http.Response res = await http.delete(
      Uri.parse('$basicurl/orders/$id/reject'),
      headers: {
        'Authorization': 'Bearer $token',
        'locale': locale.languageCode
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);
      AnOrderRequestModel response = AnOrderRequestModel.fromjson(data);

      return response;
    } else {
      throw Exception('${res.statusCode} with ${res.body}');
    }
  }

  Future<OrderRequestModel> searchOrdersService(
    int page,
    String url,
    String? search,
    String? status,
    String? id,
    String? date,
    String? cost,
    String? after,
    String? before,
    String? cheaperThan,
    String? expensiveThan,
    String? name,
    String? city,
    String? state,
    String? address,
    String? sort,
    Locale locale,
  ) async {
    status != null ? url = '$url&filter[status]=$status' : null;
    id != null ? url = '$url&filter[id]=$id' : null;
    date != null ? url = '$url&filter[date]=$date' : null;
    cost != null ? url = '$url&filter[cost]=$cost' : null;
    after != null ? url = '$url&filter[ordered_after]=$after' : null;
    before != null ? url = '$url&filter[ordered_befor]=$before' : null;
    cheaperThan != null && cheaperThan.toString().isNotEmpty
        ? url = '$url&filter[cheaper_than]=$cheaperThan'
        : null;
    expensiveThan != null && expensiveThan.toString().isNotEmpty
        ? url = '$url&filter[more_expensive_than]=$expensiveThan'
        : null;
    name != null ? url = '$url&filter[name]=$name' : null;
    city != null ? url = '$url&filter[city]=$city' : null;
    state != null ? url = '$url&filter[state]=$state' : null;
    address != null ? url = '$url&filter[address]=$address' : null;

    sort != null ? url = '$url&sort=$sort' : null;
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

  Future<dynamic> addSuppliesOrderService(
      int manufacturerId, String shippingCost, Locale locale) async {
    Map<String, dynamic> data = {
      'shipping_cost': shippingCost.toString(),
      'manufacturer_id': manufacturerId.toString()
    };
    for (int i = 0; i < suppliesOrderList.length; i++) {
      data.addAll({
        'products[$i][id]': suppliesOrderList[i].product.id.toString(),
        'products[$i][quantity]': suppliesOrderList[i].quantity.toString(),
        'products[$i][cost]': suppliesOrderList[i].product.price.toString(),
        'products[$i][exp]': suppliesOrderList[i].exDate ?? '',
      });
    }
    var response = await http.post(Uri.parse('$basicurl/orders/manufacturer'),
        headers: {
          'Authorization': 'Bearer $token',
          'locale': locale.languageCode
        },
        body: data);

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

  Future<dynamic> editSuppliesOrderService(
      int id,
      int manufacturerId,
      List<OrderProductModel> products,
      String shippingCost,
      int statusId,
      Locale locale) async {
    Map<String, dynamic> data = {
      'shipping_cost': shippingCost.toString(),
      'manufacturer_id': manufacturerId.toString(),
      'status_id': statusId.toString(),
    };
    for (int i = 0; i < products.length; i++) {
      data.addAll({
        'products[$i][id]': products[i].productId.toString(),
        'products[$i][quantity]': products[i].quantity.toString(),
        'products[$i][cost]': products[i].cost.toString(),
        'products[$i][exp]': products[i].expirationDate ?? '',
      });
    }
    var response = await http.put(Uri.parse('$basicurl/orders/$id'),
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
