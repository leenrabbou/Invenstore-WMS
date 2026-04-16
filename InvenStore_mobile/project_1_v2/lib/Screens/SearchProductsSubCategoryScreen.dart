// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Product/ProductModel.dart';
import 'package:project_1_v2/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:project_1_v2/Models/Manager/category/CategoryModel.dart';
import 'package:project_1_v2/Services/Manager/SubcategoriesServices.dart';
import 'package:project_1_v2/helper/ProductCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SearchProductsSubCategoryScreen extends StatefulWidget {
  const SearchProductsSubCategoryScreen({
    super.key,
    required this.category,
    required this.subcategory,
    required this.search,
  });
  final CategoryModel category;
  final SubCategoryModel subcategory;
  final String search;
  @override
  State<SearchProductsSubCategoryScreen> createState() =>
      _CategoryScreenState();
}

class _CategoryScreenState extends State<SearchProductsSubCategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  List<ProductModel> products = [];

  bool isFetching = false;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchProducts(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchProducts(int page) async {
    if (isFetching) return;

    setState(() {
      isFetching = true;
    });

    try {
      final locale = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      ).language!;
      final response = await SubcategoriesService()
          .showSubcategoriesProductsService(
            widget.subcategory.id,
            page,
            widget.search,
            locale,
          );
      if (response.status == 1) {
        setState(() {
          products.addAll(response.data.data);

          currentPage = response.data.currentPage;
          isFetching = currentPage < response.data.lastPage;
        });
      }
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print('$e');
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

  Future<void> _onRefresh() async {
    setState(() {
      products.clear();
      currentPage = 1;
      isFetching = false;
    });
    await fetchProducts(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchProducts(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: _onRefresh,
                color: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.primary,
                height: 100,
                child: GridView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1,
                  ),
                  itemCount: products.length + (isFetching ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < products.length) {
                      return ProductCard(
                        product: products[index],
                        warehouseType: 1,
                        isCart: false,
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
            ),
          ],
        ),
      ),
    );
  }
}
