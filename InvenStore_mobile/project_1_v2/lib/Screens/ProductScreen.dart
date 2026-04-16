// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Product/ProductModel.dart';
import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:project_1_v2/Screens/SearchProductsScreen.dart';
import 'package:project_1_v2/Services/Manager/ProductsServices.dart';
import 'package:project_1_v2/Services/Warehouse/ProductsServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/AllProductCard.dart';
import 'package:project_1_v2/helper/ProductCard.dart';
import 'package:project_1_v2/helper/SearchTextField.dart';
import 'package:project_1_v2/helper/StoredProductCard.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    super.key,
    required this.warehouseType,
    required this.isSale,
    required this.isCart,
    required this.isDestruction,
  });
  int warehouseType;
  bool isCart;
  bool isDestruction;
  bool isSale;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
    fetchProducts(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchProducts(int page) async {
    if (isFetching) return;
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    setState(() {
      isFetching = true;
    });

    try {
      if (widget.warehouseType == 1) {
        final response = await ProductsServices().showAllProductsService(
          page,
          null,
          sort,
          locale,
        );
        if (response.status == 1) {
          setState(() {
            products.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 2) {
        final response = await ProductsService().showAllProductsService(
          page,
          null,
          sort,
          locale,
        );
        if (response.status == 1) {
          setState(() {
            allProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 3) {
        final response = await ProductsService().showStoredProductsService(
          page,
          'valid',
          null,
          sort,
          locale,
        );
        if (response.status == 1) {
          setState(() {
            storedProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 4) {
        final response = await ProductsService().showStoredProductsService(
          page,
          'expired',
          null,
          sort,
          locale,
        );
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
      if (widget.warehouseType == 1) {
        products.clear();
      } else if (widget.warehouseType == 2) {
        allProduct.clear();
      } else if (widget.warehouseType == 3) {
        storedProduct.clear();
      }
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
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: widget.isSale
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.background,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    left: isArabic() ? 30 : 0,
                    right: isArabic() ? 0 : 30,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: isArabic() ? 0 : 5,
                            right: isArabic() ? 5 : 0,
                          ),
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
                            cardColor: Theme.of(
                              context,
                            ).colorScheme.background.withOpacity(0.8),
                          ),
                          child: PopupMenuButton(
                            onSelected: (value) async {
                              if (value == 1) {
                                sort = 'date';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
                              } else if (value == 2) {
                                sort = '-date';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
                              } else if (value == 3) {
                                sort = 'id';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
                              } else if (value == 4) {
                                sort = '-id';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
                              } else if (value == 5) {
                                sort = 'cost';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
                              } else if (value == 6) {
                                sort = '-cost';
                                currentPage = 1;
                                if (widget.warehouseType == 1) {
                                  products.clear();
                                } else if (widget.warehouseType == 2) {
                                  allProduct.clear();
                                } else if (widget.warehouseType == 3) {
                                  storedProduct.clear();
                                }

                                fetchProducts(currentPage);
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
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  S().dateDesc,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text(
                                  S().orderNumberAscending,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              PopupMenuItem(
                                value: 4,
                                child: Text(
                                  S().orderNumberDescending,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              PopupMenuItem(
                                value: 5,
                                child: Text(
                                  S().costAscending,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              PopupMenuItem(
                                value: 6,
                                child: Text(
                                  S().costDescending,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SearchTextField(
              searchController: searchController,
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SearchProductsScreen(
                          warehouseType: widget.warehouseType,
                          isCart: widget.isCart,
                          search: searchController.text,
                          isSale: widget.isSale,
                          isDestruction: widget.isDestruction,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          LiquidPullToRefresh(
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
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
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
                    return AllProductCard(product: allProduct[index]);
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
                      isCart: widget.isCart,
                      isDestruction: widget.isDestruction,
                      isSale: widget.isSale,
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
                      isCart: false,
                      isDestruction: widget.isDestruction,
                      isSale: widget.isSale,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
