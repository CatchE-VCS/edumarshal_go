import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// @RoutePage(
//   deferredLoading: true,
// )
class AttendanceSummaryPage extends StatefulWidget {
  const AttendanceSummaryPage({
    super.key,
    required this.entries,
    required this.firstDay,
    required this.lastDay,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final Map<DateTime, List<AttendanceEntry>> entries;

  // final List<AttendanceDatum> subjectAtt;
  // final List<AttendanceCopy> extraLecture;

  @override
  State<AttendanceSummaryPage> createState() => _AttendanceSummaryPageState();
}

class AttendanceEntry {
  final bool isAbsent;

  AttendanceEntry({
    required this.isAbsent,
  });
}

class _AttendanceSummaryPageState extends State<AttendanceSummaryPage> {
  late DateTime _selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.lastDay;

    // for (var element in widget.subjectAtt) {
    //   _events[element.absentDate] = [
    //     AttendanceEntry(isAbsent: element.isAbsent),
    //   ];
    // }
    // for (var element in widget.extraLecture) {
    //   if (_events.containsKey(element.absentDate)) {
    //     _events[element.absentDate]!.add(
    //       AttendanceEntry(isAbsent: element.isAbsent),
    //     );
    //   } else {
    //     _events[element.absentDate] = [
    //       AttendanceEntry(isAbsent: element.isAbsent),
    //     ];
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attendance Summary",
          style: TextStyle(
            fontSize: 24,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Calendar View
          TableCalendar(
            // rowHeight: 75,
            availableCalendarFormats: const {
              CalendarFormat.month: "Month",
              CalendarFormat.week: "Week",
            },
            selectedDayPredicate: (day) {
              return isSameDay(
                  _selectedDate == widget.lastDay ? null : _selectedDate, day);
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  List<AttendanceEntry> e = events as List<AttendanceEntry>;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < e.length; i++) ...[
                        if (e[i].isAbsent)
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.all(2),
                          )
                        else
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.all(2),
                          )
                      ]
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            firstDay: DateTime.utc(widget.firstDay.year, widget.firstDay.month,
                widget.firstDay.day),
            lastDay: DateTime.utc(
                widget.lastDay.year, widget.lastDay.month, widget.lastDay.day),
            focusedDay: DateTime.utc(
                _selectedDate.year, _selectedDate.month, _selectedDate.day),
            calendarFormat: _calendarFormat,
            headerStyle: HeaderStyle(
              leftChevronVisible: false,
              rightChevronVisible: false,
              formatButtonVisible: false,
              titleCentered: true,
              headerMargin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).devicePixelRatio * 32,
                vertical: 32,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMM(locale).format(date),
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
              ),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: Colors.red,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              // weekendDecoration: const BoxDecoration(
              //   shape: BoxShape.circle,
              //   color: Colors.white,
              // ),
              holidayTextStyle: TextStyle(
                color: Colors.pinkAccent,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.blue,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: Colors.pinkAccent,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 10,
              ),
              weekdayStyle: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 10,
              ),
            ),
            eventLoader: (day) {
              List<AttendanceEntry> events = [];
              widget.entries
                  .map((key, value) => MapEntry(key, value))
                  .forEach((key, value) {
                print(key);
                if (key.year == day.year &&
                    key.month == day.month &&
                    key.day == day.day) {
                  for (var i = 0; i < value.length; i++) {
                    events.add(value[i]);
                  }
                }
              });

              if (events.isEmpty) {
                return <AttendanceEntry>[];
              }
              return events;
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // call set state to update the selected day
                setState(() {
                  _selectedDate = selectedDay;
                });
              } else {
                setState(() {
                  _selectedDate = widget.lastDay;
                });
              }
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // _events[_selectedDate] == null
          //     ? const Text(
          //         "No Lectures",
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       )
          //     : _events[_selectedDate]!.length == 1
          //         ? const Text(
          //             "Lecture",
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           )
          //         : const Text(
          //             "Lectures",
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //
          // const SizedBox(
          //   height: 20,
          // ),
          // const Text(
          //   "Extra Lectures",
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: widget.extraLecture.length,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 20, vertical: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Text(
          //               widget.extraLecture[index].toString(),
          //               style: const TextStyle(
          //                 fontSize: 20,
          //               ),
          //             ),
          //             Text(
          //               widget.extraLecture[index].toString(),
          //               style: const TextStyle(
          //                 fontSize: 20,
          //               ),
          //             ),
          //             Text(
          //               widget.extraLecture[index].toString(),
          //               style: const TextStyle(
          //                 fontSize: 20,
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(DiagnosticsProperty<Map<DateTime, List<AttendanceDatum>>>(
//       '_events', _events));
// }
}
