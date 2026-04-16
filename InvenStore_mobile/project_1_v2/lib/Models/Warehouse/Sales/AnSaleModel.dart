// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Sales/ProductSales.dart';

class AnSaleModel {
  int id;
  String? saledByImage;
  String saleNum, buyerName, saledAt, saledByName;
  double totalPrice;
  List<ProductSalesModel> products;
  AnSaleModel({
    required this.id,
    required this.buyerName,
    required this.saleNum,
    required this.saledAt,
    required this.saledByImage,
    required this.saledByName,
    required this.totalPrice,
    required this.products,
  });

  factory AnSaleModel.fromjson(jsonData) {
    return AnSaleModel(
      id: jsonData['id'],
      saleNum: jsonData['sale_num'],
      buyerName: jsonData['buyer_name'],
      saledAt: jsonData['saled_at'],
      saledByImage: jsonData['saled_by_image'],
      saledByName: jsonData['saled_by_name'],
      totalPrice: (jsonData['total_price'] as num).toDouble(),
      products: List.from(
        jsonData['products'],
      ).map((val) => ProductSalesModel.fromjson(val)).toList(),
    );
  }
}
