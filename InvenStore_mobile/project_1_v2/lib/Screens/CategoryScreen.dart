// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Category/CategoriesRequestModel.dart';
import 'package:project_1_v2/Models/Manager/category/CategoryModel.dart';
import 'package:project_1_v2/Screens/SearchCategoriesScreen.dart';
import 'package:project_1_v2/Services/Manager/CategoriesServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CategoryContainer.dart';
import 'package:project_1_v2/helper/SearchTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<CategoryModel> categoryList = [];
  String? search;
  final GlobalKey<CategoryContainerState> _k =
      GlobalKey<CategoryContainerState>();

  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final newData = await CategoriesService().showAllCategoriesService(
        search,
        locale,
      );
      setState(() {
        categoryList = newData.data;
      });
      _k.currentState?.refreshSubcategories();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

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
          S().categories,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 50,
        child: FutureBuilder<CategoriesRequestModel>(
          future: CategoriesService().showAllCategoriesService(search, locale),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: SearchTextField(
                          searchController: _searchController,
                          onPressed: () async {
                            if (_searchController.text.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SearchCategoriesScreen(
                                      search: _searchController.text,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryContainer(
                              category: categoryList[index],
                              search: null,
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
      ),
    );
  }
}
