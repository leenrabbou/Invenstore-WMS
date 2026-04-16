// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:buymore/Services/Manager/SubcategoriesServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/helper/Manager/Subcategory/SubCategoryCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoryContainer extends StatefulWidget {
  CategoryContainer({
    super.key,
    required this.category,
    required this.isWarehouse,
    required this.search,
  });
  CategoryModel category;
  bool isWarehouse;
  String? search;
  @override
  State<CategoryContainer> createState() => CategoryContainerState();
}

class CategoryContainerState extends State<CategoryContainer> {
  final ScrollController _scrollController = ScrollController();
  List<SubCategoryModel> subcategories = [];
  bool isFetching = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchSubcategories(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchSubcategories(int page) async {
    if (isFetching) return;
    allSubcategoryList.clear();
    setState(() {
      isFetching = true;
    });

    try {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      final response = await SubcategoriesService().showAllSubcategoriesService(
          widget.category.id, page, widget.search, locale);
      if (response.status == 1) {
        setState(() {
          subcategories.addAll(response.data.data);

          currentPage = response.data.currentPage;
          isFetching = currentPage < response.data.lastPage;
        });
      }
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print('Error fetching subcategories: $e');
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          isFetching = false;
        });
      } else {
        isFetching = false;
      }
    }
  }

  Future<void> refreshSubcategories() async {
    setState(() {
      subcategories.clear();
      allSubcategoryList.clear();
      currentPage = 1;
      isFetching = false;
    });
    await fetchSubcategories(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchSubcategories(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 900,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400,
                  child: Text(
                    widget.category.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                permissionsMap['category.update'] == true &&
                        permissionsMap['category.index'] == true
                    ? Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.5),
                        ),
                        child: PopupMenuButton(
                            onSelected: (value) {
                              if (value == "Edit Category") {
                                ShowDialog().categoryDialog(
                                  context,
                                  title: S.of(context).editCategory,
                                  text: S.of(context).update,
                                  edit: true,
                                  id: widget.category.id,
                                );
                              } else if (value == "Add Subcategory") {
                                ShowDialog().subCategoryDialog(
                                  context,
                                  text: S.of(context).addSubcategory,
                                  edit: false,
                                  categoryId: widget.category.id,
                                  subcategoryId: 0,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.more_horiz,
                            ),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: "Edit Category",
                                    child: Row(
                                      children: [
                                        const Icon(Icons.edit, size: 20),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          S.of(context).editCategory,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "Add Subcategory",
                                    child: Row(
                                      children: [
                                        const Icon(Icons.add, size: 20),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          S.of(context).addSubcategory,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: subcategories.length + (isFetching ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < subcategories.length) {
                    return SubCategoryCard(
                      subcategory: subcategories[index],
                      category: widget.category,
                      isWarehouse: widget.isWarehouse,
                    );
                  } else {
                    return Center(
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
