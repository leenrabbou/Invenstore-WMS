// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Models/Warehouse/Shipment%20Models/ShipmentModel.dart';
import 'package:buymore/Screens/Warehouse/ShipmentDetailsScreen.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class ShipmentContainer extends StatefulWidget {
  const ShipmentContainer({
    super.key,
    required this.shipment,
  });
  final ShipmentModel shipment;

  @override
  State<ShipmentContainer> createState() => _ShipmentContainerState();
}

class _ShipmentContainerState extends State<ShipmentContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 50 : 30,
        right: isArabic() ? 30 : 50,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ShipmentDetailsScreen(shipment: widget.shipment);
              },
            ),
          );
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            height: 90,
            width: 1000,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                )
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shipment.shipmentNum,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.shipment.driverName != null
                    ? SizedBox(
                        width: 215,
                        child: Text(
                          widget.shipment.driverName!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 215,
                        child: Text(
                          '---',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                SizedBox(
                  width: 175,
                  child: Text(
                    widget.shipment.order.orderedFrom,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    widget.shipment.order.orderNum,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.shipment.order.status,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
