// ignore_for_file: must_be_immutable, file_names
import 'package:buymore/Models/Manager/Distribution%20Center/CenterModel.dart';
import 'package:buymore/Screens/Manager/CenterDetailsScreen.dart';
import 'package:flutter/material.dart';

class CenterCard extends StatelessWidget {
  CenterCard({super.key, required this.center});
  CenterModel center;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CenterDetailsScreen(
                center: center,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 110,
              width: 250,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          center.name,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: -170,
            //   left: 20,
            //   right: 20,
            //   child: Center(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(5),
            //       child: Image.asset(
            //         center.image,
            //         height: 80,
            //         width: 110,
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
