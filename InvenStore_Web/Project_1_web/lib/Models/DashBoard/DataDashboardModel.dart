import 'package:buymore/Models/DashBoard/ProductReportDashboardModel.dart';
import 'package:buymore/Models/DashBoard/TopSellingProductsForDashboardModel.dart';
import 'package:buymore/Models/DashBoard/ordersForDashboardModel.dart';

class DataDashboardModel {
  List<TopSellingProductsForDashboardModel> topSellingProducts;
  ProductReportDashboardModel productsReport;
  OrdersForDashboardModel sellOrdersReport;

  DataDashboardModel(
      {required this.productsReport,
      required this.sellOrdersReport,
      required this.topSellingProducts});

  factory DataDashboardModel.fromJson(jsonData) {
    return DataDashboardModel(
      productsReport:
          ProductReportDashboardModel.fromjson(jsonData['products_report']),
      sellOrdersReport:
          OrdersForDashboardModel.fromjson(jsonData['sell_orders_report']),
      topSellingProducts: List.from(jsonData['top_selling_products'])
          .map((val) => TopSellingProductsForDashboardModel.fromjson(val))
          .toList(),
    );
  }
}
