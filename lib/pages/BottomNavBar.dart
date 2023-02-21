import 'package:finince_manager/pages/addPage.dart';

import 'package:finince_manager/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'HistoryPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List Screen = [
    HomePage(),
    Addpage(),
    HistoryPage(),
    Addpage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 255, 196, 159),
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 93, 151, 94),
        unselectedItemColor: Color.fromARGB(255, 204, 243, 205),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            label: 'Add',
            icon: Icon(Icons.add, size: 30),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon(Icons.history, size: 30),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.person, size: 30),
          ),
        ],
      ),
    );
  }
}
