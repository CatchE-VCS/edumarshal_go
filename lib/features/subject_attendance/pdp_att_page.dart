import 'package:edumarshal/features/subject_attendance/attendance_summary_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard/model/pdp_att_model.dart';

class PDPAttendanceScreen extends StatefulWidget {
  final List<PDPAttendanceData?> attendanceData;
  final int presentLectures;
  final double percentageAttendance;

  const PDPAttendanceScreen(
      {super.key,
      required this.attendanceData,
      required this.presentLectures,
      required this.percentageAttendance});

  @override
  State<PDPAttendanceScreen> createState() => _PDPAttendanceScreenState();
}

class _PDPAttendanceScreenState extends State<PDPAttendanceScreen> {
  late DateTime _firstDay;
  late DateTime _lastDay;
  late Map<DateTime, List<AttendanceEntry>> _events;

  @override
  initState() {
    super.initState();
    // _offset = const Offset(0.0, 0.0);
    _events = {};
    if (widget.attendanceData.isNotEmpty) {
      for (var element in widget.attendanceData) {
        if (_events.containsKey(element!.attendanceDate)) {
          _events[element.attendanceDate]!.add(
            AttendanceEntry(isAbsent: element.isInAbsent),
          );
        } else {
          _events[element.attendanceDate] = [
            AttendanceEntry(isAbsent: element.isInAbsent),
          ];
        }
      }
      widget.attendanceData
          .sort((a, b) => a!.attendanceDate.compareTo(b!.attendanceDate));
      _firstDay = widget.attendanceData[0]!.attendanceDate;
      _lastDay = widget
          .attendanceData[widget.attendanceData.length - 1]!.attendanceDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PDP Attendance",
          style: TextStyle(
            // fontSize: 24,
            // fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // OverView
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Total Classes",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    Text(
                      widget.attendanceData.length.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Attended",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    Text(
                      widget.presentLectures.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Percentage",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    Text(
                      widget.percentageAttendance.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Attendance History",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _events.length,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  String attendance = "";
                  for (var element in _events[_events.keys.elementAt(index)]!) {
                    attendance += element.isAbsent ? "A" : "P";
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 183, 146, 247),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${DateTime.parse(_events.keys.elementAt(index).toString()).day}/${DateTime.parse(_events.keys.elementAt(index).toString()).month}/${DateTime.parse(_events.keys.elementAt(index).toString()).year}'
                              .toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          attendance,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttendanceSummaryPage(
                entries: _events,
                firstDay: _firstDay,
                lastDay: _lastDay,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.calendar_month_sharp,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 183, 146, 247),
        label: Text(
          "Summary",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
    );
  }
}
