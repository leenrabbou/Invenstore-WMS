// ignore_for_file: file_names

import 'package:buymore/Models/Manager/Employee/EmployeeModel.dart';
import 'package:buymore/Models/Manager/Profile/ProfileModel.dart';

//all 1  for manager, 2 all for warehouse 3 valid 4 expired
// sell 1 buy2 suplies 3

// String imageUrl = 'http://192.168.137.1:8000';
// String basicurl = 'http://192.168.137.1:8000/api';

String imageUrl = 'http://192.168.1.102:8000';
String basicurl = 'http://192.168.1.102:8000/api';

String role = '';
List<String> permissions = [];
String token = '';
EmployeeModel? userAccount;
ProfileModel? managerAccount;
late int userId;
String defaultImage = 'images/male3.jpg';
late bool verified;
Map<String, bool> permissionsMap = {
  "category.index": false,
  "category.store": false,
  "category.show": false,
  "category.update": false,
  "category.destroy": false,
  "warehouse.index": false,
  "warehouse.store": false,
  "warehouse.show.centers": false,
  "warehouse.show": false,
  "warehouse.update": false,
  "distributionCenter.index": false,
  "distributionCenter.store": false,
  "distributionCenter.show": false,
  "distributionCenter.update": false,
  "product.index": false,
  "product.store": false,
  "product.show": false,
  "product.update": false,
  "manufacturer.index": false,
  "manufacturer.store": false,
  "manufacturer.show": false,
  "manufacturer.update": false,
  "warehouse.centers.index": false,
  "warehouse.own.show": false,
  "center.index": false,
  "center.store": false,
  "center.show": false,
  "center.update": false,
  "center.own.show": false,
  "product.min.update": false,
  "product.stored.update": false,
  "employee.index": false,
  "employee.store": false,
  "employee.show": false,
  "employee.update": false,
  "orders.index": false,
  "orders.buy.store": false,
  "orders.manufacturer.store": false,
  "orders.show": false,
  "orders.sell.update": false,
  "orders.buy.update": false,
  "orders.own.update": false,
  "shippingCompany.index": false,
  "shippingCompany.store": false,
  "shippingCompany.show": false,
  "shippingCompany.update": false,
  "shipment.index": false,
  "shipment.store": false,
  "shipment.show": false,
  "role.index": false,
  "role.store": false,
  "destruction.index": false,
  "destruction.store": false,
  "destruction.show": false,
  "manager.continue": false,
  "sale.index": false,
  "sale.store": false,
  "sale.show": false,
  "employee.ban": false,
  "report.show": false,
  "product.expired.notify": false,
  "product.warning.notify": false,
};
