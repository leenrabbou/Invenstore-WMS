// ignore_for_file: file_names, must_be_immutable

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/AnSaleModel.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/AnSalesRequestModel.dart';
import 'package:project_1_v2/Services/Warehouse/SalesService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/DetailsContainer.dart';
import 'package:project_1_v2/helper/SaleProductCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SalesDetailsScreen extends StatefulWidget {
  SalesDetailsScreen({super.key, required this.order});
  AnSaleModel order;

  @override
  State<SalesDetailsScreen> createState() => _SalesDetailsScreenState();
}

class _SalesDetailsScreenState extends State<SalesDetailsScreen> {
  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      AnSaleRequestModel newData = await SalesServices()
          .showAnSalesOrdersService(widget.order.id, locale);
      setState(() {
        widget.order = newData.data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S().saleDetails,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 190,
                    width: 600,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              DetailsContainer(
                                title: S().orderId,
                                text: widget.order.saleNum,
                                height: 50,
                                width: 170,
                              ),
                              DetailsContainer(
                                title: S().buyerName,
                                text: widget.order.buyerName,
                                height: 50,
                                width: 170,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              DetailsContainer(
                                title: S().saledAt,
                                text: widget.order.saledAt.substring(0, 10),
                                height: 50,
                                width: 170,
                              ),
                              DetailsContainer(
                                title: S().SaledBy,
                                text: widget.order.saledByName,
                                height: 50,
                                width: 170,
                              ),
                            ],
                          ),
                          DetailsContainer(
                            title: S().total,
                            text: widget.order.totalPrice.toString(),
                            height: 50,
                            width: 170,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.order.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SaleProductsCard(
                      product: widget.order.products[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
