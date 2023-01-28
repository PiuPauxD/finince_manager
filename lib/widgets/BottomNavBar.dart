import 'dart:math';

import 'package:finince_manager/pages/addPage.dart';
import 'package:finince_manager/pages/home_page.dart';
import 'package:finince_manager/pages/statistic.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int indexColor = 0;
  List Screen = [
    HomePage(),
    Stattistic(),
    HomePage(),
    Stattistic(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Addpage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 210, 138, 138),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 252, 162, 162),
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 0;
                  });
                },
                child: Icon(Icons.home,
                    size: 35,
                    color: indexColor == 0
                        ? const Color.fromARGB(255, 255, 196, 159)
                        : const Color.fromARGB(255, 204, 243, 205)),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 35,
                  color: indexColor == 1
                      ? const Color.fromARGB(255, 255, 196, 159)
                      : const Color.fromARGB(255, 204, 243, 205),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 35,
                  color: indexColor == 2
                      ? const Color.fromARGB(255, 255, 196, 159)
                      : const Color.fromARGB(255, 204, 243, 205),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 3;
                  });
                },
                child: Icon(
                  Icons.person_outline_outlined,
                  size: 35,
                  color: indexColor == 3
                      ? const Color.fromARGB(255, 255, 196, 159)
                      : const Color.fromARGB(255, 204, 243, 205),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
