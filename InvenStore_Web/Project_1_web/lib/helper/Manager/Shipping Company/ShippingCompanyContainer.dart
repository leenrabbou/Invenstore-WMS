// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Shipping%20Company/ShippingCompanyShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class ShippingCompanyContainer extends StatefulWidget {
  ShippingCompanyContainer({super.key, required this.shippingCompany});
  ManufacturerModel shippingCompany;
  @override
  State<ShippingCompanyContainer> createState() => _ShippingCompanyContainer();
}

class _ShippingCompanyContainer extends State<ShippingCompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 50 : 30,
        right: isArabic() ? 30 : 50,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {},
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
                  width: 20,
                ),
                SizedBox(
                  width: 240,
                  child: Text(
                    widget.shippingCompany.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    widget.shippingCompany.city,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    widget.shippingCompany.state,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.shippingCompany.streetAddress,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                permissionsMap['shippingCompany.update'] == false
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          ShippingCompanyShowDialog().shippingCompanyDialog(
                              context,
                              edit: true,
                              shippingCompanyId: widget.shippingCompany.id);
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
      ),
    );
  }
}
