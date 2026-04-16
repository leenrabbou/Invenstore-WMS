// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/SuppliesOrderData.dart';
import 'package:buymore/Services/Warehouse/ProductsServices.dart';
import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Warehouse/Product/ProductsDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

List<SuppliesOrderData> suppliesOrderList = [];

class AllProductDetailsScreen extends StatefulWidget {
  AllProductDetailsScreen({
    super.key,
    required this.product,
    required this.isCart,
  });
  AllProductModel product;

  bool isCart;

  @override
  State<AllProductDetailsScreen> createState() =>
      _AllProductDetailsScreenState();
}

class _AllProductDetailsScreenState extends State<AllProductDetailsScreen> {
  //bool _value = true;
  int quantity = 0;
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await ProductsService()
          .showAnProductsService(widget.product.id, locale);
      setState(() {
        widget.product = newData.data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  DateTime? currentDate = DateTime.now();
  bool editDate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          widget.isCart
              ? const SizedBox.shrink()
              : permissionsMap['product.min.update'] == true
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          right: isArabic() ? 0 : 100,
                          left: isArabic() ? 100 : 0),
                      child: TextButton(
                        onPressed: () {
                          ProductsDialog().editMinimumDialog(context,
                              id: widget.product.id);
                        },
                        child: Text(
                          S().editMinimum,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 15),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 140, top: 20, right: 140),
              child: Container(
                height: 550,
                width: 800,
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
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: isArabic() ? 0 : 40,
                            left: isArabic() ? 40 : 0),
                        child: GestureDetector(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: widget.product.image == null
                                  ? Image.asset(
                                      'images/image.png',
                                      height: 500,
                                      width: 350,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      '$imageUrl/${widget.product.image!}',
                                      height: 500,
                                      width: 350,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: Text(
                                    widget.product.name,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Barcode no',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        widget.product.barcode != null
                                            ? Text('${widget.product.barcode}')
                                            : Text(
                                                '--',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            FittedBox(
                              child: Text(
                                widget.product.manufacturer,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: FittedBox(
                                child: Text(
                                  S.of(context).description,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 80,
                              child: Text(
                                widget.product.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    S.of(context).price,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: FittedBox(
                                    child: Text(
                                      '${widget.product.price} SYP',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          S().minimum,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          widget.product.min.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        S().total,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        widget.product.total.toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            widget.isCart
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          CustomElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                quantity > 0
                                                    ? quantity--
                                                    : null;
                                              });
                                            },
                                            height: 30,
                                            width: 35,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            textSize: 15,
                                            color: const Color.fromARGB(
                                                211, 199, 53, 43),
                                            elevation: 5,
                                            textcolor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            child: const Text(
                                              '-',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                // quantity > 0 ?
                                                quantity++;
                                                // : null;
                                              });
                                            },
                                            height: 30,
                                            width: 35,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            textSize: 15,
                                            color: const Color.fromARGB(
                                                193, 29, 104, 165),
                                            elevation: 5,
                                            textcolor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 80,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2025),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .copyWith(
                                                                onSurface: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onBackground,
                                                                background: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                              ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );
                                              if (pickedDate != null) {
                                                setState(() {
                                                  currentDate = pickedDate;
                                                  editDate = true;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                          ),
                                          Text(
                                            '$currentDate'.substring(0, 10),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 4,
                            ),
                            widget.isCart
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: isArabic() ? 0 : 100,
                                        right: isArabic() ? 100 : 0),
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 0) {
                                            String? pickedDate;
                                            editDate
                                                ? pickedDate = currentDate
                                                    .toString()
                                                    .substring(0, 10)
                                                : null;
                                            suppliesOrderList.add(
                                              SuppliesOrderData(
                                                product: widget.product,
                                                quantity: quantity,
                                                exDate: pickedDate,
                                              ),
                                            );
                                            for (int i = 0;
                                                i < suppliesOrderList.length;
                                                i++) {}
                                          }
                                        });
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
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
