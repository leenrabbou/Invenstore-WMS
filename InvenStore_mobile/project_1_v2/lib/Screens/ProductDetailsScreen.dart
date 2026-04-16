// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Product/ProductModel.dart';
import 'package:project_1_v2/Services/Manager/ProductsServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({
    super.key,
    required this.product,
    required this.warehouseType,
    required this.isCart,
  });
  ProductModel product;
  int warehouseType;
  bool isCart;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 0;
  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final newData = await ProductsServices().showAnProductsService(
        widget.product.id,
        locale,
      );
      setState(() {
        widget.product = newData.data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          S().productDetails,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
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
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  GestureDetector(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: widget.product.image == null
                              ? Image.asset(
                                  'images/dairy-products.png',
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  '$imageUrl/${widget.product.image!}',
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            widget.product.manufacturer,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: FittedBox(
                            child: Text(
                              S.of(context).description,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimary.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          height: 130,
                          child: Text(
                            widget.product.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                S.of(context).price,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary.withOpacity(0.5),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FittedBox(
                                child: Text(
                                  '${widget.product.price} ${S().syp}',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
