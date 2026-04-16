// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';

class DestructionModel {
  int id, quantity;
  String destructionNum, cause, destructionedByName;
  String destructionedAt;

  AllProductModel product;

  DestructionModel({
    required this.id,
    required this.quantity,
    required this.cause,
    required this.destructionNum,
    required this.destructionedAt,
    required this.destructionedByName,
    required this.product,
  });

  factory DestructionModel.fromjson(jsonData) {
    return DestructionModel(
      id: jsonData['id'],
      quantity: jsonData['quantity'],
      cause: jsonData['cause'],
      destructionNum: jsonData['destruction_num'],
      destructionedAt: jsonData['destructioned_at'],
      destructionedByName: jsonData['destructioned_by_name'],
      product: AllProductModel.fromjson(jsonData['product']),
    );
  }
}
