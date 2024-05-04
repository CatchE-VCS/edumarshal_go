import 'package:edumarshal/features/subject_attendance/attendance_summary_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/theme/theme_controller.dart';
import '../dashboard/model/attendance_model.dart';
import 'controller/att_page_banner_ad_pod.dart';

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
  bool startAnimation = false;

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subject.name ?? "Subject",
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
                // reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  String attendance = "";
                  for (var element in _events[subjectAtt[index].absentDate]!) {
                    attendance += element.isAbsent ? "A" : "P";
                  }

                  return Consumer(builder: (context, ref, child) {
                    final currentTheme = ref.watch(themecontrollerProvider);
                    var brightness = MediaQuery.of(context).platformBrightness;
                    final isDarkMode = brightness == Brightness.dark;

                    return item(index, attendance, currentTheme, isDarkMode);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, ref, child) {
                final BannerAd myBanner = ref.watch(subAttBannerAdProvider);
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width -
                            myBanner.size.width.toDouble()) /
                        2,
                  ),
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          child: Consumer(
            builder: (context, ref, child) {
              final currentTheme = ref.watch(themecontrollerProvider);
              var brightness = MediaQuery.of(context).platformBrightness;
              bool isDarkMode = brightness == Brightness.dark;
              return FloatingActionButton.extended(
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
                  size: 32,
                ),
                backgroundColor: currentTheme == ThemeMode.dark
                    ? FlexColor
                        .schemes[FlexScheme.material]?.dark.primaryContainer
                    : currentTheme == ThemeMode.light
                        ? FlexColor
                            .schemes[FlexScheme.material]?.light.appBarColor
                        : isDarkMode
                            ? FlexColor.schemes[FlexScheme.material]?.dark
                                .primaryContainer
                            : FlexColor.schemes[FlexScheme.material]?.light
                                .appBarColor,
                label: Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AnimatedContainer item(
      int index, String attendance, ThemeMode currentTheme, bool isDarkMode) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      width: screenWidth,
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 24,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: currentTheme == ThemeMode.dark
            ? Colors.grey.shade900
            : currentTheme == ThemeMode.light
                ? Colors.grey.shade200
                : isDarkMode
                    ? Colors.grey.shade900
                    : Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${DateTime.parse(subjectAtt[index].absentDate.toString()).day}/${DateTime.parse(subjectAtt[index].absentDate.toString()).month}/${DateTime.parse(subjectAtt[index].absentDate.toString()).year}'
                .toString(),
            style: TextStyle(
              fontSize: 16,
              color: currentTheme == ThemeMode.dark
                  ? Colors.white
                  : currentTheme == ThemeMode.light
                      ? Colors.black
                      : isDarkMode
                          ? Colors.white
                          : Colors.black,
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
                    return const TextSpan(
                      text: 'P',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const TextSpan(
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
  }
}
