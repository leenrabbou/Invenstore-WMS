// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Services/Warehouse/ProductsServices.dart';
import 'package:buymore/Models/Warehouse/StoredProducts%20Models/StoredProductModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Warehouse/DestructionShowDialog.dart';
import 'package:buymore/helper/Warehouse/Product/ProductsDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class StoredProductDetailsScreen extends StatefulWidget {
  StoredProductDetailsScreen({
    super.key,
    required this.product,
  });
  StoredProductModel product;

  @override
  State<StoredProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<StoredProductDetailsScreen> {
  bool isLoading = false;

  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await ProductsService()
          .showAnStoredProductsService(widget.product.id, locale);
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
    late bool activevalue;
    if (widget.product.active == 1) {
      activevalue = true;
    } else if (widget.product.active == 0) {
      activevalue = false;
    }

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
          permissionsMap['destruction.store'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 50,
                      left: isArabic() ? 50 : 0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      DestructionShowDialog().destructionProductDialog(context,
                          product: widget.product);
                    },
                    height: 40,
                    width: 130,
                    left: 0,
                    right: 0,
                    top: 5,
                    bottom: 10,
                    textSize: isArabic() ? 15 : 15,
                    color: const Color.fromARGB(255, 199, 54, 43),
                    textcolor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    child: Text(
                      S().destruction,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          permissionsMap['product.stored.update'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 30,
                      left: isArabic() ? 30 : 0),
                  child: TextButton(
                    onPressed: () {
                      try {
                        ProductsDialog()
                            .editMaximumDialog(context, id: widget.product.id);
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      S().editMaximum,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          permissionsMap['product.stored.update'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 0 : 80, left: isArabic() ? 80 : 0),
                  child: FlutterSwitch(
                      width: 50,
                      height: 20,
                      toggleSize: 20,
                      activeColor: Colors.green.withOpacity(0.5),
                      value: activevalue,
                      onToggle: (value) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                content: Padding(
                                  padding: EdgeInsets.only(
                                      top: 30,
                                      left: isArabic() ? 0 : 30,
                                      right: isArabic() ? 30 : 0),
                                  child: Text(
                                    S().deactivateProductMsg,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                    maxLines: 2,
                                  ),
                                ),
                                actions: [
                                  CustomElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    height: 40,
                                    width: 100,
                                    left: 50,
                                    right: 50,
                                    top: 5,
                                    bottom: 10,
                                    textSize: 15,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    textcolor:
                                        Theme.of(context).colorScheme.secondary,
                                    elevation: 0,
                                    child: Text(
                                      S().no,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  CustomElevatedButton(
                                    onPressed: isLoading
                                        ? () {}
                                        : () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            final locale = Provider.of<
                                                        LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .language!;
                                            setState(() {
                                              activevalue = value;
                                              activevalue
                                                  ? widget.product.active = 1
                                                  : widget.product.active = 0;
                                            });
                                            try {
                                              dynamic response;
                                              response = await ProductsService()
                                                  .editStoredProductService(
                                                      null,
                                                      widget.product.active,
                                                      widget.product.id,
                                                      locale);
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (response.status == 1) {
                                                CustomSnackBar().showToast(
                                                    response.message);
                                              } else if (response.status == 0 &&
                                                  response.message != null) {
                                                String errorMessage = '';
                                                if (response.message!.nameEn
                                                    .isNotEmpty) {
                                                  errorMessage += response
                                                      .message!.nameEn.first;
                                                }
                                                if (response.message!.nameAr
                                                    .isNotEmpty) {
                                                  errorMessage +=
                                                      errorMessage.isNotEmpty
                                                          ? ' and '
                                                          : '';
                                                  errorMessage += response
                                                      .message!.nameAr.first;
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
                                            Navigator.pop(context);
                                          },
                                    height: 40,
                                    width: 100,
                                    left: isArabic() ? 50 : 0,
                                    right: isArabic() ? 0 : 50,
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
                                            S().yes,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ],
                              );
                            });
                      }),
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
              padding: const EdgeInsets.only(left: 140, top: 40, right: 140),
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
                                                      .secondary),
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
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        S().maximum,
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
                                        widget.product.max.toString(),
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
                                      S().expirationDate,
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
                                      widget.product.expirationDate != null
                                          ? widget.product.expirationDate!
                                          : '--',
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Column(
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
                                    FittedBox(
                                      child: Text(
                                        widget.product.validQuantity.toString(),
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
                            ],
                          )
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
