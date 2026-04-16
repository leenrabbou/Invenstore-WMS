// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Services/Warehouse/SalesService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CartProductCard.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CartSalesScreen extends StatefulWidget {
  const CartSalesScreen({super.key});

  @override
  State<CartSalesScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartSalesScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  double countCost() {
    double total = 0.0;
    for (int i = 0; i < salesProductsList.length; i++) {
      total +=
          (salesProductsList[i].product.price * salesProductsList[i].quantity);
    }

    return double.parse(total.toStringAsFixed(2));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S().cartDetails,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CustomTextField(
                        text: '',
                        hint: S().enterBuyerName,
                        controller: nameController,
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        height: 105,
                        width: 500,
                        maxLines: false,
                        errorMsg: S.of(context).required,
                        fillColor: null,
                        prefix: null,
                        suffix: false,
                        obscure: false,
                        inputFormatter: null,
                        maxLength: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 8,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 110,
                        width: 600,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          S().numberOfProducts,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      FittedBox(
                                        child: Text(
                                          salesProductsList.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            S().totalPrice,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                '${countCost()}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Text(
                                                ' ${S().syp}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: salesProductsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartProductsCard(
                          product: salesProductsList[index].product,
                          quantity: salesProductsList[index].quantity,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          if (formKey.currentState!.validate()) {
                            if (salesProductsList.isNotEmpty) {
                              final locale = Provider.of<LocalizationProvider>(
                                context,
                                listen: false,
                              ).language!;
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                dynamic response;
                                response = await SalesServices()
                                    .addSaleOrderService(
                                      locale,
                                      nameController.text,
                                    );
                                if (response.status == 1) {
                                  Navigator.pop(context);
                                  salesProductsList.clear();
                                } else {
                                  Navigator.pop(context);
                                  CustomSnackBar().showToast(
                                    'quatity not valid',
                                  );
                                  salesProductsList.clear();
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                  height: 50,
                  width: 200,
                  left: isArabic() ? 00 : 0,
                  right: isArabic() ? 0 : 00,
                  top: 5,
                  bottom: 10,
                  textSize: isArabic() ? 15 : 15,
                  color: const Color.fromARGB(255, 29, 104, 165),
                  textcolor: Colors.white,
                  elevation: 5,
                  child: isLoading
                      ? SpinKitThreeInOut(
                          color: Theme.of(context).colorScheme.background,
                          size: 20,
                        )
                      : Text(
                          S().checkOut,
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
    );
  }
}
