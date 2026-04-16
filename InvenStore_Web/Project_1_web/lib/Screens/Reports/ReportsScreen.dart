import 'package:buymore/Screens/Manager/ProductsScreen.dart';
import 'package:buymore/Screens/Reports/OrdersReportDetailsScreen.dart';
import 'package:buymore/Screens/Reports/ProductReportDetailsScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Reports/ReportContainer.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(children: [
          Row(
            children: [
              ReportContainer(
                text: S().sellOrders,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const OrdersReportDetailsScreen(
                          type: 'sell',
                          text: 'Sales Report',
                        );
                      },
                    ),
                  );
                },
              ),
              ReportContainer(
                text: S().buyOrders,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const OrdersReportDetailsScreen(
                          type: 'buy',
                          text: 'Buy Orders',
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              ReportContainer(
                text: S().products,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const ProductReportDetailsScreen();
                      },
                    ),
                  );
                },
              ),
              ReportContainer(
                text: 'Specific Product',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const ProductScreen(
                          warehouseType: 2,
                          isCart: false,
                          isWarehouse: true,
                          manufacturerId: -1,
                          isReport: true,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
