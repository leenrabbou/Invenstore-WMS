class OrdersForDashboardModel {
  String from, to;
  int newOrders,
      pendingOrders,
      deletedOrders,
      rejectedOrders,
      underPreparingOrders,
      cancelledOrders,
      underShippingOrders,
      deliveredOrders;
  double cost;

  OrdersForDashboardModel({
    required this.cancelledOrders,
    required this.cost,
    required this.deletedOrders,
    required this.deliveredOrders,
    required this.from,
    required this.newOrders,
    required this.pendingOrders,
    required this.rejectedOrders,
    required this.to,
    required this.underPreparingOrders,
    required this.underShippingOrders,
  });

  factory OrdersForDashboardModel.fromjson(jsonData) {
    return OrdersForDashboardModel(
        cancelledOrders: jsonData['cancelled_orders'],
        cost: jsonData['cost'],
        deletedOrders: jsonData['deleted_orders'],
        deliveredOrders: jsonData['delivered_orders'],
        from: jsonData['from'],
        newOrders: jsonData['new_orders'],
        pendingOrders: jsonData['pending_orders'],
        rejectedOrders: jsonData['rejected_orders'],
        to: jsonData['to'],
        underPreparingOrders: jsonData['under_preparing_orders'],
        underShippingOrders: jsonData['under_shipping_orders']);
  }
}
