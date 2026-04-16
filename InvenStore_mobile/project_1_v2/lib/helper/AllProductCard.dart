// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:project_1_v2/Screens/Products/AllProductDetailsScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllProductCard extends StatelessWidget {
  AllProductCard({super.key, required this.product});
  AllProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print(product.min);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AllProductDetailsScreen(product: product);
                },
              ),
            );
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: product.image == null
                        ? Image.asset(
                            'images/dairy-products.png',
                            height: 115,
                            width: 115,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            '$imageUrl/${product.image!}',
                            height: 115,
                            width: 115,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 25,
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                '${product.price} ${S().syp}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.7),
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
          ),
        ),
      ),
    );
  }
}
