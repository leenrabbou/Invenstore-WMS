import 'package:buymore/Models/Reports/ProductReportModel.dart';

class ProductListReportModel {
  List<ProductReportModel> data;
  ProductListReportModel({required this.data});

  factory ProductListReportModel.fromjson(Map<String, dynamic> jsonData) {
    return ProductListReportModel(
      data: List.from(jsonData['report'])
          .map((val) => ProductReportModel.fromjson(val))
          .toList(),
    );
  }
}
