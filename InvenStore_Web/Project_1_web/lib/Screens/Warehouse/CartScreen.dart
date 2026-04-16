// ignore_for_file: must_be_immutable, file_names, use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/OrderModel.dart';
import 'package:buymore/Screens/Warehouse/Products/AllProductDetailsScreen.dart';
import 'package:buymore/Services/Warehouse/OrdersServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/helper/Warehouse/OrderContainerCart.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(
      {super.key, required this.order, required this.manufacturerId});
  final OrderModel? order;
  final int manufacturerId;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  void onPressed() async {
    setState(() {
      isLoading = true;
    });

    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    try {
      if (formKey.currentState!.validate()) {
        if (suppliesOrderList.isNotEmpty) {
          dynamic response = await OrdersServices().addSuppliesOrderService(
              widget.manufacturerId, costController.text, locale);
          CustomSnackBar().showToast(response.message);
        }
        Navigator.pop(context);
        suppliesOrderList.clear();
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

  double countCost() {
    double total = 0.0;
    for (int i = 0; i < suppliesOrderList.length; i++) {
      total +=
          (suppliesOrderList[i].product.price * suppliesOrderList[i].quantity);
    }

    return double.parse(total.toStringAsFixed(2));
  }

  final TextEditingController costController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Order Details',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
      body: Center(
        child: Container(
          height: 700,
          width: 1200,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 700,
                    child: Expanded(
                      child: SizedBox(
                        width: 700,
                        child: ListView.builder(
                            itemCount: suppliesOrderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OrderContainerCart(
                                isCart: true,
                                index: index,
                                quantity: suppliesOrderList[index].quantity,
                                orderProduct: suppliesOrderList[index].product,
                                expiredDate: suppliesOrderList[index].exDate,
                                onDelete: () {
                                  setState(() {
                                    suppliesOrderList.removeAt(index);
                                  });
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Color(0xfff2f3f5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Order total',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '${countCost()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Shipping',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 0),
                                  child: Text(
                                    '-------------------------',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Subtotal',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      '${countCost()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomTextField(
                          text: '',
                          hint: 'Enter Shipping cost',
                          controller: costController,
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 10,
                          height: 100,
                          width: 200,
                          maxLines: false,
                          errorMsg: S.of(context).required,
                          fillColor: null,
                          prefix: null,
                          suffix: false,
                          obscure: false,
                          inputFormatter: null,
                          maxLength: null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomElevatedButton(
                          onPressed: isLoading ? () {} : onPressed,
                          height: 40,
                          width: 150,
                          left: isArabic() ? 00 : 0,
                          right: isArabic() ? 0 : 00,
                          top: 5,
                          bottom: 10,
                          textSize: isArabic() ? 15 : 15,
                          color: const Color.fromARGB(255, 104, 168, 221),
                          textcolor: Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          child: isLoading
                              ? SpinKitThreeInOut(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  size: 20,
                                )
                              : const Text(
                                  'Check Out',
                                  style: TextStyle(
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
  }
}
