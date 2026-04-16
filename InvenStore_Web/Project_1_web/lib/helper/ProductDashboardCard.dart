import 'package:buymore/Models/DashBoard/TopSellingProductsForDashboardModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/material.dart';

class ProductDashboardCard extends StatelessWidget {
  const ProductDashboardCard({super.key, required this.product});
  final TopSellingProductsForDashboardModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 200,
        height: 200,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: product.product.image == null
                  ? Image.asset(
                      'images/image.png',
                      height: 110,
                      width: 150,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      '$imageUrl/${product.product.image!}',
                      height: 110,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              width: 130,
              height: 50,
              child: Center(
                child: Text(
                  product.product.name,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.quantity.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(' ${S().pieces}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSecondary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
