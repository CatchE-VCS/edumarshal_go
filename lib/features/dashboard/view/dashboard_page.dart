import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:edumarshal/features/subject_attendance/pdp_att_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'package:zoom_widget/zoom_widget.dart';

import '../../subject_attendance/attendance_summary_page.dart';
import '../../subject_attendance/sub_att_page.dart';
import '../../widgets/additional_info.dart';
import '../../widgets/bar_chart.dart';
import '../../widgets/swipe_card_widget.dart';
import '../controller/dashboard_banner_ad_pod.dart';
import '../dashboard.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GlobalKey drawerKey = GlobalKey();
    // final InAppReview inAppReview = InAppReview.instance;
    final currentTheme = ref.watch(themeControllerProvider);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final ad = ref.read(dashBannerAdProvider);
    return RefreshIndicator(
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      displacement: 100,
      onRefresh: () async {
        ref.invalidate(attendanceDataProvider);
        ref.invalidate(pdpAttendanceDataProvider);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: currentTheme == ThemeMode.dark
                    ? Colors.grey.shade900
                    : currentTheme == ThemeMode.light
                        ? Colors.grey.shade200
                        : isDarkMode
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Check out what we have done for you!',
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      repeatForever: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.router.pushNamed('/what-we-have-done');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ref.watch(attendanceDataProvider).when(
                  loading: () {
                    // Check the connection state
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: ref.watch(attendanceFetchProgressProvider),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            currentTheme == ThemeMode.dark
                                ? Colors.greenAccent
                                : currentTheme == ThemeMode.light
                                    ? Colors.green
                                    : isDarkMode
                                        ? Colors.greenAccent
                                        : Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                  error: (e, s) {
                    // Error fetching data
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(
                        child: Text('Error fetching data'),
                      ),
                    );
                  },
                  // Add a watch
                  data: (AttendanceData? data) {
                    // print("Refreshed");
                    // If no error occurred
                    if (data == null) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: const Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }

                    /// events for barChart Data
                    Map<DateTime, List<AttendanceEntry>> events = {};
                    for (var element in data.attendanceData) {
                      if (!events.containsKey(element.absentDate)) {
                        events[element.absentDate] = [];
                      }
                      if (events[element.absentDate] != null) {
                        events[element.absentDate]!
                            .add(AttendanceEntry(isAbsent: element.isAbsent));
                      }
                    }
                    for (var element in data.extraLectures) {
                      if (!events.containsKey(element.absentDate)) {
                        events[element.absentDate] = [];
                      }
                      if (events[element.absentDate] != null) {
                        events[element.absentDate]!
                            .add(AttendanceEntry(isAbsent: element.isAbsent));
                      }
                    }

                    ///

                    String name = '';
                    String email = '';
                    // if (kDebugMode) {
                    //   print(data.stdSubAtdDetails!.studentSubjectAttendance[0]
                    //       .userDetails);
                    // }
                    if (data.stdSubAtdDetails != null) {
                      if (data.stdSubAtdDetails!.studentSubjectAttendance[0]
                              .userDetails !=
                          null) {
                        if (jsonDecode(data
                                .stdSubAtdDetails!
                                .studentSubjectAttendance[0]
                                .userDetails!)['firstName'] !=
                            null) {
                          var userDetails = jsonDecode(data.stdSubAtdDetails!
                              .studentSubjectAttendance[0].userDetails!);
                          String firstName = userDetails['firstName'] ?? '';
                          String middleName = userDetails['middleName'] ?? '';
                          String lastName = userDetails['lastName'] ?? '';
                          if (middleName.isNotEmpty) {
                            name = '$firstName $middleName $lastName';
                          } else {
                            name = '$firstName $lastName';
                          }
                          email = jsonDecode(data
                              .stdSubAtdDetails!
                              .studentSubjectAttendance
                              .first
                              .userDetails!)['email'];
                        }
                      } else {
                        name =
                            '${data.stdSubAtdDetails!.studentSubjectAttendance.first.firstName} ${data.stdSubAtdDetails!.studentSubjectAttendance.first.lastName}';

                        email = data.stdSubAtdDetails!.studentSubjectAttendance
                                .first.email ??
                            '';
                      }
                    }
                    int totalSubjects = data.stdSubAtdDetails!
                        .studentSubjectAttendance[0].subjects.length;
                    double overallPercentage =
                        data.stdSubAtdDetails!.overallPercentage;
                    List<Subject> subjectsList = data
                        .stdSubAtdDetails!.studentSubjectAttendance[0].subjects;
                    int totalPresent =
                        data.stdSubAtdDetails?.overallPresent ?? 0;
                    int totalClasses =
                        data.stdSubAtdDetails?.overallLecture ?? 0;
                    int calculatedValue = 0;
                    if (totalClasses.isPositive && totalPresent.isPositive) {
                      // print('Total Classes: $totalClasses');
                      // print('Total Present: $totalPresent');
                      // late bool above75 = false;
                      // int totalAbsent = totalClasses - totalPresent;
                      calculatedValue = 3 * totalClasses - 4 * totalPresent;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello, $name",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        email,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          // color: Colors.black,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 8,
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return SizedBox(
                                  //           height: 80,
                                  //           width: 80,
                                  //           child: CircleAvatar(
                                  //             backgroundImage: NetworkImage(
                                  //               profilePhotoUrl!,
                                  //               scale: 0.1,
                                  //             ),
                                  //             radius: 18,
                                  //           ),
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   child: Container(
                                  //     height: 70,
                                  //     width: 70,
                                  //     decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         border: Border.all(
                                  //           color: Colors.black,
                                  //         )),
                                  //     child: ClipRRect(
                                  //         borderRadius: BorderRadius.circular(100),
                                  //         child: profilePhotoUrl!.isNotEmpty
                                  //             ? Image.network(profilePhotoUrl!,
                                  //                 fit: BoxFit.cover, loadingBuilder:
                                  //                     (context, child,
                                  //                         loadingProgress) {
                                  //                 if (loadingProgress == null) {
                                  //                   return child;
                                  //                 }
                                  //                 return const Center(
                                  //                   child:
                                  //                       CircularProgressIndicator(),
                                  //                 );
                                  //               }, errorBuilder:
                                  //                     (context, object, stack) {
                                  //                 return const Icon(
                                  //                   Icons.error_outline,
                                  //                   color: Colors.amber,
                                  //                 );
                                  //               })
                                  //             : const Center(
                                  //                 child: CircularProgressIndicator(),
                                  //               )),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 200, // Adjust the height of the cards
                          width: double.infinity,
                          child: SwipeCardsScreen(
                            totalSubjects: totalSubjects,
                            overallPercentage: overallPercentage,
                            subjectsList: subjectsList,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 2,
                          ),
                          child: Text(
                            'Your Statistics',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                AdditionalInfo(
                                  index: 0,
                                  image: Image.asset(
                                      'assets/images/school_7214224.png'),
                                  label: 'Course',
                                  value: data
                                              .stdSubAtdDetails!
                                              .studentSubjectAttendance[0]
                                              .userDetails !=
                                          null
                                      ? jsonDecode(data
                                              .stdSubAtdDetails!
                                              .studentSubjectAttendance[0]
                                              .userDetails!)['selectedCourse']
                                          .toString()
                                      : '',
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                AdditionalInfo(
                                  index: 1,
                                  image: Image.asset(
                                    'assets/images/presentation_760138.png',
                                  ),
                                  label: 'Attendance Preview',
                                  value:
                                      'Total Present: $totalPresent\nTotal Lectures: $totalClasses',
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Stack(children: [
                                  AdditionalInfo(
                                    index: 2,
                                    image: Image.asset(
                                      'assets/images/presentation_760138.png',
                                    ),
                                    label: (calculatedValue < 0)
                                        ? 'You are already above 75%'
                                        : 'Classes Required for 75%:',
                                    value: (() {
                                      int canSkip = totalPresent -
                                          (0.75 * totalClasses).ceil();
                                      if (calculatedValue < 0) {
                                        if (calculatedValue == 0) {
                                          return 'You cannot miss any classes';
                                        }
                                        return 'You can miss $canSkip class${canSkip > 1 ? 'es' : ''}';
                                      } else {
                                        return 'Classes Required: $calculatedValue';
                                      }
                                    })(),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 5,
                                      child: (calculatedValue < 0)
                                          ? IconButton(
                                              icon: const Icon(
                                                  Icons.error_outline_rounded),
                                              color: const Color(0xffD25D81),
                                              iconSize: 25,
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('DISCLAIMER',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily,
                                                          )),
                                                      content: Text(
                                                        'This calculation is only based on the attendance updated on edumarshal. Please don\'t blindly rely on this.',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily,
                                                        ),
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'OK',
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            )
                                          : Container()),
                                ]),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Your Weekly Analysis',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),
                        BarChartSample2(
                          events: events,
                          map: const {
                            0: 0.3,
                            1: 5.0,
                            2: 10.0,
                            3: 15.0,
                            4: 20.0,
                            5: 25.0,
                            6: 30.0,
                            7: 35.0,
                            8: 40.0
                          },
                          maxY: 40,
                          aR: 1.3,
                          rightBarColor: currentTheme == ThemeMode.dark
                              ? Colors.greenAccent
                              : currentTheme == ThemeMode.dark
                                  ? Colors.green
                                  : isDarkMode
                                      ? Colors.greenAccent
                                      : Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'All Subjects',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),

                        // Container(
                        //   height: 230,
                        //   width:  MediaQuery.sizeOf(context).width - 20,
                        //   margin: const EdgeInsets.only(left: 10, right: 10),
                        //   child: Zoom(
                        //     maxZoomWidth: MediaQuery.sizeOf(context).width - 20,
                        //     maxZoomHeight: 230,
                        //
                        //     child: TimetableDropdowns(),
                        //     ),
                        //   ),

                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < totalSubjects; i++) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: currentTheme == ThemeMode.dark
                                  ? Colors.grey.shade900
                                  : currentTheme == ThemeMode.light
                                      ? Colors.grey.shade200
                                      : isDarkMode
                                          ? Colors.grey.shade900
                                          : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.only(left: 18, right: 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubjectAttendanceScreen(
                                      attendanceData: data,
                                      subject: subjectsList[i],
                                      index: i,
                                    ),
                                  ),
                                );
                              },
                              child: SubjectCard(
                                totalPresent: subjectsList[i].presentLeactures,
                                totalClasses: subjectsList[i].totalLeactures,
                                subject: subjectsList[i].name ?? '',
                                attendance:
                                    subjectsList[i].percentageAttendance,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ],
                    );
                  },
                  skipLoadingOnRefresh: false,
                ),
            const SizedBox(
              height: 20,
            ),
            ref.watch(pdpAttendanceDataProvider).when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (e, s) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              },
              data: (ss) {
                int presentLectures = 0;
                if (ss != null) {
                  if (ss.isEmpty) {
                    return const SizedBox(
                      height: 100,
                    );
                  }

                  for (var element in ss) {
                    if (element.isInAbsent == false) {
                      presentLectures++;
                    }
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'PDP Attendance',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to PDP Attendance Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDPAttendanceScreen(
                                attendanceData: ss,
                                presentLectures: presentLectures,
                                percentageAttendance:
                                    (presentLectures / ss.length) * 100,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentTheme == ThemeMode.dark
                                ? Colors.grey.shade900
                                : currentTheme == ThemeMode.light
                                    ? Colors.grey.shade200
                                    : isDarkMode
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(left: 18, right: 15),
                          child: SubjectCard(
                            totalPresent: presentLectures,
                            totalClasses: ss.length,
                            subject: "PDP",
                            attendance: (presentLectures / ss.length) * 100,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    height: 100,
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width -
                        ad.size.width.toDouble()) /
                    2,
              ),
              width: ad.size.width.toDouble(),
              height: ad.size.height.toDouble(),
              child: new AdWidget(ad: ad),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subject;
  final double attendance;
  final int? totalPresent;
  final int? totalClasses;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.attendance,
    required this.totalPresent,
    required this.totalClasses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black54,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                'Attendance: $attendance%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  // color: Colors.black45,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Row(
                children: [
                  Text(
                    'Total Present: $totalPresent',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      // color: Colors.black45,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Total Classes: $totalClasses',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      // color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                'Classes Required for 75%: ${((3 * totalClasses! - 4 * totalPresent! > 0) ? 3 * totalClasses! - 4 * totalPresent! : 0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  // color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 50,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: attendance / 100),
                duration: const Duration(seconds: 3),
                builder: (BuildContext context, double value, Widget? child) =>
                    CircularProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white60,
                  color: attendance >= 75
                      ? Colors.green
                      : attendance >= 50
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              'Click here',
              style: TextStyle(
                fontSize: 12,

                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold,
                // color: Colors.black45,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}

enum Availability { loading, available, unavailable }

class InAppReviewExampleApp extends StatefulWidget {
  const InAppReviewExampleApp({Key? key}) : super(key: key);

  @override
  InAppReviewExampleAppState createState() => InAppReviewExampleAppState();
}

class InAppReviewExampleAppState extends State<InAppReviewExampleApp> {
  final InAppReview _inAppReview = InAppReview.instance;

  String _appStoreId = '';
  String _microsoftStoreId = '';
  Availability _availability = Availability.loading;

  @override
  void initState() {
    super.initState();

    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  void _setAppStoreId(String id) => _appStoreId = id;

  void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In App Review Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('In App Review Example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('In App Review status: ${_availability.name}'),
            TextField(
              onChanged: _setAppStoreId,
              decoration: const InputDecoration(hintText: 'App Store ID'),
            ),
            TextField(
              onChanged: _setMicrosoftStoreId,
              decoration: const InputDecoration(hintText: 'Microsoft Store ID'),
            ),
            ElevatedButton(
              onPressed: _requestReview,
              child: const Text('Request Review'),
            ),
            ElevatedButton(
              onPressed: _openStoreListing,
              child: const Text('Open Store Listing'),
            ),
          ],
        ),
      ),
    );
  }
}

class TimetableDropdowns extends ConsumerStatefulWidget {
  const TimetableDropdowns({super.key});

  @override
  ConsumerState<TimetableDropdowns> createState() => _TimetableDropdownsState();
}

class _TimetableDropdownsState extends ConsumerState<TimetableDropdowns> {
  String _value = 'Subject A';

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeControllerProvider);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Table(
      children: List.generate(
        7, // Number of rows
        (rowIndex) => (rowIndex > 0)
            ? TableRow(
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.dark
                      ? Colors.grey.shade900
                      : currentTheme == ThemeMode.light
                          ? Colors.grey.shade200
                          : isDarkMode
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                ),
                children: List.generate(
                  7, // Number of columns
                  (colIndex) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 20,
                      // height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        gradient: CustomLinearGradients().getGradient(
                            CustomLinearGradients().getRandomGradient()),
                        // LinearGradient(
                        //   colors: [Colors.blue, Colors.green], // Customize gradient colors
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        // ),
                        // LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [Color.fromRGBO(183, 82, 185, 1),Color.fromRGBO(233, 147, 229, 1)]
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: DropdownButton<String>(
                            value: _value,
                            items: [
                              'Subject A',
                              'Subject B',
                              'Subject C',
                              'Subject D'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: FittedBox(child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                        ),
                        // SizedBox(height: 10,),
                      ),
                    ),
                  ),
                ),
              )
            : const TableRow(children: []),
      ),
    );
  }
}

enum GradientType {
  custom1,
  custom2,
  custom3,
  custom4,
  custom5,
  custom6,
}

class CustomLinearGradients {
  LinearGradient getGradient(GradientType type) {
    switch (type) {
      case GradientType.custom1:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(103, 82, 185, 1),
            Color.fromRGBO(165, 140, 220, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientType.custom2:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(17, 136, 144, 1),
            Color.fromRGBO(132, 175, 189, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientType.custom3:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(103, 82, 185, 1),
            Color.fromRGBO(165, 140, 220, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientType.custom4:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(181, 71, 71, 1),
            Color.fromRGBO(218, 135, 135, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientType.custom5:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(115, 146, 26, 1),
            Color.fromRGBO(157, 210, 116, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientType.custom6:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(73, 160, 86, 1),
            Color.fromRGBO(137, 201, 147, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  GradientType getRandomGradient() {
    final random = Random();
    return GradientType
        .values[random.nextInt(6)]; // Randomly select from Custom1 to Custom6
  }
}
