// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Category/CategoriesRequestModel.dart';
import 'package:project_1_v2/Models/Manager/category/CategoryModel.dart';
import 'package:project_1_v2/Services/Manager/CategoriesServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CategoryContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchCategoriesScreen extends StatefulWidget {
  const SearchCategoriesScreen({super.key, required this.search});
  final String search;
  @override
  State<SearchCategoriesScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<SearchCategoriesScreen> {
  List<CategoryModel> categoryList = [];

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
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
          'Search Results',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: FutureBuilder<CategoriesRequestModel>(
        future: CategoriesService().showAllCategoriesService(
          widget.search,
          locale,
        ),
        builder: (context, snapshot) {
          try {
            // ?
            if (snapshot.hasData) {
              CategoriesRequestModel data = snapshot.data!;
              categoryList = data.data;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryContainer(
                            category: categoryList[index],
                            search: widget.search,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitFoldingCube(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return ListView(
                children: [
                  Center(
                    child: Image.asset(
                      'images/500code.png',
                      height: 100,
                      width: 200,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S().somthingWentWrong,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          S().swapToRefresh,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondary.withOpacity(0.7),
                            fontFamily: 'Lato',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: ListView(
                  children: [
                    Image.asset(
                      'images/check_connection (1).png',
                      height: 100,
                      width: 200,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S().checkYourInternetConnectionAndTryAgain,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            S().swapToRefresh,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withOpacity(0.7),
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
          return const Center(child: Text(''));
        },
      ),
    );
  }
}
