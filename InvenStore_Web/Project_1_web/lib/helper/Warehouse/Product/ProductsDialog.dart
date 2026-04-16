// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Services/Warehouse/ProductsServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductsDialog {
  void editMinimumDialog(BuildContext context, {required int id}) {
    final TextEditingController minController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 300,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S().editMinimum,
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
                          CustomTextField(
                            text: S().minimum,
                            hint: S().enterminimum,
                            controller: minController,
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
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 40,
                                  width: 150,
                                  left: isArabic() ? 50 : 0,
                                  right: isArabic() ? 0 : 50,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  textcolor:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  child: Text(
                                    S.of(context).cancel,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      // color: Colors.white,
                                    ),
                                  ),
                                ),
                                CustomElevatedButton(
                                  onPressed: () async {
                                    final locale =
                                        Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .language!;
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      dynamic response;
                                      response = await ProductsService()
                                          .editMinimumService(
                                              int.parse(minController.text),
                                              id,
                                              locale);
                                      if (response.status == 1) {
                                        CustomSnackBar()
                                            .showToast(response.message);
                                      } else if (response.status == 0 &&
                                          response.message != null) {
                                        String errorMessage = '';
                                        if (response
                                            .message!.nameEn.isNotEmpty) {
                                          errorMessage +=
                                              response.message!.nameEn.first;
                                        }
                                        if (response
                                            .message!.nameAr.isNotEmpty) {
                                          errorMessage +=
                                              errorMessage.isNotEmpty
                                                  ? ' and '
                                                  : '';
                                          errorMessage +=
                                              response.message!.nameAr.first;
                                        }

                                        CustomSnackBar()
                                            .showToast(errorMessage);
                                      } else {
                                        CustomSnackBar().showToast(
                                            'Unknown error occurred');
                                      }
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                      if (!context.mounted) {
                                        return;
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                  },
                                  height: 40,
                                  width: 150,
                                  left: 0,
                                  right: 0,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      const Color.fromARGB(255, 29, 104, 165),
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
                                          S.of(context).save,
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
              );
            },
          );
        });
  }

  void editMaximumDialog(BuildContext context, {required int id}) {
    final TextEditingController maxController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 300,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S().editMaximum,
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
                          CustomTextField(
                            text: S().maximum,
                            hint: S().entermaximum,
                            controller: maxController,
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
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 40,
                                  width: 150,
                                  left: isArabic() ? 50 : 0,
                                  right: isArabic() ? 0 : 50,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  textcolor:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  child: Text(
                                    S.of(context).cancel,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                CustomElevatedButton(
                                  onPressed: () async {
                                    final locale =
                                        Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .language!;
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      dynamic response;
                                      response = await ProductsService()
                                          .editStoredProductService(
                                              int.parse(maxController.text),
                                              null,
                                              id,
                                              locale);
                                      if (response.status == 1) {
                                        CustomSnackBar()
                                            .showToast(response.message);
                                      } else if (response.status == 0 &&
                                          response.message != null) {
                                        String errorMessage = '';
                                        if (response
                                            .message!.nameEn.isNotEmpty) {
                                          errorMessage +=
                                              response.message!.nameEn.first;
                                        }
                                        if (response
                                            .message!.nameAr.isNotEmpty) {
                                          errorMessage +=
                                              errorMessage.isNotEmpty
                                                  ? ' and '
                                                  : '';
                                          errorMessage +=
                                              response.message!.nameAr.first;
                                        }

                                        CustomSnackBar()
                                            .showToast(errorMessage);
                                      } else {
                                        CustomSnackBar().showToast(
                                            'Unknown error occurred');
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
                                  width: 150,
                                  left: 0,
                                  right: 0,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      const Color.fromARGB(255, 29, 104, 165),
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
                                          S.of(context).save,
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
              );
            },
          );
        });
  }
}
