// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Product/ProductModel.dart';
import 'package:buymore/Services/Manager/ProductsServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Product/ProductShowDialog.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen(
      {super.key,
      required this.product,
      required this.warehouseType,
      required this.isWarehouse,
      required this.isCart});
  ProductModel product;
  int warehouseType;
  bool isWarehouse;
  bool isCart;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  //bool _value = true;
  int quantity = 0;
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await ProductsServices()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          // widget.warehouseType == 1 &&
          //         widget.isCart == false &&
          permissionsMap['product.update'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 100,
                      left: isArabic() ? 100 : 0),
                  child: TextButton(
                    onPressed: () {
                      ProductShowDialog().productDialog(context,
                          text: S.of(context).editProduct,
                          edit: true,
                          product: widget.product);
                    },
                    child: Text(
                      S.of(context).editProduct,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ))
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
              padding: const EdgeInsets.only(left: 140, top: 40, right: 140),
              child: Container(
                height: 450,
                width: 750,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: 350,
                            height: 130,
                            child: Text(
                              widget.product.description,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.secondary,
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
                              const SizedBox(width: 40),
                            ],
                          ),
                          widget.isCart
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        S().quantity,
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
                                              quantity > 0 ? quantity-- : null;
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
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('$quantity'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
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
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 80,
                                        ),
                                        CustomElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 0) {}
                                            });
                                          },
                                          height: 35,
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
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
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
