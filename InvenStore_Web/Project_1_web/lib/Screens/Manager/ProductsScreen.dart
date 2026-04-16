import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Screens/Manager/SearchProductsScreen.dart';
import 'package:buymore/Screens/Warehouse/CartScreen.dart';
import 'package:buymore/Services/Manager/ProductsServices.dart';
import 'package:buymore/Services/Manager/SubcategoriesServices.dart';
import 'package:buymore/Services/Warehouse/ProductsServices.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Warehouse/Product/AllProductCard.dart';
import 'package:buymore/helper/Warehouse/Product/StoredProductCard.dart';
import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/helper/Manager/Product/ProductCard.dart';
import 'package:buymore/helper/Manager/Product/ProductShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

// 1 products //2 all products //3 stored products
class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.warehouseType,
    required this.isCart,
    required this.isWarehouse,
    required this.manufacturerId,
    required this.isReport,
  });
  final int warehouseType;
  final bool isCart;
  final bool isWarehouse;
  final int manufacturerId;
  final bool isReport;
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
    fetch();
  }

  void fetch() async {
    try {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      await SubcategoriesService().getAllSubcategoriesService(locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchProducts(int page) async {
    if (isFetching) return;
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isFetching = true;
    });

    try {
      if (widget.warehouseType == 1) {
        final response = await ProductsServices()
            .showAllProductsService(page, null, sort, locale);
        if (response.status == 1) {
          setState(() {
            products.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 2) {
        final response = await ProductsService()
            .showAllProductsService(page, null, sort, locale);
        if (response.status == 1) {
          setState(() {
            allProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 3) {
        final response = await ProductsService()
            .showStoredProductsService(page, 'valid', null, sort, locale);
        if (response.status == 1) {
          setState(() {
            storedProduct.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.warehouseType == 4) {
        final response = await ProductsService()
            .showStoredProductsService(page, 'expired', null, sort, locale);
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SearchTextField(
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
                      isWarehouse: widget.isWarehouse,
                      search: searchController.text,
                    );
                  },
                ),
              );
            }
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                left: isArabic() ? 30 : 0,
                right: isArabic() ? 0 : 30,
                top: 10,
                bottom: 10),
            child: Container(
              height: 40,
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
                      cardColor: Theme.of(context).colorScheme.background,
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
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            S().dateDesc,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
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
          widget.isCart
              ? const SizedBox.shrink()
              : permissionsMap['product.store'] == true
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        right: isArabic() ? 0 : 20,
                        left: isArabic() ? 20 : 0,
                      ),
                      child: widget.warehouseType == 1
                          ? TextButton(
                              onPressed: () {
                                ProductShowDialog().productDialog(context,
                                    text: S.of(context).addProduct,
                                    edit: false);
                              },
                              child: Text(
                                S.of(context).addProduct,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 15),
                              ),
                            )
                          : null,
                    )
                  : const SizedBox.shrink(),
          widget.isCart
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CartScreen(
                              order: null,
                              manufacturerId: widget.manufacturerId,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : const SizedBox.shrink()
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
                      product: allProduct[index], isCart: widget.isCart,
                      isReport: widget.isReport,
                      // isWarehouse: true,
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
                      // isWarehouse: true,
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
                      // isWarehouse: true,
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
      ),
    );
  }
}
