import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Models/Reports/SpecificProductModel.dart';

class SpecificDataModel {
  List<SpecificProductReportModel> data;
  ProductModel product;
  SpecificDataModel({required this.data, required this.product});

  factory SpecificDataModel.fromjson(Map<String, dynamic> jsonData) {
    return SpecificDataModel(
      product: ProductModel.fromjson(jsonData['product']),
      data: List.from(jsonData['report'])
          .map((val) => SpecificProductReportModel.fromjson(val))
          .toList(),
    );
  }
}
