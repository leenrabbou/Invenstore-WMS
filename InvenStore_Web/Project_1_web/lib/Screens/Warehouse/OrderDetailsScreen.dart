// ignore_for_file: must_be_immutable, file_names, use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Services/Warehouse/OrdersServices.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/helper/Warehouse/OrderDetailsContainer.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/AnOrderModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen(
      {super.key,
      required this.orderType,
      required this.order,
      required this.isEdit});
  int orderType;
  AnOrderModel order;
  final bool isEdit;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<String> status = [];
  String? statusValue;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    status = [
      S().pending,
      S().deleted,
      S().rejected,
      S().underPreparing,
      S().canceled,
      S().underShipping,
      S().delievered,
    ];
    statusValue = status.first;
  }

  bool editStatus = false;
  bool isLoading = false;
  bool isAccepted = false;
  bool isRejected = false;
  bool isCanceled = false;
  bool isDeleted = false;
  bool isRecieved = false;
  String acceptText = S().accept;
  String rejectText = S().reject;
  String cancelText = S().cancel;
  String deleteText = S().delete;
  String recieveText = S().recieve;

  bool isLoadingCancel = false;
  bool isLoadingReject = false;
  bool isLoadingAccept = false;
  bool isLoadingDelete = false;
  bool isLoadingRecieve = false;
  final TextEditingController costController = TextEditingController();
  void cancelFunction() async {
    setState(() {
      isLoadingCancel = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isCanceled = true;
      cancelText = S().canceled;
    });
    _onRefresh();
    try {
      await OrdersServices().rejectSellOrdersService(widget.order.id, locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoadingCancel = false;
    });
  }

  void rejectFunction() async {
    setState(() {
      isLoadingReject = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isRejected = true;
      rejectText = S().rejected;
    });
    _onRefresh();
    try {
      await OrdersServices().rejectSellOrdersService(widget.order.id, locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoadingReject = false;
    });
  }

  void acceptFunction() async {
    setState(() {
      isLoadingAccept = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isAccepted = true;
      acceptText = S().accepted;
    });
    _onRefresh();
    try {
      await OrdersServices().acceptSellOrdersService(widget.order.id, locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoadingAccept = false;
    });
  }

  void deleteFunction() async {
    setState(() {
      isLoadingDelete = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isDeleted = true;
      deleteText = S().deleted;
    });
    _onRefresh();
    try {
      await OrdersServices().deleteBuyOrdersService(widget.order.id, locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoadingDelete = false;
    });
  }

  void recieveFunction() async {
    setState(() {
      isLoadingRecieve = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    setState(() {
      isRecieved = true;
      recieveText = S().recieved;
    });
    _onRefresh();
    try {
      await OrdersServices().recieveBuyOrdersService(widget.order.id, locale);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      isLoadingRecieve = false;
    });
  }

  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData =
          await OrdersServices().showAnOrderService(widget.order.id, locale);
      setState(() {
        widget.order = newData.data;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S().orderDetails,
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
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Center(
              child: Container(
                height: 700,
                width: 1200,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 600,
                          child: ListView.builder(
                              itemCount: widget.order.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OrderDetailsContainer(
                                  isEdit: widget.isEdit,
                                  orderProduct: widget.order.products[index],
                                  quantity:
                                      widget.order.products[index].quantity,
                                  index: index,
                                  products: widget.order.products,
                                  onDelete: () {
                                    setState(() {
                                      widget.order.products.removeAt(index);
                                    });
                                  },
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 231,
                              width: 290,
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
                                      S().summary,
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
                                            S().total,
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
                                          '${widget.order.orderCost} ${S().syp}',
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
                                            S().shippingCost,
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
                                          '${widget.order.shippingCost} ${S().syp}',
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
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 0),
                                      child: Text(
                                        '------------------------',
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
                                            S().subtotal,
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
                                          '${widget.order.totalCost} ${S().syp}',
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
                            const SizedBox(
                              height: 20,
                            ),

                            Row(
                              children: [
                                Text(
                                  '${S().status}: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Container(
                                  // height: 225,
                                  //           width: 290,
                                  decoration: BoxDecoration(
                                    color: widget.order.statusId == 1 ||
                                            widget.order.statusId == 4 ||
                                            widget.order.statusId == 6
                                        ? const Color.fromARGB(
                                            144, 40, 165, 214)
                                        : widget.order.statusId == 2 ||
                                                widget.order.statusId == 3 ||
                                                widget.order.statusId == 5
                                            ? const Color.fromARGB(
                                                144, 206, 49, 38)
                                            : const Color.fromARGB(
                                                144, 40, 214, 63),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  width: 120,
                                  height: 30,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.order.status,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            permissionsMap['orders.sell.update'] == true
                                ? (isAccepted && widget.orderType == 1) ||
                                        (widget.orderType == 1 &&
                                            widget.order.statusId == 4)
                                    ? CustomElevatedButton(
                                        onPressed: isLoadingCancel
                                            ? () {}
                                            : cancelFunction,
                                        height: 40,
                                        width: 120,
                                        left: isArabic() ? 00 : 0,
                                        right: isArabic() ? 0 : 00,
                                        top: 5,
                                        bottom: 10,
                                        textSize: isArabic() ? 15 : 15,
                                        color: isCanceled
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 199, 54, 43),
                                        textcolor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        elevation: isCanceled ? 0 : 5,
                                        child: isLoadingCancel
                                            ? SpinKitThreeInOut(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                size: 20,
                                              )
                                            : Text(
                                                cancelText,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      )
                                    : !isAccepted &&
                                            widget.orderType == 1 &&
                                            widget.order.statusId == 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomElevatedButton(
                                                onPressed: isLoadingReject
                                                    ? () {}
                                                    : rejectFunction,
                                                height: 40,
                                                width: 120,
                                                left: isArabic() ? 00 : 0,
                                                right: isArabic() ? 0 : 00,
                                                top: 5,
                                                bottom: 10,
                                                textSize: isArabic() ? 15 : 15,
                                                color: isRejected
                                                    ? Colors.grey
                                                    : const Color.fromARGB(
                                                        255, 199, 54, 43),
                                                textcolor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                elevation: isRejected ? 0 : 5,
                                                child: isLoadingReject
                                                    ? SpinKitThreeInOut(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                        size: 20,
                                                      )
                                                    : Text(
                                                        rejectText,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              isRejected
                                                  ? const SizedBox.shrink()
                                                  : CustomElevatedButton(
                                                      onPressed: isLoadingAccept
                                                          ? () {}
                                                          : acceptFunction,
                                                      height: 40,
                                                      width: 120,
                                                      left: 0,
                                                      right: 0,
                                                      top: 5,
                                                      bottom: 10,
                                                      textSize:
                                                          isArabic() ? 15 : 15,
                                                      color: isRejected
                                                          ? Colors.grey
                                                          : const Color
                                                              .fromARGB(255, 29,
                                                              104, 165),
                                                      elevation:
                                                          isRejected ? 0 : 5,
                                                      textcolor: Colors.white,
                                                      child: isLoadingAccept
                                                          ? SpinKitThreeInOut(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .background,
                                                              size: 20,
                                                            )
                                                          : Text(
                                                              acceptText,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                    ),
                                            ],
                                          )
                                        : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            permissionsMap['orders.buy.update'] == true
                                ? widget.orderType == 2
                                    ? Row(
                                        children: [
                                          widget.order.statusId == 1
                                              ? CustomElevatedButton(
                                                  onPressed: isLoadingDelete
                                                      ? () {}
                                                      : deleteFunction,
                                                  height: 40,
                                                  width: 120,
                                                  left: isArabic() ? 00 : 0,
                                                  right: isArabic() ? 0 : 00,
                                                  top: 5,
                                                  bottom: 10,
                                                  textSize:
                                                      isArabic() ? 15 : 15,
                                                  color: isDeleted
                                                      ? Colors.grey
                                                      : const Color.fromARGB(
                                                          255, 199, 54, 43),
                                                  textcolor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  elevation: isDeleted ? 0 : 5,
                                                  child: isLoadingDelete
                                                      ? SpinKitThreeInOut(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .background,
                                                          size: 20,
                                                        )
                                                      : Text(
                                                          deleteText,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                )
                                              : const SizedBox.shrink(),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          widget.order.statusId == 6
                                              ? CustomElevatedButton(
                                                  onPressed: isLoadingRecieve
                                                      ? () {}
                                                      : recieveFunction,
                                                  height: 40,
                                                  width: 120,
                                                  left: isArabic() ? 00 : 0,
                                                  right: isArabic() ? 0 : 00,
                                                  top: 5,
                                                  bottom: 10,
                                                  textSize:
                                                      isArabic() ? 15 : 15,
                                                  color: isRecieved
                                                      ? Colors.grey
                                                      : const Color.fromARGB(
                                                          255, 29, 104, 165),
                                                  textcolor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  elevation: isRecieved ? 0 : 5,
                                                  child: isLoadingRecieve
                                                      ? SpinKitThreeInOut(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .background,
                                                          size: 20,
                                                        )
                                                      : Text(
                                                          recieveText,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),
                            //supplies
                            widget.orderType == 3
                                ? widget.order.statusId == 6
                                    ? CustomElevatedButton(
                                        onPressed: isLoadingRecieve
                                            ? () {}
                                            : recieveFunction,
                                        height: 40,
                                        width: 120,
                                        left: isArabic() ? 00 : 0,
                                        right: isArabic() ? 0 : 00,
                                        top: 5,
                                        bottom: 10,
                                        textSize: isArabic() ? 15 : 15,
                                        color: isRecieved
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 29, 104, 165),
                                        textcolor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        elevation: isRecieved ? 0 : 5,
                                        child: isLoadingRecieve
                                            ? SpinKitThreeInOut(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                size: 20,
                                              )
                                            : Text(
                                                recieveText,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            widget.isEdit
                                ? SizedBox(
                                    width: 160,
                                    child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.5),
                                      ),
                                      iconSize: 36,
                                      isExpanded: true,
                                      value: statusValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          statusValue = value!;
                                          editStatus = true;
                                          selectedIndex = status.indexOf(value);
                                        });
                                      },
                                      items: status
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                        );
                                      }).toList(),
                                      underline: const SizedBox(
                                        width: 120,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            widget.isEdit
                                ? CustomTextField(
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
                                    fillColor: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.7),
                                    prefix: null,
                                    suffix: false,
                                    obscure: false,
                                    inputFormatter: null,
                                    maxLength: null,
                                  )
                                : const SizedBox.shrink(),

                            widget.isEdit
                                ? CustomElevatedButton(
                                    onPressed: isLoading
                                        ? () {}
                                        : () async {
                                            try {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              int newStatus;
                                              editStatus
                                                  ? newStatus =
                                                      selectedIndex + 1
                                                  : newStatus =
                                                      widget.order.statusId;
                                              String newCost = widget
                                                  .order.shippingCost
                                                  .toString();
                                              costController.text.isEmpty
                                                  ? newCost = widget
                                                      .order.shippingCost
                                                      .toString()
                                                  : newCost =
                                                      costController.text;

                                              final locale = Provider.of<
                                                          LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                              dynamic response =
                                                  await OrdersServices()
                                                      .editSuppliesOrderService(
                                                          widget.order.id,
                                                          widget
                                                              .order
                                                              .products[0]
                                                              .manufacturerId,
                                                          widget.order.products,
                                                          newCost,
                                                          newStatus,
                                                          locale);
                                              CustomSnackBar()
                                                  .showToast(response.message);
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pop(context);
                                            } catch (e) {
                                              if (kDebugMode) {
                                                print(e);
                                              }
                                            }
                                          },
                                    height: 40,
                                    width: 150,
                                    left: isArabic() ? 00 : 0,
                                    right: isArabic() ? 0 : 00,
                                    top: 5,
                                    bottom: 10,
                                    textSize: isArabic() ? 15 : 15,
                                    color: const Color.fromARGB(
                                        255, 104, 168, 221),
                                    textcolor:
                                        Theme.of(context).colorScheme.secondary,
                                    elevation: 0,
                                    child: isLoading
                                        ? SpinKitThreeInOut(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            size: 20,
                                          )
                                        : const Text(
                                            'Check Out',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
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
