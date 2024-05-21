import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../assignment.dart';

class AssignmentPage extends ConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeControllerProvider);
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ref.watch(assignmentDataProvider).when(
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
          data: (List<AssignmentModel>? data) {
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < data.length; i++) ...[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width - 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: currentTheme == ThemeMode.dark
                            ? Colors.indigo[200]
                            : currentTheme == ThemeMode.light
                                ? Colors.blueAccent
                                : MediaQuery.of(context).platformBrightness ==
                                        Brightness.light
                                    ? Colors.blueAccent
                                    : Colors.indigo[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AssignmentCard(
                          title: data[i].title!,
                          dueDate: data[i].dueDate!,
                          subject: data[i].subjectList![0].name,
                          submittedAssignmentDetails:
                              data[i].submittedAssignmentDetails),
                    ),
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

class AssignmentCard extends StatelessWidget {
  const AssignmentCard(
      {super.key,
      required this.dueDate,
      required this.subject,
      required this.title,
      this.submittedAssignmentDetails});

  final String title;
  final String subject;
  final DateTime dueDate;
  final SubmittedAssignmentDetails? submittedAssignmentDetails;

  @override
  Widget build(BuildContext context) {
    String description = '';
    String? attachment;
    if (submittedAssignmentDetails != null) {
      description = submittedAssignmentDetails!.textResponse!;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Due Date : ${dueDate.toString().substring(0, 11)}',
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  'Title: $title',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Subject: $subject',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Attachments :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                color: Colors.orangeAccent,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 1,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        "Teacher's Feedback",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black54,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Max Score :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Grade :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Remark :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Attachments :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                color: Colors.cyan,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 2,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        "Submission Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black54,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.book, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Description: $description',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    'Attachments:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  submittedAssignmentDetails != null
                      ? IconButton(
                          icon: const Icon(
                            Icons.file_present_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            // return null;
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: const Text("Attachment"),
                            //       content: SizedBox(
                            //         height: 300,
                            //         width: 300,
                            //         child: PDFView(
                            //           filePath:
                            //               submittedAssignmentDetails!.blobId!,
                            //           enableSwipe: true,
                            //           swipeHorizontal: true,
                            //           autoSpacing: false,
                            //           pageFling: false,
                            //           onRender: (pages) {
                            //             // setState(() {
                            //             //   pages = _pages;
                            //             //   isReady = true;
                            //             // });
                            //           },
                            //           onError: (error) {
                            //             // setState(() {
                            //             //   errorMessage = error.toString();
                            //             // });
                            //             if (kDebugMode) {
                            //               print(error.toString());
                            //             }
                            //           },
                            //           onPageError: (page, error) {
                            //             // setState(() {
                            //             //   errorMessage = '$page: ${error.toString()}';
                            //             // });
                            //             print('$page: ${error.toString()}');
                            //           },
                            //           onViewCreated: (PDFViewController
                            //               pdfViewController) {
                            //             // _controller.complete(pdfViewController);
                            //           },
                            //           // onPageChanged: (int page, int total) {
                            //           //   // setState(() {
                            //           //   //   currentPage = page;
                            //           //   // });
                            //           //   print('page change: $page/$total');
                            //           // },
                            //           // onZoomChanged: (double zoom) {
                            //           //   // setState(() {
                            //           //   //   currentZoom = zoom;
                            //           //   // });
                            //           //   print('zoom change: $zoom');
                            //           // },
                            //         ),
                            //       ),
                            //       actions: [
                            //         TextButton(
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //           },
                            //           child: const Text("Close"),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const SizedBox(
                    height: 700,
                    child: Text("Feature under development"),
                  );
                  // return const SubmitSheet();
                },
              );
            },
            child: Text(
              submittedAssignmentDetails != null
                  ? "Add Resubmission"
                  : "Add Submission",
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
      ],
    );
  }
}

class SubmitSheet extends StatelessWidget {
  const SubmitSheet({super.key});

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
                      const Text(
                        'Title :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(
                        height: 4,
                      ),
                      const Text(
                        'Description :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(height: 4),

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
                      const SizedBox(
                        height: 20,
                      ),
                      const Card(
                        color: Colors.orangeAccent,
                        // width: MediaQuery.of(context).size.width - 100,
                        margin: EdgeInsets.symmetric(
                          horizontal: 1,
                          vertical: 1,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 11.0),
                          child: Row(
                            children: [],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 370,
                          maxHeight: 370,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: SingleChildScrollView(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Attachments :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
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
                              "Submit",
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
        ),
      ),
    );
  }
}
