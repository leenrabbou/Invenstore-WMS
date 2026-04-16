// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/SalesModel.dart';
import 'package:project_1_v2/Services/Warehouse/SalesService.dart';
import 'package:project_1_v2/helper/SalesContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SearchSalesScreen extends StatefulWidget {
  const SearchSalesScreen({super.key, required this.search});
  final String search;
  @override
  State<SearchSalesScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<SearchSalesScreen> {
  final ScrollController _scrollController = ScrollController();

  List<SalesModel> salesOrders = [];
  bool isFetching = false;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchEmployees(currentPage);
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchEmployees(int page) async {
    if (isFetching) return;
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    setState(() {
      isFetching = true;
    });

    try {
      final response = await SalesServices().showAllSalesOrdersService(
        page,
        widget.search,
        locale,
      );

      if (response.status == 1) {
        setState(() {
          salesOrders.addAll(response.data.data);
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
      salesOrders.clear();

      currentPage = 1;
      isFetching = false;
    });
    await fetchEmployees(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isFetching) {
      fetchEmployees(currentPage + 1);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: _onRefresh,
              color: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              height: 100,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: salesOrders.length + (isFetching ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < salesOrders.length) {
                    return SalesContainer(order: salesOrders[index]);
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
