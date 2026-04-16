// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/Models/Warehouse/Sales/ProductSales.dart';
import 'package:flutter/material.dart';

class SaleOrderProductDetailsScreen extends StatefulWidget {
  SaleOrderProductDetailsScreen({super.key, required this.product});
  ProductSalesModel product;
  @override
  State<SaleOrderProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<SaleOrderProductDetailsScreen> {
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
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
                        width: 300,
                        height: 90,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FittedBox(
                          child: Text(
                            S.of(context).subcategory,
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
                        height: 30,
                        child: Text(
                          widget.product.subcategory,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FittedBox(
                          child: Text(
                            S.of(context).quantity,
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
                        child: Text(
                          widget.product.quantity.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FittedBox(
                          child: Text(
                            S.of(context).expirationDate,
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
                        child: Text(
                          widget.product.expirationDate == null
                              ? '--'
                              : widget.product.expirationDate!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
