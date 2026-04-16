// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:buymore/Screens/Manager/ProductsScreen.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class ManufacturerContainer extends StatefulWidget {
  ManufacturerContainer(
      {super.key, required this.manufacturer, required this.isSuppliesOrrder});
  final bool isSuppliesOrrder;
  ManufacturerModel manufacturer;
  @override
  State<ManufacturerContainer> createState() => _ManufacturerContainer();
}

class _ManufacturerContainer extends State<ManufacturerContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 50 : 30,
        right: isArabic() ? 30 : 50,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          widget.isSuppliesOrrder
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProductScreen(
                        warehouseType: 2,
                        isCart: true,
                        isWarehouse: true,
                        manufacturerId: widget.manufacturer.id,
                        isReport: false,
                      );
                    },
                  ),
                )
              : null;
        },
        child: Container(
          height: 60,
          width: 900,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              )
            ],
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 240,
                child: Text(
                  widget.manufacturer.name,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                width: 210,
                child: Text(
                  widget.manufacturer.city,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  widget.manufacturer.state,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  widget.manufacturer.streetAddress,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              permissionsMap['manufacturer.update'] == false
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        ShowDialog2().manufacturerDialog(context,
                            edit: true, manufacturerId: widget.manufacturer.id);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
