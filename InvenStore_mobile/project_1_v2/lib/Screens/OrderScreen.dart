// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:project_1_v2/Services/Warehouse/OrdersServices.dart';
import 'package:project_1_v2/helper/OrderContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.status});

  final String? status;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();

  List<OrderModel> buyOrders = [];
  bool isFetching = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchData(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchData(int page) async {
    if (isFetching) return;
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    setState(() {
      isFetching = true;
    });

    try {
      final response = await OrdersServices().showAllBuyOrdersService(
        page,
        widget.status,
        locale,
      );

      if (response.status == 1) {
        setState(() {
          buyOrders.addAll(response.data.data);
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
      buyOrders.clear();

      currentPage = 1;
      isFetching = false;
    });
    await fetchData(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchData(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: _onRefresh,
              color: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              height: 100,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: buyOrders.length + (isFetching ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < buyOrders.length) {
                    return OrderContainer(order: buyOrders[index]);
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
    );
  }
}
