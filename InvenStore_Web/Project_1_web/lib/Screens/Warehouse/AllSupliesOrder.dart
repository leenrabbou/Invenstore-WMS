// ignore_for_file: file_names

import 'package:buymore/Screens/Manager/ManufacturerScreen.dart';
import 'package:buymore/Screens/Warehouse/OrderScreen.dart';
import 'package:buymore/Screens/Warehouse/SearchOrderScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class AllSupliesOrdersScreen extends StatefulWidget {
  const AllSupliesOrdersScreen({super.key});

  @override
  State<AllSupliesOrdersScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AllSupliesOrdersScreen> {
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
                        orderType: 3,
                      );
                    }));
                  }
                },
              ),
            ],
          ),
          actions: [
            permissionsMap['orders.manufacturer.store'] == true
                ? Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: isArabic() ? 0 : 50,
                        left: isArabic() ? 50 : 0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 104, 168, 221),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const ManufacturerScreen(
                                isSuppliesOrrder: true,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Create Order',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                dividerColor: Theme.of(context).colorScheme.background,
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
              ordersType: 3,
              status: null,
            ),
            OrderScreen(
              ordersType: 3,
              status: 'pending',
            ),
            OrderScreen(
              ordersType: 3,
              status: 'under preparing',
            ),
            OrderScreen(
              ordersType: 3,
              status: 'canceled',
            ),
            OrderScreen(
              ordersType: 3,
              status: 'deleted',
            ),
            OrderScreen(
              ordersType: 3,
              status: 'under shipping',
            ),
            OrderScreen(
              ordersType: 3,
              status: 'delivered',
            ),
          ],
        ),
      ),
    );
  }
}
