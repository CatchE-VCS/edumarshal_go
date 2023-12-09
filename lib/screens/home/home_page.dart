import 'dart:convert';
import 'dart:ui';

import 'package:edumarshal/models/attendance_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../controllers/db_controller.dart';
import '../widgets/additional_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<_HomePageState> drawerKey = GlobalKey();

  // bool isLoading = true; // Add a flag to track loading state

  @override
  void initState() {
    super.initState();
    // getData();
  }

  Future<AttendanceData?> getData() async {
    try {
      final token = await DataBaseCon().retrieveUser();
      var headers = {
        'Authorization': "Bearer ${token[0].toString()}",
      };
      // var headers = {
      //   'Token':
      //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoic3R1ZGVudDAxIiwicm9sZSI6InN0dWRlbnQifQ.UkULa-lSkrgCyxlHi106ocV1261_YpI3tFbxRfk09lg'
      // };
      http.Response response = await http.get(
        Uri.parse(
          'https://akgec-edumarshal-dev.onrender.com/api/v1/get-attendance',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // setState(() {
        //   isLoading = false;
        // });
        return attendanceDataFromJson(response.body);

        // if (kDebugMode) {
        //   print('Total Subjects: $totalSubjects');
        //   print('Total Present: $totalPresent');
        //   print('Total Absent: $totalAbsent');
        //   print('Total Classes: $totalClasses');
        //   print('Overall Percentage: $overallPercentage');
        //   print('Name: $name');
        //   print('Email: $email');
        // }
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
        // return AttendanceData(
        //   attendance: null,
        //   businessDays: 0,
        //   userBusinessDay: null,
        //   attendanceData: [],
        //   extraLectures: [],
        //   attendanceCopy: [],
        //   stdSubAtdDetails: StdSubAtdDetails(
        //     overallPresent: 0,
        //     overallLecture: 0,
        //     overallPercentage: 0,
        //     subjects: [],
        //     studentSubjectAttendance: [],
        //   ),
        // );
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
      // return AttendanceData(
      //   attendance: null,
      //   businessDays: 0,
      //   userBusinessDay: null,
      //   attendanceData: [],
      //   extraLectures: [],
      //   attendanceCopy: [],
      //   stdSubAtdDetails: StdSubAtdDetails(
      //     overallPresent: 0,
      //     overallLecture: 0,
      //     overallPercentage: 0,
      //     subjects: [],
      //     studentSubjectAttendance: [],
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<AttendanceData?> snapshot) {
          // Add a snapshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Check the connection state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Check if error occurred
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            // If no error occurred
            if (snapshot.data == null) {
              return const Center(
                child: Text('No data found'),
              );
            }
            String name = jsonDecode(snapshot.data!.stdSubAtdDetails
                    .studentSubjectAttendance.first.userDetails)['firstName'] +
                ' ' +
                jsonDecode(snapshot.data!.stdSubAtdDetails
                    .studentSubjectAttendance.first.userDetails)['lastName'];
            String email = jsonDecode(snapshot.data!.stdSubAtdDetails
                .studentSubjectAttendance.first.userDetails)['email'];
            int totalSubjects = snapshot.data!.stdSubAtdDetails.subjects.length;
            double overallPercentage =
                snapshot.data!.stdSubAtdDetails.overallPercentage;
            List<Subject> subjectsList =
                snapshot.data!.stdSubAtdDetails.subjects;
            int totalPresent = snapshot.data!.stdSubAtdDetails.overallPresent!;
            int totalClasses = snapshot.data!.stdSubAtdDetails.overallLecture!;
            int totalAbsent = totalClasses - totalPresent;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 23, top: 8),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Hello, ",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 224, 2, 2),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: name,
                                            style: GoogleFonts.ubuntu(
                                              textStyle: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                    ),
                                    child: Text(
                                      email,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              width: 50,
                            ),

                            //   CircleAvatar(

                            //       backgroundImage: ProfilePhotoUrl != null
                            // ? NetworkImage(ProfilePhotoUrl!)
                            // : AssetImage('assets/images/6BB89A8D-CEF5-44E6-9785-9349DC7C96FC.jpeg'),

                            //                   radius: 35,
                            //                   backgroundColor: Colors.transparent,
                            //                 ),

                            // GestureDetector(
                            //   onTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return CircleAvatar(
                            //           backgroundImage:
                            //               NetworkImage(profilePhotoUrl!),
                            //           radius: 50,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 56, 159, 243),
                            blurRadius: 20.0,
                            offset: Offset(10, 7),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Your Attendance',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Subjects : $totalSubjects',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              Color.fromARGB(255, 99, 98, 98),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '$overallPercentage%',
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.bottomRight,
                                    //   child: Text(
                                    //     ' Estimated Cgpa:$estimatedCgpa',
                                    //     style: const TextStyle(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.normal,
                                    //       color: Color.fromARGB(
                                    //           255, 120, 119, 119),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Your Statistics',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          AdditionalInfo(
                            image:
                                Image.asset('assets/images/school_7214224.png'),
                            label: 'Course',
                            value: 'B.Tech (I Year)',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          AdditionalInfo(
                            image: Image.asset(
                              'assets/images/presentation_760138.png',
                            ),
                            label: 'Preview',
                            value:
                                'Total Present : $totalPresent\nTotal Absent : $totalAbsent',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          AdditionalInfo(
                            image: Image.asset('assets/images/cv_3194447.png'),
                            label: 'Lectures',
                            value: 'Total Lectures : $totalClasses',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'All Subjects',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < totalSubjects; i++) ...[
                        Container(
                          height: 80,
                          padding: const EdgeInsets.only(left: 18, right: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectScreen(
                                    subject: subjectsList[i].name,
                                    totalPresent:
                                        subjectsList[i].presentLeactures,
                                    totalAbsent:
                                        subjectsList[i].absentLeactures,
                                  ),
                                ),
                              );
                            },
                            child: ContainerPage(
                              subject: subjectsList[i].name ?? '',
                              attendance: ' Attendance',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 18, right: 15),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => SubjectScreen(
                  //             subject: selected1 ?? '',
                  //             totalPresent: selected1TotalPresent,
                  //             totalAbsent: selected1TotalAbsent,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: ContainerPage(
                  //       subject: '$selected1',
                  //       attendance: ' Attendance',
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 15),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => SubjectScreen(
                  //             subject: selected2 ?? '',
                  //             totalPresent: selected2TotalPresent,
                  //             totalAbsent: selected2TotalAbsent,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: ContainerPage(
                  //       subject: '$selected2',
                  //       attendance: ' Attendance',
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 15),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => SubjectScreen(
                  //             subject: selected3 ?? '',
                  //             totalPresent: selected3TotalPresent,
                  //             totalAbsent: selected3TotalAbsent,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: ContainerPage(
                  //       subject: '$selected3',
                  //       attendance: ' Attendance',
                  //     ),
                  //   ),
                  // ),
                  // //   SizedBox(
                  // //   height: 10,
                  // // ),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => SubjectScreen(
                  //             subject: selected4 ?? '',
                  //             totalPresent: selected4TotalPresent,
                  //             totalAbsent: selected4TotalAbsent,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: ContainerPage(
                  //       subject: '$selected4',
                  //       attendance: ' Attendance',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ContainerPage extends StatelessWidget {
  final String subject;
  final String attendance;
  const ContainerPage(
      {super.key, required this.subject, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 350,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 227, 223, 223),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 140,
            //   width: 160,

            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            //   child: image,
            // ),

            // Icon(
            //     ,
            //     size: 40,
            //   ),

            const SizedBox(
              height: 12.0,
            ),
            Text(
              subject,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              attendance,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  final String subject;
  final int? totalPresent;
  final int? totalAbsent;

  const SubjectScreen({
    super.key,
    required this.subject,
    required this.totalPresent,
    required this.totalAbsent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 183, 146, 247), // Make the AppBar transparent
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Frame 289295.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 140, left: 40, bottom: 60),
                child: Text(
                  'Subject: $subject',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Total Present: ${totalPresent ?? 'N/A'}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Total Absent: ${totalAbsent ?? 'N/A'}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
