// // ignore_for_file: file_names

// import 'package:buymore/Screens/Warehouse/OrderScreen.dart';
// import 'package:buymore/generated/l10n.dart';
// import 'package:buymore/helper/Manager/Custom%20Widgets/SearchTextField.dart';
// import 'package:flutter/material.dart';

// class AllOrdersScreen extends StatefulWidget {
//   const AllOrdersScreen({super.key});
// //////////////////////////////////////////////
//   @override
//   State<AllOrdersScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<AllOrdersScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 7,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Theme.of(context).colorScheme.background,
//           title: Row(
//             children: [
//               SearchTextField(
//                 searchController: _searchController,
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.filter_list,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //       top: 10.0,
//             //       right: isArabic() ? 0 : 100,
//             //       left: isArabic() ? 100 : 0),
//             //   child: TextButton(
//             //     onPressed: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (BuildContext context) {
//             //             return WarehousesScreen(
//             //               isCart: true,
//             //             );
//             //           },
//             //         ),
//             //       );
//             //     },
//             //     child: Text(
//             //       S().createOrder,
//             //       style: TextStyle(
//             //           color: Theme.of(context).colorScheme.onPrimary,
//             //           fontSize: 15),
//             //     ),
//             //   ),
//             // ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(30.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: TabBar(
//                 unselectedLabelColor:
//                     Theme.of(context).colorScheme.onBackground,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 isScrollable: true,
//                 padding: EdgeInsets.zero,
//                 indicatorPadding: EdgeInsets.zero,
//                 labelPadding: EdgeInsets.zero,
//                 indicatorColor: const Color.fromARGB(255, 104, 168, 221),
//                 tabs: [
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().all,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().pending,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().underPreparing,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().canceled,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().deleted,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().underShipping,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: Tab(
//                       child: Text(
//                         S().delievered,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.onBackground),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrderScreen(
//               ordersType: 1,
//             ),
//             OrderScreen(
//               ordersType: 2,
//             ),
//             OrderScreen(
//               ordersType: 3,
//             ),
//             OrderScreen(
//               ordersType: 1,
//             ),
//             OrderScreen(
//               ordersType: 2,
//             ),
//             OrderScreen(
//               ordersType: 3,
//             ),
//             OrderScreen(
//               ordersType: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
