// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderProductModel.dart';

class AnOrderModel {
  int id, orderedFromId, orderedById, statusId;
  String? orderedFromImage, orderedByImage;
  String orderedFromType,
      orderNum,
      orderedFrom,
      orderedFromCity,
      orderedFromState,
      orderedFromAddress,
      orderedByType,
      orderedBy,
      orderedByCity,
      orderedByState,
      orderedByAddress,
      status,
      orderedAt,
      updatedAt;
  double orderCost, shippingCost, totalCost;
  List<OrderProductModel> products;

  AnOrderModel({
    required this.id,
    required this.orderCost,
    required this.orderNum,
    required this.orderedAt,
    required this.orderedBy,
    required this.orderedByAddress,
    required this.orderedByCity,
    required this.orderedById,
    required this.orderedByImage,
    required this.orderedByState,
    required this.orderedByType,
    required this.orderedFrom,
    required this.orderedFromAddress,
    required this.orderedFromCity,
    required this.orderedFromId,
    required this.orderedFromImage,
    required this.orderedFromState,
    required this.orderedFromType,
    required this.shippingCost,
    required this.status,
    required this.statusId,
    required this.totalCost,
    required this.updatedAt,
    required this.products,
  });

  factory AnOrderModel.fromjson(jsonData) {
    return AnOrderModel(
      id: jsonData['id'],
      orderNum: jsonData['order_num'],
      orderedFromId: jsonData['ordered_from_id'],
      orderedById: jsonData['ordered_by_id'],
      statusId: jsonData['status_id'],
      orderedFromImage: jsonData['ordered_from_image'],
      orderedByImage: jsonData['ordered_by_image'],
      orderedFromType: jsonData['ordered_from_type'],
      orderedFrom: jsonData['ordered_from'],
      orderedFromCity: jsonData['ordered_from_city'],
      orderedFromState: jsonData['ordered_from_state'],
      orderedFromAddress: jsonData['ordered_from_address'],
      orderedByType: jsonData['ordered_by_type'],
      orderedBy: jsonData['ordered_by'],
      orderedByCity: jsonData['ordered_by_city'],
      orderedByState: jsonData['ordered_by_state'],
      orderedByAddress: jsonData['ordered_by_address'],
      status: jsonData['status'],
      orderedAt: jsonData['ordered_at'],
      updatedAt: jsonData['updated_at'],
      orderCost: (jsonData['order_cost'] as num).toDouble(),
      shippingCost: (jsonData['shipping_cost'] as num).toDouble(),
      totalCost: (jsonData['total_cost'] as num).toDouble(),
      products: List.from(
        jsonData['products'],
      ).map((val) => OrderProductModel.fromjson(val)).toList(),
    );
  }
}
