class ProductReportDashboardModel {
  int lowStockProducts, validQuantity, expiredQuantity, quantityDisposed;

  ProductReportDashboardModel(
      {required this.expiredQuantity,
      required this.lowStockProducts,
      required this.quantityDisposed,
      required this.validQuantity});

  factory ProductReportDashboardModel.fromjson(jsonData) {
    return ProductReportDashboardModel(
        expiredQuantity: jsonData['expired_quantity'],
        lowStockProducts: jsonData['low_stock_products'],
        quantityDisposed: jsonData['quantity_disposed'],
        validQuantity: jsonData['valid_quantity']);
  }
}
