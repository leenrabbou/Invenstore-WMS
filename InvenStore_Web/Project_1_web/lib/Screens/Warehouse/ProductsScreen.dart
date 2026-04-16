// ignore_for_file: file_names

import 'package:buymore/Screens/Manager/ProductsScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProductsScreenW extends StatefulWidget {
  const ProductsScreenW({super.key});

  @override
  State<ProductsScreenW> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductsScreenW> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onBackground,
                dividerColor: Theme.of(context).colorScheme.background,
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
                        S().allProducts,
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
                        S().validProducts,
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
                        S().expiredProducts,
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
            ProductScreen(
              warehouseType: 2,
              isCart: false,
              isWarehouse: true,
              manufacturerId: -1,
              isReport: false,
            ),
            ProductScreen(
                warehouseType: 3,
                isCart: false,
                isWarehouse: true,
                manufacturerId: -1,
                isReport: false),
            ProductScreen(
                warehouseType: 4,
                isCart: false,
                isWarehouse: true,
                manufacturerId: -1,
                isReport: false),
          ],
        ),
      ),
    );
  }
}
