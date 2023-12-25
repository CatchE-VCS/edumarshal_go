import 'package:edumarshal/models/attendance_model.dart';
import 'package:edumarshal/screens/subject_attendance/attendance_summary_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectAttendanceScreen extends StatefulWidget {
  final Subject subject;
  final AttendanceData? attendanceData;

  const SubjectAttendanceScreen(
      {super.key, required this.attendanceData, required this.subject});

  @override
  State<SubjectAttendanceScreen> createState() =>
      _SubjectAttendanceScreenState();
}

class _SubjectAttendanceScreenState extends State<SubjectAttendanceScreen> {
  // String capitalizeFirstLetters(String input) {
  late DateTime _firstDay;
  late DateTime _lastDay;

  // late Offset _offset;
  late Map<DateTime, List<AttendanceEntry>> _events;
  final List<AttendanceDatum> subjectAtt = [];
  final List<AttendanceCopy> extraLecture = [];

  @override
  initState() {
    super.initState();
    // _offset = const Offset(0.0, 0.0);
    for (var element in widget.attendanceData!.attendanceData) {
      if (element.subjectId == widget.subject.id) {
        subjectAtt.add(element);
      }
    }
    for (var element in widget.attendanceData!.extraLectures) {
      if (element.subjectId == widget.subject.id) {
        extraLecture.add(element);
      }
    }

    _firstDay = subjectAtt[0].absentDate;
    _lastDay = subjectAtt[subjectAtt.length - 1].absentDate;
    subjectAtt.sort((a, b) => a.absentDate.compareTo(b.absentDate));
    extraLecture.sort((a, b) => a.absentDate.compareTo(b.absentDate));
    _events = {};
    for (var element in subjectAtt) {
      _events[element.absentDate] = [
        AttendanceEntry(isAbsent: element.isAbsent),
      ];
    }
    for (var element in extraLecture) {
      if (_events.containsKey(element.absentDate)) {
        _events[element.absentDate]!.add(
          AttendanceEntry(isAbsent: element.isAbsent),
        );
      } else {
        _events[element.absentDate] = [
          AttendanceEntry(isAbsent: element.isAbsent),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.subject.name),
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
                      widget.subject.totalLeactures.toString(),
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
                      widget.subject.presentLeactures.toString(),
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
                      widget.subject.percentageAttendance.toString(),
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
                itemCount: subjectAtt.length,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  String attendance = "";
                  for (var element in _events[subjectAtt[index].absentDate]!) {
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
                          '${DateTime.parse(subjectAtt[index].absentDate.toString()).day}/${DateTime.parse(subjectAtt[index].absentDate.toString()).month}/${DateTime.parse(subjectAtt[index].absentDate.toString()).year}'
                              .toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: List.generate(
                              attendance.length,
                              (index) {
                                if (attendance[index] == 'P') {
                                  return TextSpan(
                                    text: 'P',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return TextSpan(
                                    text: 'A',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
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
