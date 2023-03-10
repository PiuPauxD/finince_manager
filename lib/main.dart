import 'package:finince_manager/data/addDate.dart';
import 'package:finince_manager/pages/BottomNavBar.dart';
import 'package:finince_manager/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddDataAdapter());
  await Hive.openBox<AddData>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Finace manager',
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    );
  }
}
