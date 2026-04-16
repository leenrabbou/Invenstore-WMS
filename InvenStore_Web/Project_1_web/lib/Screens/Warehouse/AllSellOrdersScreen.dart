// ignore_for_file: file_names

import 'package:buymore/Screens/Warehouse/OrderScreen.dart';
import 'package:buymore/Screens/Warehouse/SearchOrderScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:flutter/material.dart';

class AllSellOrdersScreen extends StatefulWidget {
  const AllSellOrdersScreen({super.key});

  @override
  State<AllSellOrdersScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AllSellOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? status,
      orderedBy,
      before,
      after,
      id,
      cost,
      date,
      cheaperThan,
      expensiveThan,
      name,
      city,
      state,
      address;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
              SearchTextField(
                searchController: _searchController,
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchOrderScreen(
                        search: _searchController.text,
                        orderType: 1,
                      );
                    }));
                  }
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                dividerColor: Theme.of(context).colorScheme.background,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onBackground,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: const Color.fromARGB(255, 104, 168, 221),
                tabs: [
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().all,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().pending,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().underPreparing,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().canceled,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().deleted,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().underShipping,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Tab(
                      child: Text(
                        S().delievered,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
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
            OrderScreen(
              ordersType: 1,
              status: null,
            ),
            OrderScreen(
              ordersType: 1,
              status: 'pending',
            ),
            OrderScreen(
              ordersType: 1,
              status: 'under preparing',
            ),
            OrderScreen(
              ordersType: 1,
              status: 'canceled',
            ),
            OrderScreen(
              ordersType: 1,
              status: 'deleted',
            ),
            OrderScreen(
              ordersType: 1,
              status: 'under shipping',
            ),
            OrderScreen(
              ordersType: 1,
              status: 'delivered',
            ),
          ],
        ),
      ),
    );
  }
}
