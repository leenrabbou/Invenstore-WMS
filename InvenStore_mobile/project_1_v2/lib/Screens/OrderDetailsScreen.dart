// ignore_for_file: file_names, must_be_immutable

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Orders%20Models/AnOrderModel.dart';
import 'package:project_1_v2/Services/Warehouse/OrdersServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/DetailsContainer.dart';
import 'package:project_1_v2/helper/OrderProductsCard.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({super.key, required this.order});

  AnOrderModel order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isAccepted = false;
  bool isRejected = false;
  bool isCanceled = false;
  bool isDeleted = false;
  bool isRecieved = false;
  String deleteText = S().delete;
  String recieveText = S().recieve;
  bool isLoadingDelete = false;
  bool isLoadingRecieve = false;
  Future<void> _onRefresh() async {
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final newData = await OrdersServices().showAnOrderService(
        widget.order.id,
        locale,
      );
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S.of(context).orderDetails,
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
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: isArabic() ? 340 : 330,
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
                                  DetailsContainer(
                                    title: S().orderId,
                                    text: widget.order.orderNum,
                                    height: 50,
                                    width: 170,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            widget.order.statusId == 1 ||
                                                widget.order.statusId == 4 ||
                                                widget.order.statusId == 6
                                            ? const Color.fromARGB(
                                                144,
                                                40,
                                                165,
                                                214,
                                              )
                                            : widget.order.statusId == 2 ||
                                                  widget.order.statusId == 3 ||
                                                  widget.order.statusId == 5
                                            ? const Color.fromARGB(
                                                144,
                                                206,
                                                49,
                                                38,
                                              )
                                            : const Color.fromARGB(
                                                144,
                                                40,
                                                214,
                                                63,
                                              ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      width: 130,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          widget.order.status,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              DetailsContainer(
                                title: S().orderedFrom,
                                text: widget.order.orderedFrom,
                                height: 50,
                                width: 170,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  DetailsContainer(
                                    title: S().address,
                                    text: widget.order.orderedFromAddress,
                                    height: 50,
                                    width: 160,
                                  ),
                                  const SizedBox(width: 10),
                                  DetailsContainer(
                                    title: S().orderData,
                                    text: widget.order.orderedAt,
                                    height: 50,
                                    width: 170,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  DetailsContainer(
                                    title: S().cost,
                                    text: widget.order.orderCost.toString(),
                                    height: 50,
                                    width: 160,
                                  ),
                                  const SizedBox(width: 10),
                                  DetailsContainer(
                                    title: S().shippingCost,
                                    text: widget.order.shippingCost.toString(),
                                    height: 50,
                                    width: 170,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: isArabic() ? 0 : 5,
                                  right: isArabic() ? 5 : 0,
                                  top: 2,
                                  bottom: 2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(height: 2),
                                    FittedBox(
                                      child: Text(
                                        widget.order.totalCost.toString(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.order.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderProductsCard(
                          product: widget.order.products[index],
                        );
                      },
                    ),
                  ],
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
                  widget.order.statusId == 1
                      ? CustomElevatedButton(
                          onPressed: () async {
                            final locale = Provider.of<LocalizationProvider>(
                              context,
                              listen: false,
                            ).language!;
                            setState(() {
                              isDeleted = true;
                              deleteText = S().deleted;
                            });
                            _onRefresh();
                            try {
                              await OrdersServices().deleteBuyOrdersService(
                                widget.order.id,
                                locale,
                              );
                            } catch (e) {
                              if (kDebugMode) {
                                print(e);
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
                          color: isDeleted
                              ? Colors.grey
                              : const Color.fromARGB(198, 221, 51, 39),
                          textcolor: Theme.of(context).colorScheme.secondary,
                          elevation: isDeleted ? 0 : 5,
                          child: isLoadingDelete
                              ? SpinKitThreeInOut(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
                                  size: 20,
                                )
                              : Text(
                                  deleteText,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 20),
                  widget.order.statusId == 6
                      ? CustomElevatedButton(
                          onPressed: isLoadingRecieve
                              ? () {}
                              : () async {
                                  final locale =
                                      Provider.of<LocalizationProvider>(
                                        context,
                                        listen: false,
                                      ).language!;
                                  setState(() {
                                    isLoadingRecieve = true;
                                    isRecieved = true;
                                    recieveText = S().recieved;
                                  });
                                  _onRefresh();
                                  try {
                                    await OrdersServices()
                                        .recieveBuyOrdersService(
                                          widget.order.id,
                                          locale,
                                        );
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  }
                                  setState(() {
                                    isLoadingRecieve = false;
                                  });
                                },
                          height: 50,
                          width: 200,
                          left: isArabic() ? 00 : 0,
                          right: isArabic() ? 0 : 00,
                          top: 5,
                          bottom: 10,
                          textSize: isArabic() ? 15 : 15,
                          color: isRecieved
                              ? Colors.grey
                              : const Color.fromARGB(255, 29, 104, 165),
                          textcolor: Theme.of(context).colorScheme.secondary,
                          elevation: isRecieved ? 0 : 5,
                          child: isLoadingRecieve
                              ? SpinKitThreeInOut(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
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
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
