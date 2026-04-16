// ignore_for_file: file_names

import 'package:project_1_v2/Screens/CartScreen.dart';
import 'package:project_1_v2/Screens/OrderScreen.dart';
import 'package:project_1_v2/Screens/WarehouseScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/material.dart';

class AllBuyOrdersScreen extends StatefulWidget {
  const AllBuyOrdersScreen({super.key});

  @override
  State<AllBuyOrdersScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AllBuyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          toolbarHeight: 80,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            S().buyOrders,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            permissionsMap['orders.buy.store'] == true
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const WarehouseScreen(isCart: true);
                          },
                        ),
                      );
                    },
                    child: Text(S().createOrder),
                  )
                : const SizedBox.shrink(),
            permissionsMap['orders.buy.store'] == true
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CartScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  )
                : const SizedBox.shrink(),
          ],
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Theme.of(
                  context,
                ).colorScheme.onBackground,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: const Color.fromARGB(255, 104, 168, 221),
                tabs: [
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().all,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().pending,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().underPreparing,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().canceled,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().deleted,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().underShipping,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Tab(
                      child: Text(
                        S().delievered,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            OrderScreen(status: null),
            OrderScreen(status: 'pending'),
            OrderScreen(status: 'under preparing'),
            OrderScreen(status: 'canceled'),
            OrderScreen(status: 'deleted'),
            OrderScreen(status: 'under shipping'),
            OrderScreen(status: 'delivered'),
          ],
        ),
      ),
    );
  }
}
