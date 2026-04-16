// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:project_1_v2/Services/Warehouse/ProductsServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class AllProductDetailsScreen extends StatefulWidget {
  AllProductDetailsScreen({super.key, required this.product});
  AllProductModel product;

  @override
  State<AllProductDetailsScreen> createState() =>
      _AllProductDetailsScreenState();
}

class _AllProductDetailsScreenState extends State<AllProductDetailsScreen> {
  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final newData = await ProductsService().showAnProductsService(
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
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
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
                  const SizedBox(height: 20),
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
                    width: 100,
                    height: 70,
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
                  SizedBox(
                    width: 100,
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
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: FittedBox(
                      child: Text(
                        '${widget.product.price.toString()} ${S().syp}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            S().minimum,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        FittedBox(
                          child: Text(
                            widget.product.min.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          S().total,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: Text(
                          widget.product.total.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
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
