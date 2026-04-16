// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/Manufacturer/ManufacturerModel.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:project_1_v2/Services/Manager/ShippingCompanyServices.dart';
import 'package:project_1_v2/Services/Warehouse/ShipmentServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ShipmentShowDialog {
  void addShipmentDialog(BuildContext context, {required OrderModel order}) {
    final TextEditingController driverNameController = TextEditingController();
    final TextEditingController costController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ManufacturerModel intialValue = allShippingCompaniesList.first;
    ManufacturerModel shippingCompanyValue = intialValue;
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Form(
              key: formKey,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 450,
                  width: 700,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S().shippingProcess,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: isArabic() ? 0 : 100,
                              left: isArabic() ? 100 : 0,
                              bottom: 15,
                            ),
                            child: Divider(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            S.of(context).shippingCompany,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: DropdownButton<ManufacturerModel>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondary.withOpacity(0.5),
                              ),
                              iconSize: 36,
                              isExpanded: true,
                              value: shippingCompanyValue,
                              onChanged: (ManufacturerModel? value) {
                                setState(() {
                                  shippingCompanyValue = value!;
                                });
                              },
                              items: allShippingCompaniesList
                                  .map<DropdownMenuItem<ManufacturerModel>>((
                                    ManufacturerModel item,
                                  ) {
                                    return DropdownMenuItem<ManufacturerModel>(
                                      value: item,
                                      child: Text(item.name),
                                    );
                                  })
                                  .toList(),
                              underline: const SizedBox(width: 120),
                            ),
                          ),
                          CustomTextField(
                            text: S().driverName,
                            hint: S().enterdriverName,
                            controller: driverNameController,
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
                            inputFormatter: null,
                            maxLength: null,
                          ),
                          CustomTextField(
                            text: S().cost,
                            hint: S().enterCost,
                            controller: costController,
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            height: isArabic() ? 100 : 100,
                            width: 400,
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
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 40,
                                  width: 100,
                                  left: isArabic() ? 30 : 0,
                                  right: isArabic() ? 0 : 30,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
                                  textcolor: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  elevation: 0,
                                  child: Text(
                                    S.of(context).cancel,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                CustomElevatedButton(
                                  onPressed: isLoading
                                      ? () {}
                                      : () async {
                                          final locale =
                                              Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false,
                                              ).language!;
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              dynamic response;
                                              response =
                                                  await ShipmentServices()
                                                      .addShipmentService(
                                                        driverNameController
                                                            .text,
                                                        costController.text,
                                                        shippingCompanyValue.id,
                                                        order.id,
                                                        locale,
                                                      );

                                              if (response.status == 1) {
                                                CustomSnackBar().showToast(
                                                  response.message,
                                                );
                                              } else if (response.status == 0 &&
                                                  response.message != null) {
                                                String errorMessage = '';
                                                if (response
                                                    .message!
                                                    .nameEn
                                                    .isNotEmpty) {
                                                  errorMessage += response
                                                      .message!
                                                      .nameEn
                                                      .first;
                                                }
                                                if (response
                                                    .message!
                                                    .nameAr
                                                    .isNotEmpty) {
                                                  errorMessage +=
                                                      errorMessage.isNotEmpty
                                                      ? ' ${S().and} '
                                                      : '';
                                                  errorMessage += response
                                                      .message!
                                                      .nameAr
                                                      .first;
                                                }

                                                CustomSnackBar().showToast(
                                                  errorMessage,
                                                );
                                              } else {
                                                CustomSnackBar().showToast(
                                                  S().unknownErrorOccurred,
                                                );
                                              }
                                            } catch (e) {
                                              if (kDebugMode) {
                                                print(e);
                                              }
                                            }
                                            if (!context.mounted) {
                                              return;
                                            }
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                  height: 40,
                                  width: 100,
                                  left: 0,
                                  right: 0,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color: const Color.fromARGB(
                                    255,
                                    29,
                                    104,
                                    165,
                                  ),
                                  elevation: 5,
                                  textcolor: Colors.white,
                                  child: isLoading
                                      ? SpinKitThreeInOut(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.background,
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
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
