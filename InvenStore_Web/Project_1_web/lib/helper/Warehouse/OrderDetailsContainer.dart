// ignore_for_file: file_names

import 'package:buymore/Models/Warehouse/Orders%20Models/OrderProductModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Warehouse/OrderShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class OrderDetailsContainer extends StatefulWidget {
  const OrderDetailsContainer(
      {super.key,
      required this.isEdit,
      required this.orderProduct,
      required this.quantity,
      required this.index,
      required this.products,
      required this.onDelete});

  final OrderProductModel orderProduct;
  final int quantity;
  final bool isEdit;
  final int index;
  final List<OrderProductModel> products;
  final VoidCallback onDelete;

  @override
  State<OrderDetailsContainer> createState() => _OrderDetailsContainerState();
}

class _OrderDetailsContainerState extends State<OrderDetailsContainer> {
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
                  width: 130,
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
                  width: 130,
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
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.orderProduct.expirationDate != null
                            ? widget.orderProduct.expirationDate!
                            : '',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.orderProduct.cost} ${S().syp}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.isEdit
                    ? IconButton(
                        onPressed: () async {
                          OrderShowDialog dialog = OrderShowDialog();
                          Map<String, dynamic> data =
                              await dialog.editProductForOrderDialog(context);

                          widget.products.removeAt(widget.index);
                          setState(() {
                            widget.orderProduct.expirationDate = data['date'] ??
                                widget.orderProduct.expirationDate;
                            widget.orderProduct.quantity =
                                data['quantity'] ?? widget.quantity;
                          });
                          widget.products.add(
                            OrderProductModel(
                              image: widget.orderProduct.image,
                              name: widget.orderProduct.name,
                              quantity: widget.orderProduct.quantity,
                              cost: widget.orderProduct.cost,
                              description: widget.orderProduct.description,
                              descriptionAr: widget.orderProduct.descriptionAr,
                              descriptionEn: widget.orderProduct.descriptionEn,
                              expirationDate:
                                  widget.orderProduct.expirationDate,
                              manufacturer: widget.orderProduct.manufacturer,
                              id: widget.orderProduct.id,
                              nameAr: widget.orderProduct.nameAr,
                              nameEn: widget.orderProduct.nameEn,
                              productId: widget.orderProduct.productId,
                              subcategory: widget.orderProduct.subcategory,
                              subcategoryId: widget.orderProduct.subcategoryId,
                              manufacturerId:
                                  widget.orderProduct.manufacturerId,
                            ),
                          );
                        },
                        tooltip: S().edit,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.isEdit
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
