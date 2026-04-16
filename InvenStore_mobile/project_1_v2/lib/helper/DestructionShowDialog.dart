// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionCausesModel.dart';
import 'package:project_1_v2/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DestructionShowDialog {
  void destructionProductDialog(
    BuildContext context, {
    required StoredProductModel product,
  }) {
    int quantity = 1;
    DestructionCausesModel causeValue = destructionCausesList.first;
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 345,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S().destructionAProduct,
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
                        S().quantity,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimary.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomElevatedButton(
                            onPressed: () {
                              setState(() {
                                quantity > 0 ? quantity-- : null;
                              });
                            },
                            height: 40,
                            width: 45,
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            textSize: 15,
                            color: const Color.fromARGB(211, 199, 53, 43),
                            elevation: 5,
                            textcolor: Theme.of(context).colorScheme.secondary,
                            child: const Text(
                              '-',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text('$quantity'),
                          const SizedBox(width: 10),
                          CustomElevatedButton(
                            onPressed: () {
                              setState(() {
                                quantity < product.max ? quantity++ : null;
                              });
                            },
                            height: 40,
                            width: 45,
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            textSize: 15,
                            color: const Color.fromARGB(193, 29, 104, 165),
                            elevation: 5,
                            textcolor: Theme.of(context).colorScheme.secondary,
                            child: const Text(
                              '+',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        S().causeOfDestruction,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimary.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DropdownButton<DestructionCausesModel>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.5),
                          ),
                          iconSize: 36,
                          isExpanded: true,
                          value: causeValue,
                          onChanged: (DestructionCausesModel? value) {
                            setState(() {
                              causeValue = value!;
                            });
                          },
                          items: destructionCausesList
                              .map<DropdownMenuItem<DestructionCausesModel>>((
                                DestructionCausesModel item,
                              ) {
                                return DropdownMenuItem<DestructionCausesModel>(
                                  value: item,
                                  child: Text(item.name),
                                );
                              })
                              .toList(),
                          underline: const SizedBox(width: 120),
                        ),
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
                              textSize: 15,
                              color: Theme.of(context).colorScheme.background,
                              textcolor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              elevation: 0,
                              child: Text(
                                S.of(context).cancel,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            CustomElevatedButton(
                              onPressed: () async {
                                final locale =
                                    Provider.of<LocalizationProvider>(
                                      context,
                                      listen: false,
                                    ).language!;

                                dynamic response;
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  if (quantity > 0) {
                                    response = await DestructionServices()
                                        .addDestructionService(
                                          product.id,
                                          quantity,
                                          causeValue.id,
                                          locale,
                                        );
                                  }

                                  if (response.status == 1) {
                                    CustomSnackBar().showToast(
                                      response.message,
                                    );
                                  } else if (response.status == 0 &&
                                      response.message != null) {
                                    String errorMessage = '';
                                    if (response.message!.nameEn.isNotEmpty) {
                                      errorMessage +=
                                          response.message!.nameEn.first;
                                    }
                                    if (response.message!.nameAr.isNotEmpty) {
                                      errorMessage += errorMessage.isNotEmpty
                                          ? ' ${S().and} '
                                          : '';
                                      errorMessage +=
                                          response.message!.nameAr.first;
                                    }

                                    CustomSnackBar().showToast(errorMessage);
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
                              },
                              height: 40,
                              width: 100,
                              left: 0,
                              right: 0,
                              top: 5,
                              bottom: 10,
                              textSize: 15,
                              color: const Color.fromARGB(255, 29, 104, 165),
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
                                      S().done,
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
            );
          },
        );
      },
    );
  }
}
