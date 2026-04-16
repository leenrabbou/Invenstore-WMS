// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Manager/category/CategoriesRequestModel.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/helper/Manager/Category/CategoryContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchCategoriesScreen extends StatefulWidget {
  SearchCategoriesScreen(
      {super.key, required this.isWarehouse, required this.search});
  bool isWarehouse;
  String search;
  @override
  State<SearchCategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<SearchCategoriesScreen> {
  List<CategoryModel> categoryList = [];
  final GlobalKey<CategoryContainerState> _k =
      GlobalKey<CategoryContainerState>();

  @override
  Widget build(BuildContext context) {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Container(
          height: 700,
          width: 1200,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
          child: FutureBuilder<CategoriesRequestModel>(
              future: CategoriesService()
                  .showAllCategoriesService(widget.search, locale),
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    CategoriesRequestModel data = snapshot.data!;
                    categoryList = data.data;
                    return ListView.builder(
                        itemCount: categoryList.length,
                        key: _k,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryContainer(
                            category: categoryList[index],
                            isWarehouse: widget.isWarehouse,
                            search: widget.search,
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
      ),
    );
  }
}
