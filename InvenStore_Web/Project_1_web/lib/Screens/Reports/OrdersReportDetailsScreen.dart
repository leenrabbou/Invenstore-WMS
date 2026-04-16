import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Reports/OrderReportModel.dart';
import 'package:buymore/Models/Reports/ReportResponseModel.dart';
import 'package:buymore/Services/Reports/ReportsServices.dart';
import 'package:buymore/helper/Reports/DownloadReportsDialog.dart';
import 'package:buymore/helper/Reports/ReportsShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class OrdersReportDetailsScreen extends StatefulWidget {
  const OrdersReportDetailsScreen(
      {super.key, required this.type, required this.text});
  final String type;
  final String text;
  @override
  State<OrdersReportDetailsScreen> createState() =>
      _OrdersReportDetailsScreenState();
}

class _OrdersReportDetailsScreenState extends State<OrdersReportDetailsScreen> {
  List<OrderReportModel> report = [];
  String? startDate, endDate, frequency;

  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          widget.text,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 100,
                left: isArabic() ? 100 : 0),
            child: TextButton(
              onPressed: () async {
                ReportDialog dialog = ReportDialog();
                Map<String, dynamic> result =
                    await dialog.orderReportDialog(context);
                setState(() {
                  startDate = result['startDate'];
                  endDate = result['endDate'];
                  frequency = result['frequency'];
                });
              },
              child: Text(
                'Customize',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 50,
                left: isArabic() ? 50 : 0),
            child: TextButton(
              onPressed: () async {
                DownloadReportsDialog()
                    .orderReportDialog(context, type: widget.type);
              },
              child: Text(
                'download',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<ReportsRequestModel>(
        future: ReportsServices().getOrdersReportService(
            startDate, endDate, frequency, widget.type, locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFoldingCube(
                  color: Theme.of(context).colorScheme.primary),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            report = snapshot.data!.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 20, bottom: 20),
                child: Column(
                  children: [
                    DataTable(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Theme.of(context).colorScheme.primary),
                      columnSpacing: 40,
                      columns: const [
                        DataColumn(
                          label: Text('from'),
                        ),
                        DataColumn(
                          label: Text('to'),
                        ),
                        DataColumn(
                          label: Text('New'),
                        ),
                        DataColumn(
                          label: Text('Pending'),
                        ),
                        DataColumn(
                          label: Text('Deleted'),
                        ),
                        DataColumn(
                          label: Text('Rejected'),
                        ),
                        DataColumn(
                          label: Text('Under Preparing'),
                        ),
                        DataColumn(
                          label: Text('Cancelled'),
                        ),
                        DataColumn(
                          label: Text('Under Shipping'),
                        ),
                        DataColumn(
                          label: Text('Deleviered'),
                        ),
                        DataColumn(
                          label: Text('Cost'),
                        ),
                      ],
                      rows: report.map((order) {
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              order.from,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.to,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.newOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.pendingOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.deletedOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.rejectedOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.undePreparingOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.cancelledOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.underShippingOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.deliveredOrders.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              order.cost.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
