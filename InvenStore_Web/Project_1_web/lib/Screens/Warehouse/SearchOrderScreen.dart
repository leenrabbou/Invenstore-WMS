// ignore_for_file: must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:buymore/Services/Warehouse/OrdersServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/ShowDialog/SearchDialog.dart';
import 'package:buymore/helper/Warehouse/OrderContainer.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SearchOrderScreen extends StatefulWidget {
  SearchOrderScreen({
    super.key,
    required this.search,
    required this.orderType,
  });
  final String search;
  final int orderType;

  String? status;
  String? id;
  String? date;
  String? cost;
  String? after;
  String? before;
  String? cheaperThan;
  String? expensiveThan;
  String? name;
  String? city;
  String? state;
  String? address;
  @override
  State<SearchOrderScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchOrderScreen> {
  final ScrollController _scrollController = ScrollController();

  List<OrderModel> searchResult = [];
  bool isFetching = false;
  int currentPage = 1;
  String? sort;
  @override
  void initState() {
    super.initState();
    search(currentPage, sort);
    _scrollController.addListener(_onScroll);
  }

  Future<void> search(int page, String? sort) async {
    if (isFetching) return;
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isFetching = true;
    });

    try {
      if (widget.orderType == 1) {
        String url = 'orders/sell?page=$page&search=${widget.search}';
        final response = await OrdersServices().searchOrdersService(
            page,
            url,
            widget.search,
            widget.status,
            widget.id,
            widget.date,
            widget.cost,
            widget.after,
            widget.before,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.name,
            widget.city,
            widget.state,
            widget.address,
            sort,
            locale);
        if (response.status == 1) {
          setState(() {
            searchResult.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.orderType == 2) {
        String url = 'orders/buy?page=$page&search=${widget.search}';
        final response = await OrdersServices().searchOrdersService(
            page,
            url,
            widget.search,
            widget.status,
            widget.id,
            widget.date,
            widget.cost,
            widget.after,
            widget.before,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.name,
            widget.city,
            widget.state,
            widget.address,
            sort,
            locale);
        if (response.status == 1) {
          setState(() {
            searchResult.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.orderType == 3) {
        String url = 'orders/manufacturer?page=$page&search=${widget.search}';
        final response = await OrdersServices().searchOrdersService(
            page,
            url,
            widget.search,
            widget.status,
            widget.id,
            widget.date,
            widget.cost,
            widget.after,
            widget.before,
            widget.cheaperThan,
            widget.expensiveThan,
            widget.name,
            widget.city,
            widget.state,
            widget.address,
            sort,
            locale);
        if (response.status == 1) {
          setState(() {
            searchResult.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print('Error fetching data: $e');
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
      searchResult.clear();

      currentPage = 1;
      isFetching = false;
    });
    await search(currentPage, sort);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      search(currentPage + 1, sort);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                left: isArabic() ? 30 : 0, right: isArabic() ? 0 : 30),
            child: TextButton(
              onPressed: () async {
                SearchDialog searchDialog = SearchDialog();
                Map<String, dynamic> result =
                    await searchDialog.orderFilterDialog(context);
                setState(() {
                  widget.status = result['status'];
                  // widget.orderedBy = result['orderedBy'];
                  widget.before = result['before'];
                  widget.after = result['after'];
                  widget.id = result['id'];
                  widget.cost = result['cost']?.toString();
                  widget.date = result['date'];
                  widget.cheaperThan = result['cheaperThan']?.toString();
                  widget.expensiveThan = result['expensiveThan']?.toString();
                  widget.name = result['name'];
                  widget.city = result['city'];
                  widget.state = result['state'];
                  widget.address = result['address'];
                });
                currentPage = 1;
                searchResult.clear();
                search(currentPage, sort);
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
                color: Colors.grey.withOpacity(0.2),
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
                          searchResult.clear();
                          search(currentPage, sort);
                        } else if (value == 2) {
                          sort = '-date';
                          currentPage = 1;
                          searchResult.clear();
                          search(currentPage, sort);
                        } else if (value == 3) {
                          sort = 'id';
                          currentPage = 1;
                          searchResult.clear();
                          search(currentPage, sort);
                        } else if (value == 4) {
                          sort = '-id';
                          currentPage = 1;
                          searchResult.clear();
                          search(currentPage, sort);
                        } else if (value == 5) {
                          sort = 'cost';
                          currentPage = 1;
                          searchResult.clear();
                          search(currentPage, sort);
                        } else if (value == 6) {
                          sort = '-cost';
                          currentPage = 1;
                          searchResult.clear();
                          search(currentPage, sort);
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: searchResult.length + (isFetching ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index < searchResult.length) {
              return OrderContainer(
                  order: searchResult[index], orderType: widget.orderType);
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
    );
  }
}
