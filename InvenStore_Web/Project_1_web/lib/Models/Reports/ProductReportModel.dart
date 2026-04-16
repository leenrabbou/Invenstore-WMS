class ProductReportModel {
  String productName;
  String? image;
  int quantityOrderedToSell,
      quantitySold,
      quantityDisposed,
      quantityExpired,
      quantitPurchased;
  double cost, revenue;

  ProductReportModel({
    required this.image,
    required this.cost,
    required this.productName,
    required this.quantitPurchased,
    required this.quantityDisposed,
    required this.quantityExpired,
    required this.quantityOrderedToSell,
    required this.quantitySold,
    required this.revenue,
  });

  factory ProductReportModel.fromjson(jsonData) {
    return ProductReportModel(
      image: jsonData['product_image'],
      cost: jsonData['cost'],
      productName: jsonData['product_name'],
      quantitPurchased: jsonData['quantity_purchased'],
      quantityDisposed: jsonData['quantity_disposed'],
      quantityExpired: jsonData['quantity_expired'],
      quantityOrderedToSell: jsonData['quantity_ordered_to_sell'],
      quantitySold: jsonData['quantity_sold'],
      revenue: jsonData['revenue'],
    );
  }
}
