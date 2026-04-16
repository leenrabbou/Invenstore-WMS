// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionModel.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/helper/DestructionContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class SearchDestructionScreen extends StatefulWidget {
  const SearchDestructionScreen({super.key, required this.search});
  final String search;
  @override
  State<SearchDestructionScreen> createState() => _DestructionscreenState();
}

class _DestructionscreenState extends State<SearchDestructionScreen> {
  final ScrollController _scrollController = ScrollController();

  List<DestructionModel> destructionList = [];
  int currentPage = 1;
  bool isFetching = false;
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
      final response = await DestructionServices().showAllDestructionsService(
        page,
        widget.search,
        locale,
      );
      if (response.status == 1) {
        setState(() {
          destructionList.addAll(response.data.data);
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
      destructionList.clear();

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
                itemCount: destructionList.length + (isFetching ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < destructionList.length) {
                    return Destructioncontainer(
                      destruction: destructionList[index],
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
    );
  }
}
