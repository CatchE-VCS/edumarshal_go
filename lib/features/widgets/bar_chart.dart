import 'package:edumarshal/shared/extension/logger_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../subject_attendance/attendance_summary_page.dart';

class BarChartSample2 extends StatefulWidget {
  final Map<DateTime, List<AttendanceEntry>> events;
  final Map<int, double> map;
  final int maxY;
  final double aR;
  final Color leftBarColor;
  final Color rightBarColor;
  final Color avgColor;

  const BarChartSample2({
    super.key,
    required this.events,
    required this.map,
    this.maxY = 11,
    this.aR = 2.0,
    required this.rightBarColor,
    this.avgColor = Colors.orangeAccent,
    this.leftBarColor = Colors.redAccent,
  });

  @override
  State<BarChartSample2> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  final List<String> titles = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    // BarChartGroupData barGroup1 = makeGroupData(0, 5, 12);
    // BarChartGroupData  barGroup2 = makeGroupData(1, 16, 12);
    // BarChartGroupData  barGroup3 = makeGroupData(2, 18, 5);
    // BarChartGroupData  barGroup4 = makeGroupData(3, 20, 16);
    // BarChartGroupData barGroup5 = makeGroupData(4, 17, 6);
    // BarChartGroupData barGroup6 = makeGroupData(5, 19, 1.5);
    // BarChartGroupData barGroup7 = makeGroupData(6, 10, 1.5);

    List<BarChartGroupData> items = [];
    int k = 0;
    for (int i = widget.events.length - 1; i >= 0; i--) {
      DateTime x = widget.events.keys.elementAt(i);
      titles.add("${x.day}/${x.month}");
      int absentCount = 0;
      for (var e in widget.events[x]!) {
        if (e.isAbsent) absentCount++;
      }
      Map<int, double> map = widget.map;
      // widget.rightBarColor == Colors.green ? "Green".logInfo : "GreenAccent".logInfo;
      items.insert(
          0,
          makeGroupData(k++, map[absentCount]!,
              map[widget.events[x]!.length - absentCount]!));

      if (k == 7) break;
    }
    // for (var element in widget.events.entries) {
    //
    //   DateTime x = element.key;
    //   titles.add("${x.day}/${x.month}");
    //   int absentCount = 0;
    //   for(var e in element.value) {
    //     if(e.isAbsent) absentCount++;
    //   }
    //   Map<int,double> map = widget.map;
    //   items.insert(0, makeGroupData(k++,map[absentCount]! , map[element.value.length-absentCount]!));
    //
    //   if(k == 7) break;
    // }

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> items = [];
    int k = 0;
    for (int i = widget.events.length - 1; i >= 0; i--) {
      DateTime x = widget.events.keys.elementAt(i);
      titles.add("${x.day}/${x.month}");
      int absentCount = 0;
      for (var e in widget.events[x]!) {
        if (e.isAbsent) absentCount++;
      }
      Map<int, double> map = widget.map;
      // widget.rightBarColor == Colors.green ? "Green".logInfo : "GreenAccent".logInfo;
      items.insert(
          0,
          makeGroupData(k++, map[absentCount]!,
              map[widget.events[x]!.length - absentCount]!));

      if (k == 7) break;
    }
    // for (var element in widget.events.entries) {
    //
    //   DateTime x = element.key;
    //   titles.add("${x.day}/${x.month}");
    //   int absentCount = 0;
    //   for(var e in element.value) {
    //     if(e.isAbsent) absentCount++;
    //   }
    //   Map<int,double> map = widget.map;
    //   items.insert(0, makeGroupData(k++,map[absentCount]! , map[element.value.length-absentCount]!));
    //
    //   if(k == 7) break;
    // }

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    return AspectRatio(
      aspectRatio: widget.aR,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: widget.maxY.toDouble(),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return Colors.grey;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = '0';
    bool found = false;
    // print("Value = $value");
    for (var element in widget.map.entries) {
      if (element.value.floor() == value) {
        found = true;
        text = '${element.key}';
        break;
      }
    }
    if (!found) return Container();
    // if (value == 1) {
    //   text = '0';
    // } else if (value == 6) {
    //   text = '1';
    // } else if (value == 11) {
    //   text = '2';
    // } else {
    //   return Container();
    // }
    // print("built widget for $text");
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    if (y1 == 0) y1 = 1;
    if (y2 == 0) y2 = 1;
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
