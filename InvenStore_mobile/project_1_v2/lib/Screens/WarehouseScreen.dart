import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:project_1_v2/Services/Warehouse/WarehouseServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/StoredProductCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key, required this.isCart});
  final bool isCart;
  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  final ScrollController _scrollController = ScrollController();

  List<StoredProductModel> products = [];

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
      final response = await WarehouseServices().showWarehousesService(
        locale,
        page,
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
          S().products,
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
                    childAspectRatio: 0.9 / 1,
                  ),
                  itemCount: products.length + (isFetching ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < products.length) {
                      return StoredProductCard(
                        product: products[index],
                        isCart: widget.isCart,
                        isDestruction: false,
                        isSale: false,
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
