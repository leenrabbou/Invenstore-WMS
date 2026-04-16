// ignore_for_file: must_be_immutable, file_names, no_logic_in_create_state

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:buymore/Screens/Manager/SubCategoryScreen.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryCard extends StatelessWidget {
  SubCategoryCard(
      {super.key,
      required this.subcategory,
      required this.category,
      required this.isWarehouse});
  SubCategoryModel subcategory;
  CategoryModel category;
  bool isWarehouse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: GestureDetector(
        onTap: () async {
          final locale =
              Provider.of<LocalizationProvider>(context, listen: false)
                  .language!;
          try {
            CategoriesService().showAnCategory(category.id, locale);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return SubCategoryScreen(
                  category: category,
                  subcategory: subcategory,
                  isWarehouse: isWarehouse,
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                    child: subcategory.image != null
                        ? Image.network(
                            '$imageUrl/${subcategory.image!}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'images/image.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      subcategory.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
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
