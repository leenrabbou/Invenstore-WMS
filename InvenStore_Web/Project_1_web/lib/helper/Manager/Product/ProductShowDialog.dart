// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Models/Manager/Subcategory/SubcategoryModel.dart';
import 'package:buymore/Services/Manager/ManufacturerServices.dart';
import 'package:buymore/Services/Manager/ProductsServices.dart';
import 'package:buymore/Services/Manager/SubcategoriesServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductShowDialog {
  void productDialog(BuildContext context,
      {required text, required bool edit, ProductModel? product}) {
    final TextEditingController nameArController = TextEditingController();
    final TextEditingController nameEnController = TextEditingController();
    final TextEditingController descEnController = TextEditingController();
    final TextEditingController descArController = TextEditingController();
    final TextEditingController priceController1 = TextEditingController();
    final TextEditingController priceController2 = TextEditingController();

    final TextEditingController barcodeController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final imageProvider = Provider.of<ImageModel>(context, listen: false);
    ManufacturerModel intialValue = allManufacturerList.first;
    ManufacturerModel manufacturerValue = intialValue;
    bool dropdownManEdit = false;
    SubCategoryModel subintialValue = allSubcategoryList.first;
    SubCategoryModel subcategoryValue = subintialValue;
    bool isLoading = false;
    bool dropdownSubEdit = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Form(
              key: formKey,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 550,
                  width: 700,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 40, right: 40, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: isArabic() ? 0 : 300,
                              left: isArabic() ? 300 : 0,
                              bottom: 15),
                          child: Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 25.0,
                                  right: 150,
                                  bottom: 20,
                                  left: 120,
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Consumer<ImageModel>(
                                        builder: (context, model, child) {
                                      return model.pickedImage3 == null
                                          ? DottedBorder(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              child: Image.asset(
                                                'images/image.png',
                                                height: 220,
                                                width: 220,
                                              ),
                                            )
                                          : DottedBorder(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              child: Image.memory(
                                                model.webImage3,
                                                height: 220,
                                                width: 220,
                                              ),
                                            );
                                    }),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: imageProvider.pickImage2,
                                        child: const Icon(Icons.camera_alt),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                  text: S.of(context).ProductNameEn,
                                  hint: S.of(context).enterProductNameEn,
                                  controller: nameEnController,
                                  left: 0,
                                  right: 0,
                                  top: isArabic() ? 0 : 10,
                                  bottom: 0,
                                  height: isArabic() ? 100 : 100,
                                  width: 400,
                                  maxLines: false,
                                  errorMsg: S.of(context).required,
                                  fillColor: null,
                                  prefix: null,
                                  suffix: false,
                                  obscure: false,
                                  maxLength: null,
                                  inputFormatter: null),
                              CustomTextField(
                                  text: S.of(context).ProductNameAr,
                                  hint: S.of(context).enterProductNameAr,
                                  controller: nameArController,
                                  left: 0,
                                  right: 0,
                                  top: isArabic() ? 0 : 10,
                                  bottom: 0,
                                  height: isArabic() ? 100 : 100,
                                  width: 400,
                                  maxLines: false,
                                  errorMsg: S.of(context).required,
                                  fillColor: null,
                                  prefix: null,
                                  suffix: false,
                                  obscure: false,
                                  maxLength: null,
                                  inputFormatter: null),
                              Text(
                                S.of(context).manufacturer,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButton<ManufacturerModel>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: manufacturerValue,
                                  onChanged: (ManufacturerModel? value) {
                                    setState(() {
                                      manufacturerValue = value!;
                                      dropdownManEdit = true;
                                    });
                                  },
                                  items: allManufacturerList
                                      .map<DropdownMenuItem<ManufacturerModel>>(
                                          (ManufacturerModel item) {
                                    return DropdownMenuItem<ManufacturerModel>(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  underline: const SizedBox(width: 150),
                                ),
                              ),
                              CustomTextField(
                                text: S.of(context).descriptionEn,
                                hint: S.of(context).enterDescriptionEn,
                                controller: descEnController,
                                left: 0,
                                right: 0,
                                top: isArabic() ? 0 : 10,
                                bottom: 0,
                                height: isArabic() ? 150 : 150,
                                width: 400,
                                maxLines: true,
                                errorMsg: S.of(context).required,
                                fillColor: null,
                                prefix: null,
                                suffix: false,
                                obscure: false,
                                maxLength: null,
                                inputFormatter: null,
                              ),
                              CustomTextField(
                                text: S.of(context).descriptionAr,
                                hint: S.of(context).enterDescriptionAr,
                                controller: descArController,
                                left: 0,
                                right: 0,
                                top: isArabic() ? 0 : 10,
                                bottom: 0,
                                height: isArabic() ? 150 : 150,
                                width: 400,
                                maxLines: true,
                                errorMsg: S.of(context).required,
                                fillColor: null,
                                prefix: null,
                                suffix: false,
                                obscure: false,
                                inputFormatter: null,
                                maxLength: null,
                              ),
                              Text(
                                S.of(context).subcategory,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButton<SubCategoryModel>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: subcategoryValue,
                                  onChanged: (SubCategoryModel? value) {
                                    setState(() {
                                      subcategoryValue = value!;
                                      dropdownSubEdit = true;
                                    });
                                  },
                                  items: allSubcategoryList
                                      .map<DropdownMenuItem<SubCategoryModel>>(
                                          (SubCategoryModel item) {
                                    return DropdownMenuItem<SubCategoryModel>(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  underline: const SizedBox(width: 150),
                                ),
                              ),
                              Row(
                                children: [
                                  CustomTextField(
                                    text: S.of(context).price,
                                    hint: S.of(context).enterprice,
                                    controller: priceController1,
                                    left: 0,
                                    right: 10,
                                    top: isArabic() ? 0 : 10,
                                    bottom: 0,
                                    height: isArabic() ? 100 : 100,
                                    width: 300,
                                    maxLines: false,
                                    errorMsg: S.of(context).required,
                                    fillColor: null,
                                    prefix: null,
                                    suffix: false,
                                    obscure: false,
                                    inputFormatter: null,
                                    maxLength: null,
                                  ),
                                  SizedBox(
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        '.',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTextField(
                                    text: '',
                                    hint: '',
                                    controller: priceController2,
                                    left: 10,
                                    right: 0,
                                    top: isArabic() ? 0 : 10,
                                    bottom: 0,
                                    height: isArabic() ? 100 : 100,
                                    width: 50,
                                    maxLines: false,
                                    errorMsg: S.of(context).required,
                                    fillColor: null,
                                    prefix: null,
                                    suffix: false,
                                    obscure: false,
                                    inputFormatter: null,
                                    maxLength: 2,
                                  ),
                                ],
                              ),
                              CustomTextField(
                                text: S().barcode,
                                hint: S().enterBarcode,
                                controller: barcodeController,
                                left: 0,
                                right: 10,
                                top: isArabic() ? 0 : 10,
                                bottom: 0,
                                height: isArabic() ? 100 : 100,
                                width: 300,
                                maxLines: false,
                                errorMsg: S.of(context).required,
                                fillColor: null,
                                prefix: null,
                                suffix: false,
                                obscure: false,
                                inputFormatter: null,
                                maxLength: null,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: isArabic() ? 15 : 35,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        imageProvider.emptyImage3();
                                      },
                                      height: 40,
                                      width: 150,
                                      left: isArabic() ? 50 : 0,
                                      right: isArabic() ? 0 : 50,
                                      top: 5,
                                      bottom: 10,
                                      textSize: isArabic() ? 15 : 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      textcolor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      elevation: 0,
                                      child: Text(
                                        S.of(context).cancel,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    CustomElevatedButton(
                                      onPressed: isLoading
                                          ? () {}
                                          : () async {
                                              final locale = Provider.of<
                                                          LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                              dynamic response;
                                              setState(() {
                                                isLoading = true;
                                              });
                                              try {
                                                if (!edit) {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    if (imageProvider
                                                            .pickedImage3 !=
                                                        null) {
                                                    } else if (imageProvider
                                                            .pickedImage3 ==
                                                        null) {
                                                      response = ProductsServices()
                                                          .addProductService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              null,
                                                              descArController
                                                                  .text,
                                                              descEnController
                                                                  .text,
                                                              double.parse(
                                                                  '${priceController1.text}.${priceController2.text}'),
                                                              subcategoryValue
                                                                  .id,
                                                              manufacturerValue
                                                                  .id,
                                                              barcodeController
                                                                  .text,
                                                              locale);
                                                    }
                                                    CustomSnackBar().showToast(
                                                        response.message);
                                                  }
                                                } else if (edit) {
                                                  int? subcategoryId;
                                                  if (dropdownSubEdit) {
                                                    subcategoryId =
                                                        subcategoryValue.id;
                                                  }
                                                  int? manufacturerId;
                                                  if (dropdownManEdit) {
                                                    manufacturerId =
                                                        manufacturerValue.id;
                                                  }

                                                  double? priceValue;
                                                  if (priceController1
                                                          .text.isNotEmpty &&
                                                      priceController2
                                                          .text.isNotEmpty) {
                                                    priceValue = double.parse(
                                                        '${priceController1.text}.${priceController2.text}');
                                                  }

                                                  if (imageProvider
                                                          .pickedImage3 !=
                                                      null) {
                                                    response =
                                                        ProductsServices()
                                                            .editProductService(
                                                      nameEnController.text,
                                                      nameArController.text,
                                                      imageProvider.webImage3,
                                                      descArController.text,
                                                      descEnController.text,
                                                      priceValue,
                                                      subcategoryId,
                                                      manufacturerId,
                                                      locale,
                                                      barcodeController.text,
                                                      product!.id,
                                                    );
                                                  } else if (imageProvider
                                                          .pickedImage3 ==
                                                      null) {
                                                    response =
                                                        ProductsServices()
                                                            .editProductService(
                                                      nameEnController.text,
                                                      nameArController.text,
                                                      null,
                                                      descArController.text,
                                                      descEnController.text,
                                                      priceValue,
                                                      subcategoryId,
                                                      manufacturerId,
                                                      locale,
                                                      barcodeController.text,
                                                      product!.id,
                                                    );
                                                  }
                                                  if (response.status == 1) {
                                                    CustomSnackBar().showToast(
                                                        response.message);
                                                  } else if (response.status ==
                                                      0) {
                                                    CustomSnackBar().showToast(
                                                        response.message);
                                                  } else {
                                                    CustomSnackBar().showToast(
                                                        S().unknownErrorOccurred);
                                                  }
                                                }
                                              } catch (e) {
                                                if (kDebugMode) {
                                                  print(e);
                                                }
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pop(context);
                                              imageProvider.emptyImage3();
                                            },
                                      height: 40,
                                      width: 150,
                                      left: 0,
                                      right: 0,
                                      top: 5,
                                      bottom: 10,
                                      textSize: isArabic() ? 15 : 15,
                                      color: const Color.fromARGB(
                                          255, 29, 104, 165),
                                      elevation: 5,
                                      textcolor: Colors.white,
                                      child: isLoading
                                          ? SpinKitThreeInOut(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              size: 20,
                                            )
                                          : Text(
                                              S().save,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
