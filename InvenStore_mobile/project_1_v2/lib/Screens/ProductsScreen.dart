// ignore_for_file: file_names, avoid_print

import 'package:project_1_v2/Screens/ProductScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/main.dart';
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
            S().products,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            IconButton(
              onPressed: () async {
                // try {
                //   final barCode = await FlutterBarcodeScanner.scanBarcode(
                //       '0xfff69a8dd', 'Cancel', true, ScanMode.BARCODE);

                //   if (!mounted) return;
                //   print(barCode);
                // } on PlatformException {
                //   print('error to fetch');
                // }
              },
              icon: const Icon(Icons.barcode_reader),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Align(
              alignment: isArabic()
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: TabBar(
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
                    width: 120,
                    child: Tab(
                      child: Text(
                        S().allProducts,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Tab(
                      child: Text(
                        S().validProducts,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Tab(
                      child: Text(
                        S().expiredProducts,
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
        body: TabBarView(
          children: [
            ProductScreen(
              warehouseType: 2,
              isCart: false,
              isDestruction: true,
              isSale: false,
            ),
            ProductScreen(
              warehouseType: 3,
              isCart: false,
              isDestruction: true,
              isSale: false,
            ),
            ProductScreen(
              warehouseType: 4,
              isCart: false,
              isDestruction: true,
              isSale: false,
            ),
          ],
        ),
      ),
    );
  }
}
