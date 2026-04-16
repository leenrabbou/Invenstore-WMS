// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:buymore/Services/Manager/SubcategoriesServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Product/ProductCard.dart';
import 'package:buymore/helper/Manager/Product/ProductShowDialog.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SearchProductsSubCategoryScreen extends StatefulWidget {
  SearchProductsSubCategoryScreen({
    super.key,
    required this.category,
    required this.subcategory,
    required this.isWarehouse,
    required this.search,
  });
  CategoryModel category;
  SubCategoryModel subcategory;
  bool isWarehouse;
  String search;
  @override
  State<SearchProductsSubCategoryScreen> createState() =>
      _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SearchProductsSubCategoryScreen> {
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
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;

    setState(() {
      isFetching = true;
    });

    try {
      final response = await SubcategoriesService()
          .showSubcategoriesProductsService(
              widget.subcategory.id, page, widget.search, locale);
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          widget.isWarehouse
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    right: isArabic() ? 0 : 20,
                    left: isArabic() ? 20 : 0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      ProductShowDialog().productDialog(context,
                          text: S.of(context).addProduct, edit: false);
                    },
                    child: Text(
                      S.of(context).addProduct,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                ),
          widget.isWarehouse
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 50,
                      left: isArabic() ? 50 : 0),
                  child: TextButton(
                    onPressed: () {
                      ShowDialog().subCategoryDialog(
                        context,
                        text: S.of(context).editSubcategory,
                        edit: true,
                        categoryId: widget.category.id,
                        subcategoryId: widget.subcategory.id,
                      );
                    },
                    child: Text(
                      S.of(context).editSubcategory,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                ),
        ],
      ),
      body: Container(
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
          child: GridView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 5 / 5.5,
              ),
              itemCount: products.length + (isFetching ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < products.length) {
                  return ProductCard(
                    product: products[index],
                    warehouseType: 1,
                    isCart: false,
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
              }),
        ),
      ),
    );
  }
}
