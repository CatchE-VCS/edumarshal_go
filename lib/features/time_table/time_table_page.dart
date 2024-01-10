import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Map<String, List<Map<String, String>>> mySelectedEvents = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    // loadPreviousEvents();
  }

  // loadPreviousEvents() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // String? eventsJson = prefs.getString('events');
  //   if (eventsJson != null) {
  //     setState(() {
  //       mySelectedEvents =
  //           (json.decode(eventsJson) as Map<String, dynamic>).map(
  //         (key, value) => MapEntry(
  //           key,
  //           (value as List<dynamic>)
  //               .map(
  //                 (item) => Map<String, String>.from(item),
  //               )
  //               .toList(),
  //         ),
  //       );
  //     });
  //   }
  // }

  saveEvents() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('events', json.encode(mySelectedEvents));
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventsDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Add new Events",
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('fill required fields'),
                  duration: Duration(seconds: 2),
                ));
                return;
              } else {
                if (kDebugMode) {
                  print(titleController.text);

                  print(descriptionController.text);
                }
                setState(() {
                  String selectedDate =
                      DateFormat('yyyy-MM-dd').format(_selectedDate!);

                  mySelectedEvents[selectedDate] ??= [];

                  mySelectedEvents[selectedDate]!.add({
                    "eventTitle": titleController.text,
                    "eventDescription": descriptionController.text,
                  });

                  saveEvents(); // Save events to shared preferences
                });

                if (kDebugMode) {
                  print('new Event is ${json.encode(mySelectedEvents)} ');
                }

                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
                return;
              }
            },
            child: const Text('Add Event'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.blue),
                weekNumberTextStyle: TextStyle(color: Colors.red),
                weekendTextStyle: TextStyle(color: Colors.pink),
              ),
              focusedDay: _focusedDay,
              // focus current day
              firstDay: DateTime(DateTime.now().year - 1),
              lastDay: DateTime(DateTime.now().year + 1),
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDate, selectedDay)) {
                  // call set state to update the selected day
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _listOfDayEvents,
            ),
            ..._listOfDayEvents(_selectedDate!).map((myEvent) => ListTile(
                  leading: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text('EventTitle:   ${myEvent['eventTitle']}'),
                  ),
                  subtitle:
                      Text('Description :   ${myEvent['eventDescription']}'),
                )),
            const SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                _showAddEventsDialog();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "add events",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
