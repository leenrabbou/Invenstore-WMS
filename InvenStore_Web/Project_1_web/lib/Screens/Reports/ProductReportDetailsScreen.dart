import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Reports/ProductReportModel.dart';
import 'package:buymore/Models/Reports/ProductReportResponseModel.dart';
import 'package:buymore/Services/Reports/ReportsServices.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Reports/ReportsShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductReportDetailsScreen extends StatefulWidget {
  const ProductReportDetailsScreen({super.key});
  @override
  State<ProductReportDetailsScreen> createState() =>
      _ProductReportDetailsScreenState();
}

class _ProductReportDetailsScreenState
    extends State<ProductReportDetailsScreen> {
  List<ProductReportModel> products = [];

  String? startDate, endDate;

  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Products Report',
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
                Map<String, dynamic> result = await dialog
                    .productReportDialog(context, isSpecific: false);
                setState(() {
                  startDate = result['startDate'];
                  endDate = result['endDate'];
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
      body: FutureBuilder<ProductReportsRequestModel>(
        future: ReportsServices()
            .getProductReportService(startDate, endDate, locale),
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
                          label: Text('image'),
                        ),
                        DataColumn(
                          label: Text('Product name'),
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
                            DataCell(
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: product.image == null
                                    ? Image.asset(
                                        'images/image.png',
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        '$imageUrl/${product.image!}',
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            DataCell(Text(
                              product.productName,
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
                              product.quantitPurchased.toString(),
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
