// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Screens/Manager/ProductDetailsScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {super.key,
      required this.product,
      required this.warehouseType,
      required this.isWarehouse,
      required this.isCart});
  ProductModel product;
  int warehouseType;
  bool isCart;
  bool isWarehouse;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetailsScreen(
                    product: product,
                    warehouseType: warehouseType,
                    isCart: isCart,
                    isWarehouse: isWarehouse,
                  );
                },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: product.image == null
                        ? Image.asset(
                            'images/image.png',
                            height: 150,
                            width: 200,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            '$imageUrl/${product.image!}',
                            height: 150,
                            width: 200,
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
                              width: 130,
                              height: 30,
                              child: Text(
                                product.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
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
