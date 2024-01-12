import 'dart:convert';

import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:edumarshal/features/subject_attendance/pdp_att_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../subject_attendance/sub_att_page.dart';
import '../../widgets/additional_info.dart';
import '../../widgets/test.dart';
import '../dashboard.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey drawerKey = GlobalKey();
    return RefreshIndicator(
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      displacement: 100,
      onRefresh: () async {
        var d = ref.refresh(attendanceDataProvider);
        var f = ref.refresh(pdpAttendanceDataProvider);
        if (kDebugMode) {
          print("d: $d");
          print("f: $f");
        }

        // return Future.delayed(
        //   const Duration(seconds: 1),
        //   () {
        //     setState(() {});
        //   },
        // );
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ref.watch(attendanceDataProvider).when(
              loading: () {
                // Check the connection state
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: const Center(
                    child: CircularProgressIndicator(),
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
                // String profilePhotoUrl =
                //     "https://akgecerp.edumarshal.com/api/fileblob/${snapshot.data!.stdSubAtdDetails.studentSubjectAttendance[0].userDetails == null ? null : jsonDecode(snapshot.data!.stdSubAtdDetails.studentSubjectAttendance[0].userDetails)['profilePictureId']}";
                String name = '';
                String email = '';
                print(data
                    .stdSubAtdDetails!.studentSubjectAttendance[0].userDetails);
                if (jsonDecode(data
                        .stdSubAtdDetails!
                        .studentSubjectAttendance[0]
                        .userDetails)['firstName'] !=
                    null) {
                  name = jsonDecode(data
                          .stdSubAtdDetails!
                          .studentSubjectAttendance
                          .first
                          .userDetails)['firstName'] +
                      ' ' +
                      jsonDecode(data.stdSubAtdDetails!.studentSubjectAttendance
                          .first.userDetails)['lastName'];
                  email = jsonDecode(data.stdSubAtdDetails!
                      .studentSubjectAttendance.first.userDetails)['email'];
                } else {
                  name =
                      '${data.stdSubAtdDetails!.studentSubjectAttendance.first.firstName} ${data.stdSubAtdDetails!.studentSubjectAttendance.first.lastName}';

                  email = data.stdSubAtdDetails!.studentSubjectAttendance.first
                          .email ??
                      '';
                }
                int totalSubjects = data.stdSubAtdDetails!
                    .studentSubjectAttendance[0].subjects.length;
                double overallPercentage =
                    data.stdSubAtdDetails!.overallPercentage;
                List<Subject> subjectsList =
                    data.stdSubAtdDetails!.studentSubjectAttendance[0].subjects;
                int? totalPresent = data.stdSubAtdDetails?.overallPresent!;
                int? totalClasses = data.stdSubAtdDetails?.overallLecture!;
                // int totalAbsent = totalClasses - totalPresent;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            AdditionalInfo(
                              index: 0,
                              image: Image.asset(
                                  'assets/images/school_7214224.png'),
                              label: 'Course',
                              value: jsonDecode(data
                                      .stdSubAtdDetails!
                                      .studentSubjectAttendance[0]
                                      .userDetails)['selectedCourse']
                                  .toString(),
                            ),
                            const SizedBox(
                              width: 10,
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
                              width: 10,
                            ),
                            AdditionalInfo(
                              index: 2,
                              image: Image.asset(
                                'assets/images/presentation_760138.png',
                              ),
                              label: 'Classes Required for 75%:',
                              value: (() {
                                int calculatedValue =
                                    3 * totalClasses! - 4 * totalPresent!;
                                if (calculatedValue < 0) {
                                  return 'You are already above 75%';
                                } else {
                                  return 'Classes Required: $calculatedValue';
                                }
                              })(),
                            ),
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
                        'All Subjects',
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
                    for (int i = 0; i < totalSubjects; i++) ...[
                      Consumer(
                        builder: (context, ref, child) {
                          final currentTheme =
                              ref.watch(themecontrollerProvider);
                          var brightness =
                              MediaQuery.of(context).platformBrightness;
                          bool isDarkMode = brightness == Brightness.dark;
                          return Container(
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubjectAttendanceScreen(
                                      attendanceData: data,
                                      subject: subjectsList[i],
                                    ),
                                  ),
                                );
                              },
                              child: SubjectCard(
                                totalPresent: subjectsList[i].presentLeactures,
                                totalClasses: subjectsList[i].totalLeactures,
                                subject: subjectsList[i].name,
                                attendance:
                                    subjectsList[i].percentageAttendance,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ],
                );
              },
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
                      GestureDetector(
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
                        child: Consumer(
                          builder: (context, ref, child) {
                            final currentTheme =
                                ref.watch(themecontrollerProvider);
                            var brightness =
                                MediaQuery.of(context).platformBrightness;
                            bool isDarkMode = brightness == Brightness.dark;
                            return Container(
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
                              margin:
                                  const EdgeInsets.only(left: 18, right: 15),
                              child: SubjectCard(
                                totalPresent: presentLectures,
                                totalClasses: ss.length,
                                subject: "PDP",
                                attendance: (presentLectures / ss.length) * 100,
                              ),
                            );
                          },
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
              height: 10,
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

  const SubjectCard(
      {super.key,
      required this.subject,
      required this.attendance,
      required this.totalPresent,
      required this.totalClasses});

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
                'Attendance: $totalPresent / $totalClasses ($attendance%)',
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
        Container(
          alignment: Alignment.center,
          width: 50,
          child: CircularProgressIndicator(
            value: attendance / 100,
            backgroundColor: Colors.white60,
            color: attendance >= 75
                ? Colors.green
                : attendance >= 50
                    ? Colors.orange
                    : Colors.red,
          ),
        )
      ],
    );
  }
}
