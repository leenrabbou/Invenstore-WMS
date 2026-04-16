// ignore_for_file: file_names

import 'package:buymore/Models/Manager/SideBarModel.dart';
import 'package:flutter/material.dart';

int isSelected = 0;

class SideBarDrawer extends StatefulWidget {
  const SideBarDrawer({super.key, required this.ontapped});
  final Function(int) ontapped;

  @override
  State<SideBarDrawer> createState() => _SideBarDrawerState();
}

class _SideBarDrawerState extends State<SideBarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: double.infinity,
          width: 550,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: SideBarModel(context).sideBarItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  title: Text(
                    SideBarModel(context).sideBarItems[index]["text"],
                    style: TextStyle(
                      color: isSelected == index
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                  ),
                  leading: Icon(
                    SideBarModel(context).sideBarItems[index]["icon"],
                    color: isSelected == index
                        ? Colors.white
                        : const Color.fromARGB(255, 104, 168, 221),
                  ),
                  onTap: () {
                    setState(() {
                      isSelected = index;
                    });

                    widget.ontapped(index);
                  },
                  tileColor: isSelected == index
                      ? const Color.fromARGB(255, 104, 168, 221)
                          .withOpacity(0.7)
                      : null,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
