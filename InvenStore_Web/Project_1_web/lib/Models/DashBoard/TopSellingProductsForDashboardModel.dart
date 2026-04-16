import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';

class TopSellingProductsForDashboardModel {
  AllProductModel product;
  int quantity;
  TopSellingProductsForDashboardModel(
      {required this.product, required this.quantity});
  factory TopSellingProductsForDashboardModel.fromjson(jsonData) {
    return TopSellingProductsForDashboardModel(
      product: AllProductModel.fromjson(jsonData['product']),
      quantity: jsonData['quantity'],
    );
  }
}
