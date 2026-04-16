// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/CartProductModel.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:project_1_v2/Services/Warehouse/ProductsServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/DestructionShowDialog.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class StoredProductDetailsScreen extends StatefulWidget {
  StoredProductDetailsScreen({
    super.key,
    required this.product,
    required this.isSale,
    required this.isDestruction,
    required this.isCart,
  });
  StoredProductModel product;
  bool isDestruction;
  bool isSale;
  bool isCart;
  @override
  State<StoredProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<StoredProductDetailsScreen> {
  int quantity = 0;
  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final newData = await ProductsService().showAnStoredProductsService(
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
        actions: [
          permissionsMap['destruction.store'] == true && widget.isDestruction
              ? IconButton(
                  onPressed: () {
                    DestructionShowDialog().destructionProductDialog(
                      context,
                      product: widget.product,
                    );
                  },
                  icon: Icon(
                    Icons.construction,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : const SizedBox.shrink(),
        ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: widget.product.image == null
                              ? Image.asset(
                                  'images/dairy-products.png',
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  '$imageUrl/${widget.product.image!}',
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FittedBox(
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      widget.product.manufacturer,
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.9),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      child: FittedBox(
                        child: Text(
                          S.of(context).description,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        child: Text(
                          S.of(context).price,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                    child: FittedBox(
                      child: Text(
                        '${widget.product.price} ${S().syp}',
                        style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            S().maximum,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            widget.product.max.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.product.validQuantity != null
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  widget.product.validQuantity != null
                      ? SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  S().validQuantity,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  widget.product.validQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          S().expirationDate,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.5),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          widget.product.expirationDate != null
                              ? widget.product.expirationDate!
                              : '--',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.isCart
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: isArabic() ? 10 : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            S().quantity,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              CustomElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    quantity > 0 ? quantity-- : null;
                                  });
                                },
                                height: 40,
                                width: 50,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                textSize: 20,
                                color: const Color.fromARGB(211, 199, 53, 43),
                                elevation: 5,
                                textcolor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('$quantity'),
                              const SizedBox(width: 10),
                              CustomElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    quantity < widget.product.max
                                        ? quantity++
                                        : null;
                                  });
                                },
                                height: 40,
                                width: 50,
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                textSize: 20,
                                color: const Color.fromARGB(193, 29, 104, 165),
                                elevation: 5,
                                textcolor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              CustomElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 0) {
                                      widget.isSale
                                          ? salesProductsList.add(
                                              CartProductModel(
                                                quantity: quantity,
                                                product: widget.product,
                                              ),
                                            )
                                          : buyOrderProductsList.add(
                                              CartProductModel(
                                                quantity: quantity,
                                                product: widget.product,
                                              ),
                                            );
                                    }
                                  });
                                },
                                height: 45,
                                width: 150,
                                left: 0,
                                right: 0,
                                top: 5,
                                bottom: 10,
                                textSize: isArabic() ? 15 : 15,
                                color: const Color.fromARGB(255, 29, 104, 165),
                                elevation: 5,
                                textcolor: Colors.white,
                                child: Text(
                                  S().addToCart,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
