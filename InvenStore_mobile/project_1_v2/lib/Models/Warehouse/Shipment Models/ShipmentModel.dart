// ignore_for_file: file_names
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderModel.dart';

class ShipmentModel {
  int id, shippingCompanyId;
  String shipmentNum,
      shippingCompany,
      shippingCompanyCity,
      shippingCompanyState,
      shippingCompanyAddress,
      shippedAt;
  String? driverName;
  OrderModel order;
  double cost;

  ShipmentModel({
    required this.id,
    required this.shippingCompanyId,
    required this.cost,
    required this.driverName,
    required this.shipmentNum,
    required this.shippedAt,
    required this.shippingCompany,
    required this.shippingCompanyAddress,
    required this.shippingCompanyCity,
    required this.shippingCompanyState,
    required this.order,
  });
  factory ShipmentModel.fromjson(jsonData) {
    return ShipmentModel(
      id: jsonData['id'],
      shippingCompanyId: jsonData['shipping_company_id'],
      cost: (jsonData['cost'] as num).toDouble(),
      driverName: jsonData['driver_name'],
      shipmentNum: jsonData['shipment_num'],
      shippedAt: jsonData['shipped_at'],
      shippingCompany: jsonData['shipping_company'],
      shippingCompanyAddress: jsonData['shipping_company_address'],
      shippingCompanyCity: jsonData['shipping_company_city'],
      shippingCompanyState: jsonData['shipping_company_state'],
      order: OrderModel.fromjson(jsonData['order']),
    );
  }
}
