import 'package:finince_manager/data/addDate.dart';
import 'package:finince_manager/data/utility.dart';
import 'package:finince_manager/pages/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
  ValueNotifier kj = ValueNotifier(0);
  int indexColor = 0;
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
                  child: head(),
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

Stack head() {
  return Stack(
    children: [
      Container(
        height: 80,
        width: double.infinity,
        color: Color.fromARGB(255, 255, 196, 159),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Transcription history',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 93, 151, 94),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
