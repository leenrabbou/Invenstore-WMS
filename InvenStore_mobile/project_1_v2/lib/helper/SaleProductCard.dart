// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Sales/ProductSales.dart';
import 'package:project_1_v2/Screens/SaleOrderProductsDetails.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/material.dart';

class SaleProductsCard extends StatelessWidget {
  const SaleProductsCard({super.key, required this.product});
  final ProductSalesModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return SaleOrderProductDetailsScreen(product: product);
              },
            ),
          );
        },
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: product.image == null
                    ? Image.asset(
                        'images/dairy-products.png',
                        height: 110,
                        width: 110,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        '$imageUrl/${product.image!}',
                        height: 110,
                        width: 110,
                        fit: BoxFit.fill,
                      ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                height: 30,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                height: 30,
                child: Text(
                  product.quantity.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 30,
                child: Text(
                  '${product.price} ${S().syp}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
