// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class CentersScreen extends StatelessWidget {
  CentersScreen({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SearchTextField(
          searchController: _searchController,
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 100,
                left: isArabic() ? 100 : 0),
            child: TextButton(
              onPressed: () {
                ShowDialog2().centersDialog(context, text: S().addCenter);
              },
              child: Text(
                S().addCenter,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
            height: 700,
            width: 1200,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GridView.builder(
                    //     scrollDirection: Axis.vertical,
                    //     physics: const ScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate:
                    //         const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 6,
                    //       childAspectRatio: 1.2 / 1,
                    //     ),
                    //     itemCount: 20,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return CenterCard(
                    //         center:
                    //           //  CenterModel('Phenix', 'images/analgesic.jpg'),
                    //       );
                    //     }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
