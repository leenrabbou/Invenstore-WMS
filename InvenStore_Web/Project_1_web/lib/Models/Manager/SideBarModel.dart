// ignore_for_file: file_names

import 'package:buymore/Screens/MainScreen.dart';
import 'package:buymore/Screens/Manager/CategoriesScreen.dart';
import 'package:buymore/Screens/Manager/EmployeeScreen.dart';
import 'package:buymore/Screens/Manager/ManufacturerScreen.dart';
import 'package:buymore/Screens/Manager/ProductsScreen.dart';
import 'package:buymore/Screens/Manager/ProfileScreen.dart';
import 'package:buymore/Screens/Manager/ShippingCompanyScreen.dart';
import 'package:buymore/Screens/Reports/ReportsScreen.dart';
import 'package:buymore/Screens/Warehouse/AllBuyOrdersScreen.dart';
import 'package:buymore/Screens/Warehouse/AllSellOrdersScreen.dart';
import 'package:buymore/Screens/Warehouse/AllSupliesOrder.dart';
import 'package:buymore/Screens/Warehouse/DestructionScreen.dart';
import 'package:buymore/Screens/Warehouse/ShipmentsScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/Screens/Warehouse/ProductsScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SideBarModel extends ChangeNotifier {
  late List<Map<String, dynamic>> sideBarItems;
  SideBarModel(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        "icon": Icons.home,
        "text": S.of(context).home,
        "Navigator": const DashBoardScreen(),
      },
      {
        "icon": Icons.person,
        "text": S.of(context).myProfile,
        "Navigator": ProfileScreen(
          isWarehouse: role != 'admin' ? true : false,
        ),
      },
    ];
    if (permissionsMap['category.index'] == true) {
      items.add(
        {
          "icon": Icons.category,
          "text": S.of(context).categories,
          "Navigator": CategoriesScreen(
            isWarehouse: role != 'admin' ? true : false,
          ),
        },
      );
    }

    if (permissionsMap['product.index'] == true && role == 'admin') {
      items.add(
        {
          "icon": Icons.inventory_2,
          "text": S.of(context).products,
          "Navigator": const ProductScreen(
            warehouseType: 1,
            isCart: false,
            isWarehouse: false,
            manufacturerId: -1,
            isReport: false,
          ),
        },
      );
    }

    if (permissionsMap['product.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.inventory_2,
          "text": S.of(context).products,
          "Navigator": const ProductsScreenW(),
        },
      );
    }

    if (permissionsMap['manufacturer.index'] == true) {
      items.add(
        {
          "icon": Icons.factory,
          "text": S.of(context).manufacturer,
          "Navigator": const ManufacturerScreen(
            isSuppliesOrrder: false,
          ),
        },
      );
    }

    if (permissionsMap['shippingCompany.index'] == true) {
      items.add(
        {
          "icon": Icons.factory,
          "text": S.of(context).shippingCompanies,
          "Navigator": const ShippingCompanyScreen(),
        },
      );
    }

    if (permissionsMap['employee.index'] == true) {
      items.add(
        {
          "icon": Icons.groups,
          "text": S.of(context).employees,
          "Navigator": const EmployeeScreen(),
        },
      );
    }

    if (permissionsMap['orders.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.storefront,
          "text": S().sellOrders,
          "Navigator": const AllSellOrdersScreen(),
        },
      );
    }

    if (permissionsMap['orders.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.shopping_bag,
          "text": S().buyOrders,
          "Navigator": const AllBuyOrdersScreen(),
        },
      );
    }

    if (permissionsMap['orders.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.storefront,
          "text": S().suplies,
          "Navigator": const AllSupliesOrdersScreen(),
        },
      );
    }

    if (permissionsMap['shipment.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.local_shipping,
          "text": S().shipments,
          "Navigator": const ShipmentsScreen(),
        },
      );
    }

    if (permissionsMap['destruction.index'] == true && role != 'admin') {
      items.add(
        {
          "icon": Icons.construction,
          "text": S().destruction,
          "Navigator": const DestructionScreen(),
        },
      );
    }
    if (permissionsMap['report.show'] == true) {
      items.add(
        {
          "icon": Icons.list_alt,
          "text": S.of(context).report,
          "Navigator": const ReportsScreen(),
        },
      );
    }

    if (kDebugMode) {
      print(items);
    }

    sideBarItems = items;
    notifyListeners();
  }
}
