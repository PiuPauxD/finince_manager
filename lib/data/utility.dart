import 'dart:developer';

import 'package:finince_manager/data/addDate.dart';
import 'package:hive/hive.dart';

num totals = 0;

final box = Hive.box<AddData>('data');

num total() {
  var secondHistory = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < secondHistory.length; i++) {
    a.add(secondHistory[i].IN == 'income'
        ? double.parse(secondHistory[i].amount)
        : double.parse(secondHistory[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

num income() {
  var secondHistory = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < secondHistory.length; i++) {
    a.add(secondHistory[i].IN == 'income'
        ? double.parse(secondHistory[i].amount)
        : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

num expenses() {
  var secondHistory = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < secondHistory.length; i++) {
    a.add(secondHistory[i].IN == 'income'
        ? 0
        : double.parse(secondHistory[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<AddData> today() {
  List<AddData> a = [];
  var secondHistory = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < secondHistory.length; i++) {
    if (secondHistory[i].dateTime.day == date.day) {
      a.add(secondHistory[i]);
    }
  }
  return a;
}

List<AddData> week() {
  List<AddData> a = [];
  var secondHistory = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < secondHistory.length; i++) {
    if (date.day - 7 <= secondHistory[i].dateTime.day &&
        secondHistory[i].dateTime.day <= date.day) {
      a.add(secondHistory[i]);
    }
  }
  return a;
}

List<AddData> month() {
  List<AddData> a = [];
  var secondHistory = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < secondHistory.length; i++) {
    if (secondHistory[i].dateTime.month == date.month) {
      a.add(secondHistory[i]);
    }
  }
  return a;
}

List<AddData> year() {
  List<AddData> a = [];
  var secondHistory = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < secondHistory.length; i++) {
    if (secondHistory[i].dateTime.year == date.year) {
      a.add(secondHistory[i]);
    }
  }
  return a;
}

num totalChart(List<AddData> secondHistory) {
  List a = [0, 0];
  for (var i = 0; i < secondHistory.length; i++) {
    a.add(secondHistory[i].IN == 'income'
        ? double.parse(secondHistory[i].amount)
        : double.parse(secondHistory[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<AddData> secondHistory, bool hour) {
  List<AddData> a = [];
  List total = [0, 0];
  int counter = 0;
  for (var c = 0; c < secondHistory.length; c++) {
    for (var i = c; i < secondHistory.length; i++) {
      if (hour) {
        if (secondHistory[i].dateTime.hour == secondHistory[c].dateTime.hour) {
          a.add(secondHistory[i]);
          counter = i;
        }
      } else {
        if (secondHistory[i].dateTime.day == secondHistory[c].dateTime.day) {
          a.add(secondHistory[i]);
          counter = i;
        }
      }
    }
    total.add(totalChart(a));
    a.clear();
    c = counter;
  }
  return total;
}
