class SpecificProductReportModel {
  String from, to;
  int quantityOrderedToSell,
      quantitySold,
      quantityDisposed,
      quantityExpired,
      quantityPurchased;
  double revenue, cost;

  SpecificProductReportModel({
    required this.from,
    required this.cost,
    required this.quantityPurchased,
    required this.to,
    required this.quantityDisposed,
    required this.quantityExpired,
    required this.quantityOrderedToSell,
    required this.quantitySold,
    required this.revenue,
  });

  factory SpecificProductReportModel.fromjson(jsonData) {
    return SpecificProductReportModel(
      from: jsonData['from'],
      cost: jsonData['cost'],
      to: jsonData['to'],
      quantityPurchased: jsonData['quantity_purchased'],
      quantityDisposed: jsonData['quantity_disposed'],
      quantityExpired: jsonData['quantity_expired'],
      quantityOrderedToSell: jsonData['quantity_ordered_to_sell'],
      quantitySold: jsonData['quantity_sold'],
      revenue: jsonData['revenue'],
    );
  }
}
