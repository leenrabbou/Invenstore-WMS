// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Shipment%20Models/ShipmentModel.dart';
import 'package:buymore/Services/Warehouse/ShipmentServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/helper/Warehouse/OrderContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ShipmentDetailsScreen extends StatefulWidget {
  ShipmentDetailsScreen({super.key, required this.shipment});
  ShipmentModel shipment;

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await ShipmentServices()
          .showAnShipmentService(widget.shipment.id, locale);
      setState(() {
        widget.shipment = newData.data;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S.of(context).shipmentDetails,
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
        child: ListView(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1100,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 290,
                              width: 710,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().shipmentNumber,
                                          text: widget.shipment.shipmentNum,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().shippingCompany,
                                          text: widget.shipment.shippingCompany,
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().shipmentStatus,
                                          text: widget.shipment.order.status,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().driverName,
                                          text:
                                              widget.shipment.driverName != null
                                                  ? widget.shipment.driverName!
                                                  : '--',
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().sendingAddress,
                                          text: widget.shipment.order
                                              .orderedFromAddress,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().recievingAddress,
                                          text: widget
                                              .shipment.order.orderedByAddress,
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().dateOfShipment,
                                          text: widget.shipment.shippedAt,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().shippingCost,
                                          text: widget.shipment.cost.toString(),
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: FittedBox(
                              child: Text(
                                S().orderData,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          ),
                          OrderContainer(
                              order: widget.shipment.order, orderType: 3),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
