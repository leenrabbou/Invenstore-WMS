// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Screens/Reports/SpecificProductReportDetailsScreen.dart';
import 'package:buymore/Screens/Warehouse/Products/AllProductDetailsScreen.dart';
import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllProductCard extends StatelessWidget {
  const AllProductCard(
      {super.key,
      required this.product,
      required this.isCart,
      required this.isReport});
  final AllProductModel product;
  final bool isCart;
  final bool isReport;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print(product.min);
            }
            isReport
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SpecificProductReportDetailsScreen(
                          productID: product,
                        );
                      },
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AllProductDetailsScreen(
                          isCart: isCart,
                          product: product,
                          // isWarehouse: isWarehouse,
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
              padding: const EdgeInsets.all(10.0),
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
                            width: 150,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            '$imageUrl/${product.image!}',
                            height: 150,
                            width: 150,
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
                                '${product.price} SYP',
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
