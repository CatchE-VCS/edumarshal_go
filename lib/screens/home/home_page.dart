import 'dart:convert';

import 'package:edumarshal/controllers/attendance.dart';
import 'package:edumarshal/models/attendance_model.dart';
import 'package:edumarshal/screens/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 3,
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {});
          },
        );
      },
      child: FutureBuilder(
        future: AttendanceController().getData(),
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
            int totalSubjects = snapshot.data!.stdSubAtdDetails
                .studentSubjectAttendance[0].subjects.length;
            double overallPercentage =
                snapshot.data!.stdSubAtdDetails.overallPercentage;
            List<Subject> subjectsList = snapshot
                .data!.stdSubAtdDetails.studentSubjectAttendance[0].subjects;
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
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: name,
                                          style: GoogleFonts.poppins(
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
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
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
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //     horizontal: 15,
                  //     vertical: 5,
                  //   ),
                  //   height: 180,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //     color: Color.fromARGB(255, 183, 146, 247),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Color.fromARGB(255, 56, 159, 243),
                  //         // blurRadius: 20.0,
                  //         offset: Offset(7, 7),
                  //       ),
                  //     ],
                  //   ),
                  //   child:
                  SizedBox(
                    height: 200, // Adjust the height of the cards
                    width: double.infinity,
                    child: SwipeCardsScreen(
                      totalSubjects: totalSubjects,
                      overallPercentage: overallPercentage,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 200, // Adjust the height of the cards
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: <Widget>[
                  //       // Background Card
                  //       Positioned(
                  //         top: 20.0,
                  //         child: Card(
                  //           elevation: 4.0,
                  //           margin: EdgeInsets.all(16.0),
                  //           color: Colors.blue,
                  //           child: SizedBox(
                  //             width: 300,
                  //             height: 150,
                  //             child: Padding(
                  //               padding: EdgeInsets.all(16.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Text(
                  //                     'First Card',
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 20.0,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     'This is the content of the first card.',
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       // Foreground Card (Overlay)
                  //       Card(
                  //         elevation: 6.0,
                  //         margin: EdgeInsets.all(16.0),
                  //         color: Colors.white,
                  //         child: SizedBox(
                  //           width: 300,
                  //           height: 150,
                  //           child: Padding(
                  //             padding: EdgeInsets.all(16.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text(
                  //                   'Second Card (Overlay)',
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 20.0,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   'This is the content of the second card.',
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   elevation: 10,
                  //   margin: const EdgeInsets.symmetric(
                  //     horizontal: 15,
                  //     vertical: 5,
                  //   ),
                  //   color: Colors.blueAccent.shade700,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(16.0),
                  //   ),
                  //   shadowColor: Colors.blueAccent.shade700,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Row(
                  //       children: [
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'Your Attendance',
                  //               style: TextStyle(
                  //                 fontSize: 24,
                  //                 fontFamily: GoogleFonts.poppins().fontFamily,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               '$totalSubjects Subjects (incl. Labs)',
                  //               style: const TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.normal,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const Spacer(),
                  //         Column(
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(100),
                  //               ),
                  //               child: CircularProgressIndicator(
                  //                 value: overallPercentage / 100,
                  //                 backgroundColor: Colors.white,
                  //                 color: overallPercentage >= 75
                  //                     ? Colors.greenAccent
                  //                     : overallPercentage >= 50
                  //                         ? Colors.orangeAccent
                  //                         : Colors.redAccent,
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               '$overallPercentage%',
                  //               style: const TextStyle(
                  //                 fontSize: 26,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // ),
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
                                'Total Present: $totalPresent\nTotal Absent: $totalAbsent',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          AdditionalInfo(
                            image: Image.asset('assets/images/cv_3194447.png'),
                            label: 'Lectures',
                            value: 'Total Lectures: $totalClasses',
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
                  for (int i = 0; i < totalSubjects; i++) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(left: 18, right: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectScreen(
                                subject: subjectsList[i].name,
                                totalPresent: subjectsList[i].presentLeactures,
                                totalAbsent: subjectsList[i].absentLeactures,
                              ),
                            ),
                          );
                        },
                        child: SubjectCard(
                          totalPresent: subjectsList[i].presentLeactures,
                          totalClasses: subjectsList[i].totalLeactures,
                          subject: subjectsList[i].name,
                          attendance: subjectsList[i].percentageAttendance,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ],
              ),
            );
          }
        },
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
                  color: Colors.black54,
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
                  color: Colors.black45,
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Total Present: ${totalPresent ?? 'N/A'}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Total Absent: ${totalAbsent ?? 'N/A'}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
