// ignore_for_file: file_names

import 'package:project_1_v2/Screens/MainScreen.dart';
import 'package:project_1_v2/Screens/ProfileScreen.dart';
import 'package:project_1_v2/Screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    const ProfileScreen(isBar: true),
    MainScreen(),
    const SettingsScreen(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        color: Theme.of(context).colorScheme.background,
        height: 60,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 30,
            color: const Color.fromARGB(255, 95, 169, 230).withOpacity(0.8),
          ),
          Icon(
            Icons.home,
            size: 30,
            color: const Color.fromARGB(255, 95, 169, 230).withOpacity(0.8),
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: const Color.fromARGB(255, 95, 169, 230).withOpacity(0.8),
          ),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        letIndexChange: (value) => true,
      ),
      body: screens[pageIndex],
    );
  }
}
