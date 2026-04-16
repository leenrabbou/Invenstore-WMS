// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Services/Warehouse/OrdersServices.dart';
import 'package:buymore/helper/Warehouse/OrderContainer.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key, required this.ordersType, required this.status});
  final int ordersType;
  final String? status;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();

  List<OrderModel> sellOrders = [];
  List<OrderModel> buyOrders = [];
  List<OrderModel> supliesOrders = [];
  bool isFetching = false;
  int currentPage = 1;
  String? sort;
  @override
  void initState() {
    super.initState();
    fetchData(currentPage, sort);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchData(int page, String? sort) async {
    if (isFetching) return;
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isFetching = true;
    });

    try {
      if (widget.ordersType == 1) {
        final response = await OrdersServices()
            .showAllSellOrdersService(page, widget.status, locale, sort);
        if (response.status == 1) {
          setState(() {
            sellOrders.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.ordersType == 2) {
        final response = await OrdersServices()
            .showAllBuyOrdersService(page, widget.status, locale, sort);

        if (response.status == 1) {
          setState(() {
            buyOrders.addAll(response.data.data);
            currentPage = response.data.currentPage;
            isFetching = currentPage < response.data.lastPage;
          });
        }
      } else if (widget.ordersType == 3) {
        final response = await OrdersServices()
            .showAllSupliesOrdersService(page, widget.status, locale, sort);

        if (response.status == 1) {
          setState(() {
            supliesOrders.addAll(response.data.data);
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
      if (widget.ordersType == 1) {
        sellOrders.clear();
      } else if (widget.ordersType == 2) {
        buyOrders.clear();
      } else if (widget.ordersType == 3) {
        supliesOrders.clear();
      }

      currentPage = 1;
      isFetching = false;
    });
    await fetchData(currentPage, sort);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchData(currentPage + 1, sort);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 700,
        width: 1400,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 20 : 40, right: isArabic() ? 40 : 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      S.of(context).orderId,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic()
                          ? widget.ordersType == 3
                              ? 90
                              : 155
                          : 45,
                      right: isArabic()
                          ? 65
                          : widget.ordersType == 3
                              ? 75
                              : 155),
                  child: widget.ordersType == 1
                      ? Text(
                          S.of(context).orderedBy,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        )
                      : widget.ordersType == 2 || widget.ordersType == 3
                          ? Text(
                              S.of(context).orderedFrom,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                              ),
                            )
                          : null,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 0 : 180, left: isArabic() ? 220 : 0),
                  child: Text(
                    S.of(context).address,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text(
                    S.of(context).date,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 100 : 100,
                      left: isArabic() ? 100 : 100),
                  child: Text(
                    S.of(context).cost,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 10 : 100,
                      left: isArabic() ? 100 : 10),
                  child: Text(
                    S.of(context).status,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Container(
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
                            left: isArabic() ? 0 : 5,
                            right: isArabic() ? 5 : 0),
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
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
                            } else if (value == 2) {
                              sort = '-date';
                              currentPage = 1;
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
                            } else if (value == 3) {
                              sort = 'id';
                              currentPage = 1;
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
                            } else if (value == 4) {
                              sort = '-id';
                              currentPage = 1;
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
                            } else if (value == 5) {
                              sort = 'cost';
                              currentPage = 1;
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
                            } else if (value == 6) {
                              sort = '-cost';
                              currentPage = 1;
                              widget.ordersType == 1
                                  ? sellOrders.clear()
                                  : widget.ordersType == 2
                                      ? buyOrders.clear()
                                      : supliesOrders.clear();
                              fetchData(currentPage, sort);
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text(
                                S().dateDesc,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Text(
                                S().orderNumberAscending,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 4,
                              child: Text(
                                S().orderNumberDescending,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 5,
                              child: Text(
                                S().costAscending,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 6,
                              child: Text(
                                S().costDescending,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: _onRefresh,
                color: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.primary,
                height: 100,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.ordersType == 1
                      ? sellOrders.length + (isFetching ? 1 : 0)
                      : widget.ordersType == 2
                          ? buyOrders.length + (isFetching ? 1 : 0)
                          : supliesOrders.length + (isFetching ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.ordersType == 1) {
                      if (index < sellOrders.length) {
                        return OrderContainer(
                            order: sellOrders[index],
                            orderType: widget.ordersType);
                      } else {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        );
                      }
                    } else if (widget.ordersType == 2) {
                      if (index < buyOrders.length) {
                        return OrderContainer(
                            order: buyOrders[index],
                            orderType: widget.ordersType);
                      } else {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        );
                      }
                    } else if (widget.ordersType == 3) {
                      if (index < supliesOrders.length) {
                        return OrderContainer(
                            order: supliesOrders[index],
                            orderType: widget.ordersType);
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
            ),
          ],
        ),
      ),
    );
  }
}
