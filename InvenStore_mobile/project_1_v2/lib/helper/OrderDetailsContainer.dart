// ignore_for_file: file_names

import 'package:project_1_v2/Models/Warehouse/Orders%20Models/OrderProductModel.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/material.dart';

class OrderDetailsContainer extends StatefulWidget {
  const OrderDetailsContainer({
    super.key,
    required this.isCart,
    required this.orderProduct,
  });

  final OrderProductModel orderProduct;
  final bool isCart;

  @override
  State<OrderDetailsContainer> createState() => _OrderDetailsContainerState();
}

class _OrderDetailsContainerState extends State<OrderDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderProduct.name,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.orderProduct.quantity} ${S().pieces}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.orderProduct.cost} ${S().syp}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              widget.isCart
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
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
              bottom: 15,
            ),
            child: Divider(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
