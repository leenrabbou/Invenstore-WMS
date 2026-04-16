// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Screens/Warehouse/OrderDetailsScreen.dart';
import 'package:buymore/Services/Warehouse/OrdersServices.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/AnOrderRequestModel.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Warehouse/Shipment/ShipmentShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer(
      {super.key, required this.order, required this.orderType});
  final OrderModel order;
  final int orderType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 50 : 30,
        right: isArabic() ? 30 : 50,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () async {
          final locale =
              Provider.of<LocalizationProvider>(context, listen: false)
                  .language!;
          try {
            AnOrderRequestModel response =
                await OrdersServices().showAnOrderService(order.id, locale);
            if (!context.mounted) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return OrderDetailsScreen(
                    orderType: orderType,
                    order: response.data,
                    isEdit: false,
                  );
                },
              ),
            );
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            height: 100,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order.orderNum,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orderType == 3
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: order.orderedByImage == null
                              ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('images/analgesic.jpg'),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    '$imageUrl/${order.orderedByImage!}',
                                  ),
                                ),
                        ),
                  SizedBox(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderType == 3 || orderType == 2
                              ? order.orderedFrom
                              : order.orderedBy,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderType == 3 || orderType == 2
                              ? order.orderedFromAddress
                              : order.orderedByAddress,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          order.orderedAt,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${order.totalCost}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: order.statusId == 1 ||
                              order.statusId == 4 ||
                              order.statusId == 6
                          ? const Color.fromARGB(144, 40, 165, 214)
                          : order.statusId == 2 ||
                                  order.statusId == 3 ||
                                  order.statusId == 5
                              ? const Color.fromARGB(144, 206, 49, 38)
                              : const Color.fromARGB(144, 40, 214, 63),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: 120,
                    height: 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order.status,
                            style: const TextStyle(
                              fontSize: 15,
                              //color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  orderType == 1 && order.statusId == 4
                      ? IconButton(
                          onPressed: () {
                            ShipmentShowDialog()
                                .addShipmentDialog(context, order: order);
                          },
                          tooltip: S().shipping,
                          icon: Icon(
                            Icons.local_shipping,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : const SizedBox.shrink(),
                  order.buyOrdersUpdate && orderType == 3
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: isArabic() ? 0 : 50,
                              right: isArabic() ? 50 : 0),
                          child: IconButton(
                            onPressed: () async {
                              try {
                                final locale =
                                    Provider.of<LocalizationProvider>(context,
                                            listen: false)
                                        .language!;
                                AnOrderRequestModel response =
                                    await OrdersServices()
                                        .showAnOrderService(order.id, locale);
                                if (!context.mounted) {
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return OrderDetailsScreen(
                                        orderType: orderType,
                                        order: response.data,
                                        isEdit: true,
                                      );
                                    },
                                  ),
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            tooltip: S().edit,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
