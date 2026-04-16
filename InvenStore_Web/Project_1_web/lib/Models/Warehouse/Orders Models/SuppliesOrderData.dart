import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';

class SuppliesOrderData {
  AllProductModel product;
  int quantity;
  String? exDate;
  SuppliesOrderData({
    required this.product,
    required this.quantity,
    required this.exDate,
  });
}
