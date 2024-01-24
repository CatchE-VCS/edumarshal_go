import 'dart:convert';

import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:edumarshal/features/dashboard/controller/attendance_state_pod.dart';
import 'package:edumarshal/features/dashboard/controller/pdp_attendance_state_pod.dart';
import 'package:edumarshal/features/dashboard/model/attendance_model.dart';
import 'package:edumarshal/features/subject_attendance/pdp_att_page.dart';
import 'package:edumarshal/features/subject_attendance/sub_att_page.dart';
import 'package:edumarshal/features/widgets/additional_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Assign extends ConsumerWidget {
  const Assign({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey drawerKey = GlobalKey();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            print(
                data.stdSubAtdDetails!.studentSubjectAttendance[0].userDetails);
            if (jsonDecode(data.stdSubAtdDetails!.studentSubjectAttendance[0]
                    .userDetails)['firstName'] !=
                null) {
              name = jsonDecode(data.stdSubAtdDetails!.studentSubjectAttendance
                      .first.userDetails)['firstName'] +
                  ' ' +
                  jsonDecode(data.stdSubAtdDetails!.studentSubjectAttendance
                      .first.userDetails)['lastName'];
              email = jsonDecode(data.stdSubAtdDetails!.studentSubjectAttendance
                  .first.userDetails)['email'];
            } else {
              name =
                  '${data.stdSubAtdDetails!.studentSubjectAttendance.first.firstName} ${data.stdSubAtdDetails!.studentSubjectAttendance.first.lastName}';

              email =
                  data.stdSubAtdDetails!.studentSubjectAttendance.first.email ??
                      '';
            }
            int totalSubjects = data
                .stdSubAtdDetails!.studentSubjectAttendance[0].subjects.length;
            double overallPercentage = data.stdSubAtdDetails!.overallPercentage;
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
      
                for (int i = 0; i < totalSubjects; i++) ...[
                  Consumer(
                    builder: (context, ref, child) {
                      final currentTheme = ref.watch(themecontrollerProvider);
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
                        child: Assignbuilder(),
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
      ]),
    );
  }
}

class Assignbuilder extends StatelessWidget {
  const Assignbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: 500, // Adjust the height of the cards
          width: double.infinity,
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(0),
            color: Colors.blueAccent,
            child: SizedBox(
              // width: 300,
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTime.now().toString().substring(0, 11),
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Due Date :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Title :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Subject :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Attachments :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Card(
                          color: Colors.orangeAccent,
                          // width: MediaQuery.of(context).size.width - 100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 11.0),
                            child: Row(
                              children: [
                                Text(
                                  "Teacher's Feedback",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.black54,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  icon: Icon(Icons.person),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Max Score :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Grade :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Remark :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Attachments :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Card(
                          color: Colors.cyan,
                          // width: MediaQuery.of(context).size.width - 100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 11.0),
                            child: Row(
                              children: [
                                Text(
                                  "Submission Details",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.black54,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  icon: Icon(Icons.book),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Description :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 2),
                        Text(
                          'Attachments :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            enableDrag: true,
                            context: context,
                            builder: (context) => Submitsheet());
                      },
                      child: Container(
                        height: 40,
                        width: double.maxFinite,
                        color: Colors.green,
                        // width: MediaQuery.of(context).size.width - 100,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Center(
                            child: Text(
                              "Submit ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                // color: Colors.black54,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class Submitsheet extends StatelessWidget {
  const Submitsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: 700, // Adjust the height of the cards
          width: double.infinity,
          child: Card(
            elevation: 8.0,
            color: Colors.indigo[100],
            child: SizedBox(
              // width: 300,
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Submission",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Title :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(
                          height: 4,
                        ),
                        Text(
                          'Description :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Divider(height: 4),

                        // Divider(height: 2),
                        // Text(
                        //   'Subject :',
                        //   style: const TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.normal,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // Divider(height: 2),

                        Divider(height: 2),
                        Card(
                          color: Colors.orangeAccent,
                          // width: MediaQuery.of(context).size.width - 100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 1,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 11.0),
                            child: Row(
                              children: [],
                            ),
                          ),
                        ),

                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 370,
                            maxHeight: 370,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(fillColor: Colors.white),
                                controller: TextEditingController(),
                                maxLines: 300, // or set it to a large number
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Attachments :',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Card(
                          color: Colors.green,
                          // width: MediaQuery.of(context).size.width - 100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 1,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
                            child: Center(
                              child: Text(
                                "Submit ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black54,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
