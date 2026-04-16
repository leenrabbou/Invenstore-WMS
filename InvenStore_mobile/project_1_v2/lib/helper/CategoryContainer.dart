// ignore_for_file: file_names, must_be_immutable

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:project_1_v2/Models/Manager/category/CategoryModel.dart';
import 'package:project_1_v2/Services/Manager/SubcategoriesServices.dart';
import 'package:project_1_v2/helper/SubCategoryCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({
    super.key,
    required this.category,
    required this.search,
  });
  final CategoryModel category;
  final String? search;

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
      final locale = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      ).language!;
      final response = await SubcategoriesService().showAllSubcategoriesService(
        widget.category.id,
        page,
        widget.search,
        locale,
      );
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
          print(e);
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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SizedBox(
        height: 205,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  child: Text(
                    widget.category.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
