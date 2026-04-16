// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/AnOrderRequestModel.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:project_1_v2/Screens/OrderDetailsScreen.dart';
import 'package:project_1_v2/Services/Warehouse/OrdersServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () async {
          final locale = Provider.of<LocalizationProvider>(
            context,
            listen: false,
          ).language!;
          try {
            AnOrderRequestModel response = await OrdersServices()
                .showAnOrderService(order.id, locale);

            if (!context.mounted) {
              return;
            }
            response.status == 1
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return OrderDetailsScreen(order: response.data);
                      },
                    ),
                  )
                : null;
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        child: Container(
          height: 205,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: order.orderedByImage == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundImage: const AssetImage(
                                    'images/trolley.png',
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  backgroundImage: NetworkImage(
                                    '$imageUrl/${order.orderedByImage!}',
                                  ),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S().orderId,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              order.orderNum,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              decoration: BoxDecoration(
                                color:
                                    order.statusId == 1 ||
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
                              height: 40,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      order.status,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          S().orderedFrom,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        order.orderedFrom,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          S().address,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      Text(
                        profile!.address != null ? profile!.address! : '---',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              S().orderData,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                              order.orderedAt,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              S().cost,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          Text(
                            '${order.totalCost}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
