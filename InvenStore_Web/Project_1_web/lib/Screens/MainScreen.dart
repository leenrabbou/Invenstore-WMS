import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/DashBoard/DashboardResponseModel.dart';
import 'package:buymore/Models/DashBoard/DataDashboardModel.dart';
import 'package:buymore/Services/Dashboard/DashboardServices.dart';
import 'package:buymore/helper/ProductDashboardCard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  Future<DataDashboardModel> fetchData(BuildContext context) async {
    try {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      DashboardResponseModel response =
          await DashboardServices().getDataService(locale);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double lowStock = 50;
    final double validQty = 100;
    final double expiredQty = 39;
    final double disposedQty = 24;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 30),
        child: FutureBuilder<DataDashboardModel>(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitFoldingCube(
                    color: Theme.of(context).colorScheme.primary),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Failed to load data: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final data = snapshot.data!;
            final ordersData = {
              "New": data.sellOrdersReport.newOrders.toDouble(),
              "Pending": data.sellOrdersReport.pendingOrders.toDouble(),
              "Deleted": data.sellOrdersReport.deletedOrders.toDouble(),
              "Rejected": data.sellOrdersReport.rejectedOrders.toDouble(),
              "Preparing":
                  data.sellOrdersReport.underPreparingOrders.toDouble(),
              "Cancelled": data.sellOrdersReport.cancelledOrders.toDouble(),
              "Shipping": data.sellOrdersReport.underShippingOrders.toDouble(),
              "Delivered": data.sellOrdersReport.deliveredOrders.toDouble(),
            };

            List<PieChartSectionData> buildPieChartSections() {
              return [
                PieChartSectionData(
                  color: const Color(0xffffe082),
                  value: data.productsReport.lowStockProducts.toDouble(),
                  radius: 40,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: const Color(0xff81c784),
                  value: data.productsReport.validQuantity.toDouble(),
                  radius: 40,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: const Color.fromARGB(206, 213, 0, 0),
                  value: data.productsReport.expiredQuantity.toDouble(),
                  radius: 40,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: const Color(0xff64b5f6),
                  value: data.productsReport.quantityDisposed.toDouble(),
                  radius: 40,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ];
            }

            final barGroups = ordersData.entries.map((entry) {
              return BarChartGroupData(
                x: ordersData.keys.toList().indexOf(entry.key),
                barRods: [
                  BarChartRodData(
                    toY: entry.value,
                    color: const Color.fromARGB(255, 104, 168, 221),
                    width: 25,
                  ),
                ],
              );
            }).toList();

            Widget buildLegendItem(Color color, String text) {
              return Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              );
            }

            Widget buildLegend() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLegendItem(
                    const Color(0xffffe082),
                    'Low Stock Products',
                  ),
                  const SizedBox(height: 10),
                  buildLegendItem(const Color(0xff81c784), 'Valid Quantity'),
                  const SizedBox(height: 10),
                  buildLegendItem(
                      const Color.fromARGB(206, 213, 0, 0), 'Expired Quantity'),
                  const SizedBox(height: 10),
                  buildLegendItem(const Color(0xff64b5f6), 'Quantity Disposed'),
                  const SizedBox(height: 10),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sales Activity',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(
                            width: 500,
                            height: 300,
                            child: BarChart(
                              BarChartData(
                                maxY: ordersData.values
                                        .reduce((a, b) => a > b ? a : b) +
                                    10,
                                barTouchData: const BarTouchData(enabled: true),
                                titlesData: FlTitlesData(
                                  leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        final index = value.toInt();
                                        final keys = ordersData.keys.toList();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            keys[index],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: const FlGridData(show: false),
                                barGroups: barGroups,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 100),
                      // 1. عرفي القيم يدوياً هنا لتسهيل تعديلها لاحقاً

// 2. الكود الخاص بالواجهة
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Products Details',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        color: const Color(0xffffe082),
                                        value: lowStock,
                                        title: lowStock > 0
                                            ? '${lowStock.toInt()}'
                                            : '', // لا يظهر الرقم إذا كان 0 لتجنب الزحمة
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      PieChartSectionData(
                                        color: const Color(0xff81c784),
                                        value: validQty,
                                        title: validQty > 0
                                            ? '${validQty.toInt()}'
                                            : '',
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      PieChartSectionData(
                                        color: const Color.fromARGB(
                                            206, 213, 0, 0),
                                        value: expiredQty,
                                        title:
                                            '${expiredQty.toInt()}', // سيظهر 1239
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      PieChartSectionData(
                                        color: const Color(0xff64b5f6),
                                        value: disposedQty,
                                        title:
                                            '${disposedQty.toInt()}', // سيظهر 24
                                        radius: 50,
                                        titleStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                    centerSpaceRadius: 50,
                                    sectionsSpace:
                                        2, // مسافة صغيرة تعطي شكلاً جمالياً للتقسيمات
                                    borderData: FlBorderData(show: false),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              buildLegend(), // تأكدي أن هذه الدالة موجودة لديكِ لترتيب الألوان بجانب الدائرة
                            ],
                          ),
                        ],
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Products Details',
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Theme.of(context).colorScheme.secondary),
                      //     ),
                      //     Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 300,
                      //           height: 300,
                      //           child: PieChart(
                      //             PieChartData(
                      //               sections: buildPieChartSections(),
                      //               centerSpaceRadius: 50,
                      //               sectionsSpace: 35,
                      //               borderData: FlBorderData(show: false),
                      //               startDegreeOffset: 0,
                      //               pieTouchData: PieTouchData(
                      //                 touchCallback: (FlTouchEvent event,
                      //                     pieTouchResponse) {
                      //                   if (!event
                      //                           .isInterestedForInteractions ||
                      //                       pieTouchResponse == null ||
                      //                       pieTouchResponse.touchedSection ==
                      //                           null) {
                      //                     return;
                      //                   }
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         buildLegend(),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Top Selling Products',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.topSellingProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductDashboardCard(
                            product: data.topSellingProducts[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
