import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Reports/SpecificProductModel.dart';
import 'package:buymore/Models/Reports/SpecificProductReportResposeModel.dart';
import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/Services/Reports/ReportsServices.dart';
import 'package:buymore/helper/Reports/ReportsShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SpecificProductReportDetailsScreen extends StatefulWidget {
  const SpecificProductReportDetailsScreen(
      {super.key, required this.productID});
  final AllProductModel productID;
  @override
  State<SpecificProductReportDetailsScreen> createState() =>
      _ProductReportDetailsScreenState();
}

class _ProductReportDetailsScreenState
    extends State<SpecificProductReportDetailsScreen> {
  List<SpecificProductReportModel> products = [];

  String? startDate, endDate, frequency;

  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: Text(
          '${widget.productID.name} Report',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
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
                    await dialog.productReportDialog(context, isSpecific: true);
                setState(() {
                  startDate = result['startDate'];
                  endDate = result['endDate'];
                  frequency = result['frequency'];
                });
              },
              child: Text(
                'Customize',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<SpecificProductReportResposeModel>(
        future: ReportsServices().getSpecificProductReportService(
            widget.productID.id, startDate, endDate, frequency, locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFoldingCube(
                  color: Theme.of(context).colorScheme.primary),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.data.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            snapshot.data!.data.data;
            products = snapshot.data!.data.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 20, bottom: 20),
                child: Column(
                  children: [
                    DataTable(
                      dataRowHeight: 90,
                      headingRowHeight: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Theme.of(context).colorScheme.primary),
                      columnSpacing: 30,
                      columns: const [
                        DataColumn(
                          label: Text('from'),
                        ),
                        DataColumn(
                          label: Text('to'),
                        ),
                        DataColumn(
                          label: Text('quantity Ordered To Sell'),
                        ),
                        DataColumn(
                          label: Text('Quantity Sold'),
                        ),
                        DataColumn(
                          label: Text('Quantity Disposed'),
                        ),
                        DataColumn(
                          label: Text('Quantity Expired'),
                        ),
                        DataColumn(
                          label: Text('Quantity Purchased'),
                        ),
                        DataColumn(
                          label: Text('Revenue'),
                        ),
                        DataColumn(
                          label: Text('Cost'),
                        ),
                      ],
                      rows: products.map((product) {
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              product.from,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.to,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.quantityOrderedToSell.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.quantitySold.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.quantityDisposed.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.quantityExpired.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.quantityPurchased.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.revenue.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )),
                            DataCell(Text(
                              product.cost.toString(),
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
