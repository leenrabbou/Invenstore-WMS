// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Warehouse/WarehouseModel.dart';
import 'package:buymore/Screens/Manager/ProductsScreen.dart';
import 'package:buymore/Screens/Manager/WarehouseDetails.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/material.dart';

class WarehouseCard extends StatelessWidget {
  const WarehouseCard(
      {super.key, required this.warehouse, required this.isCart});
  final WarehouseModel warehouse;
  final bool isCart;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isCart
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductScreen(
                      warehouseType: 1,
                      isCart: isCart,
                      isWarehouse: true,
                      manufacturerId: -1,
                      isReport: false,
                    );
                  },
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return WarehouseDetailsScreen(
                      warehouse: warehouse,
                    );
                  },
                ),
              );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 170,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          warehouse.name,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -170,
              left: 20,
              right: 20,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: warehouse.image == null
                      ? Image.asset(
                          'images/image.png',
                          height: 80,
                          width: 110,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          '$imageUrl/${warehouse.image!}',
                          height: 80,
                          width: 110,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
