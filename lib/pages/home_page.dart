import 'package:finince_manager/data/addDate.dart';
import 'package:finince_manager/data/listdata.dart';
import 'package:finince_manager/data/utility.dart';
import 'package:finince_manager/pages/BottomNavBar.dart';
import 'package:finince_manager/pages/HistoryPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box<AddData>('data');
  final List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  var history;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 243, 205),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: ((context, value, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _head(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transactions history',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      history = box.values.toList()[index];
                      return getList(history, index);
                    },
                    childCount: box.length,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget getList(AddData history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get(index, history));
  }

  ListTile get(int index, AddData history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('img/${history.name}.png', height: 50),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '${day[history.dateTime.weekday - 1]} ${history.dateTime.day} - ${history.dateTime.month} - ${history.dateTime.year}',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontSize: 18,
          color: history.IN == "Income" ? Colors.green : Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

Widget _head() {
  return Stack(
    children: [
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 13, left: 15),
            height: 90,
            width: double.infinity,
            color: Color.fromARGB(255, 255, 196, 159),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Good Afternoon',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 93, 151, 94),
                      ),
                    ),
                    Text(
                      'NAME',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 93, 151, 94),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.account_circle,
                          size: 45,
                          color: Color.fromARGB(255, 93, 151, 94),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 325,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 330,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 255, 196, 159),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 196, 159),
                                offset: Offset(0, 6),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Balance',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 93, 151, 94),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 7),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      'BYN ${total()}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 93, 151, 94),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 204, 243, 205),
                                          radius: 15,
                                          child: Icon(
                                            Icons.arrow_downward,
                                            color: Color.fromARGB(
                                                255, 93, 151, 94),
                                          ),
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          'Income',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 93, 151, 94),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 204, 243, 205),
                                          radius: 15,
                                          child: Icon(
                                            Icons.arrow_upward,
                                            color: Color.fromARGB(
                                                255, 93, 151, 94),
                                          ),
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          'Expenses',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 93, 151, 94),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'BYN ${income()}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 93, 151, 94),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'BYN ${expenses()}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 93, 151, 94),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
