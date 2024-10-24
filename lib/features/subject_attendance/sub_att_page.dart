import 'package:edumarshal/features/subject_attendance/attendance_summary_page.dart';
import 'package:edumarshal/shared/extension/logger_extension.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../const/config.dart';
import '../../core/theme/theme_controller.dart';
import '../dashboard/model/attendance_model.dart';
import '../widgets/bar_chart.dart';
import 'controller/att_page_banner_ad_pod.dart';

class SubjectAttendanceScreen extends StatefulWidget {
  final Subject subject;
  final AttendanceData? attendanceData;
  final int index;

  const SubjectAttendanceScreen({
    super.key,
    required this.attendanceData,
    required this.subject,
    required this.index,
  });

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

  final List<String?> adsBannerId = [
    Config.bannerAdID2,
    Config.bannerAdID6,
    Config.bannerAdID7,
    Config.bannerAdID8,
    Config.bannerAdID9,
    Config.bannerAdID10,
    Config.bannerAdID11,
    Config.bannerAdID12,
    Config.bannerAdID13,
    Config.bannerAdID14,
  ];

  @override
  initState() {
    super.initState();
    if (widget.attendanceData == null) {
      return;
    } else if (widget.attendanceData!.attendanceData.isEmpty) {
      return;
    }
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
    subjectAtt.sort(
      (a, b) => a.absentDate.compareTo(b.absentDate),
    );
    extraLecture.sort(
      (a, b) => a.absentDate.compareTo(b.absentDate),
    );
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
          AttendanceEntry(
            isAbsent: element.isAbsent,
          ),
        ];
      }
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(
          () {
            startAnimation = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (subjectAtt.isEmpty) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "No attendance data found",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ref
                      .watch(subAttBannerAdProvider(
                          adsBannerId[widget.index % 10]))
                      .when(
                          data: (ad) => Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      (MediaQuery.of(context).size.width -
                                              ad.size.width.toDouble()) /
                                          2,
                                ),
                                width: ad.size.width.toDouble(),
                                height: ad.size.height.toDouble(),
                                child: AdWidget(ad: ad),
                              ),
                          loading: () => const CircularProgressIndicator(),
                          error: (e, s) => const Text("Error loading ad"));
                },
              ),
            ],
          ),
        ),
      );
    }

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
            BarChartSample2(
              events: _events,
              map: const {0: 0.3, 1: 5.0, 2: 10.0},
              // rightBarColor: ref.watch(themecontrollerProvider) == ThemeMode.dark ? Colors.greenAccent : Colors.green,
              rightBarColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.greenAccent
                  : Colors.green,
            ),
            // const SizedBox(
            //   height: 8,
            // ),
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
                  index = subjectAtt.length - index - 1;
                  "Index $index".logInfo;
                  String attendance = "";

                  for (var element in _events[subjectAtt[index].absentDate]!) {
                    attendance += element.isAbsent ? "A" : "P";
                  }

                  return Consumer(builder: (context, ref, child) {
                    final currentTheme = ref.watch(themeControllerProvider);
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
                return ref
                    .watch(
                      subAttBannerAdProvider(adsBannerId[widget.index]),
                    )
                    .when(
                        data: (ad) => Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: (MediaQuery.of(context).size.width -
                                        ad.size.width.toDouble()) /
                                    2,
                              ),
                              width: ad.size.width.toDouble(),
                              height: ad.size.height.toDouble(),
                              child: AdWidget(ad: ad),
                            ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, s) => const Text("Error loading ad"));
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
              final currentTheme = ref.watch(themeControllerProvider);
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
      duration: Duration(
        milliseconds: 300 + ((subjectAtt.length - index - 1) * 100),
      ),
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
                    return TextSpan(
                      text: 'P',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.greenAccent
                            : Colors.green,
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
