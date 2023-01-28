import 'package:finince_manager/data/addDate.dart';
import 'package:finince_manager/data/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  Chart({Key? key, required this.indexx}) : super(key: key);
  int indexx;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<AddData>? a;
  bool b = true;
  bool j = true;
  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today();
        b = true;
        j = true;
        break;
      case 1:
        a = week();
        b = false;
        j = true;
        break;
      case 2:
        a = month();
        b = false;
        j = true;
        break;
      case 3:
        a = year();
        j = false;
        break;
      default:
    }
    return Container(
      width: double.infinity,
      height: 250,
      child: SfCircularChart(
        legend: Legend(isVisible: true),
        series: <PieSeries<SalesData, String>>[
          PieSeries<SalesData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: <SalesData>[
              ...List.generate(
                time(a!, b ? true : false).length,
                (index) {
                  return SalesData(
                      j
                          ? b
                              ? a![index].dateTime.hour.toString()
                              : a![index].dateTime.day.toString()
                          : a![index].dateTime.month.toString(),
                      b
                          ? index > 0
                              ? time(a!, true)[index] +
                                  time(a!, true)[index - 1]
                              : time(a!, true)[index]
                          : index > 0
                              ? time(a!, false)[index] +
                                  time(a!, false)[index - 1]
                              : time(a!, false)[index]);
                },
              ),
            ],
            xValueMapper: (SalesData sales, _) => sales.cathegory,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.cathegory, this.sales);
  final String cathegory;
  final num sales;
}
