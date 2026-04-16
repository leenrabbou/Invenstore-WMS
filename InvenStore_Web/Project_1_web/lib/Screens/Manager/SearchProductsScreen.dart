// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Services/Manager/ProductsServices.dart';
import 'package:buymore/Services/Warehouse/ProductsServices.dart';
import 'package:buymore/helper/Manager/ShowDialog/SearchDialog.dart';
import 'package:buymore/helper/Warehouse/Product/AllProductCard.dart';
import 'package:buymore/helper/Warehouse/Product/StoredProductCard.dart';
import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Product/ProductCard.dart';
import 'package:buymore/helper/Manager/Product/ProductShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchProductsScreen extends StatefulWidget {
  SearchProductsScreen({
    super.key,
    required this.warehouseType,
    required this.isCart,
    required this.isWarehouse,
    required this.search,
  });
  int warehouseType;
  bool isCart;
  bool isWarehouse;
  String search;
  String? name,
      manufacturer,
      category,
      cheaperThan,
      expensiveThan,
      status,
      expireBefore,
      expireAfter,
      lessThan,
      moreThan;

  @override
  State<SearchProductsScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<SearchProductsScreen> {
  final ScrollController _scrollController = ScrollController();

  List<ProductModel> products = [];
  List<AllProductModel> allProduct = [];
  List<StoredProductModel> storedProduct = [];
  bool isFetching = false;

  int currentPage = 1;
  String? sort;
  @override
  void initState() {
    super.initState();
    fetchProducts(currentPage, sort);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchProducts(int page, String? sort) async {
    if (isFetching) return;
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isFetching = true;
    });

    try {
      if (widget.warehouseType == 1) {
        String url = 'products/?page=$page&search=${widget.search}';
        final response = await ProductsServices().searchProductsService(
            page,
            url,
            widget.name,
            widget.category,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.manufacturer,
            widget.status,
            widget.expireBefore,
            widget.expireAfter,
            widget.lessThan,
            widget.moreThan,
            sort,
            locale);
        if (response.status == 1) {
          setState(() {
            products.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 2) {
        String url = 'products/?page=$page&search=${widget.search}';
        final response = await ProductsService().searchAllProductsService(
            page,
            url,
            widget.name,
            widget.category,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.manufacturer,
            widget.status,
            widget.expireBefore,
            widget.expireAfter,
            widget.lessThan,
            widget.moreThan,
            sort,
            locale);
        if (response.status == 1) {
          setState(() {
            allProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 3) {
        String url =
            'stored-products?page=$page&status=valid&search=${widget.search}';
        final response = await ProductsService().searchStoredProductsService(
            page,
            url,
            widget.name,
            widget.category,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.manufacturer,
            widget.status,
            widget.expireBefore,
            widget.expireAfter,
            widget.lessThan,
            widget.moreThan,
            sort,
            locale);

        if (response.status == 1) {
          setState(() {
            storedProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 4) {
        String url =
            'stored-products?page=$page&status=expired&search=${widget.search}';
        final response = await ProductsService().searchStoredProductsService(
            page,
            url,
            widget.name,
            widget.category,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.manufacturer,
            widget.status,
            widget.expireBefore,
            widget.expireAfter,
            widget.lessThan,
            widget.moreThan,
            sort,
            locale);

        if (response.status == 1) {
          setState(() {
            storedProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
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

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchProducts(currentPage + 1, sort);
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
          Padding(
            padding: EdgeInsets.only(
                left: isArabic() ? 30 : 0, right: isArabic() ? 0 : 30),
            child: TextButton(
              onPressed: () async {
                bool isAll;
                widget.warehouseType == 1 || widget.warehouseType == 2
                    ? isAll = true
                    : isAll = false;
                SearchDialog searchDialog = SearchDialog();
                Map<String, dynamic> result = await searchDialog
                    .productsFilterDialog(context, isAll: isAll);
                setState(() {
                  widget.status = result['status'];
                  widget.manufacturer = result['manufacturer'];
                  widget.category = result['category'];
                  widget.expireBefore = result['expireBefore'];
                  widget.expireAfter = result['expireAfter']?.toString();
                  widget.cheaperThan = result['cheaperThan']?.toString();
                  widget.expensiveThan = result['expensiveThan']?.toString();
                  widget.name = result['name'];
                  widget.lessThan = result['lessThan'];
                  widget.moreThan = result['moreThan'];
                });
                currentPage = 1;
                if (widget.warehouseType == 1) {
                  products.clear();
                } else if (widget.warehouseType == 2) {
                  allProduct.clear();
                } else if (widget.warehouseType == 3 ||
                    widget.warehouseType == 4) {
                  storedProduct.clear();
                }
                fetchProducts(currentPage, sort);
              },
              child: const Row(
                children: [
                  Text('filters'),
                  Icon(
                    Icons.filter_list,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isArabic() ? 30 : 0, right: isArabic() ? 0 : 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: isArabic() ? 0 : 5, right: isArabic() ? 5 : 0),
                    child: Text(
                      S().sortBy,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.8),
                    ),
                    child: PopupMenuButton(
                      onSelected: (value) async {
                        if (value == 1) {
                          sort = 'date';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        } else if (value == 2) {
                          sort = '-date';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        } else if (value == 3) {
                          sort = 'id';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        } else if (value == 4) {
                          sort = '-id';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        } else if (value == 5) {
                          sort = 'cost';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        } else if (value == 6) {
                          sort = '-cost';
                          currentPage = 1;
                          currentPage = 1;
                          if (widget.warehouseType == 1) {
                            products.clear();
                          } else if (widget.warehouseType == 2) {
                            allProduct.clear();
                          } else if (widget.warehouseType == 3 ||
                              widget.warehouseType == 4) {
                            storedProduct.clear();
                          }
                          fetchProducts(currentPage, sort);
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            S().dateAsc,
                            style: TextStyle(
                                fontSize: 13,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            S().dateDesc,
                            style: TextStyle(
                                fontSize: 13,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text(
                            S().orderNumberAscending,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: Text(
                            S().orderNumberDescending,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 5,
                          child: Text(
                            S().costAscending,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 6,
                          child: Text(
                            S().costDescending,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // widget.isCart
          //     ? const SizedBox.shrink()
          //     : Padding(
          //         padding: EdgeInsets.only(
          //           top: 10.0,
          //           right: isArabic() ? 0 : 20,
          //           left: isArabic() ? 20 : 0,
          //         ),
          //         child: widget.warehouseType == 1
          //             ? TextButton(
          //                 onPressed: () {
          //                   ProductShowDialog().productDialog(context,
          //                       text: S.of(context).addProduct, edit: false);
          //                 },
          //                 child: Text(
          //                   S.of(context).addProduct,
          //                   style: TextStyle(
          //                       color: Theme.of(context).colorScheme.onPrimary,
          //                       fontSize: 15),
          //                 ),
          //               )
          //             : null,
          //       ),
        ],
      ),
      body: Container(
        height: 700,
        width: 1200,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(15),
        )),
        child: GridView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 5 / 6,
            ),
            itemCount: widget.warehouseType == 1
                ? products.length + (isFetching ? 1 : 0)
                : widget.warehouseType == 2
                    ? allProduct.length + (isFetching ? 1 : 0)
                    : storedProduct.length + (isFetching ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (widget.warehouseType == 1) {
                if (index < products.length) {
                  return ProductCard(
                    product: products[index],
                    warehouseType: widget.warehouseType,
                    isCart: widget.isCart,
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
              } else if (widget.warehouseType == 2) {
                if (index < allProduct.length) {
                  return AllProductCard(
                    product: allProduct[index],
                    isCart: widget.isCart,
                    isReport: false,
                  );
                } else {
                  return Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  );
                }
              } else if (widget.warehouseType == 3) {
                if (index < storedProduct.length) {
                  return StoredProductCard(
                    product: storedProduct[index],
                  );
                } else {
                  return Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  );
                }
              } else if (widget.warehouseType == 4) {
                if (index < storedProduct.length) {
                  return StoredProductCard(
                    product: storedProduct[index],
                  );
                } else {
                  return Center(
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  );
                }
              }
              return null;
            }),
      ),
    );
  }
}
