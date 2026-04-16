// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Warehouse/WarehouseRequestModel.dart';
import 'package:buymore/Services/Warehouse/WarehouseServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/helper/Manager/Warehouse/WarehouseCard.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WarehousesScreen extends StatelessWidget {
  WarehousesScreen({super.key, required this.isCart});
  final TextEditingController _searchController = TextEditingController();
  bool isCart;
  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SearchTextField(
          searchController: _searchController,
          onPressed: () {},
        ),
        actions: [
          isCart
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 100,
                      left: isArabic() ? 100 : 0),
                  child: TextButton(
                    onPressed: () {
                      ShowDialog2()
                          .warhouseDialog(context, text: S().addWarehouse);
                    },
                    child: Text(
                      S().addWarehouse,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                ),
        ],
      ),
      body: Center(
        child: Container(
            height: 700,
            width: 1200,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<WarehouseRequestModel>(
                          future: WarehouseServices()
                              .showAllWarehousesService(locale),
                          builder: (context, snapshot) {
                            try {
                              if (snapshot.hasData) {
                                WarehouseRequestModel data = snapshot.data!;

                                return GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6,
                                      childAspectRatio: 1.5 / 1,
                                    ),
                                    itemCount: data.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WarehouseCard(
                                        warehouse: data.data[index],
                                        isCart: isCart,
                                      );
                                    });
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SpinKitFoldingCube(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                );
                              } else if (snapshot.hasError) {
                                if (kDebugMode) {
                                  print(snapshot.error);
                                }
                                return Center(
                                  child: ListView(
                                    children: [
                                      Image.asset(
                                        'images/500code.png',
                                        height: 300,
                                        width: 500,
                                      ),
                                      Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Somthing Went Wrong',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Swap to Refresh',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withOpacity(0.7),
                                                fontFamily: 'Lato',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: ListView(
                                    children: [
                                      Image.asset(
                                        'images/check_connection (1).png',
                                        height: 300,
                                        width: 400,
                                      ),
                                      Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Check your internet connection and try again.',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Swap to Refresh',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withOpacity(0.7),
                                                fontFamily: 'Lato',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
                              }
                            }
                            return const Center(
                              child: Text(''),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
