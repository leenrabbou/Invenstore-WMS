// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Manager/category/CategoriesRequestModel.dart';
import 'package:buymore/Screens/Manager/SearchCategoriesScreen.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Category/CategoryContainer.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.isWarehouse});
  bool isWarehouse;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? search;
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> categoryList = [];
  final GlobalKey<CategoryContainerState> _k =
      GlobalKey<CategoryContainerState>();
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData =
          await CategoriesService().showAllCategoriesService(search, locale);
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
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SearchTextField(
          searchController: _searchController,
          onPressed: () async {
            if (_searchController.text.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SearchCategoriesScreen(
                      isWarehouse: widget.isWarehouse,
                      search: _searchController.text,
                    );
                  },
                ),
              );
            }
          },
        ),
        actions: [
          permissionsMap['category.store'] == false
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 100,
                      left: isArabic() ? 100 : 0),
                  child: TextButton(
                    onPressed: () {
                      ShowDialog().categoryDialog(
                        context,
                        title: S.of(context).addCategory,
                        text: S.of(context).addCategory,
                        edit: false,
                        id: 0,
                      );
                    },
                    child: Text(
                      S.of(context).addCategory,
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
          child: LiquidPullToRefresh(
            onRefresh: _onRefresh,
            color: Theme.of(context).colorScheme.background,
            backgroundColor: Theme.of(context).colorScheme.primary,
            height: 100,
            child: FutureBuilder<CategoriesRequestModel>(
                future: CategoriesService()
                    .showAllCategoriesService(search, locale),
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
                              search: null,
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
      ),
    );
  }
}
