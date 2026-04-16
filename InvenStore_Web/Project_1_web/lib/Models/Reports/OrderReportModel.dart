class OrderReportModel {
  String from, to;
  int newOrders,
      pendingOrders,
      deletedOrders,
      rejectedOrders,
      undePreparingOrders,
      cancelledOrders,
      underShippingOrders,
      deliveredOrders;
  double cost;

  OrderReportModel({
    required this.from,
    required this.to,
    required this.cancelledOrders,
    required this.cost,
    required this.deletedOrders,
    required this.deliveredOrders,
    required this.newOrders,
    required this.pendingOrders,
    required this.rejectedOrders,
    required this.undePreparingOrders,
    required this.underShippingOrders,
  });

  factory OrderReportModel.fromjson(jsonData) {
    return OrderReportModel(
      from: jsonData['from'],
      to: jsonData['to'],
      cancelledOrders: jsonData['cancelled_orders'],
      cost: jsonData['cost'],
      deletedOrders: jsonData['deleted_orders'],
      deliveredOrders: jsonData['delivered_orders'],
      newOrders: jsonData['new_orders'],
      pendingOrders: jsonData['pending_orders'],
      rejectedOrders: jsonData['rejected_orders'],
      undePreparingOrders: jsonData['under_preparing_orders'],
      underShippingOrders: jsonData['under_shipping_orders'],
    );
  }
}
