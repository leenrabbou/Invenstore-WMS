// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:buymore/Models/Manager/Manufacturer/ManufacturerRequestModel.dart';
import 'package:buymore/Services/Manager/ManufacturerServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Manufacturer/ManufacturerContainer.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchManufacturerScreen extends StatefulWidget {
  const SearchManufacturerScreen({super.key, required this.search});
  final String search;
  @override
  State<SearchManufacturerScreen> createState() => _ManufacturerScreenState();
}

class _ManufacturerScreenState extends State<SearchManufacturerScreen> {
  List<ManufacturerModel> manufacturerList = [];

  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        // actions: [
        //   permissionsMap['manufacturer.store'] == false
        //       ? const SizedBox.shrink()
        //       : Padding(
        //           padding: EdgeInsets.only(
        //               top: 10.0,
        //               right: isArabic() ? 0 : 100,
        //               left: isArabic() ? 100 : 0),
        //           child: TextButton(
        //             onPressed: () {
        //               ShowDialog2().manufacturerDialog(context,
        //                   edit: false, manufacturerId: 0);
        //             },
        //             child: Text(
        //               S.of(context).addManufacturer,
        //               style: TextStyle(
        //                   color: Theme.of(context).colorScheme.onPrimary,
        //                   fontSize: 15),
        //             ),
        //           ),
        //         ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 0 : 50, right: isArabic() ? 50 : 0),
                  child: Text(
                    S.of(context).manufacturer,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 0 : 120, right: isArabic() ? 120 : 0),
                  child: Text(
                    S.of(context).city,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 180 : 0, left: isArabic() ? 0 : 180),
                  child: Text(
                    S.of(context).state,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 160 : 0, left: isArabic() ? 0 : 160),
                  child: Text(
                    S.of(context).address,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<ManufacturerRequestModel>(
                  future: ManufacturerServices()
                      .showAllManufacturersService(widget.search, locale),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasData) {
                        ManufacturerRequestModel data = snapshot.data!;
                        manufacturerList = data.data;
                        return ListView.builder(
                            itemCount: manufacturerList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ManufacturerContainer(
                                manufacturer: manufacturerList[index],
                                isSuppliesOrrder: false,
                              );
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: SpinKitFoldingCube(
                              color: Theme.of(context).colorScheme.primary),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
