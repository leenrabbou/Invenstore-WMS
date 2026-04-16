// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderProductModel.dart';
import 'package:project_1_v2/Screens/OrderProductsDetails.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:flutter/material.dart';

class OrderProductsCard extends StatelessWidget {
  const OrderProductsCard({super.key, required this.product});
  final OrderProductModel product;
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
                return OrderProductDetailsScreen(product: product);
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
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        '$imageUrl/${product.image!}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
              ),
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
                width: 50,
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
                  '${product.cost} ${S().syp}',
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
        ),
      ),
    );
  }
}
