// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Models/Warehouse/Destruction%20Models/DestructionModel.dart';
import 'package:buymore/Screens/Warehouse/DestructionDetailsScreen.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class DestructionContainer extends StatefulWidget {
  const DestructionContainer({
    super.key,
    required this.destruction,
  });
  final DestructionModel destruction;

  @override
  State<DestructionContainer> createState() => _DestructionContainerState();
}

class _DestructionContainerState extends State<DestructionContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 50 : 30,
        right: isArabic() ? 30 : 50,
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DestructionDetailsScreen(
                    destruction: widget.destruction);
              },
            ),
          );
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            height: 90,
            width: 1000,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.destruction.destructionNum,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    widget.destruction.destructionedByName,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 195,
                  child: Text(
                    widget.destruction.product.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    widget.destruction.destructionedAt == null
                        ? '--'
                        : widget.destruction.destructionedAt!.substring(0, 10),
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    widget.destruction.quantity.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.destruction.cause,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
