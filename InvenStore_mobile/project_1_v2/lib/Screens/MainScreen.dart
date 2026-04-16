// ignore_for_file: file_names

import 'package:project_1_v2/Models/Itemmodel.dart';
import 'package:project_1_v2/Screens/AllBuyOrdersScreen.dart';
import 'package:project_1_v2/Screens/CategoryScreen.dart';
import 'package:project_1_v2/Screens/DestructionScreen.dart';
import 'package:project_1_v2/Screens/ProductsScreen.dart';
import 'package:project_1_v2/Screens/ProfileScreen.dart';
import 'package:project_1_v2/Screens/SalesScreen.dart';
import 'package:project_1_v2/Screens/WarehouseScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomContainer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<ItemModel> items = [];
    permissionsMap['category.index'] == true
        ? items.add(
            ItemModel(
              name: S().categories,
              image: 'images/Categories .png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CategoryScreen();
                    },
                  ),
                );
              },
            ),
          )
        : null;
    permissionsMap['product.index'] == true
        ? items.add(
            ItemModel(
              name: S().products,
              image: 'images/Products2.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ProductsScreenW();
                    },
                  ),
                );
              },
            ),
          )
        : null;
    permissionsMap['warehouse.own.show'] == true
        ? items.add(
            ItemModel(
              name: S().warehouse,
              image: 'images/warehouse (3).png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const WarehouseScreen(isCart: false);
                    },
                  ),
                );
              },
            ),
          )
        : null;

    permissionsMap['sale.index'] == true
        ? items.add(
            ItemModel(
              name: S().sales,
              image: 'images/brand-identity.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const SalesScreen();
                    },
                  ),
                );
              },
            ),
          )
        : null;

    permissionsMap['orders.index'] == true
        ? items.add(
            ItemModel(
              name: S().buyOrders,
              image: 'images/Buyorder.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AllBuyOrdersScreen();
                    },
                  ),
                );
              },
            ),
          )
        : null;

    permissionsMap['destruction.index'] == true
        ? items.add(
            ItemModel(
              name: S().destruction,
              image: 'images/Buyorder.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const Destructionscreen();
                    },
                  ),
                );
              },
            ),
          )
        : null;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ProfileScreen(isBar: false);
                        },
                      ),
                    );
                  },
                  child: profile!.image != null
                      ? CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.background,
                          backgroundImage: loadingImage,
                          radius: 30,
                        )
                      : CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.background,
                          backgroundImage: AssetImage(defaultImage),
                          radius: 30,
                        ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              '${S().hello} ${profile!.fullName}',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomContainer(item: items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
