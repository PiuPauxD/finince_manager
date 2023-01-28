import 'package:finince_manager/data/addDate.dart';
import 'package:finince_manager/data/listdata.dart';
import 'package:finince_manager/data/utility.dart';
import 'package:finince_manager/widgets/ChartWidget.dart';
import 'package:flutter/material.dart';

import '../data/top.dart';
import '../widgets/ChartWidget.dart';

class Stattistic extends StatefulWidget {
  const Stattistic({super.key});

  @override
  State<Stattistic> createState() => _StattisticState();
}

class _StattisticState extends State<Stattistic> {
  List day = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  List f = [today(), week(), month(), year()];
  List<AddData> a = [];
  ValueNotifier kj = ValueNotifier(0);
  int indexColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 243, 205),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: ((context, dynamic value, child) {
            a = f[value];
            return custom();
          }),
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Statistic',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 151, 94),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        4,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                indexColor = index;
                                kj.value = index;
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: indexColor == index
                                    ? const Color.fromARGB(255, 255, 196, 159)
                                    : const Color.fromARGB(255, 204, 243, 205),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: indexColor == index
                                      ? const Color.fromARGB(255, 204, 243, 205)
                                      : const Color.fromARGB(
                                          255, 255, 196, 159),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Expanses',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 93, 151, 94),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_downward_sharp,
                              color: Color.fromARGB(255, 93, 151, 94),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 93, 151, 94),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Chart(
                  indexx: indexColor,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Spending',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //add more spending and less spending
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('img/${a[index].name}.png', height: 50),
              ),
              title: Text(
                a[index].name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${a[index].dateTime.weekday - 1} ${a[index].dateTime.day} - ${a[index].dateTime.month} - ${a[index].dateTime.year}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text(
                a[index].amount,
                style: TextStyle(
                  fontSize: 18,
                  color: a[index].IN == "Income" ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
          childCount: a.length,
        ))
      ],
    );
  }
}
