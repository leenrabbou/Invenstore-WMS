// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Models/Warehouse/AllProduct%20Model/AllProductModel.dart';
import 'package:buymore/Models/Warehouse/Orders%20Models/SuppliesOrderData.dart';
import 'package:buymore/Screens/Warehouse/Products/AllProductDetailsScreen.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Warehouse/OrderShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class OrderContainerCart extends StatefulWidget {
  OrderContainerCart({
    super.key,
    required this.isCart,
    required this.orderProduct,
    required this.quantity,
    required this.expiredDate,
    required this.index,
    required this.onDelete,
  });

  final AllProductModel orderProduct;
  int quantity;
  final bool isCart;
  String? expiredDate;
  final int index;
  final VoidCallback onDelete;

  @override
  State<OrderContainerCart> createState() => _OrderDetailsContainerState();
}

class _OrderDetailsContainerState extends State<OrderContainerCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 30 : 30,
        right: isArabic() ? 30 : 30,
      ),
      child: Container(
        height: 131,
        width: 750,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: widget.orderProduct.image == null
                        ? Image.asset(
                            'images/analgesic.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            '$imageUrl/${widget.orderProduct.image!}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderProduct.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.quantity} Pieces',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expiredDate != null ? widget.expiredDate! : '--',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.orderProduct.price} SYP',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    OrderShowDialog dialog = OrderShowDialog();
                    Map<String, dynamic> data =
                        await dialog.editProductForOrderDialog(context);

                    suppliesOrderList.removeAt(widget.index);
                    setState(() {
                      widget.expiredDate = data['date'] ?? widget.expiredDate;
                      widget.quantity = data['quantity'] ?? widget.quantity;
                    });
                    suppliesOrderList.add(
                      SuppliesOrderData(
                          product: widget.orderProduct,
                          quantity: widget.quantity,
                          exDate: widget.expiredDate),
                    );
                  },
                  tooltip: S().edit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ),
                widget.isCart
                    ? IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 15,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: isArabic() ? 0 : 100,
                  left: isArabic() ? 100 : 0,
                  bottom: 15),
              child: Divider(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
